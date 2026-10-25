package com.palai.prootsmoke;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.View;
import android.view.WindowManager;
import android.view.inputmethod.CompletionInfo;
import android.view.inputmethod.CorrectionInfo;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.ExtractedText;
import android.view.inputmethod.ExtractedTextRequest;
import android.view.inputmethod.InputConnection;
import android.view.inputmethod.InputContentInfo;
import android.view.inputmethod.InputMethodManager;
import android.webkit.ConsoleMessage;
import android.webkit.JavascriptInterface;
import android.webkit.PermissionRequest;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.EditText;
import android.widget.FrameLayout;
import java.io.FileOutputStream;

/* JADX INFO: loaded from: /home/runner/work/coopanion-re/coopanion-re/src/x/classes.dex */
public class PetWindowService extends Service {
    private static final String CHANNEL = "coopanion_pet";
    private static final String KEY_ALPHA = "pet_alpha";
    private static final int NOTI_ID = 8801;
    private static final String PET_HOST_SHIM = "(function(){ if (window.petHost) return 'already'; if (typeof petHostNative === 'undefined') return 'no-bridge'; window.petHost = {   setInteractive: function(on){ try{ petHostNative.setInteractive(!!on); }catch(e){} },   focus: function(){ try{ petHostNative.focus(); }catch(e){} },   grabFocus: function(){ try{ petHostNative.grabFocus(); }catch(e){} },   releaseFocus: function(){ try{ petHostNative.releaseFocus(); }catch(e){} },   hide: function(){ try{ petHostNative.hide(); }catch(e){} },   openDress: function(){ try{ petHostNative.openDress(); }catch(e){} },   setAlpha: function(f){ try{ petHostNative.setAlpha(f); }catch(e){} },   getAlpha: function(){ try{ return petHostNative.getAlpha(); }catch(e){ return 1; } },   openApp: function(n){ try{ return !!petHostNative.openApp(String(n)); }catch(e){ return false; } },   onCursor: function(cb){ (window.__petCursorSubs=window.__petCursorSubs||[]).push(cb); },   sampleBackdrop: function(){ return null; } }; document.body.classList.remove('tab'); document.body.classList.add('desk'); return 'ok';})()";
    private static final String PET_URL = "http://127.0.0.1:7797/pet";
    private static final String PREF = "coopanion";
    private static final String TAG = "PetWindow";
    private static final int TOUCH_SIZE = 700;
    private EditText imeProxy;
    private int screenH;
    private int screenW;
    private FrameLayout showBox;
    private WindowManager.LayoutParams showLp;
    private FrameLayout touchBox;
    private WindowManager.LayoutParams touchLp;
    private WebView web;
    private WindowManager wm;
    private float petAlpha = 1.0f;
    private volatile boolean firstLoadReloaded = false;
    private volatile float petX = -1.0f;
    private volatile float petY = -1.0f;
    private int lastTouchX = Integer.MIN_VALUE;
    private int lastTouchY = Integer.MIN_VALUE;
    private int lastTouchW = Integer.MIN_VALUE;
    private int lastTouchH = Integer.MIN_VALUE;
    private Handler ui = new Handler(Looper.getMainLooper());
    private final Runnable followTick = new Runnable() { // from class: com.palai.prootsmoke.PetWindowService.14
        @Override // java.lang.Runnable
        public void run() {
            try {
                PetWindowService.this.queryPetRect();
            } catch (Throwable unused) {
            }
            PetWindowService.this.ui.postDelayed(this, 80L);
        }
    };
    private volatile boolean inputFocusOn = false;
    private long lastFocusLog = 0;
    private long lastProbeLog = 0;

    @Override // android.app.Service
    public IBinder onBind(Intent intent) {
        return null;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void diag(String str) {
        try {
            Log.i("PetWindow", "[DIAG] " + str);
            FileOutputStream fileOutputStream = new FileOutputStream("/sdcard/Download/coop-diag.txt", true);
            fileOutputStream.write(("[" + System.currentTimeMillis() + "] " + str + "\n").getBytes("UTF-8"));
            fileOutputStream.flush();
            fileOutputStream.close();
        } catch (Throwable unused) {
        }
    }

    @Override // android.app.Service
    public int onStartCommand(Intent intent, int i, int i2) {
        if (intent == null) {
            return 1;
        }
        try {
            if (!"com.palai.prootsmoke.SET_ALPHA".equals(intent.getAction())) {
                return 1;
            }
            final float floatExtra = intent.getFloatExtra("alpha", this.petAlpha);
            this.ui.post(new Runnable() { // from class: com.palai.prootsmoke.PetWindowService.1
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        PetWindowService petWindowService = PetWindowService.this;
                        float f = floatExtra;
                        float f2 = 0.0f;
                        if (f < 0.0f) {
                            f = f2;
                        } else {
                            f2 = 1.0f;
                            if (f > 1.0f) {
                                f = f2;
                            }
                        }
                        petWindowService.petAlpha = f;
                        if (PetWindowService.this.showLp == null || PetWindowService.this.showBox == null) {
                            return;
                        }
                        PetWindowService.this.showLp.alpha = PetWindowService.this.petAlpha;
                        PetWindowService.this.wm.updateViewLayout(PetWindowService.this.showBox, PetWindowService.this.showLp);
                    } catch (Throwable unused) {
                    }
                }
            });
            return 1;
        } catch (Throwable unused) {
            return 1;
        }
    }

    @Override // android.app.Service
    public void onCreate() {
        super.onCreate();
        startForegroundCompat();
        this.wm = (WindowManager) getSystemService("window");
        DisplayMetrics displayMetrics = new DisplayMetrics();
        this.wm.getDefaultDisplay().getMetrics(displayMetrics);
        this.screenW = displayMetrics.widthPixels;
        this.screenH = displayMetrics.heightPixels;
        showPetWindow();
    }

    private void startForegroundCompat() {
        Notification.Builder builder;
        if (Build.VERSION.SDK_INT >= 26) {
            NotificationManager notificationManager = (NotificationManager) getSystemService("notification");
            NotificationChannel notificationChannel = new NotificationChannel(CHANNEL, "桌宠运行中", 1);
            notificationChannel.setShowBadge(false);
            notificationManager.createNotificationChannel(notificationChannel);
        }
        PendingIntent activity = PendingIntent.getActivity(this, 0, new Intent(this, (Class<?>) MainActivity.class), 201326592);
        if (Build.VERSION.SDK_INT >= 26) {
            builder = new Notification.Builder(this, CHANNEL);
        } else {
            builder = new Notification.Builder(this);
        }
        builder.setContentTitle("Coopanion").setContentText("桌宠正在运行").setSmallIcon(android.R.drawable.ic_menu_compass).setContentIntent(activity).setOngoing(true);
        startForeground(NOTI_ID, builder.build());
    }

    private void showPetWindow() {
        final int i = Build.VERSION.SDK_INT >= 26 ? 2038 : 2002;
        WebView webView = new WebView(this);
        this.web = webView;
        WebSettings settings = webView.getSettings();
        settings.setJavaScriptEnabled(true);
        settings.setDomStorageEnabled(true);
        settings.setAllowFileAccess(true);
        settings.setMixedContentMode(0);
        settings.setMediaPlaybackRequiresUserGesture(false);
        settings.setUseWideViewPort(true);
        settings.setLoadWithOverviewMode(true);
        this.web.setBackgroundColor(0);
        this.web.setLayerType(0, null);
        this.web.setVerticalScrollBarEnabled(false);
        this.web.setHorizontalScrollBarEnabled(false);
        this.web.setOverScrollMode(2);
        warmUpRenderer(new Runnable() { // from class: com.palai.prootsmoke.PetWindowService.2
            @Override // java.lang.Runnable
            public void run() {
                PetWindowService.this.buildAndAttachLayers(i);
            }
        });
    }

    private void warmUpRenderer(final Runnable runnable) {
        try {
            final WebView webView = new WebView(this);
            WebSettings settings = webView.getSettings();
            settings.setJavaScriptEnabled(true);
            settings.setDomStorageEnabled(true);
            settings.setAllowFileAccess(true);
            settings.setMixedContentMode(0);
            webView.setBackgroundColor(0);
            webView.setLayerType(0, null);
            final WindowManager windowManager = (WindowManager) getSystemService("window");
            final FrameLayout frameLayout = new FrameLayout(this);
            frameLayout.setBackgroundColor(0);
            frameLayout.addView(webView, new FrameLayout.LayoutParams(1, 1));
            WindowManager.LayoutParams layoutParams = new WindowManager.LayoutParams(1, 1, Build.VERSION.SDK_INT >= 26 ? 2038 : 2002, 24, -3);
            layoutParams.gravity = 8388659;
            final boolean[] zArr = {false};
            final Runnable runnable2 = new Runnable() { // from class: com.palai.prootsmoke.PetWindowService.3
                @Override // java.lang.Runnable
                public void run() {
                    boolean[] zArr2 = zArr;
                    if (zArr2[0]) {
                        return;
                    }
                    zArr2[0] = true;
                    try {
                        windowManager.removeView(frameLayout);
                    } catch (Throwable unused) {
                    }
                    try {
                        webView.stopLoading();
                        webView.destroy();
                    } catch (Throwable unused2) {
                    }
                    Log.i("PetWindow", "[PET] 渲染器预热完成 → 开始正式挂载");
                    runnable.run();
                }
            };
            webView.setWebViewClient(new WebViewClient() { // from class: com.palai.prootsmoke.PetWindowService.4
                @Override // android.webkit.WebViewClient
                public void onPageFinished(WebView webView2, String str) {
                    Log.i("PetWindow", "[PET] 预热页加载完成，再等 400ms 让合成器落定");
                    PetWindowService.this.ui.postDelayed(runnable2, 400L);
                }
            });
            try {
                windowManager.addView(frameLayout, layoutParams);
                webView.loadUrl(PET_URL);
                this.ui.postDelayed(runnable2, 2500L);
            } catch (Throwable th) {
                Log.w("PetWindow", "[PET] 预热窗口挂载失败，跳过预热: " + th);
                runnable2.run();
            }
        } catch (Throwable th2) {
            Log.w("PetWindow", "[PET] 预热异常，跳过预热: " + th2);
            runnable.run();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void buildAndAttachLayers(int i) {
        PetHostBridge petHostBridge = new PetHostBridge();
        WebView webView = this.web;
        webView.addJavascriptInterface(petHostBridge, "petHostNative");
        webView.addJavascriptInterface(new VoiceBridge(this, webView), "petVoiceNative");
        this.web.setWebViewClient(new WebViewClient() { // from class: com.palai.prootsmoke.PetWindowService.5
            @Override // android.webkit.WebViewClient
            public void onPageStarted(WebView webView2, String str, Bitmap bitmap) {
                webView2.evaluateJavascript(PetWindowService.PET_HOST_SHIM, null);
            }

            @Override // android.webkit.WebViewClient
            public void onPageFinished(WebView webView2, String str) {
                Log.i("PetWindow", "[PET] onPageFinished " + str);
                webView2.evaluateJavascript(PetWindowService.PET_HOST_SHIM, null);
                PetWindowService.this.startRepaintWatchdog(webView2);
            }
        });
        this.web.setWebChromeClient(new WebChromeClient() { // from class: com.palai.prootsmoke.PetWindowService.6
            @Override // android.webkit.WebChromeClient
            public boolean onConsoleMessage(ConsoleMessage consoleMessage) {
                Log.i("PetWindow", "[PET-JS] " + consoleMessage.message());
                return true;
            }

            @Override // android.webkit.WebChromeClient
            public void onPermissionRequest(PermissionRequest permissionRequest) {
                try {
                    boolean z = false;
                    for (String str : permissionRequest.getResources()) {
                        if ("android.webkit.resource.AUDIO_CAPTURE".equals(str)) {
                            z = true;
                        }
                    }
                    if (z) {
                        Log.i("PetWindow", "[PET][MIC] WebView 请求麦克风 -> 已放行");
                        permissionRequest.grant(permissionRequest.getResources());
                    } else {
                        permissionRequest.deny();
                    }
                } catch (Throwable th) {
                    Log.i("PetWindow", "[PET][MIC] onPermissionRequest err: " + th);
                }
            }
        });
        FrameLayout frameLayout = new FrameLayout(this);
        this.showBox = frameLayout;
        frameLayout.setBackgroundColor(0);
        this.showBox.addView(this.web, new FrameLayout.LayoutParams(-1, -1));
        this.showLp = new WindowManager.LayoutParams(-1, -1, i, 66328, -3);
        try {
            this.petAlpha = getSharedPreferences(PREF, 0).getFloat(KEY_ALPHA, 1.0f);
        } catch (Throwable unused) {
        }
        if (this.petAlpha < 0.0f) {
            this.petAlpha = 0.0f;
        }
        if (this.petAlpha > 1.0f) {
            this.petAlpha = 1.0f;
        }
        this.showLp.alpha = this.petAlpha;
        this.showLp.gravity = 8388659;
        this.showLp.x = 0;
        this.showLp.y = 0;
        try {
            this.wm.addView(this.showBox, this.showLp);
            FrameLayout frameLayout2 = this.showBox;
            PetKeyboardGuard.install(this, frameLayout2, frameLayout2);
            Log.i("PetWindow", "[PET] 显示层已挂载（全屏穿透）");
        } catch (Throwable th) {
            Log.e("PetWindow", "[PET] 显示层 addView 失败: " + th);
        }
        FrameLayout frameLayout3 = new FrameLayout(this);
        this.touchBox = frameLayout3;
        PetKeyboardGuard.setTouchLayer(frameLayout3);
        frameLayout3.setBackgroundColor(0);
        this.touchBox.setOnTouchListener(new View.OnTouchListener() { // from class: com.palai.prootsmoke.PetWindowService.7
            @Override // android.view.View.OnTouchListener
            public boolean onTouch(View view, MotionEvent motionEvent) {
                PetWindowService.this.forwardToWeb(motionEvent);
                return true;
            }
        });
        WindowManager.LayoutParams layoutParams = new WindowManager.LayoutParams(520, 520, i, 808, -3);
        this.touchLp = layoutParams;
        layoutParams.gravity = 8388659;
        this.touchLp.x = 0;
        this.touchLp.y = 0;
        try {
            this.touchLp.softInputMode = 16;
        } catch (Throwable unused2) {
        }
        this.touchBox.setFocusable(false);
        this.touchBox.setFocusableInTouchMode(false);
        EditText editText = new EditText(this) { // from class: com.palai.prootsmoke.PetWindowService.8
            @Override // android.widget.TextView, android.view.View
            public InputConnection onCreateInputConnection(EditorInfo editorInfo) {
                InputConnection inputConnectionOnCreateInputConnection = super.onCreateInputConnection(editorInfo);
                if (inputConnectionOnCreateInputConnection == null) {
                    return null;
                }
                return new ImeCommitConnection(inputConnectionOnCreateInputConnection, new ImeCommitConnection.Sink() { // from class: com.palai.prootsmoke.PetWindowService.8.1
                    @Override // com.palai.prootsmoke.PetWindowService.ImeCommitConnection.Sink
                    public void onCommit(String str) {
                        PetWindowService.this.pushTextToPage(str);
                    }

                    @Override // com.palai.prootsmoke.PetWindowService.ImeCommitConnection.Sink
                    public void onDelete() {
                        PetWindowService.this.pushKeyToPage("Backspace");
                    }

                    @Override // com.palai.prootsmoke.PetWindowService.ImeCommitConnection.Sink
                    public void onClearLocal() {
                        try {
                            PetWindowService.this.imeProxy.setText("");
                        } catch (Throwable unused3) {
                        }
                    }
                });
            }
        };
        this.imeProxy = editText;
        editText.setBackgroundColor(0);
        this.imeProxy.setTextColor(0);
        this.imeProxy.setCursorVisible(false);
        this.imeProxy.setImeOptions(33554438);
        this.imeProxy.setInputType(1);
        this.imeProxy.setSingleLine(true);
        this.imeProxy.setFocusable(false);
        this.imeProxy.setFocusableInTouchMode(false);
        this.imeProxy.addTextChangedListener(new TextWatcher() { // from class: com.palai.prootsmoke.PetWindowService.9
            @Override // android.text.TextWatcher
            public void beforeTextChanged(CharSequence charSequence, int i2, int i3, int i4) {
            }

            @Override // android.text.TextWatcher
            public void onTextChanged(CharSequence charSequence, int i2, int i3, int i4) {
            }

            @Override // android.text.TextWatcher
            public void afterTextChanged(Editable editable) {
                try {
                    if (editable.length() == 0 || PetWindowService._isComposing(editable)) {
                        return;
                    }
                    editable.clear();
                } catch (Throwable unused3) {
                }
            }
        });
        this.imeProxy.setOnKeyListener(new View.OnKeyListener() { // from class: com.palai.prootsmoke.PetWindowService.10
            @Override // android.view.View.OnKeyListener
            public boolean onKey(View view, int i2, KeyEvent keyEvent) {
                if (keyEvent.getAction() != 0 || i2 != 67) {
                    return false;
                }
                PetWindowService.this.pushKeyToPage("Backspace");
                return true;
            }
        });
        this.touchBox.addView(this.imeProxy, new FrameLayout.LayoutParams(1, 1));
        try {
            this.wm.addView(this.touchBox, this.touchLp);
            Log.i("PetWindow", "[PET] 触摸层已挂载 520x520");
        } catch (Throwable th2) {
            Log.e("PetWindow", "[PET] 触摸层 addView 失败: " + th2);
        }
        this.showBox.addOnLayoutChangeListener(new View.OnLayoutChangeListener() { // from class: com.palai.prootsmoke.PetWindowService.11
            boolean loaded = false;

            @Override // android.view.View.OnLayoutChangeListener
            public void onLayoutChange(View view, int i2, int i3, int i4, int i5, int i6, int i7, int i8, int i9) {
                if (!this.loaded && i4 - i2 > 0 && i5 - i3 > 0) {
                    this.loaded = true;
                    PetWindowService.this.ui.postDelayed(new Runnable() { // from class: com.palai.prootsmoke.PetWindowService.11.1
                        @Override // java.lang.Runnable
                        public void run() {
                            try {
                                PetWindowService.this.web.loadUrl(PetWindowService.PET_URL);
                                Log.i("PetWindow", "[PET] loadUrl(布局就绪后) -> http://127.0.0.1:7797/pet");
                            } catch (Throwable unused3) {
                            }
                        }
                    }, 32L);
                }
            }
        });
        this.ui.postDelayed(new Runnable() { // from class: com.palai.prootsmoke.PetWindowService.12
            boolean fired = false;

            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (PetWindowService.this.web.getUrl() == null) {
                        PetWindowService.this.web.loadUrl(PetWindowService.PET_URL);
                        Log.i("PetWindow", "[PET] loadUrl(兜底超时) -> http://127.0.0.1:7797/pet");
                    }
                } catch (Throwable unused3) {
                }
            }
        }, 1000L);
        this.ui.postDelayed(this.followTick, 300L);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void startRepaintWatchdog(final WebView webView) {
        int i = 0;
        while (i < 40) {
            i++;
            this.ui.postDelayed(new Runnable() { // from class: com.palai.prootsmoke.PetWindowService.13
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        webView.invalidate();
                        webView.evaluateJavascript("(function(){try{if(window.__repaintHack)return 0;window.__repaintHack=1;var els=document.querySelectorAll('#pet,#bubble,#menu,.pet,.whale,svg,canvas');for(var i=0;i<els.length;i++){var e=els[i];var t=e.style.transform;e.style.transform=(t||'')+' translateZ(0)';void e.offsetHeight;e.style.transform=t||'';}window.dispatchEvent(new Event('resize'));window.__repaintHack=0;return 1;}catch(e){return 0;}})()", null);
                    } catch (Throwable unused) {
                    }
                }
            }, ((long) i) * 200);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void queryPetRect() {
        WebView webView = this.web;
        if (webView == null) {
            return;
        }
        webView.evaluateJavascript("(function(){try{var box='';try{if(window.__petUnionRect)box=window.__petUnionRect()||'';}catch(e0){}if(!box){function r(id){var e=document.getElementById(id);  if(!e) return null; var st=window.getComputedStyle(e);  if(st.display==='none'||st.visibility==='hidden'||e.hidden) return null;  var b=e.getBoundingClientRect(); if(b.width<1&&b.height<1) return null; return b; }var ids=['pet','pet2','pet3','pet4','bubble','bubble2','bubble3','bubble4','menu','tools'];var arr=[];for(var i=0;i<ids.length;i++){var q=r(ids[i]); if(q) arr.push(q);}if(arr.length){var l=1e9,t=1e9,rr=-1e9,b=-1e9;  for(var k=0;k<arr.length;k++){var q=arr[k];    if(q.left<l)l=q.left; if(q.top<t)t=q.top;    if(q.right>rr)rr=q.right; if(q.bottom>b)b=q.bottom; }  box=l+','+t+','+rr+','+b; }}var ae=document.activeElement;var focused = !!(ae && (ae.tagName==='INPUT'||ae.tagName==='TEXTAREA'||ae.isContentEditable));return box+'|'+(focused?'1':'0');}catch(err){return '';}})()", new ValueCallback<String>() { // from class: com.palai.prootsmoke.PetWindowService.15
            @Override // android.webkit.ValueCallback
            public void onReceiveValue(String str) {
                if (str == null || str.length() < 3) {
                    return;
                }
                try {
                    String strReplace = str.replace("\"", "");
                    int iLastIndexOf = strReplace.lastIndexOf(124);
                    if (iLastIndexOf < 0) {
                        return;
                    }
                    String strSubstring = strReplace.substring(0, iLastIndexOf);
                    boolean zStartsWith = strReplace.substring(iLastIndexOf + 1).startsWith("1");
                    long jCurrentTimeMillis = System.currentTimeMillis();
                    if (jCurrentTimeMillis - PetWindowService.this.lastProbeLog > 1000) {
                        PetWindowService.this.lastProbeLog = jCurrentTimeMillis;
                        PetWindowService.this.diag("probe box=[" + strSubstring + "] focused=" + zStartsWith);
                    }
                    PetWindowService.this.applyInputFocus(zStartsWith);
                    if (strSubstring.length() < 5) {
                        return;
                    }
                    String[] strArrSplit = strSubstring.split(",");
                    if (strArrSplit.length < 4) {
                        return;
                    }
                    float f = PetWindowService.this.getResources().getDisplayMetrics().density;
                    int i = (int) (Float.parseFloat(strArrSplit[0]) * f);
                    int i2 = (int) (Float.parseFloat(strArrSplit[1]) * f);
                    int i3 = (int) (Float.parseFloat(strArrSplit[2]) * f);
                    int i4 = (int) (Float.parseFloat(strArrSplit[3]) * f);
                    int i5 = i + i3;
                    PetWindowService.this.petX = i5 / 2.0f;
                    int i6 = i2 + i4;
                    PetWindowService.this.petY = i6 / 2.0f;
                    int iMax = Math.max((i3 - i) + 80, 520);
                    int iMax2 = Math.max((i4 - i2) + 80, 520);
                    PetWindowService.this.sizeTouchTo((i5 / 2) - (iMax / 2), (i6 / 2) - (iMax2 / 2), iMax, iMax2);
                } catch (Throwable unused) {
                }
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void applyInputFocus(final boolean z) {
        long jCurrentTimeMillis = System.currentTimeMillis();
        if (z != this.inputFocusOn && jCurrentTimeMillis - this.lastFocusLog > 300) {
            this.lastFocusLog = jCurrentTimeMillis;
            diag("inputFocus=" + z + " -> NOT_FOCUSABLE " + (z ? "OFF" : "ON"));
        }
        if (z == this.inputFocusOn) {
            return;
        }
        this.inputFocusOn = z;
        this.ui.post(new Runnable() { // from class: com.palai.prootsmoke.PetWindowService.16
            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (PetWindowService.this.touchBox != null && PetWindowService.this.touchLp != null) {
                        if (z) {
                            PetWindowService.this.touchLp.flags &= -9;
                        } else {
                            PetWindowService.this.touchLp.flags |= 8;
                        }
                        try {
                            PetWindowService.this.wm.updateViewLayout(PetWindowService.this.touchBox, PetWindowService.this.touchLp);
                        } catch (Throwable unused) {
                        }
                    }
                    if (z) {
                        PetWindowService.this.ui.postDelayed(new Runnable() { // from class: com.palai.prootsmoke.PetWindowService.16.1
                            @Override // java.lang.Runnable
                            public void run() {
                                PetWindowService.this.focusImeAndShow();
                            }
                        }, 120L);
                        PetWindowService.this.ui.postDelayed(new Runnable() { // from class: com.palai.prootsmoke.PetWindowService.16.2
                            @Override // java.lang.Runnable
                            public void run() {
                                PetWindowService.this.focusImeAndShow();
                            }
                        }, 450L);
                        return;
                    }
                    if (PetWindowService.this.imeProxy != null) {
                        InputMethodManager inputMethodManager = (InputMethodManager) PetWindowService.this.getSystemService("input_method");
                        if (inputMethodManager != null) {
                            inputMethodManager.hideSoftInputFromWindow(PetWindowService.this.imeProxy.getWindowToken(), 0);
                        }
                        PetWindowService.this.imeProxy.clearFocus();
                        PetWindowService.this.imeProxy.setFocusable(false);
                        PetWindowService.this.imeProxy.setFocusableInTouchMode(false);
                    }
                    if (PetWindowService.this.touchBox != null) {
                        PetWindowService.this.touchBox.clearFocus();
                    }
                } catch (Throwable unused2) {
                }
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void focusImeAndShow() {
        try {
            EditText editText = this.imeProxy;
            if (editText == null) {
                return;
            }
            editText.setFocusable(true);
            this.imeProxy.setFocusableInTouchMode(true);
            this.imeProxy.requestFocus();
            InputMethodManager inputMethodManager = (InputMethodManager) getSystemService("input_method");
            if (inputMethodManager != null) {
                inputMethodManager.showSoftInput(this.imeProxy, 1);
            }
            Log.i("PetWindow", "[PET] 已请求 IME（hasFocus=" + this.imeProxy.hasFocus() + "）");
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static boolean _isComposing(Editable editable) {
        try {
            for (Object obj : editable.getSpans(0, editable.length(), Object.class)) {
                if ((editable.getSpanFlags(obj) & 256) != 0) {
                    return true;
                }
            }
        } catch (Throwable unused) {
        }
        return false;
    }

    private static class ImeCommitConnection implements InputConnection {
        private final InputConnection base;
        private final Sink sink;

        interface Sink {
            void onClearLocal();

            void onCommit(String str);

            void onDelete();
        }

        ImeCommitConnection(InputConnection inputConnection, Sink sink) {
            this.base = inputConnection;
            this.sink = sink;
        }

        @Override // android.view.inputmethod.InputConnection
        public CharSequence getTextBeforeCursor(int i, int i2) {
            return this.base.getTextBeforeCursor(i, i2);
        }

        @Override // android.view.inputmethod.InputConnection
        public CharSequence getTextAfterCursor(int i, int i2) {
            return this.base.getTextAfterCursor(i, i2);
        }

        @Override // android.view.inputmethod.InputConnection
        public CharSequence getSelectedText(int i) {
            return this.base.getSelectedText(i);
        }

        @Override // android.view.inputmethod.InputConnection
        public int getCursorCapsMode(int i) {
            return this.base.getCursorCapsMode(i);
        }

        @Override // android.view.inputmethod.InputConnection
        public ExtractedText getExtractedText(ExtractedTextRequest extractedTextRequest, int i) {
            return this.base.getExtractedText(extractedTextRequest, i);
        }

        @Override // android.view.inputmethod.InputConnection
        public boolean deleteSurroundingText(int i, int i2) {
            return this.base.deleteSurroundingText(i, i2);
        }

        @Override // android.view.inputmethod.InputConnection
        public boolean deleteSurroundingTextInCodePoints(int i, int i2) {
            return this.base.deleteSurroundingTextInCodePoints(i, i2);
        }

        @Override // android.view.inputmethod.InputConnection
        public boolean setComposingText(CharSequence charSequence, int i) {
            return this.base.setComposingText(charSequence, i);
        }

        @Override // android.view.inputmethod.InputConnection
        public boolean setComposingRegion(int i, int i2) {
            this.base.setComposingRegion(i, i2);
            return true;
        }

        @Override // android.view.inputmethod.InputConnection
        public boolean finishComposingText() {
            try {
                CharSequence textBeforeCursor = this.base.getTextBeforeCursor(4096, 0);
                if (textBeforeCursor != null && textBeforeCursor.length() > 0) {
                    this.sink.onCommit(textBeforeCursor.toString());
                }
            } catch (Throwable unused) {
            }
            try {
                this.base.finishComposingText();
            } catch (Throwable unused2) {
            }
            try {
                this.sink.onClearLocal();
                return true;
            } catch (Throwable unused3) {
                return true;
            }
        }

        @Override // android.view.inputmethod.InputConnection
        public boolean beginBatchEdit() {
            return this.base.beginBatchEdit();
        }

        @Override // android.view.inputmethod.InputConnection
        public boolean endBatchEdit() {
            return this.base.endBatchEdit();
        }

        @Override // android.view.inputmethod.InputConnection
        public boolean commitText(CharSequence charSequence, int i) {
            if (charSequence != null) {
                try {
                    if (charSequence.length() > 0) {
                        this.sink.onCommit(charSequence.toString());
                    }
                } catch (Throwable unused) {
                }
            }
            try {
                this.base.commitText(charSequence, i);
            } catch (Throwable unused2) {
            }
            try {
                this.sink.onClearLocal();
                return true;
            } catch (Throwable unused3) {
                return true;
            }
        }

        @Override // android.view.inputmethod.InputConnection
        public boolean commitCompletion(CompletionInfo completionInfo) {
            return this.base.commitCompletion(completionInfo);
        }

        @Override // android.view.inputmethod.InputConnection
        public boolean commitCorrection(CorrectionInfo correctionInfo) {
            return this.base.commitCorrection(correctionInfo);
        }

        @Override // android.view.inputmethod.InputConnection
        public boolean setSelection(int i, int i2) {
            return this.base.setSelection(i, i2);
        }

        @Override // android.view.inputmethod.InputConnection
        public boolean performEditorAction(int i) {
            return this.base.performEditorAction(i);
        }

        @Override // android.view.inputmethod.InputConnection
        public boolean performContextMenuAction(int i) {
            return this.base.performContextMenuAction(i);
        }

        @Override // android.view.inputmethod.InputConnection
        public boolean sendKeyEvent(KeyEvent keyEvent) {
            if (keyEvent != null) {
                try {
                    if (keyEvent.getAction() == 0 && keyEvent.getKeyCode() == 67) {
                        this.sink.onDelete();
                    }
                } catch (Throwable unused) {
                }
            }
            return this.base.sendKeyEvent(keyEvent);
        }

        @Override // android.view.inputmethod.InputConnection
        public boolean clearMetaKeyStates(int i) {
            return this.base.clearMetaKeyStates(i);
        }

        @Override // android.view.inputmethod.InputConnection
        public boolean reportFullscreenMode(boolean z) {
            return this.base.reportFullscreenMode(z);
        }

        @Override // android.view.inputmethod.InputConnection
        public boolean performPrivateCommand(String str, Bundle bundle) {
            return this.base.performPrivateCommand(str, bundle);
        }

        @Override // android.view.inputmethod.InputConnection
        public boolean commitContent(InputContentInfo inputContentInfo, int i, Bundle bundle) {
            return this.base.commitContent(inputContentInfo, i, bundle);
        }

        @Override // android.view.inputmethod.InputConnection
        public boolean requestCursorUpdates(int i) {
            return this.base.requestCursorUpdates(i);
        }

        @Override // android.view.inputmethod.InputConnection
        public Handler getHandler() {
            return this.base.getHandler();
        }

        @Override // android.view.inputmethod.InputConnection
        public void closeConnection() {
            this.base.closeConnection();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void pushTextToPage(String str) {
        if (this.web == null) {
            return;
        }
        this.web.evaluateJavascript("(function(){try{var ae=document.activeElement;var el=null;if(ae && (ae.tagName==='INPUT'||ae.tagName==='TEXTAREA')) el=ae;if(!el) el=document.querySelector('#bubble input,#bubble textarea,.d-body input,.d-body textarea,input:focus,textarea:focus');if(!el) return 'no-target';el.value=(el.value||'')+" + jsStr(str) + ";el.dispatchEvent(new Event('input',{bubbles:true}));return 'ok';}catch(e){return 'err';}})()", null);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void pushKeyToPage(String str) {
        WebView webView = this.web;
        if (webView == null) {
            return;
        }
        webView.evaluateJavascript("(function(){try{var ae=document.activeElement;var el=null;if(ae && (ae.tagName==='INPUT'||ae.tagName==='TEXTAREA')) el=ae;if(!el) el=document.querySelector('#bubble input,#bubble textarea,.d-body input,.d-body textarea');if(!el) return 'no-target';el.value=(el.value||'').slice(0,-1);el.dispatchEvent(new Event('input',{bubbles:true}));return 'ok';}catch(e){return 'err';}})()", null);
    }

    private static String jsStr(String str) {
        StringBuilder sb = new StringBuilder("\"");
        for (int i = 0; i < str.length(); i++) {
            char cCharAt = str.charAt(i);
            if (cCharAt == '\"' || cCharAt == '\\') {
                sb.append('\\').append(cCharAt);
            } else if (cCharAt == '\n') {
                sb.append("\\n");
            } else if (cCharAt == '\r') {
                sb.append("\\r");
            } else if (cCharAt < ' ') {
                sb.append(String.format("\\u%04x", Integer.valueOf(cCharAt)));
            } else {
                sb.append(cCharAt);
            }
        }
        return sb.append('\"').toString();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void sizeTouchTo(final int i, final int i2, final int i3, final int i4) {
        if (i == this.lastTouchX && i2 == this.lastTouchY && i3 == this.lastTouchW && i4 == this.lastTouchH) {
            return;
        }
        this.lastTouchX = i;
        this.lastTouchY = i2;
        this.lastTouchW = i3;
        this.lastTouchH = i4;
        this.ui.post(new Runnable() { // from class: com.palai.prootsmoke.PetWindowService.17
            @Override // java.lang.Runnable
            public void run() {
                try {
                    PetWindowService.this.touchLp.x = i;
                    PetWindowService.this.touchLp.y = i2;
                    PetWindowService.this.touchLp.width = i3;
                    PetWindowService.this.touchLp.height = i4;
                    PetWindowService.this.wm.updateViewLayout(PetWindowService.this.touchBox, PetWindowService.this.touchLp);
                } catch (Throwable unused) {
                }
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean forwardToWeb(MotionEvent motionEvent) {
        if (this.web == null) {
            return false;
        }
        try {
            int pointerCount = motionEvent.getPointerCount();
            MotionEvent.PointerProperties[] pointerPropertiesArr = new MotionEvent.PointerProperties[pointerCount];
            MotionEvent.PointerCoords[] pointerCoordsArr = new MotionEvent.PointerCoords[pointerCount];
            int i = 0;
            while (i < pointerCount) {
                MotionEvent.PointerProperties pointerProperties = new MotionEvent.PointerProperties();
                pointerProperties.id = motionEvent.getPointerId(i);
                pointerProperties.toolType = motionEvent.getToolType(i);
                pointerPropertiesArr[i] = pointerProperties;
                MotionEvent.PointerCoords pointerCoords = new MotionEvent.PointerCoords();
                pointerCoords.x = i == 0 ? motionEvent.getRawX() : motionEvent.getX(i);
                pointerCoords.y = i == 0 ? motionEvent.getRawY() : motionEvent.getY(i);
                pointerCoords.pressure = motionEvent.getPressure(i);
                pointerCoords.size = motionEvent.getSize(i);
                pointerCoordsArr[i] = pointerCoords;
                i++;
            }
            MotionEvent motionEventObtain = MotionEvent.obtain(motionEvent.getDownTime(), motionEvent.getEventTime(), motionEvent.getAction(), pointerCount, pointerPropertiesArr, pointerCoordsArr, motionEvent.getMetaState(), motionEvent.getButtonState(), motionEvent.getXPrecision(), motionEvent.getYPrecision(), motionEvent.getDeviceId(), motionEvent.getEdgeFlags(), motionEvent.getSource(), motionEvent.getFlags());
            boolean zDispatchTouchEvent = this.web.dispatchTouchEvent(motionEventObtain);
            motionEventObtain.recycle();
            return zDispatchTouchEvent;
        } catch (Throwable unused) {
            return false;
        }
    }

    private class PetHostBridge {
        @JavascriptInterface
        public void focus() {
        }

        @JavascriptInterface
        public void grabFocus() {
        }

        @JavascriptInterface
        public void releaseFocus() {
        }

        private PetHostBridge() {
        }

        @JavascriptInterface
        public void setInteractive(boolean z) {
            Log.i("PetWindow", "[PET] setInteractive=" + z);
        }

        @JavascriptInterface
        public void setAlpha(final float f) {
            if (f < 0.0f) {
                f = 0.0f;
            }
            if (f > 1.0f) {
                f = 1.0f;
            }
            try {
                PetWindowService.this.getSharedPreferences(PetWindowService.PREF, 0).edit().putFloat(PetWindowService.KEY_ALPHA, f).apply();
            } catch (Throwable unused) {
            }
            PetWindowService.this.ui.post(new Runnable() { // from class: com.palai.prootsmoke.PetWindowService.PetHostBridge.1
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        PetWindowService.this.petAlpha = f;
                        if (PetWindowService.this.showLp != null && PetWindowService.this.showBox != null) {
                            PetWindowService.this.showLp.alpha = f;
                            PetWindowService.this.wm.updateViewLayout(PetWindowService.this.showBox, PetWindowService.this.showLp);
                        }
                        Log.i("PetWindow", "[PET] setAlpha=" + f);
                    } catch (Throwable unused2) {
                    }
                }
            });
        }

        @JavascriptInterface
        public float getAlpha() {
            return PetWindowService.this.petAlpha;
        }

        @JavascriptInterface
        public boolean openApp(String str) {
            int length;
            if (str == null) {
                return false;
            }
            String lowerCase = str.trim().toLowerCase();
            if (lowerCase.isEmpty()) {
                return false;
            }
            try {
                PackageManager packageManager = PetWindowService.this.getPackageManager();
                Intent intent = new Intent("android.intent.action.MAIN");
                intent.addCategory("android.intent.category.LAUNCHER");
                String str2 = null;
                int i = -1;
                for (ResolveInfo resolveInfo : packageManager.queryIntentActivities(intent, 0)) {
                    if (resolveInfo != null && resolveInfo.activityInfo != null) {
                        String str3 = resolveInfo.activityInfo.packageName;
                        CharSequence charSequenceLoadLabel = resolveInfo.loadLabel(packageManager);
                        String lowerCase2 = (charSequenceLoadLabel == null ? "" : charSequenceLoadLabel.toString()).toLowerCase();
                        String lowerCase3 = str3.toLowerCase();
                        if (lowerCase3.equals(lowerCase)) {
                            length = 1000;
                        } else if (lowerCase2.equals(lowerCase)) {
                            length = 900;
                        } else if (lowerCase2.contains(lowerCase)) {
                            length = 700 - (lowerCase2.length() - lowerCase.length());
                        } else {
                            length = lowerCase3.contains(lowerCase) ? 500 - (lowerCase3.length() - lowerCase.length()) : -1;
                        }
                        if (length > i) {
                            i = length;
                            str2 = str3;
                        }
                    }
                }
                if (str2 != null && i >= 0) {
                    Intent launchIntentForPackage = packageManager.getLaunchIntentForPackage(str2);
                    if (launchIntentForPackage == null) {
                        Log.i("PetWindow", "[PET] openApp 无启动入口: " + str2);
                        return false;
                    }
                    launchIntentForPackage.addFlags(268435456);
                    PetWindowService.this.startActivity(launchIntentForPackage);
                    Log.i("PetWindow", "[PET] openApp 启动 " + str + " -> " + str2);
                    return true;
                }
                Log.i("PetWindow", "[PET] openApp 没找到: " + str);
                return false;
            } catch (Throwable th) {
                Log.e("PetWindow", "[PET] openApp 失败: " + th);
                return false;
            }
        }

        @JavascriptInterface
        public void hide() {
            PetWindowService.this.ui.post(new Runnable() { // from class: com.palai.prootsmoke.PetWindowService.PetHostBridge.2
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        if (PetWindowService.this.showBox != null) {
                            PetWindowService.this.showBox.setVisibility(8);
                        }
                    } catch (Throwable unused) {
                    }
                    try {
                        if (PetWindowService.this.touchBox != null) {
                            PetWindowService.this.touchBox.setVisibility(8);
                        }
                    } catch (Throwable unused2) {
                    }
                }
            });
        }

        @JavascriptInterface
        public void openDress() {
            final PetWindowService petWindowService = PetWindowService.this;
            petWindowService.ui.post(new Runnable() { // from class: com.palai.prootsmoke.PetWindowService.PetHostBridge.3
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        Intent intent = new Intent("android.intent.action.VIEW", Uri.parse("http://127.0.0.1:7797/dress"));
                        intent.addFlags(268435456);
                        petWindowService.startActivity(intent);
                    } catch (Throwable unused) {
                    }
                }
            });
        }
    }

    @Override // android.app.Service
    public void onDestroy() {
        this.ui.removeCallbacksAndMessages(null);
        try {
            if (this.imeProxy != null) {
                InputMethodManager inputMethodManager = (InputMethodManager) getSystemService("input_method");
                if (inputMethodManager != null) {
                    inputMethodManager.hideSoftInputFromWindow(this.imeProxy.getWindowToken(), 0);
                }
                this.imeProxy.clearFocus();
            }
        } catch (Throwable unused) {
        }
        try {
            WebView webView = this.web;
            if (webView != null) {
                webView.loadUrl("about:blank");
                this.web.destroy();
                this.web = null;
            }
        } catch (Throwable unused2) {
        }
        try {
            FrameLayout frameLayout = this.touchBox;
            if (frameLayout != null) {
                this.wm.removeView(frameLayout);
            }
        } catch (Throwable unused3) {
        }
        try {
            FrameLayout frameLayout2 = this.showBox;
            if (frameLayout2 != null) {
                this.wm.removeView(frameLayout2);
            }
        } catch (Throwable unused4) {
        }
        this.touchBox = null;
        this.showBox = null;
        super.onDestroy();
    }
}
