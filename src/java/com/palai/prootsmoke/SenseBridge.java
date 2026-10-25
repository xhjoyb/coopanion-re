package com.palai.prootsmoke;

import android.app.AppOpsManager;
import android.app.KeyguardManager;
import android.app.usage.UsageStats;
import android.app.usage.UsageStatsManager;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.os.PowerManager;
import android.os.Process;
import android.provider.Settings;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: /home/runner/work/coopanion-re/coopanion-re/src/x/classes.dex */
public final class SenseBridge {
    private static final int NOTIF_CAP = 64;
    public static final int PORT = 17899;
    private static volatile SenseBridge instance;
    private final Context ctx;
    private volatile boolean running;
    private ServerSocket server;
    private Thread thread;
    private final List<JSONObject> notifs = new ArrayList();
    private long notifSeq = 0;

    public static synchronized SenseBridge get(Context context) {
        if (instance == null) {
            instance = new SenseBridge(context.getApplicationContext());
        }
        return instance;
    }

    public static SenseBridge peek() {
        return instance;
    }

    public synchronized void addNotification(String str, String str2, String str3, String str4, long j) throws JSONException {
        this.notifSeq++;
        JSONObject jSONObject = new JSONObject();
        try {
            jSONObject.put("seq", this.notifSeq);
            jSONObject.put("id", "n" + this.notifSeq);
            if (str == null) {
                str = "";
            }
            jSONObject.put("pkg", str);
            if (str2 == null) {
                str2 = "";
            }
            jSONObject.put("app", str2);
            if (str3 == null) {
                str3 = "";
            }
            jSONObject.put("title", str3);
            if (str4 == null) {
                str4 = "";
            }
            jSONObject.put("text", str4);
        } catch (Exception unused) {
        }
        this.notifs.add(jSONObject);
        while (this.notifs.size() > NOTIF_CAP) {
            this.notifs.remove(0);
        }
    }

    private SenseBridge(Context context) {
        this.ctx = context;
    }

    public void start() {
        if (this.running) {
            return;
        }
        this.running = true;
        Thread thread = new Thread(new Runnable() { // from class: com.palai.prootsmoke.SenseBridge$$ExternalSyntheticLambda0
            @Override // java.lang.Runnable
            public final void run() {
                this.f$0.loop();
            }
        }, "sense-bridge");
        this.thread = thread;
        thread.setDaemon(true);
        this.thread.start();
    }

    public void stop() {
        this.running = false;
        try {
            ServerSocket serverSocket = this.server;
            if (serverSocket != null) {
                serverSocket.close();
            }
        } catch (IOException unused) {
        }
        this.server = null;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void loop() {
        try {
            this.server = new ServerSocket(PORT, 8, InetAddress.getByName("127.0.0.1"));
            while (this.running) {
                final Socket socketAccept = this.server.accept();
                new Thread(new Runnable() { // from class: com.palai.prootsmoke.SenseBridge$$ExternalSyntheticLambda1
                    @Override // java.lang.Runnable
                    public final void run() {
                        this.f$0.lambda$loop$0(socketAccept);
                    }
                }, "sense-bridge-conn").start();
            }
        } catch (IOException unused) {
            this.running = false;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Code duplicated, block: B:35:0x0094  */
    /* JADX WARN: Code duplicated, block: B:40:0x00be  */
    /* JADX WARN: Code duplicated, block: B:41:0x00c1  */
    /* JADX INFO: renamed from: handle, reason: merged with bridge method [inline-methods] */
    public void lambda$loop$0(Socket socket) {
        String line;
        String strNotificationsJson;
        int i;
        long j;
        String str;
        try {
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(socket.getInputStream(), StandardCharsets.UTF_8));
            String line2 = bufferedReader.readLine();
            if (line2 != null) {
                String[] strArrSplit = line2.split(" ");
                String str2 = strArrSplit.length >= 2 ? strArrSplit[1] : "/";
                do {
                    line = bufferedReader.readLine();
                    if (line == null) {
                        break;
                    }
                } while (!line.isEmpty());
                if (str2.startsWith("/health")) {
                    strNotificationsJson = healthJson();
                } else if (str2.startsWith("/state")) {
                    strNotificationsJson = stateJson();
                } else {
                    if (str2.startsWith("/notifications")) {
                        int iIndexOf = str2.indexOf("since=");
                        if (iIndexOf >= 0) {
                            StringBuilder sb = new StringBuilder();
                            for (int i2 = iIndexOf + 6; i2 < str2.length() && Character.isDigit(str2.charAt(i2)); i2++) {
                                sb.append(str2.charAt(i2));
                            }
                            if (sb.length() > 0) {
                                j = Long.parseLong(sb.toString());
                            } else {
                                j = 0;
                            }
                        } else {
                            j = 0;
                        }
                        strNotificationsJson = notificationsJson(j);
                    } else {
                        strNotificationsJson = "{}";
                        i = 404;
                    }
                    byte[] bytes = strNotificationsJson.getBytes(StandardCharsets.UTF_8);
                    OutputStream outputStream = socket.getOutputStream();
                    StringBuilder sbAppend = new StringBuilder().append("HTTP/1.1 ").append(i).append(" ");
                    if (i == 200) {
                        str = "OK";
                    } else {
                        str = "Not Found";
                    }
                    outputStream.write(sbAppend.append(str).append("\r\nContent-Type: application/json; charset=utf-8\r\nContent-Length: ").append(bytes.length).append("\r\nConnection: close\r\n\r\n").toString().getBytes(StandardCharsets.UTF_8));
                    outputStream.write(bytes);
                    outputStream.flush();
                }
                i = 200;
                byte[] bytes2 = strNotificationsJson.getBytes(StandardCharsets.UTF_8);
                OutputStream outputStream2 = socket.getOutputStream();
                StringBuilder sbAppend2 = new StringBuilder().append("HTTP/1.1 ").append(i).append(" ");
                if (i == 200) {
                    str = "OK";
                } else {
                    str = "Not Found";
                }
                outputStream2.write(sbAppend2.append(str).append("\r\nContent-Type: application/json; charset=utf-8\r\nContent-Length: ").append(bytes2.length).append("\r\nConnection: close\r\n\r\n").toString().getBytes(StandardCharsets.UTF_8));
                outputStream2.write(bytes2);
                outputStream2.flush();
            } else {
                try {
                    socket.close();
                    return;
                } catch (IOException unused) {
                    return;
                }
            }
        } catch (Exception unused2) {
        } catch (Throwable th) {
            try {
                socket.close();
            } catch (IOException unused3) {
            }
            throw th;
        }
        try {
            socket.close();
        } catch (IOException unused4) {
        }
    }

    private String healthJson() {
        try {
            JSONObject jSONObject = new JSONObject();
            jSONObject.put("usage", hasUsageAccess());
            jSONObject.put("notif", NotifListenerService.isEnabled(this.ctx));
            jSONObject.put("accessibility", isAccessibilityOn());
            JSONObject jSONObject2 = new JSONObject();
            jSONObject2.put("ok", true);
            jSONObject2.put("sources", jSONObject);
            return jSONObject2.toString();
        } catch (Exception unused) {
            return "{\"ok\":true,\"sources\":{}}";
        }
    }

    private String stateJson() {
        try {
            JSONObject jSONObject = new JSONObject();
            jSONObject.put("app", currentAppJson());
            jSONObject.put("screen", screenJson());
            jSONObject.put("power", powerJson());
            return jSONObject.toString();
        } catch (Exception unused) {
            return "{}";
        }
    }

    private JSONObject currentAppJson() {
        JSONObject jSONObject = new JSONObject();
        try {
            String strForegroundPackage = foregroundPackage();
            String strAppLabel = "";
            jSONObject.put("pkg", strForegroundPackage == null ? "" : strForegroundPackage);
            if (strForegroundPackage != null) {
                strAppLabel = appLabel(strForegroundPackage);
            }
            jSONObject.put("label", strAppLabel);
            jSONObject.put("ts", nowIso());
        } catch (Exception unused) {
        }
        return jSONObject;
    }

    private JSONObject screenJson() {
        JSONObject jSONObject = new JSONObject();
        try {
            PowerManager powerManager = (PowerManager) this.ctx.getSystemService("power");
            boolean z = true;
            boolean z2 = powerManager != null && powerManager.isInteractive();
            KeyguardManager keyguardManager = (KeyguardManager) this.ctx.getSystemService("keyguard");
            if (keyguardManager == null || !keyguardManager.isKeyguardLocked()) {
                z = false;
            }
            jSONObject.put("on", z2);
            jSONObject.put("locked", z);
        } catch (Exception unused) {
        }
        return jSONObject;
    }

    private JSONObject powerJson() {
        JSONObject jSONObject = new JSONObject();
        try {
            Intent intentRegisterReceiver = this.ctx.registerReceiver(null, new IntentFilter("android.intent.action.BATTERY_CHANGED"));
            boolean z = false;
            int iRound = -1;
            if (intentRegisterReceiver != null) {
                int intExtra = intentRegisterReceiver.getIntExtra("status", -1);
                z = intExtra == 2 || intExtra == 5;
                int intExtra2 = intentRegisterReceiver.getIntExtra("level", -1);
                int intExtra3 = intentRegisterReceiver.getIntExtra("scale", 100);
                if (intExtra2 >= 0 && intExtra3 > 0) {
                    iRound = Math.round((intExtra2 * 100.0f) / intExtra3);
                }
            }
            jSONObject.put("charging", z);
            jSONObject.put("level", iRound);
        } catch (Exception unused) {
        }
        return jSONObject;
    }

    private String notificationsJson(long j) {
        try {
            JSONObject jSONObject = new JSONObject();
            JSONArray jSONArray = new JSONArray();
            synchronized (this) {
                for (JSONObject jSONObject2 : this.notifs) {
                    if (jSONObject2.optLong("seq", 0L) >= j) {
                        jSONArray.put(jSONObject2);
                    }
                }
                jSONObject.put("cursor", this.notifSeq);
            }
            jSONObject.put("items", jSONArray);
            return jSONObject.toString();
        } catch (Exception unused) {
            return "{\"cursor\":0,\"items\":[]}";
        }
    }

    private boolean hasUsageAccess() {
        try {
            AppOpsManager appOpsManager = (AppOpsManager) this.ctx.getSystemService("appops");
            return appOpsManager != null && appOpsManager.checkOpNoThrow("android:get_usage_stats", Process.myUid(), this.ctx.getPackageName()) == 0;
        } catch (Exception unused) {
            return false;
        }
    }

    private String foregroundPackage() {
        try {
            UsageStatsManager usageStatsManager = (UsageStatsManager) this.ctx.getSystemService("usagestats");
            if (usageStatsManager == null) {
                return null;
            }
            long jCurrentTimeMillis = System.currentTimeMillis();
            List<UsageStats> listQueryUsageStats = usageStatsManager.queryUsageStats(0, jCurrentTimeMillis - 3600000, jCurrentTimeMillis);
            if (listQueryUsageStats == null) {
                return null;
            }
            UsageStats usageStats = null;
            for (UsageStats usageStats2 : listQueryUsageStats) {
                if (usageStats == null || usageStats2.getLastTimeUsed() > usageStats.getLastTimeUsed()) {
                    usageStats = usageStats2;
                }
            }
            if (usageStats != null) {
                return usageStats.getPackageName();
            }
            return null;
        } catch (Exception unused) {
            return null;
        }
    }

    private String appLabel(String str) {
        try {
            PackageManager packageManager = this.ctx.getPackageManager();
            CharSequence applicationLabel = packageManager.getApplicationLabel(packageManager.getApplicationInfo(str, 0));
            return applicationLabel == null ? str : applicationLabel.toString();
        } catch (Exception unused) {
            return str;
        }
    }

    private boolean isAccessibilityOn() {
        try {
            String string = Settings.Secure.getString(this.ctx.getContentResolver(), "enabled_accessibility_services");
            return string != null && string.contains(this.ctx.getPackageName());
        } catch (Exception unused) {
            return false;
        }
    }

    private String nowIso() {
        return new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssXXX", Locale.US).format(new Date());
    }
}
