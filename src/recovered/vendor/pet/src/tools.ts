/** Tool declarations; `DesktopPetWorld.tools()` binds the handlers. */
import type { ToolDef } from 'cortico/core/types.ts';

export const DESKTOP_PET_TOOL_DECLS: ReadonlyArray<Omit<ToolDef, 'handler'>> = [
  {
    name: 'pet_say',
    tags: ['speak'],
    description: '在桌宠头顶冒出对话气泡说话。表情和动作写成标记放进 script:【】先做动作再换一个新气泡,<> 打字到那里时做。回执报告大约显示多久;窗口没连接时失败。',
    parameters: {
      type: 'object',
      properties: {
        script: { type: 'string', description: '要说的话,可夹带【表情,动作】与 <表情> 标记。一个气泡一两句。不想说话就不要调用。' },
      },
      required: ['script'],
    },
  },
  {
    name: 'pet_ask',
    tags: ['speak'],
    description: '冒出一个提问气泡,下面列出最多 3 个选项,默认再加一格让对方自己写。立即返回;对方的回答以 [回答] 事件送达,关掉不答也会送达。新的 pet_say 或 pet_ask 会替换还没回答的提问。',
    parameters: {
      type: 'object',
      properties: {
        question: { type: 'string', description: '问题,一句话。' },
        options: { type: 'array', items: { type: 'string' }, maxItems: 3, description: '1–3 个简短选项,每个不超过 40 字。' },
        allowOwnAnswer: { type: 'boolean', description: '是否提供自己写回答的输入格,默认 true。' },
      },
      required: ['question', 'options'],
    },
  },
  {
    name: 'pet_walk_to',
    tags: ['act'],
    description: '沿屏幕底边走(或跑)到某个位置,走到或被打断后返回,最多等 30 秒。',
    parameters: {
      type: 'object',
      properties: {
        to: { description: '目标:0–1 的数字(屏幕宽度比例,0 最左、1 最右),或 left / center / right / cursor(鼠标所在的横向位置)。', anyOf: [{ type: 'number', minimum: 0, maximum: 1 }, { type: 'string', enum: ['left', 'center', 'right', 'cursor'] }] },
        run: { type: 'boolean', description: 'true 跑过去,默认走过去。' },
      },
      required: ['to'],
    },
  },
  {
    name: 'pet_act',
    tags: ['act'],
    description: '不说话,依次做一串表情或动作(词表见环境说明)。立即返回;sit 和 sleep 会一直保持到下一个动作。',
    parameters: {
      type: 'object',
      properties: {
        actions: { type: 'array', items: { type: 'string' }, minItems: 1, maxItems: 6, description: '表情或动作的词,按顺序执行。' },
      },
      required: ['actions'],
    },
  },
  {
    name: 'pet_open_app',
    tags: ['act'],
    description: '打开/启动用户设备上的一个应用（按应用名或包名模糊匹配已安装的应用）。用于「帮我打开微信」「打开相册」这类请求。找到了就返回已发起启动，找不到或没权限则失败。',
    parameters: {
      type: 'object',
      properties: {
        name: { type: 'string', description: '要打开的应用名或包名，例如「微信」「bilibili」「com.tencent.mm」。用简短关键词即可。' },
      },
      required: ['name'],
    },
  },
  {
    name: 'eyes_look',
    tags: ['read', 'snapshot'],
    description: '看一眼对方手机现在这块屏幕：返回前台应用、屏幕上能读到的文字,并把画面截图一起给你(能看图的模型会拿到图片本身)。你想主动看一眼、或者想看清刚才那条 [画面] 事件时用它。手机系统里「无障碍 → Coopanion 眼睛」没打开时会失败并说明。',
    parameters: {
      type: 'object',
      properties: {
        detail: { type: 'string', enum: ['both', 'screen', 'text'], description: 'both 画面加文字(默认);screen 只要画面;text 只要文字,省流量也不占上下文。' },
      },
      required: [],
    },
  },
  {
    name: 'eyes_watch',
    tags: ['act'],
    description: '开关「自己看屏幕」:开着时你会隔一会儿瞄一眼对方在用什么应用、屏幕上是些什么,画面明显变了或停了很久就自己开口吐槽,不用别人叫你。默认开着;对方嫌你吵时用它关掉,想让你重新盯着时打开。',
    parameters: {
      type: 'object',
      properties: {
        on: { type: 'boolean', description: 'true 盯着屏幕,false 停下来不再自己看。' },
        intervalSec: { type: 'integer', minimum: 5, maximum: 600, description: '隔多少秒瞄一眼,默认 20。越大越安静。' },
      },
      required: [],
    },
  },
  {
    name: 'eyes_open_settings',
    tags: ['act'],
    description: '打开手机系统的无障碍设置页,用于「眼睛」没被打开、对方愿意去开一下的时候。返回是否已经跳转。',
    parameters: { type: 'object', properties: {}, required: [] },
  },
];
