package com.palai.prootsmoke;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.webkit.WebView;

/* JADX INFO: loaded from: /home/runner/work/coopanion-re/coopanion-re/src/x/classes2.dex */
public final class WebRetry {
    private static final String TAG = "PetWebRetry";
    private static final Handler UI = new Handler(Looper.getMainLooper());
    private static int tries = 0;
    private static long lastAt = 0;

    private WebRetry() {
    }

    public static void fail(final WebView webView, long j) {
        if (webView == null) {
            return;
        }
        long jCurrentTimeMillis = System.currentTimeMillis();
        if (jCurrentTimeMillis - lastAt > 30000) {
            tries = 0;
        }
        lastAt = jCurrentTimeMillis;
        int i = tries;
        if (i >= 40) {
            Log.w(TAG, "give up after " + tries);
            return;
        }
        int i2 = i + 1;
        tries = i2;
        Log.i(TAG, "load failed, retry #" + i2 + " in " + j + "ms");
        UI.postDelayed(new Runnable() { // from class: com.palai.prootsmoke.WebRetry.1
            @Override // java.lang.Runnable
            public void run() {
                try {
                    webView.reload();
                } catch (Throwable th) {
                    Log.w(WebRetry.TAG, "reload: " + th);
                }
            }
        }, Math.max(300L, j));
    }

    public static void ok() {
        tries = 0;
    }
}
