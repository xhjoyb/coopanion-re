#!/usr/bin/env python3
# -*- coding: utf-8 -*-
r"""MT MCP 直连客户端（绕过 Operit 包注入，直打 127.0.0.1:8786/mcp）。

用法：
  python3 src/mt.py list                      # 列出工具名
  python3 src/mt.py schema <tool>             # 打印某工具 inputSchema
  python3 src/mt.py call <tool> '<json>'      # 调用工具，打印 result
  python3 src/mt.py callf <tool> <file.json>  # 从文件读参数调用

说明：
  - MT MCP 走 JSON-RPC 2.0 over HTTP，协议版本 2025-11-25（服务端自报），
    这里固定按无状态单次请求调用，不维护 session。
  - 输出统一 pretty-print，便于直接看 workspaceId / editSessionId / locator。
"""

import json
import sys
import urllib.request

URL = 'http://127.0.0.1:8786/mcp'


def rpc(method, params=None, _id=1):
    body = json.dumps({'jsonrpc': '2.0', 'id': _id, 'method': method,
                       'params': params or {}}, ensure_ascii=False).encode('utf-8')
    req = urllib.request.Request(URL, data=body, headers={
        'Content-Type': 'application/json',
        'Accept': 'application/json, text/event-stream',
    })
    with urllib.request.urlopen(req, timeout=180) as r:
        raw = r.read().decode('utf-8', 'replace')
    # 兼容 SSE 包装（event: message\ndata: {...}）
    if raw.lstrip().startswith('event:') or '\ndata: ' in raw:
        parts = [ln[5:].strip() for ln in raw.splitlines() if ln.startswith('data:')]
        raw = parts[-1] if parts else raw
    return json.loads(raw)


def call_tool(name, args):
    res = rpc('tools/call', {'name': name, 'arguments': args}, 2)
    if 'error' in res:
        print('RPC ERROR:', json.dumps(res['error'], ensure_ascii=False, indent=2))
        return 1
    content = res['result'].get('content') or []
    for c in content:
        if c.get('type') == 'text':
            try:
                obj = json.loads(c['text'])
                print(json.dumps(obj, ensure_ascii=False, indent=2))
            except Exception:
                print(c['text'])
        else:
            print(json.dumps(c, ensure_ascii=False, indent=2))
    return 0


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        return 1
    cmd = sys.argv[1]
    if cmd == 'list':
        res = rpc('tools/list', {}, 3)
        for t in res['result']['tools']:
            print(t['name'])
        return 0
    if cmd == 'schema':
        res = rpc('tools/list', {}, 3)
        for t in res['result']['tools']:
            if t['name'] == sys.argv[2]:
                print(json.dumps({'description': t.get('description'),
                                  'inputSchema': t.get('inputSchema')},
                                 ensure_ascii=False, indent=2))
                return 0
        print('no such tool')
        return 1
    if cmd == 'call':
        return call_tool(sys.argv[2], json.loads(sys.argv[3]))
    if cmd == 'callf':
        with open(sys.argv[3], encoding='utf-8') as f:
            return call_tool(sys.argv[2], json.load(f))
    print(__doc__)
    return 1


if __name__ == '__main__':
    sys.exit(main())