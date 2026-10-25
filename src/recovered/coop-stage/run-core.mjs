import { fileURLToPath } from 'node:url';
import { join, dirname } from 'node:path';
import { cpSync, existsSync, readdirSync, statSync, writeFileSync } from 'node:fs';

const __dirname = dirname(fileURLToPath(import.meta.url));
process.env.CORTICO_COMPANION_ROOT = join(__dirname, 'build', 'cortico');
process.env.CORTICO_HOME = join(__dirname, 'home');
process.env.CORTICO_EXTENSIONS_DIR = join(__dirname, 'data', 'extensions');

/**
 * 升级不丢记忆。
 *
 * Android 壳层按「版本号 + payload 长度」算出指纹，指纹一变就把 rootfs 解压到一个**新目录**，
 * 于是桌宠的 workspace 记忆、设置和 providers 里的 API Key 全被留在了旧目录里。
 * 旧目录还在同一个应用私有目录下，而 /proc/self/root 让 proot 里的进程也能看到宿主路径，
 * 所以这里把上一个指纹目录里的 home 搬过来一次。搬不动就算了，不影响启动。
 */
function carryOverHome(home) {
  const marker = join(home, '.carried-over');
  try {
    if (existsSync(marker)) return;
    let mine = -1;
    try {
      mine = statSync(join(home, '..')).ino;
    } catch {
      mine = -1;
    }
    const bases = [
      '/proc/self/root/data/user/0/com.palai.prootsmoke/files',
      '/proc/self/root/data/data/com.palai.prootsmoke/files',
    ];
    let best = null;
    for (const base of bases) {
      if (!existsSync(base)) continue;
      for (const name of readdirSync(base)) {
        if (!name.startsWith('rootfs-v8-')) continue;
        const stage = join(base, name, 'app', 'coop-stage');
        const theirs = join(stage, 'home');
        if (!existsSync(join(theirs, 'companion', 'config.json'))) continue;
        let ino = -2;
        try {
          ino = statSync(stage).ino;
        } catch {
          continue;
        }
        if (ino === mine) continue; // 就是当前这一份
        let stamp = 0;
        try {
          stamp = statSync(join(theirs, 'companion', 'data')).mtimeMs;
        } catch {
          stamp = statSync(theirs).mtimeMs;
        }
        if (!best || stamp > best.stamp) best = { dir: theirs, stamp, name };
      }
    }
    if (best) {
      cpSync(best.dir, home, {
        recursive: true,
        force: true,
        errorOnExist: false,
        // 别把上一份的实例锁和历史运行日志搬过来
        filter: (src) => !/instance\.lock$/.test(src) && !src.includes('/data/runs'),
      });
      console.log('[RUN] 已把上一个 rootfs 里的家搬回来：' + best.name);
    }
    writeFileSync(marker, new Date().toISOString() + '\n');
  } catch (err) {
    console.log('[RUN] 搬旧家失败（忽略）：' + (err && err.message ? err.message : String(err)));
  }
}

carryOverHome(join(__dirname, 'home'));

console.log('[RUN] root=' + process.env.CORTICO_COMPANION_ROOT);
await import(join(__dirname, 'app', 'core', 'boot.ts'));
