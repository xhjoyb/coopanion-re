package com.palai.prootsmoke;

import android.content.Context;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.view.WindowManager;
import android.webkit.JavascriptInterface;
import android.webkit.WebView;
import android.webkit.WebViewClient;

/* JADX INFO: loaded from: /home/runner/work/coopanion-re/coopanion-re/src/x/classes2.dex */
public final class PetWindow2 {
    private static final int BASE_TOUCH = 520;
    private static final String SHIM = "(function(){ if (typeof petHostNative === 'undefined') return 'no-bridge'; if (window.petHost) return 'already'; window.petHost = { setInteractive:function(o){}, focus:function(){}, grabFocus:function(){}, releaseFocus:function(){}, hide:function(){}, openDress:function(){}, setAlpha:function(f){}, getAlpha:function(){return 1;}, openApp:function(n){return false;}, onCursor:function(cb){}, sampleBackdrop:function(){return null;} }; document.body.classList.remove('tab'); document.body.classList.add('desk'); return 'ok';})()";
    private static final String TAG = "PetWin2";
    private static final String URL = "http://127.0.0.1:7797/pet?pet=2";
    private static View touch;
    private static WindowManager.LayoutParams touchLp;
    private static WebView web;
    private static WindowManager.LayoutParams webLp;
    private static WindowManager wm;
    private static volatile int petL = -1;
    private static volatile int petT = -1;
    private static volatile int petR = -1;
    private static volatile int petB = -1;
    private static boolean started = false;
    private static final Handler ui = new Handler(Looper.getMainLooper());
    private static final Runnable tick = new Runnable() { // from class: com.palai.prootsmoke.PetWindow2.1
        @Override // java.lang.Runnable
        public void run() {
            try {
                PetWindow2.sync();
            } catch (Throwable th) {
                Log.w(PetWindow2.TAG, "tick: " + th);
            }
            PetWindow2.ui.postDelayed(this, 120L);
        }
    };

    private PetWindow2() {
    }

    public static void start(Context context) {
        if (started) {
            return;
        }
        started = true;
        try {
            build(context.getApplicationContext());
        } catch (Throwable th) {
            Log.e(TAG, "start: " + th);
            started = false;
        }
    }

    public static void stop() {
        started = false;
        try {
            ui.removeCallbacks(tick);
        } catch (Throwable th) {
        }
        try {
            WebView webView = web;
            if (webView != null) {
                wm.removeView(webView);
            }
        } catch (Throwable th2) {
        }
        try {
            View view = touch;
            if (view != null) {
                wm.removeView(view);
            }
        } catch (Throwable th3) {
        }
        web = null;
        touch = null;
    }

    private static void build(Context context) {
        int i;
        wm = (WindowManager) context.getSystemService("window");
        if (Build.VERSION.SDK_INT >= 26) {
            i = 2038;
        } else {
            i = 2002;
        }
        WebView webView = new WebView(context);
        web = webView;
        webView.setBackgroundColor(0);
        web.setLayerType(2, null);
        web.getSettings().setJavaScriptEnabled(true);
        web.getSettings().setDomStorageEnabled(true);
        web.addJavascriptInterface(new Bridge(), "pet2Native");
        web.addJavascriptInterface(new HostBridge(), "petHostNative");
        web.setWebViewClient(new WebViewClient() { // from class: com.palai.prootsmoke.PetWindow2.2
            @Override // android.webkit.WebViewClient
            public void onPageFinished(WebView webView2, String str) {
                try {
                    webView2.evaluateJavascript(PetWindow2.SHIM, null);
                } catch (Throwable th) {
                }
            }
        });
        web.loadUrl(URL);
        int i2 = i;
        WindowManager.LayoutParams layoutParams = new WindowManager.LayoutParams(-1, -1, i2, 792, -3);
        webLp = layoutParams;
        layoutParams.gravity = 8388659;
        wm.addView(web, webLp);
        touch = new View(context) { // from class: com.palai.prootsmoke.PetWindow2.3
            @Override // android.view.View
            public boolean onTouchEvent(MotionEvent motionEvent) {
                return PetWindow2.forward(motionEvent);
            }
        };
        WindowManager.LayoutParams layoutParams2 = new WindowManager.LayoutParams(BASE_TOUCH, BASE_TOUCH, i2, 776, -3);
        touchLp = layoutParams2;
        layoutParams2.gravity = 8388659;
        wm.addView(touch, touchLp);
        ui.post(tick);
        Log.i(TAG, "started");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static void sync() {
        if (touch == null || petL < 0 || petR <= petL) {
            return;
        }
        float f = 1.0f;
        try {
            float f2 = web.getContext().getSharedPreferences("coopanion", 0).getFloat("pet_scale", 1.0f);
            if (f2 > 0.2f && f2 <= 3.0f) {
                f = f2;
            }
        } catch (Throwable th) {
        }
        int iMax = Math.max(160, Math.round(f * 520.0f));
        int i = (petL + petR) / 2;
        int i2 = (petT + petB) / 2;
        touchLp.width = iMax;
        touchLp.height = iMax;
        int i3 = iMax / 2;
        touchLp.x = Math.max(0, i - i3);
        touchLp.y = Math.max(0, i2 - i3);
        try {
            wm.updateViewLayout(touch, touchLp);
        } catch (Throwable th2) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static boolean forward(MotionEvent motionEvent) {
        try {
            WebView webView = web;
            if (webView == null) {
                return false;
            }
            float f = webView.getResources().getDisplayMetrics().density;
            MotionEvent motionEventObtain = MotionEvent.obtain(motionEvent);
            motionEventObtain.setLocation((motionEvent.getX() + touchLp.x) / f, (motionEvent.getY() + touchLp.y) / f);
            web.dispatchTouchEvent(motionEventObtain);
            motionEventObtain.recycle();
            return true;
        } catch (Throwable th) {
            return false;
        }
    }

    public static final class HostBridge {
        @JavascriptInterface
        public void setInteractive(boolean z) {
        }

        @JavascriptInterface
        public void focus() {
        }

        @JavascriptInterface
        public void grabFocus() {
        }

        @JavascriptInterface
        public void releaseFocus() {
        }

        @JavascriptInterface
        public void hide() {
        }

        @JavascriptInterface
        public void openDress() {
        }

        @JavascriptInterface
        public void setAlpha(float f) {
        }

        @JavascriptInterface
        public float getAlpha() {
            return 1.0f;
        }

        @JavascriptInterface
        public boolean openApp(String str) {
            return false;
        }
    }

    public static final class Bridge {
        @JavascriptInterface
        public void rect(float f, float f2, float f3, float f4) {
            int unused = PetWindow2.petL = Math.round(f);
            int unused2 = PetWindow2.petT = Math.round(f2);
            int unused3 = PetWindow2.petR = Math.round(f3);
            int unused4 = PetWindow2.petB = Math.round(f4);
        }

        @JavascriptInterface
        public void log(String str) {
            Log.i(PetWindow2.TAG, "page: " + str);
        }
    }
}
