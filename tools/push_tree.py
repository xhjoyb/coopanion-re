import argparse
import base64
import hashlib
import json
import os
import sys
import time
import urllib.error
import urllib.request
from concurrent.futures import ThreadPoolExecutor

API = "https://api.github.com"

EXCLUDED_DIRS = {
    ".git", ".gradle", "build", ".idea", ".operit", ".backup",
    "keystore", "__pycache__", "output", ".cxx", ".externalNativeBuild",
    "captures", "release",
}
EXCLUDED_SUFFIXES = (".apk", ".aab", ".jks", ".keystore", ".p12", ".iml", ".hprof", ".log")
EXCLUDED_FILES = {"local.properties", "keystore.properties", ".DS_Store", "Thumbs.db"}
EXECUTABLE_NAMES = {"gradlew"}


def log(msg):
    print(msg, flush=True)


class GhApi:
    def __init__(self, token):
        self.token = token

    def call(self, method, path, body=None, retries=4):
        url = path if path.startswith("http") else API + path
        data = None if body is None else json.dumps(body).encode("utf-8")
        headers = {
            "Authorization": "Bearer " + self.token,
            "Accept": "application/vnd.github+json",
            "X-GitHub-Api-Version": "2022-11-28",
            "User-Agent": "operit-push-tree",
        }
        if data is not None:
            headers["Content-Type"] = "application/json"
        last = None
        for attempt in range(1, retries + 1):
            req = urllib.request.Request(url, data=data, headers=headers, method=method)
            try:
                with urllib.request.urlopen(req, timeout=90) as resp:
                    raw = resp.read()
                    return json.loads(raw.decode("utf-8")) if raw else None
            except urllib.error.HTTPError as e:
                payload = e.read().decode("utf-8", "replace")[:300]
                if e.code in (403, 429, 500, 502, 503, 504) and attempt < retries:
                    wait = 2 ** attempt
                    log("  ! HTTP %d on %s %s, retry in %ds" % (e.code, method, path, wait))
                    time.sleep(wait)
                    last = "HTTP %d: %s" % (e.code, payload)
                    continue
                raise RuntimeError("HTTP %d %s %s\n%s" % (e.code, method, url, payload))
            except Exception as e:
                if attempt < retries:
                    wait = 2 ** attempt
                    log("  ! %s on %s, retry in %ds" % (type(e).__name__, path, wait))
                    time.sleep(wait)
                    last = str(e)
                    continue
                raise RuntimeError("%s %s %s: %s" % (type(e).__name__, method, url, e))
        raise RuntimeError("failed: %s" % last)


def blob_sha(data):
    return hashlib.sha1(b"blob %d\0" % len(data) + data).hexdigest()


def collect(root, prefix, extras):
    out = []
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames[:] = sorted(d for d in dirnames if d not in EXCLUDED_DIRS)
        for name in sorted(filenames):
            if name in EXCLUDED_FILES or name.endswith(EXCLUDED_SUFFIXES):
                continue
            full = os.path.join(dirpath, name)
            if os.path.islink(full):
                continue
            rel = os.path.relpath(full, root).replace(os.sep, "/")
            if rel.startswith(".ci/"):
                continue
            with open(full, "rb") as fh:
                data = fh.read()
            mode = "100755" if name in EXECUTABLE_NAMES else "100644"
            out.append((prefix + "/" + rel if prefix else rel, data, mode))
    for src, dst in extras:
        full = os.path.join(root, src)
        if not os.path.exists(full):
            log("  ! extra missing: %s" % src)
            continue
        with open(full, "rb") as fh:
            data = fh.read()
        out.append((dst, data, "100644"))
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--owner", required=True)
    ap.add_argument("--repo", required=True)
    ap.add_argument("--branch", default="main")
    ap.add_argument("--dir", default=".")
    ap.add_argument("--prefix", default="")
    ap.add_argument("--message", required=True)
    ap.add_argument("--extra", action="append", default=[], help="src=dst，可多次")
    ap.add_argument("--token", default=os.environ.get("GH_TOKEN", ""))
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--workers", type=int, default=6)
    args = ap.parse_args()

    if not args.token:
        log("ERROR: 缺少 token")
        return 2

    extras = []
    for item in args.extra:
        src, dst = item.split("=", 1)
        extras.append((src, dst))

    gh = GhApi(args.token)
    root = os.path.abspath(args.dir)
    files = collect(root, args.prefix.strip("/"), extras)
    total = sum(len(d) for _, d, _ in files)
    log("本地文件 %d 个，%.1f KB，prefix=%s" % (len(files), total / 1024.0, args.prefix or "(root)"))

    ref_path = "/repos/%s/%s/git/ref/heads/%s" % (args.owner, args.repo, args.branch)
    try:
        ref = gh.call("GET", ref_path)
    except RuntimeError as e:
        log("分支不存在或读取失败：%s" % str(e)[:120])
        ref = None
    base_tree, parents = None, []
    if isinstance(ref, dict) and ref.get("object", {}).get("sha"):
        base_commit = ref["object"]["sha"]
        parents = [base_commit]
        commit = gh.call("GET", "/repos/%s/%s/git/commits/%s" % (args.owner, args.repo, base_commit))
        base_tree = commit["tree"]["sha"]
        log("分支 %s @ %s base_tree=%s" % (args.branch, base_commit[:8], base_tree[:8]))

    remote = {}
    if base_tree:
        tree = gh.call("GET", "/repos/%s/%s/git/trees/%s?recursive=1" % (args.owner, args.repo, base_tree))
        for item in tree.get("tree", []):
            if item.get("type") == "blob":
                remote[item["path"]] = item["sha"]
        log("远端已有 blob %d 个" % len(remote))

    todo = []
    entries = []
    for path, data, mode in files:
        sha = blob_sha(data)
        if remote.get(path) != sha:
            todo.append((path, data, mode))
        entries.append({"path": path, "mode": mode, "type": "blob", "sha": sha})

    log("待上传 %d 个，可复用 %d 个" % (len(todo), len(files) - len(todo)))
    if args.dry_run:
        for p, d, _ in todo[:200]:
            log("  [dry] %s (%d B)" % (p, len(d)))
        return 0

    ok = [0]

    def up(item):
        path, data, _ = item
        resp = gh.call("POST", "/repos/%s/%s/git/blobs" % (args.owner, args.repo),
                       {"content": base64.b64encode(data).decode("ascii"), "encoding": "base64"})
        ok[0] += 1
        if ok[0] % 25 == 0:
            log("  ... uploaded %d/%d" % (ok[0], len(todo)))
        return path, resp["sha"]

    sha_map = {}
    if todo:
        with ThreadPoolExecutor(max_workers=args.workers) as ex:
            for path, sha in ex.map(up, todo):
                sha_map[path] = sha
    for e in entries:
        if e["path"] in sha_map:
            e["sha"] = sha_map[e["path"]]

    tree_body = {"tree": entries}
    if base_tree:
        tree_body["base_tree"] = base_tree
    new_tree = gh.call("POST", "/repos/%s/%s/git/trees" % (args.owner, args.repo), tree_body)
    log("tree=%s" % new_tree["sha"][:8])

    new_commit = gh.call("POST", "/repos/%s/%s/git/commits" % (args.owner, args.repo),
                         {"message": args.message, "tree": new_tree["sha"], "parents": parents})
    log("commit=%s" % new_commit["sha"][:8])

    if parents:
        res = gh.call("PATCH", "/repos/%s/%s/git/refs/heads/%s" % (args.owner, args.repo, args.branch),
                      {"sha": new_commit["sha"], "force": False})
        if not isinstance(res, dict) or res.get("object", {}).get("sha") != new_commit["sha"]:
            raise RuntimeError("ref 更新失败: %s" % res)
    else:
        gh.call("POST", "/repos/%s/%s/git/refs" % (args.owner, args.repo),
                {"ref": "refs/heads/%s" % args.branch, "sha": new_commit["sha"]})
    log("OK -> %s/%s:%s %s" % (args.owner, args.repo, args.branch, new_commit["sha"]))
    return 0


if __name__ == "__main__":
    sys.exit(main())