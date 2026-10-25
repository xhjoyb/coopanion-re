package com.palai.prootsmoke;

import android.accessibilityservice.AccessibilityService;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Rect;
import android.os.Build;
import android.os.SystemClock;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityNodeInfo;
import android.view.accessibility.AccessibilityWindowInfo;
import android.view.inputmethod.InputMethodInfo;
import android.view.inputmethod.InputMethodManager;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.nio.charset.StandardCharsets;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicReference;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: /home/runner/work/coopanion-re/coopanion-re/src/x/classes2.dex */
public final class EyesService extends AccessibilityService {
    private static final int CAPTURE_ATTEMPTS = 3;
    private static final long CAPTURE_WAIT_MS = 9000;
    private static final long FRAME_CACHE_MS = 700;
    private static final long MAX_STALE_MS = 2500;
    private static final long MIN_CAPTURE_GAP_MS = 1200;
    public static final int PORT = 17898;
    private static volatile ImeListener imeListener;
    private static volatile EyesService instance;
    private static volatile long lastImeNotifyAt;
    private Thread acceptThread;
    private ExecutorService captureExecutor;
    private volatile String foregroundPkg = "";
    private volatile String lastError = "";
    private volatile int lastHeight;
    private volatile byte[] lastJpeg;
    private volatile long lastJpegAt;
    private volatile long lastRequestAt;
    private volatile int lastWidth;
    private volatile boolean running;
    private ServerSocket server;
    private ExecutorService workers;

    public interface ImeListener {
        void onImeHeight(int i);
    }

    public static EyesService peek() {
        return instance;
    }

    public static boolean isRunning() {
        EyesService eyesService = instance;
        return eyesService != null && eyesService.running;
    }

    public static int imeHeight() {
        int iImeHeightOf;
        EyesService eyesService = instance;
        if (eyesService != null && (iImeHeightOf = imeHeightOf(eyesService)) > 0) {
            return iImeHeightOf;
        }
        return 0;
    }

    public static int imeHeightSmart() {
        EyesService eyesService = instance;
        if (eyesService == null) {
            return 0;
        }
        return imeHeightOf(eyesService);
    }

    private static int imeHeightOf(EyesService eyesService) {
        try {
            int i = eyesService.getResources().getDisplayMetrics().heightPixels;
            Set<String> setImePackages = imePackages(eyesService);
            try {
                List<AccessibilityWindowInfo> windows = eyesService.getWindows();
                if (windows == null) {
                    return 0;
                }
                int i2 = 0;
                boolean z = false;
                for (AccessibilityWindowInfo accessibilityWindowInfo : windows) {
                    if (accessibilityWindowInfo != null) {
                        try {
                            int type = accessibilityWindowInfo.getType();
                            String strSafe = "";
                            try {
                                strSafe = safe(accessibilityWindowInfo.getRoot().getPackageName());
                            } catch (Throwable th) {
                            }
                            if (type == 2 || (strSafe != null && strSafe.length() > 0 && setImePackages.contains(strSafe))) {
                                Rect rect = new Rect();
                                accessibilityWindowInfo.getBoundsInScreen(rect);
                                if (rect.width() < 60 || rect.height() < 60) {
                                    accessibilityWindowInfo.recycle();
                                } else if (rect.bottom < i - 200) {
                                    accessibilityWindowInfo.recycle();
                                } else {
                                    try {
                                        int iHeight = rect.height();
                                        if (iHeight >= ((int) (((double) i) * 0.9d))) {
                                            try {
                                                accessibilityWindowInfo.recycle();
                                            } catch (Throwable th2) {
                                            }
                                            z = true;
                                        } else {
                                            if (iHeight > i2) {
                                                i2 = iHeight;
                                            }
                                            try {
                                                accessibilityWindowInfo.recycle();
                                            } catch (Throwable th3) {
                                            }
                                            z = true;
                                        }
                                    } catch (Throwable th4) {
                                        z = true;
                                        accessibilityWindowInfo.recycle();
                                    }
                                }
                            } else {
                                accessibilityWindowInfo.recycle();
                            }
                        } catch (Throwable th5) {
                        }
                    }
                }
                if (i2 > 0) {
                    return i2;
                }
                return z ? -1 : 0;
            } catch (Throwable th6) {
                return 0;
            }
        } catch (Throwable th7) {
            return 0;
        }
    }

    private static Set<String> imePackages(EyesService eyesService) {
        HashSet hashSet = new HashSet();
        try {
            InputMethodManager inputMethodManager = (InputMethodManager) eyesService.getSystemService("input_method");
            if (inputMethodManager != null) {
                for (InputMethodInfo inputMethodInfo : inputMethodManager.getEnabledInputMethodList()) {
                    if (inputMethodInfo != null && inputMethodInfo.getPackageName() != null) {
                        hashSet.add(inputMethodInfo.getPackageName());
                    }
                }
                for (InputMethodInfo inputMethodInfo2 : inputMethodManager.getInputMethodList()) {
                    if (inputMethodInfo2 != null && inputMethodInfo2.getPackageName() != null) {
                        hashSet.add(inputMethodInfo2.getPackageName());
                    }
                }
            }
        } catch (Throwable th) {
        }
        return hashSet;
    }

    public static boolean imeVisible() {
        EyesService eyesService = instance;
        if (eyesService == null) {
            return false;
        }
        try {
            List<AccessibilityWindowInfo> windows = eyesService.getWindows();
            if (windows == null) {
                return false;
            }
            for (AccessibilityWindowInfo accessibilityWindowInfo : windows) {
                if (accessibilityWindowInfo != null) {
                    try {
                        if (accessibilityWindowInfo.getType() != 2) {
                            accessibilityWindowInfo.recycle();
                        } else {
                            Rect rect = new Rect();
                            accessibilityWindowInfo.getBoundsInScreen(rect);
                            if (rect.width() >= 40 && rect.height() >= 60) {
                                try {
                                    accessibilityWindowInfo.recycle();
                                    return true;
                                } catch (Throwable th) {
                                    return true;
                                }
                            }
                            accessibilityWindowInfo.recycle();
                        }
                    } catch (Throwable th2) {
                        try {
                            accessibilityWindowInfo.recycle();
                        } catch (Throwable th3) {
                        }
                        throw th2;
                    }
                }
            }
            return false;
        } catch (Throwable th4) {
        }
    }

    @Override // android.accessibilityservice.AccessibilityService
    protected void onServiceConnected() {
        super.onServiceConnected();
        instance = this;
        startServer();
    }

    @Override // android.accessibilityservice.AccessibilityService
    public void onAccessibilityEvent(AccessibilityEvent accessibilityEvent) {
        if (accessibilityEvent == null) {
            return;
        }
        try {
            CharSequence packageName = accessibilityEvent.getPackageName();
            if (packageName != null && packageName.length() > 0) {
                this.foregroundPkg = packageName.toString();
            }
        } catch (Throwable th) {
        }
        try {
            int eventType = accessibilityEvent.getEventType();
            if (eventType == 4194304 || eventType == 32 || eventType == 2048) {
                notifyIme(imeHeight());
            }
        } catch (Throwable th2) {
        }
    }

    public static void setImeListener(ImeListener imeListener2) {
        imeListener = imeListener2;
        if (imeListener2 != null) {
            try {
                imeListener2.onImeHeight(0);
            } catch (Throwable th) {
            }
        }
    }

    private static void notifyIme(int i) {
        ImeListener imeListener2 = imeListener;
        if (imeListener2 == null) {
            return;
        }
        long jUptimeMillis = SystemClock.uptimeMillis();
        if (jUptimeMillis - lastImeNotifyAt < 60) {
            return;
        }
        lastImeNotifyAt = jUptimeMillis;
        try {
            imeListener2.onImeHeight(i);
        } catch (Throwable th) {
        }
    }

    @Override // android.accessibilityservice.AccessibilityService
    public void onInterrupt() {
    }

    @Override // android.app.Service
    public boolean onUnbind(Intent intent) {
        stopServer();
        instance = null;
        return super.onUnbind(intent);
    }

    @Override // android.app.Service
    public void onDestroy() {
        stopServer();
        instance = null;
        super.onDestroy();
    }

    private synchronized void startServer() {
        if (this.running) {
            return;
        }
        this.running = true;
        this.workers = Executors.newCachedThreadPool();
        this.captureExecutor = Executors.newSingleThreadExecutor();
        Thread thread = new Thread(new Runnable() { // from class: com.palai.prootsmoke.EyesService.1
            @Override // java.lang.Runnable
            public void run() {
                EyesService.this.acceptLoop();
            }
        }, "coop-eyes");
        this.acceptThread = thread;
        thread.setDaemon(true);
        this.acceptThread.start();
    }

    private synchronized void stopServer() {
        this.running = false;
        try {
            ServerSocket serverSocket = this.server;
            if (serverSocket != null) {
                serverSocket.close();
            }
        } catch (IOException e) {
        }
        this.server = null;
        ExecutorService executorService = this.workers;
        if (executorService != null) {
            executorService.shutdownNow();
        }
        ExecutorService executorService2 = this.captureExecutor;
        if (executorService2 != null) {
            executorService2.shutdownNow();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void acceptLoop() {
        try {
            ServerSocket serverSocket = new ServerSocket(PORT, 16, InetAddress.getByName("127.0.0.1"));
            this.server = serverSocket;
            while (this.running) {
                final Socket socketAccept = serverSocket.accept();
                try {
                    socketAccept.setSoTimeout(20000);
                } catch (IOException e) {
                }
                ExecutorService executorService = this.workers;
                if (executorService != null) {
                    executorService.execute(new Runnable() { // from class: com.palai.prootsmoke.EyesService.2
                        @Override // java.lang.Runnable
                        public void run() {
                            EyesService.this.handle(socketAccept);
                        }
                    });
                } else {
                    close(socketAccept);
                }
            }
        } catch (Throwable th) {
            if (this.running) {
                this.lastError = String.valueOf(th);
            }
            this.running = false;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void handle(Socket socket) {
        try {
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(socket.getInputStream(), StandardCharsets.UTF_8));
            String line = bufferedReader.readLine();
            if (line == null) {
                close(socket);
                close(socket);
                return;
            }
            int i = 0;
            do {
                String line2 = bufferedReader.readLine();
                if (line2 == null || line2.length() <= 0) {
                    break;
                } else {
                    i++;
                }
            } while (i <= 64);
            String[] strArrSplit = line.split(" ");
            String str = strArrSplit.length >= 2 ? strArrSplit[1] : "/";
            String strSubstring = "";
            int iIndexOf = str.indexOf(63);
            if (iIndexOf >= 0) {
                String strSubstring2 = str.substring(0, iIndexOf);
                strSubstring = str.substring(iIndexOf + 1);
                str = strSubstring2;
            }
            if (str.startsWith("/health")) {
                sendJson(socket, 200, healthJson());
            } else if (str.startsWith("/screen.jpg") || str.startsWith("/screen")) {
                sendScreen(socket, strSubstring);
            } else if (str.startsWith("/ui")) {
                sendJson(socket, 200, uiJson());
            } else if (str.startsWith("/open_settings")) {
                sendJson(socket, 200, openSettings());
            } else if (str.equals("/") || str.startsWith("/help")) {
                sendJson(socket, 200, helpJson());
            } else {
                sendJson(socket, 404, "{\"ok\":false,\"error\":\"NOT_FOUND\"}");
            }
        } catch (Throwable th) {
            try {
                this.lastError = String.valueOf(th);
            } finally {
                close(socket);
            }
        }
    }

    private void close(Socket socket) {
        try {
            socket.close();
        } catch (IOException e) {
        }
    }

    private void sendJson(Socket socket, int i, String str) {
        try {
            byte[] bytes = str.getBytes(StandardCharsets.UTF_8);
            OutputStream outputStream = socket.getOutputStream();
            outputStream.write(("HTTP/1.1 " + i + (i == 200 ? " OK" : " ERR") + "\r\nContent-Type: application/json; charset=utf-8\r\nContent-Length: " + bytes.length + "\r\nCache-Control: no-store\r\nConnection: close\r\n\r\n").getBytes(StandardCharsets.UTF_8));
            outputStream.write(bytes);
            outputStream.flush();
        } catch (Throwable th) {
        }
    }

    private void sendScreen(Socket socket, String str) {
        byte[] bArrJpeg;
        int iIntParam = intParam(str, "max", 720);
        int iIntParam2 = intParam(str, "q", 62);
        if (iIntParam < 120) {
            iIntParam = 120;
        }
        if (iIntParam > 2160) {
            iIntParam = 2160;
        }
        if (iIntParam2 < 20) {
            iIntParam2 = 20;
        }
        if (iIntParam2 > 95) {
            iIntParam2 = 95;
        }
        try {
            bArrJpeg = jpeg(iIntParam, iIntParam2);
        } catch (Throwable th) {
            this.lastError = String.valueOf(th);
            bArrJpeg = null;
        }
        if (bArrJpeg == null || bArrJpeg.length == 0) {
            sendJson(socket, 503, "{\"ok\":false,\"error\":\"" + escape(this.lastError.length() == 0 ? "NO_FRAME" : this.lastError) + "\",\"sdk\":" + Build.VERSION.SDK_INT + "}");
            return;
        }
        try {
            OutputStream outputStream = socket.getOutputStream();
            outputStream.write(("HTTP/1.1 200 OK\r\nContent-Type: image/jpeg\r\nContent-Length: " + bArrJpeg.length + "\r\nX-Width: " + this.lastWidth + "\r\nX-Height: " + this.lastHeight + "\r\nX-Pkg: " + escape(this.foregroundPkg) + "\r\nX-Age-Ms: " + Math.max(0L, System.currentTimeMillis() - this.lastJpegAt) + "\r\nCache-Control: no-store\r\nConnection: close\r\n\r\n").getBytes(StandardCharsets.UTF_8));
            outputStream.write(bArrJpeg);
            outputStream.flush();
        } catch (Throwable th2) {
        }
    }

    private static int intParam(String str, String str2, int i) {
        if (str == null || str.length() == 0) {
            return i;
        }
        for (String str3 : str.split("&")) {
            String[] strArrSplit = str3.split("=");
            if (strArrSplit.length == 2 && strArrSplit[0].equals(str2)) {
                try {
                    return Integer.parseInt(strArrSplit[1].trim());
                } catch (Throwable th) {
                    return i;
                }
            }
        }
        return i;
    }

    private static String escape(String str) {
        if (str == null) {
            return "";
        }
        StringBuilder sb = new StringBuilder(str.length() + 8);
        for (int i = 0; i < str.length(); i++) {
            char cCharAt = str.charAt(i);
            if (cCharAt == '\"' || cCharAt == '\\') {
                sb.append('\\').append(cCharAt);
            } else if (cCharAt == '\n') {
                sb.append("\\n");
            } else if (cCharAt == '\r') {
                sb.append("\\r");
            } else if (cCharAt == '\t') {
                sb.append("\\t");
            } else if (cCharAt < ' ') {
                sb.append(' ');
            } else {
                sb.append(cCharAt);
            }
        }
        return sb.toString();
    }

    private String healthJson() {
        JSONObject jSONObject = new JSONObject();
        try {
            boolean z = true;
            jSONObject.put("ok", true);
            jSONObject.put("service", "coopanion-eyes");
            jSONObject.put("sdk", Build.VERSION.SDK_INT);
            if (Build.VERSION.SDK_INT < 30) {
                z = false;
            }
            jSONObject.put("canScreenshot", z);
            jSONObject.put("pkg", this.foregroundPkg == null ? "" : this.foregroundPkg);
            jSONObject.put("frameWidth", this.lastWidth);
            jSONObject.put("frameHeight", this.lastHeight);
            jSONObject.put("frameAgeMs", this.lastJpeg == null ? -1L : System.currentTimeMillis() - this.lastJpegAt);
            jSONObject.put("frameBytes", this.lastJpeg != null ? this.lastJpeg.length : 0);
            jSONObject.put("error", this.lastError);
            return jSONObject.toString();
        } catch (Throwable th) {
            return "{\"ok\":true,\"service\":\"coopanion-eyes\"}";
        }
    }

    private String helpJson() {
        return "{\"ok\":true,\"service\":\"coopanion-eyes\",\"routes\":[\"/health\",\"/screen.jpg?max=720&q=62\",\"/ui\",\"/open_settings\"]}";
    }

    private String openSettings() {
        JSONObject jSONObject = new JSONObject();
        try {
            Intent intent = new Intent("android.settings.ACCESSIBILITY_SETTINGS");
            intent.addFlags(268435456);
            startActivity(intent);
            jSONObject.put("ok", true);
            jSONObject.put("opened", "accessibility");
        } catch (Throwable th) {
            try {
                jSONObject.put("ok", false);
                jSONObject.put("error", String.valueOf(th));
            } catch (Throwable th2) {
            }
        }
        return jSONObject.toString();
    }

    /* JADX WARN: Code duplicated, block: B:38:0x0067  */
    private synchronized byte[] jpeg(int i, int i2) {
        byte[] bArrCaptureOnce;
        long jCurrentTimeMillis = System.currentTimeMillis();
        if (this.lastJpeg != null && jCurrentTimeMillis - this.lastJpegAt < FRAME_CACHE_MS) {
            return this.lastJpeg;
        }
        if (Build.VERSION.SDK_INT < 30) {
            this.lastError = "需要 Android 11 及以上才能后台截屏";
            return null;
        }
        String str = null;
        for (int i3 = 0; i3 < CAPTURE_ATTEMPTS; i3++) {
            long jCurrentTimeMillis2 = System.currentTimeMillis() - this.lastRequestAt;
            if (jCurrentTimeMillis2 < MIN_CAPTURE_GAP_MS) {
                try {
                    Thread.sleep(MIN_CAPTURE_GAP_MS - jCurrentTimeMillis2);
                    this.lastRequestAt = System.currentTimeMillis();
                    bArrCaptureOnce = captureOnce(i, i2);
                    if (bArrCaptureOnce == null && bArrCaptureOnce.length > 0) {
                        this.lastJpeg = bArrCaptureOnce;
                        this.lastJpegAt = System.currentTimeMillis();
                        this.lastError = "";
                        return bArrCaptureOnce;
                    }
                    str = this.lastError;
                    try {
                        Thread.sleep(FRAME_CACHE_MS);
                    } catch (InterruptedException e) {
                    }
                } catch (InterruptedException e2) {
                }
            } else {
                this.lastRequestAt = System.currentTimeMillis();
                bArrCaptureOnce = captureOnce(i, i2);
                if (bArrCaptureOnce == null) {
                }
                str = this.lastError;
                Thread.sleep(FRAME_CACHE_MS);
            }
            if (str == null) {
                str = "截屏失败";
            }
            this.lastError = str;
            if (this.lastJpeg != null || System.currentTimeMillis() - this.lastJpegAt > MAX_STALE_MS) {
                return null;
            }
            return this.lastJpeg;
        }
        if (str == null) {
            str = "截屏失败";
        }
        this.lastError = str;
        if (this.lastJpeg != null) {
        }
        return null;
    }

    private byte[] captureOnce(int i, int i2) {
        AtomicReference atomicReference = new AtomicReference();
        AtomicReference atomicReference2 = new AtomicReference();
        CountDownLatch countDownLatch = new CountDownLatch(1);
        try {
            Api30.capture(this, this.captureExecutor, i, i2, atomicReference, atomicReference2, countDownLatch);
            try {
                countDownLatch.await(CAPTURE_WAIT_MS, TimeUnit.MILLISECONDS);
                byte[] bArr = (byte[]) atomicReference.get();
                if (bArr != null && bArr.length > 0) {
                    return bArr;
                }
                this.lastError = atomicReference2.get() != null ? (String) atomicReference2.get() : "截屏超时";
                return null;
            } catch (InterruptedException e) {
                return null;
            }
        } catch (Throwable th) {
            this.lastError = String.valueOf(th);
            return null;
        }
    }

    private static final class Api30 {
        private Api30() {
        }

        static void capture(AccessibilityService accessibilityService, ExecutorService executorService, final int i, final int i2, final AtomicReference<byte[]> atomicReference, final AtomicReference<String> atomicReference2, final CountDownLatch countDownLatch) {
            accessibilityService.takeScreenshot(0, executorService, new AccessibilityService.TakeScreenshotCallback() { // from class: com.palai.prootsmoke.EyesService.Api30.1
                @Override // android.accessibilityservice.AccessibilityService.TakeScreenshotCallback
                public void onSuccess(AccessibilityService.ScreenshotResult screenshotResult) {
                    try {
                        atomicReference.set(Api30.encode(screenshotResult, i, i2));
                        try {
                            screenshotResult.getHardwareBuffer().close();
                        } catch (Throwable th) {
                        }
                    } catch (Throwable th2) {
                        try {
                            atomicReference2.set(String.valueOf(th2));
                        } finally {
                            try {
                                screenshotResult.getHardwareBuffer().close();
                            } catch (Throwable th3) {
                            }
                            countDownLatch.countDown();
                        }
                    }
                }

                @Override // android.accessibilityservice.AccessibilityService.TakeScreenshotCallback
                public void onFailure(int i3) {
                    atomicReference2.set("截屏失败(code=" + i3 + ")");
                    countDownLatch.countDown();
                }
            });
        }

        /* JADX INFO: Access modifiers changed from: private */
        public static byte[] encode(AccessibilityService.ScreenshotResult screenshotResult, int i, int i2) {
            Bitmap bitmapCreateScaledBitmap;
            Bitmap bitmapWrapHardwareBuffer = Bitmap.wrapHardwareBuffer(screenshotResult.getHardwareBuffer(), screenshotResult.getColorSpace());
            if (bitmapWrapHardwareBuffer == null) {
                throw new IllegalStateException("拿不到画面");
            }
            try {
                Bitmap bitmapCopy = bitmapWrapHardwareBuffer.copy(Bitmap.Config.ARGB_8888, false);
                bitmapWrapHardwareBuffer.recycle();
                if (bitmapCopy == null) {
                    throw new IllegalStateException("画面转换失败");
                }
                int width = bitmapCopy.getWidth();
                int height = bitmapCopy.getHeight();
                if (width <= i) {
                    bitmapCreateScaledBitmap = bitmapCopy;
                } else {
                    bitmapCreateScaledBitmap = Bitmap.createScaledBitmap(bitmapCopy, i, Math.max(1, Math.round(height * (i / width))), true);
                }
                EyesService eyesService = EyesService.instance;
                if (eyesService != null) {
                    eyesService.lastWidth = bitmapCreateScaledBitmap.getWidth();
                    eyesService.lastHeight = bitmapCreateScaledBitmap.getHeight();
                }
                ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream(262144);
                bitmapCreateScaledBitmap.compress(Bitmap.CompressFormat.JPEG, i2, byteArrayOutputStream);
                if (bitmapCreateScaledBitmap != bitmapCopy) {
                    bitmapCreateScaledBitmap.recycle();
                }
                bitmapCopy.recycle();
                return byteArrayOutputStream.toByteArray();
            } catch (Throwable th) {
                bitmapWrapHardwareBuffer.recycle();
                throw th;
            }
        }
    }

    private String uiJson() {
        JSONObject jSONObject = new JSONObject();
        try {
            jSONObject.put("ok", true);
            jSONObject.put("pkg", this.foregroundPkg == null ? "" : this.foregroundPkg);
            jSONObject.put("screenOn", true);
            AccessibilityNodeInfo rootInActiveWindow = getRootInActiveWindow();
            JSONArray jSONArray = new JSONArray();
            if (rootInActiveWindow != null) {
                try {
                    collect(rootInActiveWindow, jSONArray, 0);
                    String strSafe = safe(rootInActiveWindow.getPackageName());
                    if (strSafe.length() > 0) {
                        jSONObject.put("pkg", strSafe);
                    }
                    try {
                        rootInActiveWindow.recycle();
                    } catch (Throwable th) {
                    }
                } catch (Throwable th2) {
                    try {
                        rootInActiveWindow.recycle();
                    } catch (Throwable th3) {
                    }
                    throw th2;
                }
            }
            jSONObject.put("count", jSONArray.length());
            jSONObject.put("items", jSONArray);
        } catch (Throwable th4) {
            try {
                jSONObject.put("ok", false);
                jSONObject.put("error", String.valueOf(th4));
            } catch (Throwable th5) {
            }
        }
        return jSONObject.toString();
    }

    /* JADX WARN: Bottom block not found for handler: all -> 0x00da */
    /* JADX WARN: Code restructure failed: missing block: B:45:0x00db, code lost:
    
        return;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private static void collect(android.view.accessibility.AccessibilityNodeInfo r7, org.json.JSONArray r8, int r9) {
        /*
            Method dump skipped, instruction units count: 221
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.palai.prootsmoke.EyesService.collect(android.view.accessibility.AccessibilityNodeInfo, org.json.JSONArray, int):void");
    }

    private static String trim(String str, int i) {
        if (str == null) {
            return "";
        }
        String strTrim = str.replace('\n', ' ').replace('\r', ' ').trim();
        return strTrim.length() <= i ? strTrim : strTrim.substring(0, i) + "…";
    }

    private static String safe(CharSequence charSequence) {
        return charSequence == null ? "" : charSequence.toString();
    }
}
