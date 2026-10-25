package com.palai.prootsmoke;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.speech.RecognitionListener;
import android.speech.SpeechRecognizer;
import android.util.Log;
import android.webkit.JavascriptInterface;
import android.webkit.WebView;
import java.util.ArrayList;

/* JADX INFO: loaded from: /home/runner/work/coopanion-re/coopanion-re/src/x/classes2.dex */
public class VoiceBridge {
    private static final String TAG = "PetVoice";
    private final Context ctx;
    private SpeechRecognizer rec;
    private final Handler ui = new Handler(Looper.getMainLooper());
    private boolean wanted = false;
    private final WebView web;

    public VoiceBridge(Context context, WebView webView) {
        this.ctx = context;
        this.web = webView;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void deliver(String str, String str2, String str3) {
        if (this.web == null) {
            return;
        }
        StringBuilder sbAppend = new StringBuilder().append("(function(){try{var f=window.__petVoiceResult;if(typeof f==='function')f(").append(jsStr(str)).append(",");
        if (str2 == null) {
            str2 = "";
        }
        StringBuilder sbAppend2 = sbAppend.append(jsStr(str2)).append(",");
        if (str3 == null) {
            str3 = "";
        }
        final String string = sbAppend2.append(jsStr(str3)).append(");}catch(e){}})()").toString();
        this.ui.post(new Runnable() { // from class: com.palai.prootsmoke.VoiceBridge.1
            @Override // java.lang.Runnable
            public void run() {
                try {
                    VoiceBridge.this.web.evaluateJavascript(string, null);
                } catch (Throwable th) {
                    Log.w(VoiceBridge.TAG, "deliver: " + th);
                }
            }
        });
    }

    private static String jsStr(String str) {
        StringBuilder sb = new StringBuilder("'");
        for (int i = 0; i < str.length(); i++) {
            char cCharAt = str.charAt(i);
            if (cCharAt == '\'' || cCharAt == '\\') {
                sb.append('\\').append(cCharAt);
            } else if (cCharAt == '\n') {
                sb.append("\\n");
            } else if (cCharAt == '\r') {
                sb.append("\\r");
            } else {
                sb.append(cCharAt);
            }
        }
        return sb.append('\'').toString();
    }

    @JavascriptInterface
    public boolean available() {
        try {
            return SpeechRecognizer.isRecognitionAvailable(this.ctx);
        } catch (Throwable th) {
            return false;
        }
    }

    @JavascriptInterface
    public void start() {
        this.ui.post(new Runnable() { // from class: com.palai.prootsmoke.VoiceBridge.2
            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (VoiceBridge.this.rec == null) {
                        VoiceBridge voiceBridge = VoiceBridge.this;
                        voiceBridge.rec = voiceBridge.build();
                    }
                    VoiceBridge.this.wanted = true;
                    VoiceBridge.this.rec.cancel();
                    VoiceBridge.this.rec.startListening(VoiceBridge.this.intent());
                    VoiceBridge.this.deliver("start", "", "");
                } catch (Throwable th) {
                    Log.w(VoiceBridge.TAG, "start: " + th);
                    VoiceBridge.this.deliver("error", "", String.valueOf(th.getMessage()));
                }
            }
        });
    }

    @JavascriptInterface
    public void stop() {
        this.ui.post(new Runnable() { // from class: com.palai.prootsmoke.VoiceBridge.3
            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (VoiceBridge.this.rec != null) {
                        VoiceBridge.this.rec.stopListening();
                    }
                } catch (Throwable th) {
                    Log.w(VoiceBridge.TAG, "stop: " + th);
                }
            }
        });
    }

    @JavascriptInterface
    public void cancel() {
        this.ui.post(new Runnable() { // from class: com.palai.prootsmoke.VoiceBridge.4
            @Override // java.lang.Runnable
            public void run() {
                VoiceBridge.this.wanted = false;
                try {
                    if (VoiceBridge.this.rec != null) {
                        VoiceBridge.this.rec.cancel();
                    }
                } catch (Throwable th) {
                    Log.w(VoiceBridge.TAG, "cancel: " + th);
                }
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public Intent intent() {
        Intent intent = new Intent("android.speech.action.RECOGNIZE_SPEECH");
        intent.putExtra("android.speech.extra.LANGUAGE_MODEL", "free_form");
        intent.putExtra("android.speech.extra.LANGUAGE", "zh-CN");
        intent.putExtra("android.speech.extra.PARTIAL_RESULTS", true);
        intent.putExtra("android.speech.extra.MAX_RESULTS", 1);
        intent.putExtra("calling_package", this.ctx.getPackageName());
        return intent;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public SpeechRecognizer build() {
        SpeechRecognizer speechRecognizerCreateSpeechRecognizer = SpeechRecognizer.createSpeechRecognizer(this.ctx);
        speechRecognizerCreateSpeechRecognizer.setRecognitionListener(new RecognitionListener() { // from class: com.palai.prootsmoke.VoiceBridge.5
            @Override // android.speech.RecognitionListener
            public void onReadyForSpeech(Bundle bundle) {
                VoiceBridge.this.deliver("level", "", "ready");
            }

            @Override // android.speech.RecognitionListener
            public void onBeginningOfSpeech() {
                VoiceBridge.this.deliver("level", "", "speech");
            }

            @Override // android.speech.RecognitionListener
            public void onRmsChanged(float f) {
                VoiceBridge.this.deliver("rms", "", String.valueOf((int) f));
            }

            @Override // android.speech.RecognitionListener
            public void onBufferReceived(byte[] bArr) {
            }

            @Override // android.speech.RecognitionListener
            public void onEndOfSpeech() {
                VoiceBridge.this.deliver("level", "", "end");
            }

            @Override // android.speech.RecognitionListener
            public void onError(int i) {
                Log.w(VoiceBridge.TAG, "onError " + i);
                VoiceBridge voiceBridge = VoiceBridge.this;
                voiceBridge.deliver((voiceBridge.wanted && i == 7) ? "empty" : "error", "", VoiceBridge.errName(i));
            }

            @Override // android.speech.RecognitionListener
            public void onResults(Bundle bundle) {
                VoiceBridge.this.deliver("final", VoiceBridge.first(bundle), "");
            }

            @Override // android.speech.RecognitionListener
            public void onPartialResults(Bundle bundle) {
                String strFirst = VoiceBridge.first(bundle);
                if (strFirst != null && strFirst.length() > 0) {
                    VoiceBridge.this.deliver("partial", strFirst, "");
                }
            }

            @Override // android.speech.RecognitionListener
            public void onEvent(int i, Bundle bundle) {
            }
        });
        return speechRecognizerCreateSpeechRecognizer;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String first(Bundle bundle) {
        ArrayList<String> stringArrayList;
        if (bundle == null || (stringArrayList = bundle.getStringArrayList("results_recognition")) == null || stringArrayList.isEmpty()) {
            return "";
        }
        return stringArrayList.get(0);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String errName(int i) {
        switch (i) {
            case 1:
                return "网络超时";
            case 2:
                return "网络错误";
            case 3:
                return "录音出错";
            case 4:
                return "识别服务出错";
            case 5:
                return "客户端错误";
            case 6:
                return "没听到声音";
            case 7:
                return "没听清";
            case 8:
                return "识别服务忙";
            case 9:
                return "没有麦克风权限";
            default:
                return "错误 " + i;
        }
    }
}
