package com.palai.prootsmoke;

import android.content.Context;
import android.util.Log;
import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/* JADX INFO: loaded from: /home/runner/work/coopanion-re/coopanion-re/src/x/classes.dex */
public final class AppLog {
    private static final SimpleDateFormat FMT = new SimpleDateFormat("HH:mm:ss.SSS", Locale.US);
    private static volatile File LOG_FILE = null;
    public static final String TAG = "PetWindow";

    private AppLog() {
    }

    public static void init(Context context) {
        try {
            File externalFilesDir = context.getExternalFilesDir(null);
            if (externalFilesDir == null) {
                externalFilesDir = context.getFilesDir();
            }
            LOG_FILE = new File(externalFilesDir, "coop-run.log");
        } catch (Throwable unused) {
        }
    }

    public static void i(String str) {
        try {
            Log.i(TAG, str);
        } catch (Throwable unused) {
        }
        write("I", str);
    }

    public static void e(String str) {
        try {
            Log.e(TAG, str);
        } catch (Throwable unused) {
        }
        write("E", str);
    }

    private static void write(String str, String str2) {
        File file = LOG_FILE;
        if (file == null) {
            return;
        }
        try {
            String str3 = "[" + FMT.format(new Date()) + "] " + str + "/PetWindow: " + str2 + "\n";
            FileOutputStream fileOutputStream = new FileOutputStream(file, true);
            fileOutputStream.write(str3.getBytes("UTF-8"));
            fileOutputStream.flush();
            fileOutputStream.close();
        } catch (Throwable unused) {
        }
    }
}
