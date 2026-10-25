package com.palai.prootsmoke;

import android.content.Context;
import android.graphics.Rect;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowInsets;
import android.webkit.WebView;

/* JADX INFO: loaded from: /home/runner/work/coopanion-re/coopanion-re/src/x/classes2.dex */
public final class PetKeyboardGuard {
    private static final float IME_RATIO = 0.12f;
    private static final long INTERVAL_MS = 150;
    private static final String TAG = "PetKb";
    private static volatile PetKeyboardGuard current;
    private static volatile View touchLayer;
    private final Context app;
    private volatile View root;
    private final int screenH;
    private volatile View target;
    private WebView web;
    private final Handler ui = new Handler(Looper.getMainLooper());
    private long seq = 0;
    private int lastHeight = -1;
    private String lastSource = "";
    private boolean reportedOnce = false;
    private final Runnable tick = new Runnable() { // from class: com.palai.prootsmoke.PetKeyboardGuard.1
        @Override // java.lang.Runnable
        public void run() {
            try {
                PetKeyboardGuard.this.evaluate();
            } catch (Throwable th) {
                Log.w(PetKeyboardGuard.TAG, "tick failed: " + th);
            }
            PetKeyboardGuard.this.ui.postDelayed(this, PetKeyboardGuard.INTERVAL_MS);
        }
    };

    private PetKeyboardGuard(Context context, View view, View view2) {
        this.app = context.getApplicationContext();
        this.root = view;
        this.target = view2;
        this.screenH = context.getResources().getDisplayMetrics().heightPixels;
    }

    public static void install(Context context, View view, View view2) {
        if (context == null || view == null) {
            return;
        }
        try {
            PetKeyboardGuard petKeyboardGuard = current;
            if (petKeyboardGuard == null) {
                if (view2 == null) {
                    view2 = view;
                }
                petKeyboardGuard = new PetKeyboardGuard(context, view, view2);
                petKeyboardGuard.ui.post(petKeyboardGuard.tick);
                current = petKeyboardGuard;
            } else {
                if (view2 == null) {
                    view2 = view;
                }
                petKeyboardGuard.retarget(view, view2);
            }
            EyesService.setImeListener(new EyesService.ImeListener() { // from class: com.palai.prootsmoke.PetKeyboardGuard.2
                @Override // com.palai.prootsmoke.EyesService.ImeListener
                public void onImeHeight(int i) {
                    PetKeyboardGuard.this.onImeFromA11y(i);
                }
            });
            Log.i(TAG, "installed screenH=" + petKeyboardGuard.screenH + " a11y=" + EyesService.isRunning());
        } catch (Throwable th) {
            Log.w(TAG, "install failed: " + th);
        }
    }

    public static void setTouchLayer(View view) {
        touchLayer = view;
        Log.i(TAG, "touch layer attached=" + (view != null));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void onImeFromA11y(int i) {
        if (i < 0) {
            i = 0;
        }
        publish(i, "a11y");
    }

    private void publish(int i, String str) {
        this.lastSource = str;
        this.lastHeight = i;
        reportKeyboard(i);
        reportIme(i > 0, str);
    }

    private void retarget(View view, View view2) {
        this.root = view;
        this.target = view2;
        this.web = null;
    }

    private int imeHeight() {
        WindowInsets rootWindowInsets;
        int i;
        int i2;
        this.lastSource = "";
        int iImeHeightSmart = EyesService.imeHeightSmart();
        if (iImeHeightSmart > 0) {
            this.lastSource = "a11y=" + iImeHeightSmart;
            return clampH(iImeHeightSmart);
        }
        if (iImeHeightSmart < 0) {
            int i3 = (int) (((double) this.screenH) * 0.38d);
            this.lastSource = "a11y~guess=" + i3;
            return clampH(i3);
        }
        WindowInsets rootWindowInsets2 = this.root.getRootWindowInsets();
        if (rootWindowInsets2 != null && (i2 = rootWindowInsets2.getInsets(WindowInsets.Type.ime()).bottom) > 0) {
            this.lastSource = "root.insets=" + i2;
            return clampH(i2);
        }
        View view = touchLayer;
        if (view != null && (rootWindowInsets = view.getRootWindowInsets()) != null && (i = rootWindowInsets.getInsets(WindowInsets.Type.ime()).bottom) > 0) {
            this.lastSource = "touch.insets=" + i;
            return clampH(i);
        }
        try {
            Rect rect = new Rect();
            this.root.getWindowVisibleDisplayFrame(rect);
            int i4 = this.screenH - rect.bottom;
            if (i4 <= 0) {
                return 0;
            }
            this.lastSource = "frame=" + i4;
            return clampH(i4);
        } catch (Throwable th) {
            return 0;
        }
    }

    private int a11yOrInsets() {
        try {
            int iImeHeight = EyesService.imeHeight();
            if (iImeHeight > 0) {
                this.lastSource = "a11y=" + iImeHeight;
                return clampH(iImeHeight);
            }
        } catch (Throwable th) {
        }
        return imeHeight();
    }

    private int clampH(int i) {
        if (i <= 0) {
            return 0;
        }
        return Math.min(i, (int) (((double) this.screenH) * 0.75d));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void evaluate() {
        boolean zIsRunning = EyesService.isRunning();
        int iA11yOrInsets = zIsRunning ? a11yOrInsets() : imeHeight();
        if (!this.reportedOnce) {
            this.reportedOnce = true;
            String str = zIsRunning ? "init a11y=on" : "init a11y=off 需要开启无障碍";
            Log.i(TAG, str);
            reportIme(false, str);
        }
        if (iA11yOrInsets != this.lastHeight) {
            Log.i(TAG, "ime height " + iA11yOrInsets + " (" + this.lastSource + ")");
        }
        this.lastHeight = iA11yOrInsets;
        reportKeyboard(iA11yOrInsets);
        reportIme(iA11yOrInsets > 0, this.lastSource);
    }

    private void reportKeyboard(int i) {
        try {
            if (this.web == null) {
                this.web = findWeb(this.root);
            }
            WebView webView = this.web;
            if (webView == null) {
                Log.w(TAG, "no webview for keyboard report");
            } else {
                this.seq++;
                webView.evaluateJavascript("window.__petKeyboard&&window.__petKeyboard(" + i + "," + this.seq + ")", null);
            }
        } catch (Throwable th) {
            Log.w(TAG, "reportKeyboard failed: " + th);
        }
    }

    private void reportIme(boolean z, String str) {
        try {
            if (this.web == null) {
                this.web = findWeb(this.root);
            }
            if (this.web == null) {
                Log.w(TAG, "no webview for ime report");
            } else {
                this.web.evaluateJavascript("window.__petIme&&window.__petIme(" + z + ",'" + (str == null ? "" : str.replace("'", " ")) + "')", null);
            }
        } catch (Throwable th) {
        }
    }

    private static WebView findWeb(View view) {
        if (view == null) {
            return null;
        }
        if (view instanceof WebView) {
            return (WebView) view;
        }
        if (view instanceof ViewGroup) {
            ViewGroup viewGroup = (ViewGroup) view;
            for (int i = 0; i < viewGroup.getChildCount(); i++) {
                WebView webViewFindWeb = findWeb(viewGroup.getChildAt(i));
                if (webViewFindWeb != null) {
                    return webViewFindWeb;
                }
            }
        }
        return null;
    }
}
