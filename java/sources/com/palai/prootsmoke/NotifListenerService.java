package com.palai.prootsmoke;

import android.content.Context;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.provider.Settings;
import android.service.notification.NotificationListenerService;
import android.service.notification.StatusBarNotification;

/* JADX INFO: loaded from: /home/runner/work/coopanion-re/coopanion-re/src/x/classes.dex */
public class NotifListenerService extends NotificationListenerService {
    private static volatile boolean connected;

    public static boolean isConnected() {
        return connected;
    }

    public static boolean isEnabled(Context context) {
        try {
            String string = Settings.Secure.getString(context.getContentResolver(), "enabled_notification_listeners");
            return string != null && string.toLowerCase().contains(context.getPackageName().toLowerCase());
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // android.service.notification.NotificationListenerService
    public void onListenerConnected() {
        connected = true;
    }

    @Override // android.service.notification.NotificationListenerService
    public void onListenerDisconnected() {
        connected = false;
    }

    @Override // android.service.notification.NotificationListenerService
    public void onNotificationPosted(StatusBarNotification statusBarNotification) {
        SenseBridge senseBridgePeek;
        CharSequence charSequence;
        if (statusBarNotification == null || statusBarNotification.getNotification() == null) {
            return;
        }
        try {
            String packageName = statusBarNotification.getPackageName();
            Bundle bundle = statusBarNotification.getNotification().extras;
            CharSequence charSequence2 = null;
            CharSequence charSequence3 = bundle == null ? null : bundle.getCharSequence("android.title");
            if (bundle != null) {
                charSequence2 = bundle.getCharSequence("android.text");
            }
            if (charSequence2 == null && bundle != null && (charSequence = bundle.getCharSequence("android.bigText")) != null) {
                charSequence2 = charSequence;
            }
            String string = "";
            String string2 = charSequence3 == null ? "" : charSequence3.toString();
            if (charSequence2 != null) {
                string = charSequence2.toString();
            }
            String str = string;
            if ((string2.isEmpty() && str.isEmpty()) || (senseBridgePeek = SenseBridge.peek()) == null) {
                return;
            }
            senseBridgePeek.addNotification(packageName, appLabel(packageName), string2, str, statusBarNotification.getPostTime());
        } catch (Exception unused) {
        }
    }

    private String appLabel(String str) {
        try {
            PackageManager packageManager = getPackageManager();
            CharSequence applicationLabel = packageManager.getApplicationLabel(packageManager.getApplicationInfo(str, 0));
            return applicationLabel == null ? str : applicationLabel.toString();
        } catch (Exception unused) {
            return str;
        }
    }
}
