/**
 * 反馈修复 Agent（P0：只读诊断）
 *
 * 独立模块，不依赖宿主内核，只做「读日志 + 读源码 + 调用户已配置的模型 → 出诊断」。
 * - Key 来源：home/providers/<activeProvider>/.env（与宿主同源，token 走用户）
 * - 黑盒：对外只暴露 { status, summary, steps }，绝不返回代码/diff/原始日志
 * - 只读：P0 不写任何文件，零风险
 */
import { existsSync, readFileSync, readdirSync, statSync } from 'node:fs';
import { join, resolve } from 'node:path';

/** 对外可见的结果：黑盒，无代码、无 diff、无原始日志。 */
export interface RepairReport {
  status: 'no_key' | 'analyzing' | 'diagnosed' | 'failed';
  /** 一句话结论（面向用户，安全）。 */
  summary: string;
  /** 给用户看的步骤/建议（安全，无代码）。 */
  steps: string[];
  /** 本次消耗估算（tokens），仅用于告知用户。 */
  tokens: number;
}

export interface RepairAgentOptions {
  /** 部署根（CORTICO_HOME），含 providers/ 与 companion/。 */
  home: string;
  /** 源码根（pet 包所在 stage 目录），诊断时只读扫描。 */
  stageRoot: string;
}

const MAX_LOG_CHARS = 12000;   // 喂给模型的日志片段上限
const MAX_SRC_CHARS = 16000;   // 源码片段上限
const MAX_SRC_FILES = 12;

/** 读一个 provider 的 config.json。 */
function readProviderConfig(home: string, name: string): { baseUrl: string; secret: string; model: string; multimodal: boolean } | null {
  const cfg = join(home, 'providers', name, 'config.json');
  if (!existsSync(cfg)) return null;
  try {
    const j = JSON.parse(readFileSync(cfg, 'utf8')) as Record<string, unknown>;
    const spec = (j.spec ?? {}) as Record<string, unknown>;
    return {
      baseUrl: String(j.baseUrl ?? '').replace(/\/+$/, ''),
      secret: String(j.secret ?? ''),
      model: String(spec.model ?? ''),
      multimodal: j.multimodal === true,
    };
  } catch {
    return null;
  }
}

/** 从 .env 或进程环境按名取 key（与宿主 secretReader 同规则）。 */
function readSecret(home: string, provider: string, name: string): string {
  const fromEnv = process.env[name];
  if (fromEnv) return fromEnv;
  const file = join(home, 'providers', provider, '.env');
  if (!existsSync(file)) return '';
  const m = new RegExp(`^[ \\t]*${name}[ \\t]*=[ \\t]*(\\S+)`, 'm').exec(readFileSync(file, 'utf8'));
  return m ? m[1] : '';
}

/** 当前激活的 provider 名。 */
function activeProvider(home: string): string {
  const cfg = join(home, 'companion', 'config.json');
  if (!existsSync(cfg)) return 'deepseek';
  try {
    return String((JSON.parse(readFileSync(cfg, 'utf8')) as Record<string, unknown>).activeProvider ?? 'deepseek');
  } catch {
    return 'deepseek';
  }
}

/** 收集最近的运行日志（只读尾部）。 */
function collectLogs(home: string): string {
  const runs = join(home, 'companion', 'data', 'runs');
  if (!existsSync(runs)) return '';
  const dirs = readdirSync(runs, { withFileTypes: true })
    .filter((d) => d.isDirectory() && d.name.startsWith('r-'))
    .map((d) => ({ name: d.name, mtime: statSync(join(runs, d.name)).mtimeMs }))
    .sort((a, b) => b.mtime - a.mtime)
    .slice(0, 2);
  const out: string[] = [];
  for (const d of dirs) {
    for (const f of ['log.jsonl', 'events.jsonl']) {
      const p = join(runs, d.name, f);
      if (!existsSync(p)) continue;
      const txt = readFileSync(p, 'utf8');
      out.push(`--- ${d.name}/${f} (尾部) ---\n` + txt.slice(-MAX_LOG_CHARS / 2));
    }
  }
  return out.join('\n').slice(-MAX_LOG_CHARS);
}

/** 按关键词在源码里找相关片段（只读）。 */
function collectRelatedSource(stageRoot: string, keywords: string[]): string {
  const hits: string[] = [];
  const roots = [join(stageRoot, 'vendor', 'pet', 'src'), join(stageRoot, 'app', 'core'), join(stageRoot, 'vendor', 'pet', 'web')];
  const exts = new Set(['.ts', '.js']);
  const walk = (dir: string): void => {
    if (hits.length >= MAX_SRC_FILES * 400 || !existsSync(dir)) return;
    for (const e of readdirSync(dir, { withFileTypes: true })) {
      if (e.name === 'node_modules' || e.name.startsWith('.')) continue;
      const p = join(dir, e.name);
      if (e.isDirectory()) { walk(p); continue; }
      if (!exts.has(p.slice(p.lastIndexOf('.')))) continue;
      const txt = readFileSync(p, 'utf8');
      for (const kw of keywords) {
        const i = txt.indexOf(kw);
        if (i < 0) continue;
        const seg = txt.slice(Math.max(0, i - 200), i + 400);
        hits.push(`--- ${resolve(p)} [${kw}] ---\n${seg}`);
        break;
      }
    }
  };
  for (const r of roots) walk(r);
  return hits.join('\n').slice(-MAX_SRC_CHARS);
}

/** 调模型（OpenAI 兼容 /chat/completions）。返回文本 + 用量。 */
async function callModel(
  baseUrl: string, key: string, model: string,
  messages: Array<Record<string, unknown>>,
): Promise<{ text: string; tokens: number }> {
  const res = await fetch(`${baseUrl}/chat/completions`, {
    method: 'POST',
    headers: { 'content-type': 'application/json', authorization: `Bearer ${key}` },
    body: JSON.stringify({ model, messages, max_tokens: 1200, stream: false }),
  });
  if (!res.ok) throw new Error(`模型返回 ${res.status}`);
  const j = (await res.json()) as { choices?: Array<{ message?: { content?: string } }>; usage?: { total_tokens?: number } };
  const text = j.choices?.[0]?.message?.content ?? '';
  const tokens = Number(j.usage?.total_tokens ?? 0);
  return { text, tokens };
}

const SYSTEM_PROMPT = [
  '你是桌面宠物软件的故障诊断助手，运行在用户手机内的 proot 环境里。',
  '你会收到：用户反馈、若干日志片段、若干相关源码片段。',
  '任务：判断问题最可能的原因，并给用户一段【不含任何代码、函数名、文件路径、变量名】的白话说明和修复建议。',
  '严格只输出 JSON：{"summary":"一句话结论","steps":["建议1","建议2"]}。',
  '不要输出代码、diff、文件名、函数名、行号、堆栈。若证据不足，summary 写"信息不足，请补充现象截图或描述"。',
].join('\n');

/** 只读诊断：读日志 + 相关源码 → 调用户模型 → 返回黑盒报告。 */
export async function diagnose(opts: RepairAgentOptions, userReport: string, imageDataUrl?: string): Promise<RepairReport> {
  const { home, stageRoot } = opts;
  const provider = activeProvider(home);
  const conf = readProviderConfig(home, provider);
  if (!conf || !conf.baseUrl || !conf.secret) return fail('没有找到模型配置');
  const key = readSecret(home, provider, conf.secret);
  if (!key) return { status: 'no_key', summary: '还没有配置大模型 API，本功能需要你先在设置里填好 API Key。', steps: [], tokens: 0 };

  const keywords = userReport.split(/[\s,，。、]+/).filter((w) => w.length >= 2).slice(0, 8);
  const logs = collectLogs(home);
  const src = keywords.length ? collectRelatedSource(stageRoot, keywords) : '';

  const parts = [`【用户反馈】\n${userReport || '(未填写)'}`];
  if (logs) parts.push(`【最近日志】\n${logs}`);
  if (src) parts.push(`【相关源码片段（仅供你判断，不要转述给用户）】\n${src}`);
  const content: Array<Record<string, unknown>> = [{ type: 'text', text: parts.join('\n\n') }];
  if (imageDataUrl && conf.multimodal) content.push({ type: 'image_url', image_url: { url: imageDataUrl } });

  let text = '';
  let tokens = 0;
  try {
    const r = await callModel(conf.baseUrl, key, conf.model, [
      { role: 'system', content: SYSTEM_PROMPT },
      { role: 'user', content },
    ]);
    text = r.text; tokens = r.tokens;
  } catch (e) {
    return fail(`调用模型失败：${e instanceof Error ? e.message : String(e)}`);
  }

  let parsed: { summary?: string; steps?: string[] } = {};
  try { parsed = JSON.parse(text.replace(/^```json\s*|\s*```$/g, '')) as typeof parsed; } catch { /* 容错 */ }
  const summary = clean(parsed.summary) || '诊断完成，但未能确定具体原因，建议补充现象描述或截图。';
  const steps = (parsed.steps ?? []).map(clean).filter(Boolean).slice(0, 5);
  return { status: 'diagnosed', summary, steps, tokens };
}

/** 过滤掉可能泄露代码/路径的行。 */
function clean(s: unknown): string {
  let t = String(s ?? '').trim();
  t = t.replace(/[\w./-]+\.(ts|js|json|java|so)\b/g, '某文件');
  t = t.replace(/`[^`]*`/g, '相关代码');
  return t.slice(0, 300);
}

function fail(msg: string): RepairReport {
  return { status: 'failed', summary: msg, steps: [], tokens: 0 };
}
