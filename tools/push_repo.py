#!/usr/bin/env python3
"""通过 GitHub Git Data API 把本地目录推成一个提交（并可打 tag）。

本机环境的两个硬约束，决定了不能用 `git push`：
  1. 上游 proxy 下 `github.com:443` 的 TCP/TLS 与 `/info/refs` 都通，
     但 **proot 里的 `git` CLI 会在 smart-HTTP 阶段挂死**（无输出、不退出）；
  2. `api.github.com` 稳定可达。
因此统一走 REST：blob → tree → commit → ref（可选 tag）。

用法:
    GH_TOKEN=$(gh auth token --user xhjoyb) python3 tools/push_repo.py \
        --owner xhjoyb --repo coopanion-re --message "docs: baseline" \
        --tag v12.71-baseline --tag-message "基准"

特性:
  - 按 blob sha 增量上传：内容没变的文件不重复上传（二次推送几乎零成本）
  - 多线程上传（默认 8 并发），1,000+ 文件约 1–2 分钟
  - 每个请求带指数退避重试（429 / 5xx / 网络抖动）
  - `--create` 自动建库（private=false 即公开）
  - `--tag` 建注释 tag；已存在则就地更新
  - `--prune` 删除远端存在但本地没有的文件
"""

import argparse
import base64
import hashlib
import json
import os
import random
import ssl
import sys
import threading
import time
import urllib.error
import urllib.request
from concurrent.futures import ThreadPoolExecutor, as_completed

API = "https://api.github.com"

# 全局节流：GitHub 对「内容创建类」请求有 secondary rate limit（约 80/分钟），
# 超了就回 403 且冷却很久；这里主动把节奏压到 --min-interval 一个请求。
_PACE = {"last": 0.0}
_PACE_LOCK = threading.Lock()


def pace(interval):
    if interval <= 0:
        return
    with _PACE_LOCK:
        gap = _PACE["last"] + interval - time.time()
        if gap > 0:
            time.sleep(gap)
        _PACE["last"] = time.time()

# 目录级排除（相对仓库根）
EXCLUDE_DIRS = {
    ".git", ".backup", ".operit", "__pycache__", "node_modules",
    "apk", "mcp_out",          # 137 MB 级原始/重签 APK，超 GitHub 单文件上限
}
# 路径前缀排除（深层大目录）
EXCLUDE_PREFIXES = ("src/rootfs/",)   # 137 MB rootfs，可从 payload.asset 重现
EXCLUDE_FILES = {".DS_Store", "Thumbs.db"}
EXCLUDE_SUFFIXES = (".apk", ".aab", ".pyc")


def log(msg):
    print(msg, flush=True)


class GhApi:
    def __init__(self, token):
        self.token = token
        self.ctx = ssl.create_default_context()

    def call(self, method, path, body=None, retries=6, allow=(404,)):
        url = path if path.startswith("http") else API + path
        data = json.dumps(body).encode("utf-8") if body is not None else None
        headers = {
            "Authorization": "Bearer " + self.token,
            "Accept": "application/vnd.github+json",
            "X-GitHub-Api-Version": "2022-11-28",
            "User-Agent": "coopanion-re-push",
        }
        if data is not None:
            headers["Content-Type"] = "application/json"

        last = None
        for attempt in range(1, retries + 1):
            req = urllib.request.Request(url, data=data, headers=headers, method=method)
            try:
                with urllib.request.urlopen(req, timeout=90, context=self.ctx) as resp:
                    raw = resp.read()
                    return json.loads(raw.decode("utf-8")) if raw else None
            except urllib.error.HTTPError as e:
                payload = e.read().decode("utf-8", "replace")[:300]
                if e.code in allow:
                    return {"__status__": e.code, "__body__": payload}
                # 403 多为 secondary rate limit（内容创建 ≤80/分钟），必须给足冷却
                if e.code in (403, 429, 500, 502, 503, 504) and attempt < retries:
                    base = 30 if e.code in (403, 429) else 2 ** attempt
                    wait = min(120, base if e.code in (403, 429) else 2 ** attempt) + random.uniform(0, 5)
                    log(f"  ! HTTP {e.code} {method} {path} → retry {wait:.0f}s")
                    time.sleep(wait)
                    last = payload
                    continue
                raise RuntimeError(f"HTTP {e.code} {method} {url}\n{payload}")
            except Exception as e:
                if attempt < retries:
                    wait = 2 ** attempt
                    log(f"  ! {type(e).__name__} {method} {path} → retry {wait}s")
                    time.sleep(wait)
                    last = str(e)
                    continue
                raise RuntimeError(f"{type(e).__name__} {method} {url}: {e}")
        raise RuntimeError(f"request failed: {last}")


def blob_sha(data):
    return hashlib.sha1(b"blob %d\0" % len(data) + data).hexdigest()


def collect(root):
    out = []
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames[:] = sorted(d for d in dirnames if d not in EXCLUDE_DIRS)
        for name in sorted(filenames):
            if name in EXCLUDE_FILES or name.endswith(EXCLUDE_SUFFIXES):
                continue
            full = os.path.join(dirpath, name)
            if os.path.islink(full):
                continue
            rel = os.path.relpath(full, root).replace(os.sep, "/")
            if any(rel.startswith(p) for p in EXCLUDE_PREFIXES):
                continue
            with open(full, "rb") as fh:
                mode = "100755" if os.access(full, os.X_OK) else "100644"
                with open(full, "rb") as fh:
                    out.append((rel, fh.read(), mode))
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--owner", required=True)
    ap.add_argument("--repo", required=True)
    ap.add_argument("--branch", default="main")
    ap.add_argument("--dir", default=".")
    ap.add_argument("--message", required=True)
    ap.add_argument("--token", default=os.environ.get("GH_TOKEN", ""))
    ap.add_argument("--workers", type=int, default=3)
    ap.add_argument("--min-interval", type=float, default=0.9,
                    help="每个 blob 之间的最小间隔秒数（躲 GitHub 内容创建限流，默认 0.9 ≈ 67/min）")
    ap.add_argument("--create", action="store_true", help="仓库不存在则创建（公开）")
    ap.add_argument("--description", default="")
    ap.add_argument("--tag", default="")
    ap.add_argument("--tag-message", default="")
    ap.add_argument("--prune", action="store_true")
    ap.add_argument("--orphan", action="store_true",
                    help="单提交历史：不继承父提交（配合 force 更新 ref）")
    ap.add_argument("--bootstrap-file", default="README.md",
                    help="空仓库时先用 contents API 提交此文件，绕过 blobs 端点的 409")
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()

    if not args.token:
        log("ERROR: 缺少 token（--token 或 GH_TOKEN）")
        return 2

    gh = GhApi(args.token)

    if args.create:
        r = gh.call("GET", f"/repos/{args.owner}/{args.repo}", allow=(404,))
        if isinstance(r, dict) and r.get("full_name"):
            log(f"仓库已存在: {r['full_name']} (private={r['private']})")
        else:
            r = gh.call("POST", "/user/repos", {
                "name": args.repo,
                "description": args.description,
                "private": False,
                "has_issues": True,
                "has_wiki": False,
                "auto_init": False,
            })
            log(f"已创建仓库: {r['full_name']} (private={r['private']}) → {r['html_url']}")

    root = os.path.abspath(args.dir)
    files = collect(root)
    total = sum(len(d) for _, d, _ in files)
    log(f"本地待推 {len(files)} 文件 / {total:,} B，根目录 {root}")
    if not files:
        log("ERROR: 没有可推送文件")
        return 2

    ref = gh.call("GET", f"/repos/{args.owner}/{args.repo}/git/ref/heads/{args.branch}", allow=(404, 409))
    base_tree, parents = None, []
    if isinstance(ref, dict) and ref.get("object", {}).get("sha"):
        parents = [ref["object"]["sha"]]
        commit = gh.call("GET", f"/repos/{args.owner}/{args.repo}/git/commits/{parents[0]}")
        base_tree = commit["tree"]["sha"]
        log(f"已有 {args.branch} @ {parents[0][:8]} base_tree={base_tree[:8]}")
    else:
        log(f"{args.branch} 不存在，将创建首个提交")
        # 空仓库（0 commit）时 Git Data API 的 blobs 端点会 409 "Git Repository is empty"，
        # 必须先用 contents API 落一个真实提交作为父提交，之后 blob/tree 才可用。
        boot = os.path.join(root, args.bootstrap_file)
        if os.path.isfile(boot):
            with open(boot, "rb") as fh:
                content = fh.read()
            rel = args.bootstrap_file.replace(os.sep, "/")
            log(f"空仓库引导：先用 contents API 提交 {rel}（{len(content)} B）")
            r = gh.call("PUT", f"/repos/{args.owner}/{args.repo}/contents/{rel}", {
                "message": "chore: 初始化仓库（引导提交）",
                "content": base64.b64encode(content).decode("ascii"),
                "branch": args.branch,
            })
            parents = [r["commit"]["sha"]]
            c = gh.call("GET", f"/repos/{args.owner}/{args.repo}/git/commits/{parents[0]}")
            base_tree = c["tree"]["sha"]
            log(f"引导提交 {parents[0][:8]} base_tree={base_tree[:8]}")
        else:
            log(f"WARN: 找不到引导文件 {args.bootstrap_file}，空仓库可能无法上传")

    remote = {}
    if base_tree:
        tree = gh.call("GET", f"/repos/{args.owner}/{args.repo}/git/trees/{base_tree}?recursive=1")
        remote = {i["path"]: i["sha"] for i in tree.get("tree", []) if i.get("type") == "blob"}
        log(f"远端已有 blob {len(remote)}")

    if args.orphan:
        log("orphan 模式：不继承父提交，产出单提交历史")
        parents = []
        base_tree = None

    todo = [(rel, data, mode) for rel, data, mode in files if remote.get(rel) != blob_sha(data)]
    log(f"需要上传 {len(todo)}，复用 {len(files) - len(todo)}")

    def upload(item):
        rel, data, mode = item
        pace(args.min_interval)
        resp = gh.call("POST", f"/repos/{args.owner}/{args.repo}/git/blobs",
                       {"content": base64.b64encode(data).decode("ascii"), "encoding": "base64"})
        return rel, resp["sha"], len(data)

    shas = {}
    if todo:
        if args.dry_run:
            for rel, data, mode in todo:
                log(f"  [dry] {rel} mode={mode} ({len(data)} B)")
            return 0
        done = 0
        with ThreadPoolExecutor(max_workers=args.workers) as ex:
            futs = {ex.submit(upload, it): it[0] for it in todo}
            for fut in as_completed(futs):
                try:
                    rel, sha, size = fut.result()
                except Exception as e:
                    log(f"  ! 上传失败 {futs[fut]}: {str(e)[:200]}")
                    raise
                shas[rel] = sha
                done += 1
                if done % 100 == 0 or done == len(todo):
                    log(f"  上传进度 {done}/{len(todo)}")

    entries = []
    for rel, data, mode in files:
        sha = shas.get(rel) or remote.get(rel) or blob_sha(data)
        entries.append({"path": rel, "mode": mode, "type": "blob", "sha": sha})

    if args.prune and remote:
        local = {rel for rel, _, _ in files}
        gone = sorted(p for p in remote if p not in local)
        for p in gone:
            entries.append({"path": p, "mode": "100644", "type": "blob", "sha": None})
        log(f"删除远端多余文件 {len(gone)}")

    body = {"tree": entries}
    if base_tree:
        body["base_tree"] = base_tree
    new_tree = gh.call("POST", f"/repos/{args.owner}/{args.repo}/git/trees", body)
    log(f"tree={new_tree['sha'][:8]} entries={len(entries)}")

    new_commit = gh.call("POST", f"/repos/{args.owner}/{args.repo}/git/commits",
                         {"message": args.message, "tree": new_tree["sha"], "parents": parents})
    cs = new_commit["sha"]
    log(f"commit={cs[:8]}")

    if parents or args.orphan:
        gh.call("PATCH", f"/repos/{args.owner}/{args.repo}/git/refs/heads/{args.branch}",
                {"sha": cs, "force": bool(args.orphan)})
    else:
        gh.call("POST", f"/repos/{args.owner}/{args.repo}/git/refs",
                {"ref": f"refs/heads/{args.branch}", "sha": cs})
    log(f"OK 分支 {args.branch} → {cs}")

    if args.tag:
        msg = args.tag_message or args.tag
        tag_obj = gh.call("POST", f"/repos/{args.owner}/{args.repo}/git/tags",
                          {"tag": args.tag, "message": msg, "object": cs, "type": "commit"})
        tag_sha = tag_obj["sha"]
        existed = gh.call("GET", f"/repos/{args.owner}/{args.repo}/git/ref/tags/{args.tag}",
                          allow=(404,))
        if isinstance(existed, dict) and existed.get("ref"):
            gh.call("PATCH", f"/repos/{args.owner}/{args.repo}/git/refs/tags/{args.tag}",
                    {"sha": tag_sha, "force": True})
            log(f"OK tag {args.tag} 已更新 → {tag_sha[:8]}")
        else:
            gh.call("POST", f"/repos/{args.owner}/{args.repo}/git/refs",
                    {"ref": f"refs/tags/{args.tag}", "sha": tag_sha})
            log(f"OK tag {args.tag} → {tag_sha[:8]} (annotated)")

    return 0


if __name__ == "__main__":
    sys.exit(main())