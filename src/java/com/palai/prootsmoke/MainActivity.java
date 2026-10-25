package com.palai.prootsmoke;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.AssetFileDescriptor;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.provider.Settings;
import android.util.Log;
import android.view.View;
import android.webkit.PermissionRequest;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Button;
import android.widget.HorizontalScrollView;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.TextView;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.lang.reflect.Method;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.zip.GZIPInputStream;

/* JADX INFO: loaded from: /home/runner/work/coopanion-re/coopanion-re/src/x/classes.dex */
public class MainActivity extends Activity {
    private static final int PET_MAX_RETRY = 20;
    private static final int PET_RETRY_INTERVAL = 1500;
    private static final int REQ_MIC = 10087;
    private static final int REQ_OVERLAY = 10086;
    private static final String TAG = "ProotSmoke";
    private static final AtomicBoolean petWinOn = new AtomicBoolean(false);
    private ScrollView logScroll;
    private LinearLayout root;
    private TextView statusTv;
    private TextView tv;
    private WebView web;
    private volatile boolean coreReady = false;
    private volatile boolean booting = false;
    private String pendingName = null;
    private String pendingLink = null;
    private int petRetry = 0;

    private void syncPetSw(boolean z) {
    }

    private void setStatus(final String str) {
        runOnUiThread(new Runnable() { // from class: com.palai.prootsmoke.MainActivity.1
            @Override // java.lang.Runnable
            public void run() {
                if (MainActivity.this.statusTv != null) {
                    MainActivity.this.statusTv.setText(str);
                }
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void log(final String str) {
        Log.i(TAG, str);
        try {
            File externalFilesDir = getExternalFilesDir(null);
            if (externalFilesDir == null) {
                externalFilesDir = getFilesDir();
            }
            FileOutputStream fileOutputStream = new FileOutputStream(new File(externalFilesDir, "coop-run.log"), true);
            fileOutputStream.write((str + "\n").getBytes("UTF-8"));
            fileOutputStream.close();
        } catch (Throwable unused) {
        }
        runOnUiThread(new Runnable() { // from class: com.palai.prootsmoke.MainActivity.2
            @Override // java.lang.Runnable
            public void run() {
                if (MainActivity.this.tv != null) {
                    MainActivity.this.tv.append(str + "\n");
                    if (MainActivity.this.logScroll != null) {
                        MainActivity.this.logScroll.post(new Runnable() { // from class: com.palai.prootsmoke.MainActivity.2.1
                            @Override // java.lang.Runnable
                            public void run() {
                                MainActivity.this.logScroll.fullScroll(130);
                            }
                        });
                    }
                }
            }
        });
    }

    private void askMicOnce() {
        try {
            if (checkSelfPermission("android.permission.RECORD_AUDIO") == 0) {
                return;
            }
            SharedPreferences sharedPreferences = getSharedPreferences("coopanion", 0);
            if (sharedPreferences.getBoolean("mic_asked", false)) {
                return;
            }
            sharedPreferences.edit().putBoolean("mic_asked", true).apply();
            requestPermissions(new String[]{"android.permission.RECORD_AUDIO"}, REQ_MIC);
        } catch (Throwable unused) {
        }
    }

    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        AppLog.init(this);
        AppLog.i("[BOOT] ===== MainActivity onCreate =====");
        LinearLayout linearLayout = new LinearLayout(this);
        this.root = linearLayout;
        linearLayout.setOrientation(1);
        try {
            int identifier = getResources().getIdentifier("status_bar_height", "dimen", "android");
            this.root.setPadding(0, identifier > 0 ? getResources().getDimensionPixelSize(identifier) : 0, 0, 0);
        } catch (Throwable unused) {
        }
        HorizontalScrollView horizontalScrollView = new HorizontalScrollView(this);
        horizontalScrollView.setHorizontalScrollBarEnabled(false);
        LinearLayout linearLayout2 = new LinearLayout(this);
        linearLayout2.setOrientation(0);
        horizontalScrollView.addView(linearLayout2);
        Button button = new Button(this);
        button.setText("新手引导");
        button.setOnClickListener(new View.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.3
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                MainActivity.this.showGuide(0);
            }
        });
        linearLayout2.addView(button);
        Button button2 = new Button(this);
        button2.setText("重试启动");
        button2.setOnClickListener(new View.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.4
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                new Thread(new Runnable() { // from class: com.palai.prootsmoke.MainActivity.4.1
                    @Override // java.lang.Runnable
                    public void run() {
                        MainActivity.this.boot();
                    }
                }).start();
            }
        });
        linearLayout2.addView(button2);
        Button button3 = new Button(this);
        button3.setText("看桌宠");
        button3.setOnClickListener(new View.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.5
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                if (MainActivity.this.web == null) {
                    return;
                }
                MainActivity.this.petRetry = 0;
                MainActivity.this.loadPetWithRetry(0);
            }
        });
        linearLayout2.addView(button3);
        Button button4 = new Button(this);
        button4.setText("全屏桌宠");
        button4.setOnClickListener(new View.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.6
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                try {
                    MainActivity.this.startActivity(new Intent(MainActivity.this, (Class<?>) PetActivity.class));
                    MainActivity.this.log("[PET] 启动全屏桌宠 (PetActivity)");
                } catch (Throwable th) {
                    MainActivity.this.log("[PET] 启动 PetActivity 失败: " + th);
                }
            }
        });
        linearLayout2.addView(button4);
        Button button5 = new Button(this);
        button5.setText("控制台");
        button5.setOnClickListener(new View.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.7
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                if (MainActivity.this.web == null) {
                    return;
                }
                MainActivity.this.web.loadUrl("http://127.0.0.1:17788/");
                MainActivity.this.log("[PET] 切回控制台 -> http://127.0.0.1:17788/");
            }
        });
        linearLayout2.addView(button5);
        Button button6 = new Button(this);
        button6.setText("手机感知");
        button6.setOnClickListener(new View.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.8
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                MainActivity.this.openSenseSettings();
            }
        });
        linearLayout2.addView(button6);
        Button button7 = new Button(this);
        button7.setText("透明度");
        button7.setOnClickListener(new View.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.9
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                MainActivity.this.showAlphaDialog();
            }
        });
        linearLayout2.addView(button7);
        Button button8 = new Button(this);
        button8.setText("日志");
        button8.setOnClickListener(new View.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.10
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                if (MainActivity.this.logScroll == null) {
                    return;
                }
                boolean z = MainActivity.this.logScroll.getVisibility() != 0;
                MainActivity.this.logScroll.setVisibility(z ? 0 : 8);
                ((Button) view).setText(z ? "收起日志" : "日志");
            }
        });
        Button button9 = new Button(this);
        button9.setText("修复");
        button9.setOnClickListener(new View.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.11
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                try {
                    MainActivity.this.startActivity(new Intent(MainActivity.this, (Class<?>) RepairActivity.class));
                    MainActivity.this.log("[REPAIR] 打开修复助手 (RepairActivity)");
                } catch (Throwable th) {
                    MainActivity.this.log("[REPAIR] 打开失败: " + th);
                }
            }
        });
        linearLayout2.addView(button9);
        linearLayout2.addView(button8);
        this.root.addView(horizontalScrollView);
        TextView textView = new TextView(this);
        this.statusTv = textView;
        textView.setTextSize(16.0f);
        this.statusTv.setPadding(PET_MAX_RETRY, PET_MAX_RETRY, PET_MAX_RETRY, PET_MAX_RETRY);
        this.statusTv.setText("状态: 准备中...");
        this.root.addView(this.statusTv);
        TextView textView2 = new TextView(this);
        this.tv = textView2;
        textView2.setTextSize(9.0f);
        this.tv.setText("=== Coopanion Android 宿主 ===\n");
        ScrollView scrollView = new ScrollView(this);
        this.logScroll = scrollView;
        scrollView.addView(this.tv);
        scrollView.setVisibility(8);
        this.root.addView(scrollView, new LinearLayout.LayoutParams(-1, 0, 1.0f));
        WebView webView = new WebView(this);
        this.web = webView;
        webView.getSettings().setJavaScriptEnabled(true);
        this.web.getSettings().setDomStorageEnabled(true);
        this.web.getSettings().setMixedContentMode(0);
        this.web.setLayerType(2, null);
        this.web.setWebViewClient(new WebViewClient() { // from class: com.palai.prootsmoke.MainActivity.12
            @Override // android.webkit.WebViewClient
            public void onPageFinished(WebView webView2, String str) {
                MainActivity.this.log("[WEB] onPageFinished: " + str + " title=" + webView2.getTitle());
            }

            @Override // android.webkit.WebViewClient
            public void onReceivedError(WebView webView2, int i, String str, String str2) {
                MainActivity.this.log("[WEB-ERR] " + i + " " + str + " @ " + str2);
            }
        });
        this.web.setWebChromeClient(new WebChromeClient() { // from class: com.palai.prootsmoke.MainActivity.13
            @Override // android.webkit.WebChromeClient
            public void onPermissionRequest(final PermissionRequest permissionRequest) {
                boolean z = false;
                for (String str : permissionRequest.getResources()) {
                    if ("android.webkit.resource.AUDIO_CAPTURE".equals(str)) {
                        z = true;
                    }
                }
                if (z) {
                    MainActivity.this.log("[MIC] WebView 请求麦克风 -> 已放行");
                    MainActivity.this.runOnUiThread(new Runnable() { // from class: com.palai.prootsmoke.MainActivity.13.1
                        @Override // java.lang.Runnable
                        public void run() {
                            PermissionRequest permissionRequest2 = permissionRequest;
                            permissionRequest2.grant(permissionRequest2.getResources());
                        }
                    });
                } else {
                    MainActivity.this.runOnUiThread(new Runnable() { // from class: com.palai.prootsmoke.MainActivity.13.2
                        @Override // java.lang.Runnable
                        public void run() {
                            permissionRequest.deny();
                        }
                    });
                }
            }
        });
        this.root.addView(this.web, new LinearLayout.LayoutParams(-1, 0, 2.0f));
        setContentView(this.root);
        askMicOnce();
        try {
            SenseBridge.get(getApplicationContext()).start();
            log("[SENSE] bridge started on 127.0.0.1:17899");
        } catch (Throwable th) {
            log("[SENSE] bridge start failed: " + th);
        }
        try {
            this.root.postDelayed(new Runnable() { // from class: com.palai.prootsmoke.MainActivity.14
                @Override // java.lang.Runnable
                public void run() {
                    MainActivity.this.showGuide(0);
                }
            }, 1200L);
        } catch (Throwable th2) {
            log("[GUIDE] 自动引导失败: " + th2);
        }
        try {
            if (getSharedPreferences("coopanion", 0).getBoolean("pet_window_wanted", false)) {
                this.root.postDelayed(new Runnable() { // from class: com.palai.prootsmoke.MainActivity.15
                    @Override // java.lang.Runnable
                    public void run() {
                        if (MainActivity.this.canDrawOverlays() && !MainActivity.petWinOn.get()) {
                            MainActivity.this.log("[PET] 上次桌宠开着，自动恢复悬浮窗（v10.3：先等 7797 就绪）");
                            MainActivity.this.startPetWindowWhenReady();
                        } else {
                            if (MainActivity.this.canDrawOverlays()) {
                                return;
                            }
                            MainActivity.this.log("[PET] 上次桌宠开着，但悬浮窗权限没了");
                        }
                    }
                }, 2500L);
            }
        } catch (Throwable th3) {
            log("[PET] 自动恢复悬浮窗失败: " + th3);
        }
        new Thread(new Runnable() { // from class: com.palai.prootsmoke.MainActivity.16
            @Override // java.lang.Runnable
            public void run() {
                MainActivity.this.boot();
            }
        }).start();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void boot() {
        if (this.booting) {
            log("[BOOT] 已在启动中，忽略重复调用");
            return;
        }
        this.booting = true;
        try {
            doBoot();
        } finally {
            this.booting = false;
        }
    }

    private void doBoot() {
        long length;
        long j;
        File file;
        BufferedReader bufferedReader;
        log("[BOOT] 日志文件 = " + (getExternalFilesDir(null) != null ? getExternalFilesDir(null).getAbsolutePath() : "?") + "/coop-run.log");
        try {
            String str = getApplicationInfo().nativeLibraryDir;
            try {
                try {
                    try {
                        AssetFileDescriptor assetFileDescriptorOpenFd = getAssets().openFd("payload.asset");
                        length = assetFileDescriptorOpenFd.getLength();
                        try {
                            assetFileDescriptorOpenFd.close();
                            loop2: while (true) {
                                int i = 0;
                                while (true) {
                                    String line = bufferedReader.readLine();
                                    if (line == null) {
                                        break loop2;
                                    }
                                    log(line);
                                    if (line.contains("core已启动") && !this.coreReady) {
                                        this.coreReady = true;
                                        new Thread(new Runnable() { // from class: com.palai.prootsmoke.MainActivity.17
                                            @Override // java.lang.Runnable
                                            public void run() {
                                                if (!MainActivity.waitPortOpen("127.0.0.1", 17788, 60000)) {
                                                    MainActivity.this.log("[3] Web UI 端口超时未就绪");
                                                } else {
                                                    MainActivity.this.runOnUiThread(new Runnable() { // from class: com.palai.prootsmoke.MainActivity.17.1
                                                        @Override // java.lang.Runnable
                                                        public void run() {
                                                            MainActivity.this.log("[3] Web UI load (once) -> http://127.0.0.1:17788/");
                                                            MainActivity.this.web.loadUrl("http://127.0.0.1:17788/");
                                                        }
                                                    });
                                                }
                                            }
                                        }).start();
                                    }
                                    int i2 = i + 1;
                                    if (i2 > 500) {
                                        break;
                                    } else {
                                        i = i2;
                                    }
                                }
                            }
                        } catch (Throwable unused) {
                            try {
                                InputStream inputStreamOpen = getAssets().open("payload.asset");
                                byte[] bArr = new byte[65536];
                                long j2 = 0;
                                while (true) {
                                    int i3 = inputStreamOpen.read(bArr);
                                    if (i3 <= 0) {
                                        break;
                                    } else {
                                        j2 += (long) i3;
                                    }
                                }
                                inputStreamOpen.close();
                                length = j2;
                            } catch (Throwable unused2) {
                            }
                        }
                    } catch (Throwable unused3) {
                        length = -1;
                    }
                    j = getPackageManager().getPackageInfo(getPackageName(), 0).versionCode;
                } catch (Throwable unused4) {
                    j = 0;
                }
                File[] fileArrListFiles = getFilesDir().listFiles();
                if (fileArrListFiles != null) {
                    String name = file.getName();
                    for (File file2 : fileArrListFiles) {
                        String name2 = file2.getName();
                        if (file2.isDirectory() && name2.startsWith("rootfs-v8-") && !name2.equals(name)) {
                            try {
                                deleteRec(file2);
                                log("[0b] 清理旧 rootfs 目录: " + name2);
                            } catch (Throwable unused5) {
                            }
                        }
                    }
                }
            } catch (Throwable unused6) {
            }
            char c = 0;
            File file3 = new File(getFilesDir(), "rootfs-v8-" + j + "-" + length);
            File file4 = new File(file3, ".ok-v8-" + j + "-" + length);
            if (!file4.exists()) {
                log("[0] 检测到新指纹，解压到新目录 rootfs-v8-" + j + "-" + length + " ...");
                log("[1] 解压 rootfs (payload=" + length + "B, 耐心等 1-2 分钟) ...");
                long jCurrentTimeMillis = System.currentTimeMillis();
                file3.mkdirs();
                extractTarGz(getAssets().open("payload.asset"), file3);
                fixPerms(file3);
                int i4 = 5;
                try {
                    String[][] strArr = {new String[]{"app/coop-stage/node_modules/sherpa-onnx-node/node_modules/sherpa-onnx-linux-arm64/sherpa-onnx.node", "804112"}, new String[]{"app/coop-stage/node_modules/sherpa-onnx-node/node_modules/sherpa-onnx-linux-arm64/libonnxruntime.so", "34606912"}, new String[]{"app/coop-stage/node_modules/sherpa-onnx-node/node_modules/sherpa-onnx-linux-arm64/libsherpa-onnx-c-api.so", "4613032"}, new String[]{"app/coop-stage/node_modules/sherpa-onnx-node/node_modules/sherpa-onnx-linux-arm64/libsherpa-onnx-cxx-api.so", "281200"}, new String[]{"bin/node", "123024744"}};
                    int i5 = 0;
                    int i6 = 0;
                    while (i5 < i4) {
                        String[] strArr2 = strArr[i5];
                        File file5 = new File(file3, strArr2[c]);
                        file = file3;
                        try {
                            long j3 = Long.parseLong(strArr2[1]);
                            long length2 = file5.exists() ? file5.length() : -1L;
                            if (length2 != j3) {
                                log("[CHK] MISMATCH " + strArr2[0] + " got=" + length2 + " want=" + j3);
                                i6++;
                            }
                            i5++;
                            file3 = file;
                            strArr = strArr;
                            i4 = 5;
                            c = 0;
                        } catch (Throwable unused7) {
                        }
                    }
                    file = file3;
                    log("[CHK] critical files: " + (5 - i6) + "/5 OK" + (i6 > 0 ? "  <-- !!! 解压有问题，语音会失败" : ""));
                } catch (Throwable unused8) {
                    file = file3;
                }
                file4.createNewFile();
                log("    完成 " + (System.currentTimeMillis() - jCurrentTimeMillis) + "ms");
            } else {
                file = file3;
                log("[1] rootfs 已解压（指纹一致）");
            }
            File file6 = new File(getFilesDir(), "ptmp");
            file6.mkdirs();
            file6.setReadable(true, false);
            file6.setWritable(true, false);
            file6.setExecutable(true, false);
            log("[2] 启动 Coopanion Core ...");
            ArrayList arrayList = new ArrayList();
            arrayList.add(str + "/libproot.so");
            arrayList.add("-0");
            arrayList.add("-r");
            arrayList.add(file.getAbsolutePath());
            arrayList.add("--link2symlink");
            arrayList.add("-b");
            arrayList.add("/dev");
            arrayList.add("-b");
            arrayList.add("/proc");
            arrayList.add("-b");
            arrayList.add("/sys");
            arrayList.add("-b");
            arrayList.add(str + ":/hostlib");
            arrayList.add("-w");
            arrayList.add("/app/coop-stage");
            File file7 = file;
            if (new File(file7, "app/boot.sh").exists()) {
                arrayList.add("/bin/sh");
                arrayList.add("/app/boot.sh");
            } else {
                log("[1b] 未找到 boot.sh，直接用 run-core.mjs 兜底启动 ...");
                arrayList.add("/bin/node");
                arrayList.add("--experimental-transform-types");
                arrayList.add("run-core.mjs");
            }
            ProcessBuilder processBuilder = new ProcessBuilder(arrayList);
            processBuilder.redirectErrorStream(true);
            processBuilder.directory(file7);
            Map<String, String> mapEnvironment = processBuilder.environment();
            String absolutePath = file6.getAbsolutePath();
            mapEnvironment.put("TMPDIR", absolutePath);
            mapEnvironment.put("TMP", absolutePath);
            mapEnvironment.put("TEMP", absolutePath);
            mapEnvironment.put("PROOT_TMP_DIR", absolutePath);
            mapEnvironment.put("PROOT_LOADER", str + "/libprootloader.so");
            mapEnvironment.put("PROOT_LOADER_32", str + "/libprootloader32.so");
            mapEnvironment.put("PROOT_NO_SECCOMP", "1");
            mapEnvironment.put("HOME", "/root");
            mapEnvironment.put("LANG", "en_US.UTF-8");
            mapEnvironment.put("TZ", "Asia/Shanghai");
            mapEnvironment.put("CORTICO_SUPERVISED", "1");
            mapEnvironment.remove("LD_PRELOAD");
            Process processStart = processBuilder.start();
            bufferedReader = new BufferedReader(new InputStreamReader(processStart.getInputStream()));
            int iWaitFor = processStart.waitFor();
            File file8 = new File(file7, "app/coop-stage/home/companion/data/.restart-request");
            if (file8.exists()) {
                try {
                    file8.delete();
                } catch (Throwable unused9) {
                }
                log("[!] 检测到重启请求：扩展已安装，正在重启内核以生效 ...");
                log("[!] 重启中，请稍等 10~30 秒，控制台页面会自动刷新。");
                this.coreReady = false;
                try {
                    Thread.sleep(1000L);
                } catch (Throwable unused10) {
                }
                new Thread(new Runnable() { // from class: com.palai.prootsmoke.MainActivity.18
                    @Override // java.lang.Runnable
                    public void run() {
                        MainActivity.this.boot();
                    }
                }).start();
                return;
            }
            log("[4] core 进程结束 rc=" + iWaitFor);
        } catch (Throwable th) {
            log("[EXC] " + th);
            th.printStackTrace();
        }
    }

    private void extractTarGz(InputStream inputStream, File file) throws Exception {
        char c;
        char c2 = 0;
        BufferedInputStream bufferedInputStream = new BufferedInputStream(new GZIPInputStream(inputStream), 65536);
        int i = 512;
        byte[] bArr = new byte[512];
        loop0: while (readFull(bufferedInputStream, bArr, i) >= i) {
            int i2 = 0;
            while (true) {
                if (i2 >= i) {
                    break loop0;
                }
                if (bArr[i2] != 0) {
                    break;
                }
                i2++;
                i = 512;
            }
            String strCstr = cstr(bArr, 0, 100);
            long oct = parseOct(bArr, 124, 12);
            long oct2 = parseOct(bArr, 100, 8);
            char c3 = (char) bArr[156];
            String strCstr2 = cstr(bArr, 157, 100);
            String strCstr3 = cstr(bArr, 345, 155);
            if (strCstr3.length() > 0) {
                strCstr = strCstr3 + "/" + strCstr;
            }
            String strReplace = strCstr.replace("\\", "/");
            while (strReplace.startsWith("./")) {
                strReplace = strReplace.substring(2);
            }
            while (strReplace.endsWith("/")) {
                strReplace = strReplace.substring(0, strReplace.length() - 1);
            }
            if (strReplace.length() == 0) {
                skipExactly(bufferedInputStream, oct);
            } else {
                if (c3 == 'L' || c3 == 'K') {
                    c = 0;
                    int i3 = (int) oct;
                    byte[] bArr2 = new byte[i3];
                    readFull(bufferedInputStream, bArr2, i3);
                    String str = new String(bArr2, 0, i3, "UTF-8");
                    int iIndexOf = str.indexOf(0);
                    if (iIndexOf >= 0) {
                        str = str.substring(0, iIndexOf);
                    }
                    String strTrim = str.trim();
                    if (c3 == 'L') {
                        this.pendingName = strTrim;
                    } else {
                        this.pendingLink = strTrim;
                    }
                    skipPad(bufferedInputStream, oct);
                } else if (c3 == 'x' || c3 == 'g') {
                    c = 0;
                    int i4 = (int) oct;
                    byte[] bArr3 = new byte[i4];
                    readFull(bufferedInputStream, bArr3, i4);
                    for (String str2 : new String(bArr3, 0, i4, "UTF-8").split("\n")) {
                        int iIndexOf2 = str2.indexOf(32);
                        if (iIndexOf2 > 0) {
                            String strSubstring = str2.substring(iIndexOf2 + 1);
                            if (strSubstring.startsWith("path=")) {
                                this.pendingName = strSubstring.substring(5);
                            } else if (strSubstring.startsWith("linkpath=")) {
                                this.pendingLink = strSubstring.substring(9);
                            }
                        }
                    }
                    skipPad(bufferedInputStream, oct);
                } else {
                    String str3 = this.pendingName;
                    if (str3 != null && str3.length() > 0) {
                        strReplace = this.pendingName;
                        this.pendingName = null;
                    }
                    String str4 = this.pendingLink;
                    if (str4 != null && str4.length() > 0) {
                        strCstr2 = this.pendingLink;
                        this.pendingLink = null;
                    }
                    while (strReplace.startsWith("./")) {
                        strReplace = strReplace.substring(2);
                    }
                    while (strReplace.endsWith("/")) {
                        strReplace = strReplace.substring(0, strReplace.length() - 1);
                    }
                    if (strReplace.length() == 0) {
                        skipExactly(bufferedInputStream, oct);
                    } else {
                        File file2 = new File(file, strReplace);
                        if (c3 == '5') {
                            file2.mkdirs();
                        } else {
                            if (c3 == '2') {
                                try {
                                    if (file2.exists()) {
                                        file2.delete();
                                    }
                                    Runtime.getRuntime().exec(new String[]{"ln", "-sf", strCstr2, file2.getAbsolutePath()}).waitFor();
                                } catch (Throwable unused) {
                                }
                            } else if (c3 == '1') {
                                File file3 = new File(file, strCstr2);
                                File parentFile = file2.getParentFile();
                                if (parentFile != null) {
                                    parentFile.mkdirs();
                                }
                                if (file2.exists()) {
                                    file2.delete();
                                }
                                FileInputStream fileInputStream = new FileInputStream(file3);
                                FileOutputStream fileOutputStream = new FileOutputStream(file2);
                                c = 0;
                                try {
                                    byte[] bArr4 = new byte[65536];
                                    while (true) {
                                        int i5 = fileInputStream.read(bArr4);
                                        if (i5 <= 0) {
                                            break;
                                        } else {
                                            fileOutputStream.write(bArr4, 0, i5);
                                        }
                                    }
                                    fileInputStream.close();
                                    fileOutputStream.close();
                                    file2.setReadable(true, false);
                                    file2.setExecutable(true, false);
                                } catch (Throwable unused2) {
                                }
                            } else {
                                c = 0;
                                File parentFile2 = file2.getParentFile();
                                if (parentFile2 != null) {
                                    parentFile2.mkdirs();
                                }
                                FileOutputStream fileOutputStream2 = new FileOutputStream(file2);
                                copyN(bufferedInputStream, fileOutputStream2, oct);
                                fileOutputStream2.close();
                                file2.setReadable(true, false);
                                file2.setWritable(true, false);
                                if ((73 & oct2) != 0 || strReplace.startsWith("bin/") || strReplace.endsWith(".so") || strReplace.endsWith(".so.6") || strReplace.startsWith("app/")) {
                                    file2.setExecutable(true, false);
                                }
                            }
                            skipPad(bufferedInputStream, oct);
                        }
                        c = 0;
                        skipPad(bufferedInputStream, oct);
                    }
                }
                c2 = c;
                i = 512;
            }
            i = 512;
            c2 = 0;
        }
        bufferedInputStream.close();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static boolean waitPortOpen(String str, int i, int i2) {
        long jCurrentTimeMillis = System.currentTimeMillis() + ((long) i2);
        while (System.currentTimeMillis() < jCurrentTimeMillis) {
            Socket socket = null;
            try {
                Socket socket2 = new Socket();
                try {
                    socket2.connect(new InetSocketAddress(str, i), 1200);
                    try {
                        socket2.close();
                        return true;
                    } catch (Throwable unused) {
                        return true;
                    }
                } catch (Throwable unused2) {
                    socket = socket2;
                    try {
                        Thread.sleep(700L);
                    } catch (Throwable unused3) {
                    }
                    if (socket != null) {
                        try {
                            socket.close();
                        } catch (Throwable unused4) {
                        }
                    }
                }
            } catch (Throwable unused5) {
            }
        }
        return false;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void loadPetWithRetry(final int i) {
        if (this.web == null) {
            return;
        }
        this.petRetry = i;
        log("[PET] load pet page (attempt " + (i + 1) + "/20) ...");
        runOnUiThread(new Runnable() { // from class: com.palai.prootsmoke.MainActivity.19
            @Override // java.lang.Runnable
            public void run() {
                if (MainActivity.this.web == null) {
                    return;
                }
                MainActivity.this.web.loadDataWithBaseURL(null, "<html><body style='background:#0b0f14;color:#8aa;font-family:sans-serif;display:flex;align-items:center;justify-content:center;height:100%'><div style='text-align:center'>&#27491;&#22312;&#36830;&#25509;&#26700;&#23456;&#26381;&#21153;<br><small style='color:#567'>&#31532; " + (i + 1) + " / 20 &#27425;&#23581;&#35797;&#65292;&#35831;&#31245;&#31561;&#8230;</small></div></body></html>", "text/html", "UTF-8", null);
                MainActivity.this.web.loadUrl("http://127.0.0.1:7797/pet?host=app");
            }
        });
        new Handler(Looper.getMainLooper()).postDelayed(new AnonymousClass20(i), 2500L);
    }

    /* JADX INFO: renamed from: com.palai.prootsmoke.MainActivity$20, reason: invalid class name */
    class AnonymousClass20 implements Runnable {
        final /* synthetic */ int val$attempt;

        AnonymousClass20(int i) {
            this.val$attempt = i;
        }

        @Override // java.lang.Runnable
        public void run() {
            if (MainActivity.this.web == null) {
                return;
            }
            MainActivity.this.web.evaluateJavascript("(function(){try{if(!document||!document.body)return 'empty';var b=document.body;var t=b.innerText||'';if(t.indexOf('ERR_CONNECTION')>=0||t.indexOf('无法')>=0)return 'err';if(b.querySelector('canvas')||b.children.length>0)return 'ok';return 'empty';}catch(e){return 'err';}})()", new ValueCallback<String>() { // from class: com.palai.prootsmoke.MainActivity.20.1
                @Override // android.webkit.ValueCallback
                public void onReceiveValue(String str) {
                    String strTrim = str != null ? str.replace("\"", "").trim() : "";
                    if ("ok".equals(strTrim)) {
                        MainActivity.this.log("[PET] OK rendered (attempt " + (AnonymousClass20.this.val$attempt + 1) + ")");
                        return;
                    }
                    MainActivity.this.log("[PET] FAIL attempt " + (AnonymousClass20.this.val$attempt + 1) + " (" + strTrim + ")");
                    if (AnonymousClass20.this.val$attempt + 1 < MainActivity.PET_MAX_RETRY) {
                        new Handler(Looper.getMainLooper()).postDelayed(new Runnable() { // from class: com.palai.prootsmoke.MainActivity.20.1.1
                            @Override // java.lang.Runnable
                            public void run() {
                                MainActivity.this.loadPetWithRetry(AnonymousClass20.this.val$attempt + 1);
                            }
                        }, 1500L);
                    } else {
                        MainActivity.this.log("[PET] retry limit reached, stop");
                        MainActivity.this.runOnUiThread(new Runnable() { // from class: com.palai.prootsmoke.MainActivity.20.1.2
                            @Override // java.lang.Runnable
                            public void run() {
                                if (MainActivity.this.web == null) {
                                    return;
                                }
                                MainActivity.this.web.loadDataWithBaseURL(null, "<html><body style='background:#0b0f14;color:#c88;font-family:sans-serif;display:flex;align-items:center;justify-content:center;height:100%'><div style='text-align:center'>&#26700;&#23456;&#26381;&#21153;&#36830;&#25509;&#22833;&#36133;<br><small style='color:#567'>&#35831;&#30830;&#35748;&#20869;&#26680;&#24050;&#21551;&#21160;&#65292;&#28982;&#21518;&#28857;&#39;&#37325;&#35797;&#21551;&#21160;&#39;</small></div></body></html>", "text/html", "UTF-8", null);
                            }
                        });
                    }
                }
            });
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void showGuide(int i) {
        final AlertDialog.Builder builder = new AlertDialog.Builder(this);
        if (i == 0) {
            builder.setTitle("欢迎使用 Coopanion（1/5）");
            builder.setMessage("这是一个「住在你手机里」的 AI 桌宠。\n\n接下来 4 步，我带你把该开的都开好，大约 2 分钟：\n\n① 启动内核（自动）\n② 把桌宠召唤到手机桌面\n③ 给桌宠开「感知手机」的两个开关\n④ 让桌宠学会说话（模型 + Key）\n\n随时可以重新点顶部「新手引导」再看一遍。");
            builder.setPositiveButton("开始", new DialogInterface.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.21
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i2) {
                    MainActivity.this.showGuide(1);
                }
            });
            builder.setNegativeButton("跳过", (DialogInterface.OnClickListener) null);
        } else if (i == 1) {
            builder.setTitle("第 1 步：启动内核（2/5）");
            builder.setMessage("App 会自动在后台启动内核（Coopanion 的大脑）。\n\n· 屏幕下方会滚动显示日志\n· 看到「core已启动」就算好了\n· 如果卡住了，点顶部「重试启动」\n\n注意：内核在后台跑，请保持 App 不要被系统杀掉\n（建议在最近任务里把本 App 加锁 / 允许后台运行）。");
            builder.setPositiveButton("下一步", new DialogInterface.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.22
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i2) {
                    MainActivity.this.showGuide(2);
                }
            });
            builder.setNegativeButton("重试启动", new DialogInterface.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.23
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i2) {
                    new Thread(new Runnable() { // from class: com.palai.prootsmoke.MainActivity.23.1
                        @Override // java.lang.Runnable
                        public void run() {
                            MainActivity.this.boot();
                        }
                    }).start();
                }
            });
        } else if (i == 2) {
            builder.setTitle("第 2 步：把桌宠召唤到桌面（3/5）");
            builder.setMessage("桌宠有两种样子：\n\n【App 内】点顶部「看桌宠」，就在这个页面里显示。\n\n【悬浮在桌面上】点顶部「桌宠悬浮窗」——\n它就会飘在所有 App 上面，像一个小生命趴在桌面。\n\n· 第一次点会跳去系统设置，请打开「显示在其他应用上层 / 悬浮窗」权限\n· 打开后回到 App，再点一次「桌宠悬浮窗」即可\n· 再点一次是关闭");
            builder.setPositiveButton("现在就召唤", new DialogInterface.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.24
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i2) {
                    MainActivity.this.togglePetWindow();
                    MainActivity.this.showGuide(3);
                }
            });
            builder.setNegativeButton("下一步", new DialogInterface.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.25
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i2) {
                    MainActivity.this.showGuide(3);
                }
            });
        } else if (i == 3) {
            String[] strArrSenseStatus = senseStatus();
            builder.setTitle("第 3 步：让桌宠感知手机（4/5）");
            builder.setMessage("桌宠想知道「你在用哪个 App」「谁给你发消息了」，\n需要你在系统里打开两个开关（都跟无障碍无关，可以放心开）：\n\n① 使用情况访问 —— 当前：" + strArrSenseStatus[0] + "\n   作用：知道你在用微信 / 在看视频 / 在打游戏\n\n② 通知使用权 —— 当前：" + strArrSenseStatus[1] + "\n   作用：知道谁给你发了消息\n\n点下面按钮会跳到系统设置，找到「Coopanion」打开开关，再返回本页。");
            builder.setPositiveButton("① 使用情况访问", new DialogInterface.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.26
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i2) {
                    try {
                        MainActivity.this.startActivity(new Intent("android.settings.USAGE_ACCESS_SETTINGS"));
                    } catch (Throwable th) {
                        MainActivity.this.log("[GUIDE] usage 设置打不开: " + th);
                    }
                }
            });
            builder.setNeutralButton("② 通知使用权", new DialogInterface.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.27
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i2) {
                    try {
                        MainActivity.this.startActivity(new Intent("android.settings.ACTION_NOTIFICATION_LISTENER_SETTINGS"));
                    } catch (Throwable th) {
                        MainActivity.this.log("[GUIDE] 通知设置打不开: " + th);
                    }
                }
            });
            builder.setNegativeButton("下一步", new DialogInterface.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.28
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i2) {
                    MainActivity.this.showGuide(4);
                }
            });
        } else {
            builder.setTitle("第 4 步：让桌宠开口说话（5/5）");
            builder.setMessage("桌宠要说话，得先接上一家大模型：\n\n1. 打开「控制台」（顶部按钮）\n2. 去「模型供应商」页，选一家（DeepSeek / 通义 / Kimi /\n   GLM / 豆包 / 千帆 / MiniMax / 阶跃 / OpenRouter）\n3. 把你申请到的 API Key 贴进去，保存\n\n小提示：第一次使用时，桌宠自己也会冒泡问你要 Key，\n跟着气泡点就行 —— 那是官方自带的引导。\n\n全部就绪后，桌宠就会「活」过来啦！");
            builder.setPositiveButton("打开控制台", new DialogInterface.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.29
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i2) {
                    if (MainActivity.this.web != null) {
                        MainActivity.this.web.loadUrl("http://127.0.0.1:17788/");
                        MainActivity.this.log("[GUIDE] 切到控制台");
                    }
                }
            });
            builder.setNegativeButton("完成", (DialogInterface.OnClickListener) null);
        }
        runOnUiThread(new Runnable() { // from class: com.palai.prootsmoke.MainActivity.30
            @Override // java.lang.Runnable
            public void run() {
                builder.show();
            }
        });
    }

    private String[] senseStatus() {
        SenseBridge senseBridge;
        String strValueOf;
        try {
            senseBridge = SenseBridge.get(getApplicationContext());
        } catch (Throwable unused) {
            senseBridge = null;
        }
        try {
            Method declaredMethod = SenseBridge.class.getDeclaredMethod("hasUsageAccess", new Class[0]);
            declaredMethod.setAccessible(true);
            strValueOf = String.valueOf(declaredMethod.invoke(senseBridge, new Object[0]));
        } catch (Throwable unused2) {
            strValueOf = "未知";
        }
        return new String[]{strValueOf, String.valueOf(NotifListenerService.isEnabled(getApplicationContext()))};
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void showAlphaDialog() {
        final SharedPreferences sharedPreferences = getSharedPreferences("coopanion", 0);
        float f = sharedPreferences.getFloat("pet_alpha", 1.0f);
        SeekBar seekBar = new SeekBar(this);
        seekBar.setMax(90);
        seekBar.setProgress(Math.round((f - 0.1f) * 100.0f));
        final TextView textView = new TextView(this);
        textView.setPadding(40, 30, 40, 10);
        textView.setText("桌宠透明度：" + Math.round(f * 100.0f) + "%");
        LinearLayout linearLayout = new LinearLayout(this);
        linearLayout.setOrientation(1);
        linearLayout.addView(textView);
        linearLayout.addView(seekBar);
        seekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() { // from class: com.palai.prootsmoke.MainActivity.31
            @Override // android.widget.SeekBar.OnSeekBarChangeListener
            public void onStartTrackingTouch(SeekBar seekBar2) {
            }

            @Override // android.widget.SeekBar.OnSeekBarChangeListener
            public void onStopTrackingTouch(SeekBar seekBar2) {
            }

            @Override // android.widget.SeekBar.OnSeekBarChangeListener
            public void onProgressChanged(SeekBar seekBar2, int i, boolean z) {
                float f2 = (i / 100.0f) + 0.1f;
                if (f2 > 1.0f) {
                    f2 = 1.0f;
                }
                textView.setText("桌宠透明度：" + Math.round(100.0f * f2) + "%");
                if (z) {
                    MainActivity.this.pushAlphaToService(f2);
                }
            }
        });
        new AlertDialog.Builder(this).setTitle("桌宠透明度").setView(linearLayout).setPositiveButton("确定", (DialogInterface.OnClickListener) null).setNegativeButton("恢复 100%", new DialogInterface.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.32
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                sharedPreferences.edit().putFloat("pet_alpha", 1.0f).apply();
                MainActivity.this.pushAlphaToService(1.0f);
            }
        }).show();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void pushAlphaToService(float f) {
        try {
            getSharedPreferences("coopanion", 0).edit().putFloat("pet_alpha", f).apply();
            Intent intent = new Intent(this, (Class<?>) PetWindowService.class);
            intent.setAction("com.palai.prootsmoke.SET_ALPHA");
            intent.putExtra("alpha", f);
            startService(intent);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void openSenseSettings() {
        String[] strArrSenseStatus = senseStatus();
        String str = strArrSenseStatus[0];
        String str2 = strArrSenseStatus[1];
        log("[SENSE] usage=" + str + " notif=" + str2);
        final AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("手机感知授权");
        builder.setMessage("桌宠要「感知手机」，需要两个独立开关（都不涉及无障碍）：\n\n① 使用情况访问：" + str + "\n    → 让桌宠知道你在用哪个 App\n\n② 通知使用权：" + str2 + "\n    → 让桌宠知道你收到了什么通知\n\n点下面按钮逐个打开，在系统设置里找到本应用（Coopanion）打开开关，然后返回。");
        builder.setPositiveButton("① 使用情况访问", new DialogInterface.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.33
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                try {
                    MainActivity.this.startActivity(new Intent("android.settings.USAGE_ACCESS_SETTINGS"));
                } catch (Throwable th) {
                    MainActivity.this.log("[SENSE] 打不开 usage 设置: " + th);
                }
            }
        });
        builder.setNeutralButton("② 通知使用权", new DialogInterface.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.34
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                try {
                    MainActivity.this.startActivity(new Intent("android.settings.ACTION_NOTIFICATION_LISTENER_SETTINGS"));
                } catch (Throwable th) {
                    MainActivity.this.log("[SENSE] 打不开通知设置: " + th);
                }
            }
        });
        builder.setNegativeButton("关闭", (DialogInterface.OnClickListener) null);
        runOnUiThread(new Runnable() { // from class: com.palai.prootsmoke.MainActivity.35
            @Override // java.lang.Runnable
            public void run() {
                builder.show();
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void togglePetWindow() {
        AtomicBoolean atomicBoolean = petWinOn;
        if (atomicBoolean.get()) {
            stopService(new Intent(this, (Class<?>) PetWindowService.class));
            atomicBoolean.set(false);
            syncPetSw(false);
            getSharedPreferences("coopanion", 0).edit().putBoolean("pet_window_wanted", false).apply();
            log("[PET] 悬浮窗已关闭");
            setStatus("状态: 桌宠悬浮窗已关闭");
            return;
        }
        if (!canDrawOverlays()) {
            log("[PET] 缺少悬浮窗权限，去申请");
            final AlertDialog.Builder builder = new AlertDialog.Builder(this);
            builder.setTitle("需要「悬浮窗」权限");
            builder.setMessage("桌宠要飘在手机桌面上，需要你允许它「显示在其他应用上层」。\n\n点「去允许」→ 在系统设置里找到 Coopanion → 打开开关 → 返回 App。\n\n返回后会自动把桌宠召唤出来，不用再点一次。");
            builder.setPositiveButton("去允许", new DialogInterface.OnClickListener() { // from class: com.palai.prootsmoke.MainActivity.36
                @Override // android.content.DialogInterface.OnClickListener
                public void onClick(DialogInterface dialogInterface, int i) {
                    MainActivity.this.requestOverlay();
                }
            });
            builder.setNegativeButton("取消", (DialogInterface.OnClickListener) null);
            runOnUiThread(new Runnable() { // from class: com.palai.prootsmoke.MainActivity.37
                @Override // java.lang.Runnable
                public void run() {
                    builder.show();
                }
            });
            return;
        }
        startPetWindow();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean canDrawOverlays() {
        try {
            return Settings.canDrawOverlays(this);
        } catch (Throwable unused) {
            return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void requestOverlay() {
        try {
            startActivityForResult(new Intent("android.settings.action.MANAGE_OVERLAY_PERMISSION", Uri.parse("package:" + getPackageName())), REQ_OVERLAY);
            setStatus("状态: 请先允许「显示在其他应用上层」，回来再点一次");
        } catch (Throwable th) {
            log("[PET] 权限页打不开: " + th);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void startPetWindowWhenReady() {
        new Thread(new Runnable() { // from class: com.palai.prootsmoke.MainActivity.38
            @Override // java.lang.Runnable
            public void run() {
                if (!MainActivity.waitPortOpen("127.0.0.1", 7797, 90000)) {
                    MainActivity.this.log("[PET] 7797 端口超时未就绪，仍尝试启动桌宠（可能显示空白）");
                } else {
                    MainActivity.this.log("[PET] 7797 端口已就绪，启动桌宠悬浮窗");
                }
                MainActivity.this.root.post(new Runnable() { // from class: com.palai.prootsmoke.MainActivity.38.1
                    @Override // java.lang.Runnable
                    public void run() {
                        if (!MainActivity.this.canDrawOverlays() || MainActivity.petWinOn.get()) {
                            return;
                        }
                        MainActivity.this.startPetWindow();
                    }
                });
            }
        }).start();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void startPetWindow() {
        try {
            Intent intent = new Intent(this, (Class<?>) PetWindowService.class);
            if (Build.VERSION.SDK_INT >= 26) {
                startForegroundService(intent);
            } else {
                startService(intent);
            }
            petWinOn.set(true);
            getSharedPreferences("coopanion", 0).edit().putBoolean("pet_window_wanted", true).apply();
            syncPetSw(true);
            log("[PET] 桌宠悬浮窗已启动 -> http://127.0.0.1:7797/pet");
            setStatus("状态: 桌宠已上桌面（可拖动）");
        } catch (Throwable th) {
            log("[PET] 启动失败: " + th);
        }
    }

    @Override // android.app.Activity
    public void onRequestPermissionsResult(int i, String[] strArr, int[] iArr) {
        super.onRequestPermissionsResult(i, strArr, iArr);
        if (i == REQ_MIC) {
            boolean z = false;
            if (iArr.length > 0 && iArr[0] == 0) {
                z = true;
            }
            log("[MIC] 麦克风权限".concat(z ? "已授权" : "被拒绝"));
        }
    }

    @Override // android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) {
        super.onActivityResult(i, i2, intent);
        if (i == REQ_OVERLAY && canDrawOverlays()) {
            log("[PET] 权限已授予，自动开启悬浮窗");
            startPetWindow();
        }
    }

    private void deleteRec(File file) {
        File[] fileArrListFiles;
        if (file == null || !file.exists()) {
            return;
        }
        if (file.isDirectory() && (fileArrListFiles = file.listFiles()) != null) {
            for (File file2 : fileArrListFiles) {
                deleteRec(file2);
            }
        }
        file.delete();
    }

    private void fixPerms(File file) {
        if (file.isDirectory()) {
            File[] fileArrListFiles = file.listFiles();
            if (fileArrListFiles != null) {
                for (File file2 : fileArrListFiles) {
                    fixPerms(file2);
                }
                return;
            }
            return;
        }
        String name = file.getName();
        if (name.equals("node") || name.equals("busybox") || name.endsWith(".so") || name.endsWith(".so.6") || name.endsWith(".sh") || name.equals("run-core.mjs")) {
            file.setExecutable(true, false);
            file.setReadable(true, false);
        }
    }

    private static int readFull(InputStream inputStream, byte[] bArr, int i) throws Exception {
        int i2 = 0;
        while (i2 < i) {
            int i3 = inputStream.read(bArr, i2, i - i2);
            if (i3 < 0) {
                break;
            }
            i2 += i3;
        }
        return i2;
    }

    private static void copyN(InputStream inputStream, OutputStream outputStream, long j) throws Exception {
        int i;
        byte[] bArr = new byte[65536];
        while (j > 0 && (i = inputStream.read(bArr, 0, (int) Math.min(65536, j))) >= 0) {
            outputStream.write(bArr, 0, i);
            j -= (long) i;
        }
    }

    private static void skipExactly(InputStream inputStream, long j) throws Exception {
        long j2 = j;
        while (j2 > 0) {
            long jSkip = inputStream.skip(j2);
            if (jSkip <= 0) {
                if (inputStream.read() < 0) {
                    break;
                } else {
                    jSkip = 1;
                }
            }
            j2 -= jSkip;
        }
        skipPad(inputStream, j);
    }

    private static void skipPad(InputStream inputStream, long j) throws Exception {
        long j2 = (512 - (j % 512)) % 512;
        while (j2 > 0) {
            long jSkip = inputStream.skip(j2);
            if (jSkip <= 0) {
                return;
            } else {
                j2 -= jSkip;
            }
        }
    }

    private static String cstr(byte[] bArr, int i, int i2) {
        int i3 = i;
        while (i3 < i + i2 && bArr[i3] != 0) {
            i3++;
        }
        try {
            return new String(bArr, i, i3 - i, "UTF-8");
        } catch (Exception unused) {
            return "";
        }
    }

    private static long parseOct(byte[] bArr, int i, int i2) {
        int i3;
        long j = 0;
        for (int i4 = i; i4 < i + i2 && (i3 = bArr[i4] & 255) != 0 && i3 != 32; i4++) {
            if (i3 >= 48 && i3 <= 55) {
                j = (j << 3) + ((long) (i3 - 48));
            }
        }
        return j;
    }
}
