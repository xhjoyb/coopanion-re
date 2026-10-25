package com.palai.prootsmoke;

import android.app.Application;
import android.os.Build;
import android.os.Looper;
import android.util.Log;
import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/* JADX INFO: loaded from: /home/runner/work/coopanion-re/coopanion-re/src/x/classes.dex */
public class CrashApp extends Application {
    private static final String TAG = "CoopCrash";

    @Override // android.app.Application
    public void onCreate() {
        super.onCreate();
        final Thread.UncaughtExceptionHandler defaultUncaughtExceptionHandler = Thread.getDefaultUncaughtExceptionHandler();
        Thread.setDefaultUncaughtExceptionHandler(new Thread.UncaughtExceptionHandler() { // from class: com.palai.prootsmoke.CrashApp.1
            @Override // java.lang.Thread.UncaughtExceptionHandler
            public void uncaughtException(Thread thread, Throwable th) {
                try {
                    CrashApp.this.dump(thread, th);
                } catch (Throwable unused) {
                }
                Thread.UncaughtExceptionHandler uncaughtExceptionHandler = defaultUncaughtExceptionHandler;
                if (uncaughtExceptionHandler != null) {
                    uncaughtExceptionHandler.uncaughtException(thread, th);
                }
            }
        });
        try {
            Looper.getMainLooper();
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void dump(Thread thread, Throwable th) {
        StringWriter stringWriter = new StringWriter();
        PrintWriter printWriter = new PrintWriter(stringWriter);
        printWriter.println("time=" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.US).format(new Date()));
        printWriter.println("thread=" + thread.getName());
        printWriter.println("android=" + Build.VERSION.SDK_INT + " device=" + Build.MODEL);
        printWriter.println("---- stack ----");
        th.printStackTrace(printWriter);
        printWriter.flush();
        String string = stringWriter.toString();
        Log.e(TAG, string);
        String[] strArr = {"/sdcard/Download/coop-crash.txt", "/storage/emulated/0/Download/coop-crash.txt", "/storage/emulated/10/Download/coop-crash.txt"};
        for (int i = 0; i < 3; i++) {
            try {
                FileOutputStream fileOutputStream = new FileOutputStream(new File(strArr[i]), true);
                fileOutputStream.write(("\n========== CRASH ==========\n" + string).getBytes("UTF-8"));
                fileOutputStream.flush();
                fileOutputStream.close();
            } catch (Throwable unused) {
            }
        }
    }
}
