package com.palai.prootsmoke;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.view.MotionEvent;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.LinearLayout;

/* JADX INFO: loaded from: /home/runner/work/coopanion-re/coopanion-re/src/x/classes.dex */
public class RepairActivity extends Activity {
    private static final String REPAIR_URL = "http://127.0.0.1:7797/repair";
    private static final int REQ_FILE = 20818;
    private ValueCallback<Uri[]> filePathCallback;
    private Handler imeHandler;
    private boolean imeShown = false;
    private WebView web;

    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        AppLog.init(this);
        AppLog.i("[REPAIRACT] ===== RepairActivity onCreate =====");
        getWindow().setFlags(1024, 1024);
        try {
            getWindow().setSoftInputMode(16);
        } catch (Throwable unused) {
        }
        FrameLayout frameLayout = new FrameLayout(this);
        frameLayout.setBackgroundColor(-16052460);
        WebView webView = new WebView(this);
        this.web = webView;
        WebSettings settings = webView.getSettings();
        settings.setJavaScriptEnabled(true);
        settings.setDomStorageEnabled(true);
        settings.setMixedContentMode(0);
        settings.setAllowFileAccess(true);
        settings.setMediaPlaybackRequiresUserGesture(false);
        settings.setDatabaseEnabled(true);
        settings.setSupportZoom(true);
        settings.setBuiltInZoomControls(false);
        settings.setAllowContentAccess(true);
        settings.setJavaScriptCanOpenWindowsAutomatically(true);
        this.web.setFocusable(true);
        this.web.setFocusableInTouchMode(true);
        this.web.setClickable(true);
        this.web.requestFocus();
        this.web.setBackgroundColor(-16052460);
        this.web.setWebChromeClient(new WebChromeClient() { // from class: com.palai.prootsmoke.RepairActivity.1
            @Override // android.webkit.WebChromeClient
            public boolean onShowFileChooser(WebView webView2, ValueCallback<Uri[]> valueCallback, WebChromeClient.FileChooserParams fileChooserParams) {
                AppLog.i("[REPAIRACT][FILE] onShowFileChooser");
                if (RepairActivity.this.filePathCallback != null) {
                    try {
                        RepairActivity.this.filePathCallback.onReceiveValue(null);
                    } catch (Throwable unused2) {
                    }
                }
                RepairActivity.this.filePathCallback = valueCallback;
                try {
                    Intent intent = new Intent("android.intent.action.GET_CONTENT");
                    intent.addCategory("android.intent.category.OPENABLE");
                    intent.setType("image/*");
                    RepairActivity.this.startActivityForResult(Intent.createChooser(intent, "select image"), RepairActivity.REQ_FILE);
                    return true;
                } catch (Throwable th) {
                    AppLog.i("[REPAIRACT][FILE] err: " + th);
                    if (RepairActivity.this.filePathCallback == null) {
                        return false;
                    }
                    RepairActivity.this.filePathCallback.onReceiveValue(null);
                    RepairActivity.this.filePathCallback = null;
                    return false;
                }
            }
        });
        this.web.setOnTouchListener(new View.OnTouchListener() { // from class: com.palai.prootsmoke.RepairActivity.2
            @Override // android.view.View.OnTouchListener
            public boolean onTouch(View view, MotionEvent motionEvent) {
                if (motionEvent.getAction() != 0) {
                    return false;
                }
                try {
                    view.requestFocus();
                    return false;
                } catch (Throwable unused2) {
                    return false;
                }
            }
        });
        this.web.setWebViewClient(new WebViewClient() { // from class: com.palai.prootsmoke.RepairActivity.3
            @Override // android.webkit.WebViewClient
            public void onPageFinished(WebView webView2, String str) {
                AppLog.i("[REPAIRACT] onPageFinished: " + str);
                webView2.evaluateJavascript("(function(){ if(window.__imeHack) return; window.__imeHack=1;document.addEventListener('focusin',function(ev){  var t=ev.target; if(!t) return;  var tag=(t.tagName||'').toUpperCase();  if(tag==='INPUT'||tag==='TEXTAREA'||t.isContentEditable){    try{ window.__wantIme=1; }catch(e){}  }},true);window.__imeProbe=function(){var a=document.activeElement;  return (a&&(a.tagName==='INPUT'||a.tagName==='TEXTAREA'||a.isContentEditable))?1:0;};})()", null);
                RepairActivity.this.startImeWatchdog(webView2);
            }
        });
        frameLayout.addView(this.web, new FrameLayout.LayoutParams(-1, -1));
        LinearLayout linearLayout = new LinearLayout(this);
        linearLayout.setOrientation(0);
        FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(-2, -2);
        layoutParams.gravity = 51;
        layoutParams.topMargin = 40;
        layoutParams.leftMargin = 20;
        Button button = new Button(this);
        button.setText("‹ 返回");
        button.setAlpha(0.6f);
        button.setOnClickListener(new View.OnClickListener() { // from class: com.palai.prootsmoke.RepairActivity.4
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                RepairActivity.this.finish();
            }
        });
        linearLayout.addView(button);
        frameLayout.addView(linearLayout, layoutParams);
        setContentView(frameLayout);
        this.web.loadUrl(REPAIR_URL);
        AppLog.i("[REPAIRACT] loadUrl -> http://127.0.0.1:7797/repair");
    }

    @Override // android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) {
        if (i == REQ_FILE) {
            Object[] objArr = (i2 != -1 || intent == null || intent.getData() == null) ? null : new Uri[]{intent.getData()};
            ValueCallback<Uri[]> valueCallback = this.filePathCallback;
            if (valueCallback != null) {
                try {
                    valueCallback.onReceiveValue((Uri[]) objArr);
                } catch (Throwable unused) {
                }
                this.filePathCallback = null;
            }
            AppLog.i("[REPAIRACT][FILE] onActivityResult req=" + i + " res=" + i2 + " ok=" + (objArr != null) + " uri=" + (objArr != null ? objArr[0] : "null"));
            return;
        }
        super.onActivityResult(i, i2, intent);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void startImeWatchdog(final WebView webView) {
        if (this.imeHandler == null) {
            this.imeHandler = new Handler(Looper.getMainLooper());
        }
        this.imeHandler.postDelayed(new Runnable() { // from class: com.palai.prootsmoke.RepairActivity.5
            @Override // java.lang.Runnable
            public void run() {
                try {
                    WebView webView2 = webView;
                    if (webView2 == null) {
                        return;
                    } else {
                        webView2.evaluateJavascript("(window.__imeProbe?window.__imeProbe():0)", new ValueCallback<String>() { // from class: com.palai.prootsmoke.RepairActivity.5.1
                            @Override // android.webkit.ValueCallback
                            public void onReceiveValue(String str) {
                                boolean z = str != null && str.contains("1");
                                if (z && !RepairActivity.this.imeShown) {
                                    RepairActivity.this.imeShown = true;
                                    RepairActivity.this.showImeNow();
                                } else {
                                    if (z) {
                                        return;
                                    }
                                    RepairActivity.this.imeShown = false;
                                }
                            }
                        });
                    }
                } catch (Throwable unused) {
                }
                if (RepairActivity.this.imeHandler != null) {
                    RepairActivity.this.imeHandler.postDelayed(this, 400L);
                }
            }
        }, 600L);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void showImeNow() {
        try {
            WebView webView = this.web;
            if (webView == null) {
                return;
            }
            webView.requestFocus();
            InputMethodManager inputMethodManager = (InputMethodManager) getSystemService("input_method");
            if (inputMethodManager != null) {
                inputMethodManager.showSoftInput(this.web, 1);
                AppLog.i("[REPAIRACT][IME] showSoftInput requested");
            }
        } catch (Throwable th) {
            AppLog.i("[REPAIRACT][IME] err: " + th);
        }
    }

    @Override // android.app.Activity
    protected void onDestroy() {
        try {
            Handler handler = this.imeHandler;
            if (handler != null) {
                handler.removeCallbacksAndMessages(null);
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
        super.onDestroy();
    }
}
