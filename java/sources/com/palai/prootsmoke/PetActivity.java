package com.palai.prootsmoke;

import android.app.Activity;
import android.content.Intent;
import android.graphics.drawable.ColorDrawable;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.webkit.JavascriptInterface;
import android.webkit.PermissionRequest;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.LinearLayout;

/* JADX INFO: loaded from: /home/runner/work/coopanion-re/coopanion-re/src/x/classes.dex */
public class PetActivity extends Activity {
    private static final String PET_URL = "http://127.0.0.1:7797/pet?host=app";
    private static final int REQ_FILE = 20819;
    private ValueCallback<Uri[]> filePathCallback;
    private FrameLayout root;
    private WebView web;

    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        AppLog.init(this);
        AppLog.i("[PETACT] ===== PetActivity onCreate =====");
        boolean z = getIntent() != null && getIntent().getBooleanExtra("transparent", false);
        if (z) {
            try {
                getWindow().setBackgroundDrawable(new ColorDrawable(0));
                getWindow().addFlags(32);
            } catch (Throwable unused) {
            }
        }
        getWindow().setFlags(1024, 1024);
        if (Build.VERSION.SDK_INT >= 28) {
            getWindow().getAttributes().layoutInDisplayCutoutMode = 1;
        }
        FrameLayout frameLayout = new FrameLayout(this);
        this.root = frameLayout;
        frameLayout.setBackgroundColor(z ? 0 : -16052460);
        WebView webView = new WebView(this);
        this.web = webView;
        WebSettings settings = webView.getSettings();
        settings.setJavaScriptEnabled(true);
        settings.setDomStorageEnabled(true);
        settings.setMixedContentMode(0);
        settings.setAllowFileAccess(true);
        settings.setMediaPlaybackRequiresUserGesture(false);
        settings.setUseWideViewPort(false);
        settings.setLoadWithOverviewMode(false);
        settings.setSupportZoom(false);
        settings.setBuiltInZoomControls(false);
        settings.setDisplayZoomControls(false);
        this.web.setBackgroundColor(z ? 0 : -16052460);
        this.web.addJavascriptInterface(new PetHostBridge(), "petHostNative");
        this.web.addJavascriptInterface(new PetHostBridge(), "petHost");
        this.web.setWebChromeClient(new WebChromeClient() { // from class: com.palai.prootsmoke.PetActivity.1
            @Override // android.webkit.WebChromeClient
            public void onPermissionRequest(PermissionRequest permissionRequest) {
                try {
                    boolean z2 = false;
                    for (String str : permissionRequest.getResources()) {
                        if ("android.webkit.resource.AUDIO_CAPTURE".equals(str)) {
                            z2 = true;
                        }
                    }
                    if (z2) {
                        AppLog.i("[PETACT][MIC] WebView 请求麦克风 -> 已放行");
                        permissionRequest.grant(permissionRequest.getResources());
                    } else {
                        permissionRequest.deny();
                    }
                } catch (Throwable th) {
                    AppLog.i("[PETACT][MIC] onPermissionRequest err: " + th);
                }
            }

            @Override // android.webkit.WebChromeClient
            public boolean onShowFileChooser(WebView webView2, ValueCallback<Uri[]> valueCallback, WebChromeClient.FileChooserParams fileChooserParams) {
                AppLog.i("[PETACT][FILE] onShowFileChooser");
                if (PetActivity.this.filePathCallback != null) {
                    try {
                        PetActivity.this.filePathCallback.onReceiveValue(null);
                    } catch (Throwable unused2) {
                    }
                }
                PetActivity.this.filePathCallback = valueCallback;
                try {
                    Intent intent = new Intent("android.intent.action.GET_CONTENT");
                    intent.addCategory("android.intent.category.OPENABLE");
                    intent.setType("image/*");
                    PetActivity.this.startActivityForResult(Intent.createChooser(intent, "select image"), PetActivity.REQ_FILE);
                    return true;
                } catch (Throwable th) {
                    AppLog.i("[PETACT][FILE] err: " + th);
                    if (PetActivity.this.filePathCallback == null) {
                        return false;
                    }
                    PetActivity.this.filePathCallback.onReceiveValue(null);
                    PetActivity.this.filePathCallback = null;
                    return false;
                }
            }
        });
        this.web.setWebViewClient(new WebViewClient() { // from class: com.palai.prootsmoke.PetActivity.2
            @Override // android.webkit.WebViewClient
            public void onPageFinished(WebView webView2, String str) {
                AppLog.i("[PETACT] onPageFinished: " + str);
                webView2.evaluateJavascript("(function(){try{var e=document.getElementById('pet');var g=(function tick(){window.__rc=(window.__rc||0)+1;requestAnimationFrame(tick);})();return 'petEl='+(e?'yes':'NO')+' raf='+(typeof requestAnimationFrame)+' vp='+innerWidth+'x'+innerHeight;}catch(err){return 'err '+err;}})()", new ValueCallback<String>() { // from class: com.palai.prootsmoke.PetActivity.2.1
                    @Override // android.webkit.ValueCallback
                    public void onReceiveValue(String str2) {
                        AppLog.i("[PETACT] probe -> " + str2);
                    }
                });
            }
        });
        this.root.addView(this.web, new FrameLayout.LayoutParams(-1, -1));
        LinearLayout linearLayout = new LinearLayout(this);
        linearLayout.setOrientation(0);
        FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(-2, -2);
        layoutParams.gravity = 53;
        layoutParams.topMargin = 40;
        layoutParams.rightMargin = 24;
        Button button = new Button(this);
        button.setText("✕ 退出");
        button.setAlpha(0.55f);
        button.setOnClickListener(new View.OnClickListener() { // from class: com.palai.prootsmoke.PetActivity.3
            @Override // android.view.View.OnClickListener
            public void onClick(View view) {
                PetActivity.this.finish();
            }
        });
        linearLayout.addView(button);
        this.root.addView(linearLayout, layoutParams);
        setContentView(this.root);
        try {
            if (checkSelfPermission("android.permission.RECORD_AUDIO") != 0) {
                requestPermissions(new String[]{"android.permission.RECORD_AUDIO"}, 10088);
            }
        } catch (Throwable unused2) {
        }
        this.web.loadUrl(PET_URL);
        AppLog.i("[PETACT] loadUrl -> http://127.0.0.1:7797/pet?host=app");
    }

    @Override // android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) {
        if (i == REQ_FILE) {
            Uri[] uriArr = (i2 != -1 || intent == null || intent.getData() == null) ? null : new Uri[]{intent.getData()};
            ValueCallback<Uri[]> valueCallback = this.filePathCallback;
            if (valueCallback != null) {
                valueCallback.onReceiveValue(uriArr);
                this.filePathCallback = null;
            }
            AppLog.i("[PETACT][FILE] onActivityResult ok=" + (uriArr != null));
            return;
        }
        super.onActivityResult(i, i2, intent);
    }

    @Override // android.app.Activity
    public void onBackPressed() {
        finish();
    }

    @Override // android.app.Activity
    protected void onDestroy() {
        try {
            WebView webView = this.web;
            if (webView != null) {
                webView.loadUrl("about:blank");
                this.web.destroy();
                this.web = null;
            }
        } catch (Throwable unused) {
        }
        super.onDestroy();
    }

    public static class PetHostBridge {
        @JavascriptInterface
        public void focus() {
        }

        @JavascriptInterface
        public void grabFocus() {
        }

        @JavascriptInterface
        public void hide() {
        }

        @JavascriptInterface
        public void onCursor() {
        }

        @JavascriptInterface
        public void openDress() {
        }

        @JavascriptInterface
        public void releaseFocus() {
        }

        @JavascriptInterface
        public void reportPetRect(int i, int i2, int i3, int i4) {
        }

        @JavascriptInterface
        public String sampleBackdrop() {
            return null;
        }

        @JavascriptInterface
        public void setInteractive(boolean z) {
        }

        @JavascriptInterface
        public void jsw(String str) {
            AppLog.i("[JS] " + str);
        }
    }
}
