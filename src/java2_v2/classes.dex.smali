.class public final Lcom/palai/prootsmoke/AppLog;
.super Ljava/lang/Object;

.field private static final FMT:Ljava/text/SimpleDateFormat;
.field private static volatile LOG_FILE:Ljava/io/File;
.field public static final TAG:Ljava/lang/String;

# direct access=0x10008
.method static constructor Lcom/palai/prootsmoke/AppLog;-><clinit>()V
    # registers=3 ins=0 tries=0
    new-instance v0, Ljava/text/SimpleDateFormat;
    const-string v1, "HH:mm:ss.SSS"
    sget-object v2, Ljava/util/Locale;->US:Ljava/util/Locale;
    invoke-direct {v0, v1, v2}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V
    sput-object v0, Lcom/palai/prootsmoke/AppLog;->FMT:Ljava/text/SimpleDateFormat;
    return-void 
.end method

# direct access=0x10002
.method private constructor Lcom/palai/prootsmoke/AppLog;-><init>()V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# direct access=0x9
.method public static Lcom/palai/prootsmoke/AppLog;->e(Ljava/lang/String;)V
    # registers=2 ins=1 tries=1
    const-string v0, "PetWindow"
    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    const-string v0, "E"
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/AppLog;->write(Ljava/lang/String;Ljava/lang/String;)V
    return-void 
.end method

# direct access=0x9
.method public static Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    # registers=2 ins=1 tries=1
    const-string v0, "PetWindow"
    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    const-string v0, "I"
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/AppLog;->write(Ljava/lang/String;Ljava/lang/String;)V
    return-void 
.end method

# direct access=0x9
.method public static Lcom/palai/prootsmoke/AppLog;->init(Landroid/content/Context;)V
    # registers=3 ins=1 tries=1
    const/4 v0, #0
    invoke-virtual {v2, v0}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;
    move-result-object v0
    if-nez v0, :L11
    invoke-virtual {v2}, Landroid/content/Context;->getFilesDir()Ljava/io/File;
    move-result-object v0
    :L11
    new-instance v2, Ljava/io/File;
    const-string v1, "coop-run.log"
    invoke-direct {v2, v0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V
    sput-object v2, Lcom/palai/prootsmoke/AppLog;->LOG_FILE:Ljava/io/File;
    return-void 
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/AppLog;->write(Ljava/lang/String;Ljava/lang/String;)V
    # registers=7 ins=2 tries=1
    const-string v0, "/PetWindow: "
    const-string v1, "["
    sget-object v2, Lcom/palai/prootsmoke/AppLog;->LOG_FILE:Ljava/io/File;
    if-nez v2, :L9
    return-void 
    :L9
    new-instance v3, Ljava/lang/StringBuilder;
    invoke-direct {v3, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    sget-object v1, Lcom/palai/prootsmoke/AppLog;->FMT:Ljava/text/SimpleDateFormat;
    new-instance v4, Ljava/util/Date;
    invoke-direct {v4}, Ljava/util/Date;-><init>()V
    invoke-virtual {v1, v4}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    const-string v3, "] "
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
    const-string v6, "
"
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v5
    new-instance v6, Ljava/io/FileOutputStream;
    const/4 v0, #1
    invoke-direct {v6, v2, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;Z)V
    const-string v0, "UTF-8"
    invoke-virtual {v5, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B
    move-result-object v5
    invoke-virtual {v6, v5}, Ljava/io/FileOutputStream;->write([B)V
    invoke-virtual {v6}, Ljava/io/FileOutputStream;->flush()V
    invoke-virtual {v6}, Ljava/io/FileOutputStream;->close()V
    return-void 
.end method

.class Lcom/palai/prootsmoke/CrashApp$1;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/CrashApp;
.field final synthetic val$prev:Ljava/lang/Thread$UncaughtExceptionHandler;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/CrashApp$1;-><init>(Lcom/palai/prootsmoke/CrashApp;Ljava/lang/Thread$UncaughtExceptionHandler;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/CrashApp$1;->this$0:Lcom/palai/prootsmoke/CrashApp;
    iput-object v2, v0, Lcom/palai/prootsmoke/CrashApp$1;->val$prev:Ljava/lang/Thread$UncaughtExceptionHandler;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/CrashApp$1;->uncaughtException(Ljava/lang/Thread;Ljava/lang/Throwable;)V
    # registers=4 ins=3 tries=1
    iget-object v0, v1, Lcom/palai/prootsmoke/CrashApp$1;->this$0:Lcom/palai/prootsmoke/CrashApp;
    invoke-static {v0, v2, v3}, Lcom/palai/prootsmoke/CrashApp;->-$$Nest$mdump(Lcom/palai/prootsmoke/CrashApp;Ljava/lang/Thread;Ljava/lang/Throwable;)V
    iget-object v0, v1, Lcom/palai/prootsmoke/CrashApp$1;->val$prev:Ljava/lang/Thread$UncaughtExceptionHandler;
    if-eqz v0, :L12
    invoke-interface {v0, v2, v3}, Ljava/lang/Thread$UncaughtExceptionHandler;->uncaughtException(Ljava/lang/Thread;Ljava/lang/Throwable;)V
    :L12
    return-void 
.end method

.class public Lcom/palai/prootsmoke/CrashApp;
.super Landroid/app/Application;

.field private static final TAG:Ljava/lang/String;

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/CrashApp;->-$$Nest$mdump(Lcom/palai/prootsmoke/CrashApp;Ljava/lang/Thread;Ljava/lang/Throwable;)V
    # registers=3 ins=3 tries=0
    invoke-direct {v0, v1, v2}, Lcom/palai/prootsmoke/CrashApp;->dump(Ljava/lang/Thread;Ljava/lang/Throwable;)V
    return-void 
.end method

# direct access=0x10001
.method public constructor Lcom/palai/prootsmoke/CrashApp;-><init>()V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Landroid/app/Application;-><init>()V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/CrashApp;->dump(Ljava/lang/Thread;Ljava/lang/Throwable;)V
    # registers=9 ins=3 tries=1
    new-instance v0, Ljava/io/StringWriter;
    invoke-direct {v0}, Ljava/io/StringWriter;-><init>()V
    new-instance v1, Ljava/io/PrintWriter;
    invoke-direct {v1, v0}, Ljava/io/PrintWriter;-><init>(Ljava/io/Writer;)V
    new-instance v2, Ljava/lang/StringBuilder;
    const-string v3, "time="
    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    new-instance v3, Ljava/text/SimpleDateFormat;
    const-string v4, "yyyy-MM-dd HH:mm:ss"
    sget-object v5, Ljava/util/Locale;->US:Ljava/util/Locale;
    invoke-direct {v3, v4, v5}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V
    new-instance v4, Ljava/util/Date;
    invoke-direct {v4}, Ljava/util/Date;-><init>()V
    invoke-virtual {v3, v4}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v1, v2}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V
    new-instance v2, Ljava/lang/StringBuilder;
    const-string v3, "thread="
    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v7}, Ljava/lang/Thread;->getName()Ljava/lang/String;
    move-result-object v7
    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v7
    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v7
    invoke-virtual {v1, v7}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V
    new-instance v7, Ljava/lang/StringBuilder;
    const-string v2, "android="
    invoke-direct {v7, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I
    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v7
    const-string v2, " device="
    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v7
    sget-object v2, Landroid/os/Build;->MODEL:Ljava/lang/String;
    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v7
    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v7
    invoke-virtual {v1, v7}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V
    const-string v7, "---- stack ----"
    invoke-virtual {v1, v7}, Ljava/io/PrintWriter;->println(Ljava/lang/String;)V
    invoke-virtual {v8, v1}, Ljava/lang/Throwable;->printStackTrace(Ljava/io/PrintWriter;)V
    invoke-virtual {v1}, Ljava/io/PrintWriter;->flush()V
    invoke-virtual {v0}, Ljava/io/StringWriter;->toString()Ljava/lang/String;
    move-result-object v7
    const-string v8, "CoopCrash"
    invoke-static {v8, v7}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    const/4 v8, #3
    new-array v0, v8, [Ljava/lang/String;
    const-string v1, "/sdcard/Download/coop-crash.txt"
    const/4 v2, #0
    aput-object v1, v0, v2
    const-string v1, "/storage/emulated/0/Download/coop-crash.txt"
    const/4 v3, #1
    aput-object v1, v0, v3
    const/4 v1, #2
    const-string v4, "/storage/emulated/10/Download/coop-crash.txt"
    aput-object v4, v0, v1
    :L138
    if-ge v2, v8, :L189
    aget-object v1, v0, v2
    new-instance v4, Ljava/io/File;
    invoke-direct {v4, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V
    new-instance v1, Ljava/io/FileOutputStream;
    invoke-direct {v1, v4, v3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;Z)V
    new-instance v4, Ljava/lang/StringBuilder;
    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V
    const-string v5, "
========== CRASH ==========
"
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v4
    invoke-virtual {v4, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v4
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    const-string v5, "UTF-8"
    invoke-virtual {v4, v5}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B
    move-result-object v4
    invoke-virtual {v1, v4}, Ljava/io/FileOutputStream;->write([B)V
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->flush()V
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    add-int/lit8 v2, v2, #1
    goto :L138
    :L189
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/CrashApp;->onCreate()V
    # registers=3 ins=1 tries=1
    invoke-super {v2}, Landroid/app/Application;->onCreate()V
    invoke-static {}, Ljava/lang/Thread;->getDefaultUncaughtExceptionHandler()Ljava/lang/Thread$UncaughtExceptionHandler;
    move-result-object v0
    new-instance v1, Lcom/palai/prootsmoke/CrashApp$1;
    invoke-direct {v1, v2, v0}, Lcom/palai/prootsmoke/CrashApp$1;-><init>(Lcom/palai/prootsmoke/CrashApp;Ljava/lang/Thread$UncaughtExceptionHandler;)V
    invoke-static {v1}, Ljava/lang/Thread;->setDefaultUncaughtExceptionHandler(Ljava/lang/Thread$UncaughtExceptionHandler;)V
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$10;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$10;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$10;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$10;->onClick(Landroid/view/View;)V
    # registers=5 ins=2 tries=0
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$10;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetlogScroll(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/ScrollView;
    move-result-object v0
    if-nez v0, :L9
    return-void 
    :L9
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$10;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetlogScroll(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/ScrollView;
    move-result-object v0
    invoke-virtual {v0}, Landroid/widget/ScrollView;->getVisibility()I
    move-result v0
    const/4 v1, #0
    if-eqz v0, :L24
    const/4 v0, #1
    goto :L25
    :L24
    move v0, v1
    :L25
    iget-object v2, v3, Lcom/palai/prootsmoke/MainActivity$10;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetlogScroll(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/ScrollView;
    move-result-object v2
    if-eqz v0, :L34
    goto :L36
    :L34
    const/16 v1, #8
    :L36
    invoke-virtual {v2, v1}, Landroid/widget/ScrollView;->setVisibility(I)V
    check-cast v4, Landroid/widget/Button;
    if-eqz v0, :L46
    const-string v0, "收起日志"
    goto :L48
    :L46
    const-string v0, "日志"
    :L48
    invoke-virtual {v4, v0}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$11;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$11;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$11;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$11;->onClick(Landroid/view/View;)V
    # registers=5 ins=2 tries=1
    iget-object v4, v3, Lcom/palai/prootsmoke/MainActivity$11;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v0, Landroid/content/Intent;
    iget-object v1, v3, Lcom/palai/prootsmoke/MainActivity$11;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-class v2, Lcom/palai/prootsmoke/RepairActivity;
    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    invoke-virtual {v4, v0}, Lcom/palai/prootsmoke/MainActivity;->startActivity(Landroid/content/Intent;)V
    iget-object v4, v3, Lcom/palai/prootsmoke/MainActivity$11;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v0, "[REPAIR] 打开修复助手 (RepairActivity)"
    invoke-static {v4, v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    goto :L43
    move-exception v4
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$11;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "[REPAIR] 打开失败: "
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v4
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-static {v0, v4}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    :L43
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$12;
.super Landroid/webkit/WebViewClient;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$12;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$12;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Landroid/webkit/WebViewClient;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$12;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    # registers=6 ins=3 tries=0
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$12;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "[WEB] onPageFinished: "
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
    const-string v1, " title="
    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
    invoke-virtual {v4}, Landroid/webkit/WebView;->getTitle()Ljava/lang/String;
    move-result-object v4
    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v4
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-static {v0, v4}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$12;->onReceivedError(Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V
    # registers=7 ins=5 tries=0
    iget-object v3, v2, Lcom/palai/prootsmoke/MainActivity$12;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[WEB-ERR] "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v4
    const-string v0, " "
    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v4
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v4
    const-string v5, " @ "
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v4
    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v4
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-static {v3, v4}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$13$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/MainActivity$13;
.field final synthetic val$request:Landroid/webkit/PermissionRequest;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$13$1;-><init>(Lcom/palai/prootsmoke/MainActivity$13;Landroid/webkit/PermissionRequest;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$13$1;->this$1:Lcom/palai/prootsmoke/MainActivity$13;
    iput-object v2, v0, Lcom/palai/prootsmoke/MainActivity$13$1;->val$request:Landroid/webkit/PermissionRequest;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$13$1;->run()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$13$1;->val$request:Landroid/webkit/PermissionRequest;
    invoke-virtual {v0}, Landroid/webkit/PermissionRequest;->getResources()[Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/webkit/PermissionRequest;->grant([Ljava/lang/String;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$13$2;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/MainActivity$13;
.field final synthetic val$request:Landroid/webkit/PermissionRequest;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$13$2;-><init>(Lcom/palai/prootsmoke/MainActivity$13;Landroid/webkit/PermissionRequest;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$13$2;->this$1:Lcom/palai/prootsmoke/MainActivity$13;
    iput-object v2, v0, Lcom/palai/prootsmoke/MainActivity$13$2;->val$request:Landroid/webkit/PermissionRequest;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$13$2;->run()V
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/MainActivity$13$2;->val$request:Landroid/webkit/PermissionRequest;
    invoke-virtual {v0}, Landroid/webkit/PermissionRequest;->deny()V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$13;
.super Landroid/webkit/WebChromeClient;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$13;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$13;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Landroid/webkit/WebChromeClient;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$13;->onPermissionRequest(Landroid/webkit/PermissionRequest;)V
    # registers=8 ins=2 tries=0
    invoke-virtual {v7}, Landroid/webkit/PermissionRequest;->getResources()[Ljava/lang/String;
    move-result-object v0
    array-length v1, v0
    const/4 v2, #0
    move v3, v2
    :L7
    if-ge v2, v1, :L23
    aget-object v4, v0, v2
    const-string v5, "android.webkit.resource.AUDIO_CAPTURE"
    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v4
    if-eqz v4, :L20
    const/4 v3, #1
    :L20
    add-int/lit8 v2, v2, #1
    goto :L7
    :L23
    if-eqz v3, :L43
    iget-object v0, v6, Lcom/palai/prootsmoke/MainActivity$13;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v1, "[MIC] WebView 请求麦克风 -> 已放行"
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    iget-object v0, v6, Lcom/palai/prootsmoke/MainActivity$13;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v1, Lcom/palai/prootsmoke/MainActivity$13$1;
    invoke-direct {v1, v6, v7}, Lcom/palai/prootsmoke/MainActivity$13$1;-><init>(Lcom/palai/prootsmoke/MainActivity$13;Landroid/webkit/PermissionRequest;)V
    invoke-virtual {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    goto :L53
    :L43
    iget-object v0, v6, Lcom/palai/prootsmoke/MainActivity$13;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v1, Lcom/palai/prootsmoke/MainActivity$13$2;
    invoke-direct {v1, v6, v7}, Lcom/palai/prootsmoke/MainActivity$13$2;-><init>(Lcom/palai/prootsmoke/MainActivity$13;Landroid/webkit/PermissionRequest;)V
    invoke-virtual {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    :L53
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$14;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$14;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$14;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$14;->run()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$14;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const/4 v1, #0
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mshowGuide(Lcom/palai/prootsmoke/MainActivity;I)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$15;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$15;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$15;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$15;->run()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$15;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mcanDrawOverlays(Lcom/palai/prootsmoke/MainActivity;)Z
    move-result v0
    if-eqz v0, :L31
    invoke-static {}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$sfgetpetWinOn()Ljava/util/concurrent/atomic/AtomicBoolean;
    move-result-object v0
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z
    move-result v0
    if-nez v0, :L31
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$15;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v1, "[PET] 上次桌宠开着，自动恢复悬浮窗（v10.3：先等 7797 就绪）"
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$15;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mstartPetWindowWhenReady(Lcom/palai/prootsmoke/MainActivity;)V
    goto :L46
    :L31
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$15;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mcanDrawOverlays(Lcom/palai/prootsmoke/MainActivity;)Z
    move-result v0
    if-nez v0, :L46
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$15;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v1, "[PET] 上次桌宠开着，但悬浮窗权限没了"
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    :L46
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$16;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$16;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$16;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$16;->run()V
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/MainActivity$16;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mboot(Lcom/palai/prootsmoke/MainActivity;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$17$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/MainActivity$17;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$17$1;-><init>(Lcom/palai/prootsmoke/MainActivity$17;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$17$1;->this$1:Lcom/palai/prootsmoke/MainActivity$17;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$17$1;->run()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$17$1;->this$1:Lcom/palai/prootsmoke/MainActivity$17;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$17;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v1, "[3] Web UI load (once) -> http://127.0.0.1:17788/"
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$17$1;->this$1:Lcom/palai/prootsmoke/MainActivity$17;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$17;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v0
    const-string v1, "http://127.0.0.1:17788/"
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$17;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$17;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$17;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$17;->run()V
    # registers=4 ins=1 tries=0
    const/16 v0, #17788
    const v1, #60000
    const-string v2, "127.0.0.1"
    invoke-static {v2, v0, v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$smwaitPortOpen(Ljava/lang/String;II)Z
    move-result v0
    if-nez v0, :L21
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$17;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v1, "[3] Web UI 端口超时未就绪"
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    return-void 
    :L21
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$17;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v1, Lcom/palai/prootsmoke/MainActivity$17$1;
    invoke-direct {v1, v3}, Lcom/palai/prootsmoke/MainActivity$17$1;-><init>(Lcom/palai/prootsmoke/MainActivity$17;)V
    invoke-virtual {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$18;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$18;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$18;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$18;->run()V
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/MainActivity$18;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mboot(Lcom/palai/prootsmoke/MainActivity;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$19;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;
.field final synthetic val$attempt:I

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$19;-><init>(Lcom/palai/prootsmoke/MainActivity;I)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$19;->this$0:Lcom/palai/prootsmoke/MainActivity;
    iput v2, v0, Lcom/palai/prootsmoke/MainActivity$19;->val$attempt:I
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$19;->run()V
    # registers=8 ins=1 tries=0
    iget-object v0, v7, Lcom/palai/prootsmoke/MainActivity$19;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v0
    if-nez v0, :L9
    return-void 
    :L9
    iget-object v0, v7, Lcom/palai/prootsmoke/MainActivity$19;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v1
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v2, "<html><body style='background:#0b0f14;color:#8aa;font-family:sans-serif;display:flex;align-items:center;justify-content:center;height:100%'><div style='text-align:center'>&#27491;&#22312;&#36830;&#25509;&#26700;&#23456;&#26381;&#21153;<br><small style='color:#567'>&#31532; "
    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget v2, v7, Lcom/palai/prootsmoke/MainActivity$19;->val$attempt:I
    add-int/lit8 v2, v2, #1
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v2, " / 20 &#27425;&#23581;&#35797;&#65292;&#35831;&#31245;&#31561;&#8230;</small></div></body></html>"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    const-string v5, "UTF-8"
    const/4 v6, #0
    const/4 v2, #0
    const-string v4, "text/html"
    invoke-virtual/range {v1..v6}, Landroid/webkit/WebView;->loadDataWithBaseURL(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    iget-object v0, v7, Lcom/palai/prootsmoke/MainActivity$19;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v0
    const-string v1, "http://127.0.0.1:7797/pet?host=app"
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$1;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;
.field final synthetic val$s:Ljava/lang/String;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$1;-><init>(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$1;->this$0:Lcom/palai/prootsmoke/MainActivity;
    iput-object v2, v0, Lcom/palai/prootsmoke/MainActivity$1;->val$s:Ljava/lang/String;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$1;->run()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$1;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetstatusTv(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/TextView;
    move-result-object v0
    if-eqz v0, :L19
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$1;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetstatusTv(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/TextView;
    move-result-object v0
    iget-object v1, v2, Lcom/palai/prootsmoke/MainActivity$1;->val$s:Ljava/lang/String;
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :L19
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$2$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/MainActivity$2;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$2$1;-><init>(Lcom/palai/prootsmoke/MainActivity$2;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$2$1;->this$1:Lcom/palai/prootsmoke/MainActivity$2;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$2$1;->run()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$2$1;->this$1:Lcom/palai/prootsmoke/MainActivity$2;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$2;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetlogScroll(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/ScrollView;
    move-result-object v0
    const/16 v1, #130
    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->fullScroll(I)Z
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$20$1$1;
.super Ljava/lang/Object;

.field final synthetic this$2:Lcom/palai/prootsmoke/MainActivity$20$1;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$20$1$1;-><init>(Lcom/palai/prootsmoke/MainActivity$20$1;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$20$1$1;->this$2:Lcom/palai/prootsmoke/MainActivity$20$1;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$20$1$1;->run()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$20$1$1;->this$2:Lcom/palai/prootsmoke/MainActivity$20$1;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$20;->this$0:Lcom/palai/prootsmoke/MainActivity;
    iget-object v1, v2, Lcom/palai/prootsmoke/MainActivity$20$1$1;->this$2:Lcom/palai/prootsmoke/MainActivity$20$1;
    iget-object v1, v1, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget v1, v1, Lcom/palai/prootsmoke/MainActivity$20;->val$attempt:I
    add-int/lit8 v1, v1, #1
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mloadPetWithRetry(Lcom/palai/prootsmoke/MainActivity;I)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$20$1$2;
.super Ljava/lang/Object;

.field final synthetic this$2:Lcom/palai/prootsmoke/MainActivity$20$1;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$20$1$2;-><init>(Lcom/palai/prootsmoke/MainActivity$20$1;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$20$1$2;->this$2:Lcom/palai/prootsmoke/MainActivity$20$1;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$20$1$2;->run()V
    # registers=8 ins=1 tries=0
    iget-object v0, v7, Lcom/palai/prootsmoke/MainActivity$20$1$2;->this$2:Lcom/palai/prootsmoke/MainActivity$20$1;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$20;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v0
    if-nez v0, :L13
    return-void 
    :L13
    iget-object v0, v7, Lcom/palai/prootsmoke/MainActivity$20$1$2;->this$2:Lcom/palai/prootsmoke/MainActivity$20$1;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$20;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v1
    const-string v5, "UTF-8"
    const/4 v6, #0
    const/4 v2, #0
    const-string v3, "<html><body style='background:#0b0f14;color:#c88;font-family:sans-serif;display:flex;align-items:center;justify-content:center;height:100%'><div style='text-align:center'>&#26700;&#23456;&#26381;&#21153;&#36830;&#25509;&#22833;&#36133;<br><small style='color:#567'>&#35831;&#30830;&#35748;&#20869;&#26680;&#24050;&#21551;&#21160;&#65292;&#28982;&#21518;&#28857;&#39;&#37325;&#35797;&#21551;&#21160;&#39;</small></div></body></html>"
    const-string v4, "text/html"
    invoke-virtual/range {v1..v6}, Landroid/webkit/WebView;->loadDataWithBaseURL(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$20$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/MainActivity$20;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$20$1;-><init>(Lcom/palai/prootsmoke/MainActivity$20;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1041
.method public bridge synthetic Lcom/palai/prootsmoke/MainActivity$20$1;->onReceiveValue(Ljava/lang/Object;)V
    # registers=2 ins=2 tries=0
    check-cast v1, Ljava/lang/String;
    invoke-virtual {v0, v1}, Lcom/palai/prootsmoke/MainActivity$20$1;->onReceiveValue(Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$20$1;->onReceiveValue(Ljava/lang/String;)V
    # registers=6 ins=2 tries=0
    const-string v0, ""
    if-nez v5, :L5
    goto :L15
    :L5
    const-string v1, """
    invoke-virtual {v5, v1, v0}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;
    move-result-object v5
    invoke-virtual {v5}, Ljava/lang/String;->trim()Ljava/lang/String;
    move-result-object v0
    :L15
    const-string v5, "ok"
    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v5
    const-string v1, ")"
    if-eqz v5, :L58
    iget-object v5, v4, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget-object v5, v5, Lcom/palai/prootsmoke/MainActivity$20;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v2, "[PET] OK rendered (attempt "
    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget-object v2, v4, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget v2, v2, Lcom/palai/prootsmoke/MainActivity$20;->val$attempt:I
    add-int/lit8 v2, v2, #1
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static {v5, v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    return-void 
    :L58
    iget-object v5, v4, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget-object v5, v5, Lcom/palai/prootsmoke/MainActivity$20;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v2, Ljava/lang/StringBuilder;
    const-string v3, "[PET] FAIL attempt "
    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget-object v3, v4, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget v3, v3, Lcom/palai/prootsmoke/MainActivity$20;->val$attempt:I
    add-int/lit8 v3, v3, #1
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v2
    const-string v3, " ("
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static {v5, v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    iget-object v5, v4, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget v5, v5, Lcom/palai/prootsmoke/MainActivity$20;->val$attempt:I
    add-int/lit8 v5, v5, #1
    const/16 v0, #20
    if-ge v5, v0, :L130
    new-instance v5, Landroid/os/Handler;
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;
    move-result-object v0
    invoke-direct {v5, v0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
    new-instance v0, Lcom/palai/prootsmoke/MainActivity$20$1$1;
    invoke-direct {v0, v4}, Lcom/palai/prootsmoke/MainActivity$20$1$1;-><init>(Lcom/palai/prootsmoke/MainActivity$20$1;)V
    const-wide/16 v1, #1500
    invoke-virtual {v5, v0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    goto :L151
    :L130
    iget-object v5, v4, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget-object v5, v5, Lcom/palai/prootsmoke/MainActivity$20;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v0, "[PET] retry limit reached, stop"
    invoke-static {v5, v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    iget-object v5, v4, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget-object v5, v5, Lcom/palai/prootsmoke/MainActivity$20;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v0, Lcom/palai/prootsmoke/MainActivity$20$1$2;
    invoke-direct {v0, v4}, Lcom/palai/prootsmoke/MainActivity$20$1$2;-><init>(Lcom/palai/prootsmoke/MainActivity$20$1;)V
    invoke-virtual {v5, v0}, Lcom/palai/prootsmoke/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    :L151
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$20;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;
.field final synthetic val$attempt:I

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$20;-><init>(Lcom/palai/prootsmoke/MainActivity;I)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$20;->this$0:Lcom/palai/prootsmoke/MainActivity;
    iput v2, v0, Lcom/palai/prootsmoke/MainActivity$20;->val$attempt:I
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$20;->run()V
    # registers=4 ins=1 tries=0
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$20;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v0
    if-nez v0, :L9
    return-void 
    :L9
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$20;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v0
    new-instance v1, Lcom/palai/prootsmoke/MainActivity$20$1;
    invoke-direct {v1, v3}, Lcom/palai/prootsmoke/MainActivity$20$1;-><init>(Lcom/palai/prootsmoke/MainActivity$20;)V
    const-string v2, "(function(){try{if(!document||!document.body)return 'empty';var b=document.body;var t=b.innerText||'';if(t.indexOf('ERR_CONNECTION')>=0||t.indexOf('无法')>=0)return 'err';if(b.querySelector('canvas')||b.children.length>0)return 'ok';return 'empty';}catch(e){return 'err';}})()"
    invoke-virtual {v0, v2, v1}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$21;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$21;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$21;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$21;->onClick(Landroid/content/DialogInterface;I)V
    # registers=3 ins=3 tries=0
    iget-object v1, v0, Lcom/palai/prootsmoke/MainActivity$21;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const/4 v2, #1
    invoke-static {v1, v2}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mshowGuide(Lcom/palai/prootsmoke/MainActivity;I)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$22;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$22;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$22;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$22;->onClick(Landroid/content/DialogInterface;I)V
    # registers=3 ins=3 tries=0
    iget-object v1, v0, Lcom/palai/prootsmoke/MainActivity$22;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const/4 v2, #2
    invoke-static {v1, v2}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mshowGuide(Lcom/palai/prootsmoke/MainActivity;I)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$23$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/MainActivity$23;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$23$1;-><init>(Lcom/palai/prootsmoke/MainActivity$23;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$23$1;->this$1:Lcom/palai/prootsmoke/MainActivity$23;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$23$1;->run()V
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/MainActivity$23$1;->this$1:Lcom/palai/prootsmoke/MainActivity$23;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$23;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mboot(Lcom/palai/prootsmoke/MainActivity;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$23;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$23;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$23;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$23;->onClick(Landroid/content/DialogInterface;I)V
    # registers=3 ins=3 tries=0
    new-instance v1, Ljava/lang/Thread;
    new-instance v2, Lcom/palai/prootsmoke/MainActivity$23$1;
    invoke-direct {v2, v0}, Lcom/palai/prootsmoke/MainActivity$23$1;-><init>(Lcom/palai/prootsmoke/MainActivity$23;)V
    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$24;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$24;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$24;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$24;->onClick(Landroid/content/DialogInterface;I)V
    # registers=3 ins=3 tries=0
    iget-object v1, v0, Lcom/palai/prootsmoke/MainActivity$24;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mtogglePetWindow(Lcom/palai/prootsmoke/MainActivity;)V
    iget-object v1, v0, Lcom/palai/prootsmoke/MainActivity$24;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const/4 v2, #3
    invoke-static {v1, v2}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mshowGuide(Lcom/palai/prootsmoke/MainActivity;I)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$25;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$25;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$25;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$25;->onClick(Landroid/content/DialogInterface;I)V
    # registers=3 ins=3 tries=0
    iget-object v1, v0, Lcom/palai/prootsmoke/MainActivity$25;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const/4 v2, #3
    invoke-static {v1, v2}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mshowGuide(Lcom/palai/prootsmoke/MainActivity;I)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$26;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$26;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$26;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$26;->onClick(Landroid/content/DialogInterface;I)V
    # registers=5 ins=3 tries=1
    iget-object v3, v2, Lcom/palai/prootsmoke/MainActivity$26;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v4, Landroid/content/Intent;
    const-string v0, "android.settings.USAGE_ACCESS_SETTINGS"
    invoke-direct {v4, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    invoke-virtual {v3, v4}, Lcom/palai/prootsmoke/MainActivity;->startActivity(Landroid/content/Intent;)V
    goto :L34
    move-exception v3
    iget-object v4, v2, Lcom/palai/prootsmoke/MainActivity$26;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[GUIDE] usage 设置打不开: "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-static {v4, v3}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    :L34
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$27;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$27;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$27;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$27;->onClick(Landroid/content/DialogInterface;I)V
    # registers=5 ins=3 tries=1
    iget-object v3, v2, Lcom/palai/prootsmoke/MainActivity$27;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v4, Landroid/content/Intent;
    const-string v0, "android.settings.ACTION_NOTIFICATION_LISTENER_SETTINGS"
    invoke-direct {v4, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    invoke-virtual {v3, v4}, Lcom/palai/prootsmoke/MainActivity;->startActivity(Landroid/content/Intent;)V
    goto :L34
    move-exception v3
    iget-object v4, v2, Lcom/palai/prootsmoke/MainActivity$27;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[GUIDE] 通知设置打不开: "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-static {v4, v3}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    :L34
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$28;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$28;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$28;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$28;->onClick(Landroid/content/DialogInterface;I)V
    # registers=3 ins=3 tries=0
    iget-object v1, v0, Lcom/palai/prootsmoke/MainActivity$28;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const/4 v2, #4
    invoke-static {v1, v2}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mshowGuide(Lcom/palai/prootsmoke/MainActivity;I)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$29;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$29;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$29;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$29;->onClick(Landroid/content/DialogInterface;I)V
    # registers=3 ins=3 tries=0
    iget-object v1, v0, Lcom/palai/prootsmoke/MainActivity$29;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v1
    if-eqz v1, :L26
    iget-object v1, v0, Lcom/palai/prootsmoke/MainActivity$29;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v1
    const-string v2, "http://127.0.0.1:17788/"
    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    iget-object v1, v0, Lcom/palai/prootsmoke/MainActivity$29;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v2, "[GUIDE] 切到控制台"
    invoke-static {v1, v2}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    :L26
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$2;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;
.field final synthetic val$s:Ljava/lang/String;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$2;-><init>(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$2;->this$0:Lcom/palai/prootsmoke/MainActivity;
    iput-object v2, v0, Lcom/palai/prootsmoke/MainActivity$2;->val$s:Ljava/lang/String;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$2;->run()V
    # registers=4 ins=1 tries=0
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$2;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgettv(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/TextView;
    move-result-object v0
    if-eqz v0, :L60
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$2;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgettv(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/TextView;
    move-result-object v0
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    iget-object v2, v3, Lcom/palai/prootsmoke/MainActivity$2;->val$s:Ljava/lang/String;
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    const-string v2, "
"
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->append(Ljava/lang/CharSequence;)V
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$2;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetlogScroll(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/ScrollView;
    move-result-object v0
    if-eqz v0, :L60
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$2;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetlogScroll(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/ScrollView;
    move-result-object v0
    new-instance v1, Lcom/palai/prootsmoke/MainActivity$2$1;
    invoke-direct {v1, v3}, Lcom/palai/prootsmoke/MainActivity$2$1;-><init>(Lcom/palai/prootsmoke/MainActivity$2;)V
    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->post(Ljava/lang/Runnable;)Z
    :L60
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$30;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;
.field final synthetic val$b:Landroid/app/AlertDialog$Builder;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$30;-><init>(Lcom/palai/prootsmoke/MainActivity;Landroid/app/AlertDialog$Builder;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$30;->this$0:Lcom/palai/prootsmoke/MainActivity;
    iput-object v2, v0, Lcom/palai/prootsmoke/MainActivity$30;->val$b:Landroid/app/AlertDialog$Builder;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$30;->run()V
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/MainActivity$30;->val$b:Landroid/app/AlertDialog$Builder;
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$31;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;
.field final synthetic val$label:Landroid/widget/TextView;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$31;-><init>(Lcom/palai/prootsmoke/MainActivity;Landroid/widget/TextView;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$31;->this$0:Lcom/palai/prootsmoke/MainActivity;
    iput-object v2, v0, Lcom/palai/prootsmoke/MainActivity$31;->val$label:Landroid/widget/TextView;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$31;->onProgressChanged(Landroid/widget/SeekBar;IZ)V
    # registers=7 ins=4 tries=0
    int-to-float v4, v5
    const/high16 v5, #int 0x42c80000
    div-float/2addr v4, v5
    const v0, #1036831949
    add-float/2addr v4, v0
    const/high16 v0, #int 0x3f800000
    cmpl-float v1, v4, v0
    if-lez v1, :L15
    move v4, v0
    :L15
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$31;->val$label:Landroid/widget/TextView;
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "桌宠透明度："
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    mul-float/2addr v5, v4
    invoke-static {v5}, Ljava/lang/Math;->round(F)I
    move-result v5
    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v5
    const-string v1, "%"
    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v5
    invoke-virtual {v0, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    if-eqz v6, :L53
    iget-object v5, v3, Lcom/palai/prootsmoke/MainActivity$31;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v5, v4}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mpushAlphaToService(Lcom/palai/prootsmoke/MainActivity;F)V
    :L53
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$31;->onStartTrackingTouch(Landroid/widget/SeekBar;)V
    # registers=2 ins=2 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$31;->onStopTrackingTouch(Landroid/widget/SeekBar;)V
    # registers=2 ins=2 tries=0
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$32;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;
.field final synthetic val$sp:Landroid/content/SharedPreferences;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$32;-><init>(Lcom/palai/prootsmoke/MainActivity;Landroid/content/SharedPreferences;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$32;->this$0:Lcom/palai/prootsmoke/MainActivity;
    iput-object v2, v0, Lcom/palai/prootsmoke/MainActivity$32;->val$sp:Landroid/content/SharedPreferences;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$32;->onClick(Landroid/content/DialogInterface;I)V
    # registers=4 ins=3 tries=0
    iget-object v2, v1, Lcom/palai/prootsmoke/MainActivity$32;->val$sp:Landroid/content/SharedPreferences;
    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v2
    const-string v3, "pet_alpha"
    const/high16 v0, #int 0x3f800000
    invoke-interface {v2, v3, v0}, Landroid/content/SharedPreferences$Editor;->putFloat(Ljava/lang/String;F)Landroid/content/SharedPreferences$Editor;
    move-result-object v2
    invoke-interface {v2}, Landroid/content/SharedPreferences$Editor;->apply()V
    iget-object v2, v1, Lcom/palai/prootsmoke/MainActivity$32;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v2, v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mpushAlphaToService(Lcom/palai/prootsmoke/MainActivity;F)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$33;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$33;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$33;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$33;->onClick(Landroid/content/DialogInterface;I)V
    # registers=5 ins=3 tries=1
    iget-object v3, v2, Lcom/palai/prootsmoke/MainActivity$33;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v4, Landroid/content/Intent;
    const-string v0, "android.settings.USAGE_ACCESS_SETTINGS"
    invoke-direct {v4, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    invoke-virtual {v3, v4}, Lcom/palai/prootsmoke/MainActivity;->startActivity(Landroid/content/Intent;)V
    goto :L34
    move-exception v3
    iget-object v4, v2, Lcom/palai/prootsmoke/MainActivity$33;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[SENSE] 打不开 usage 设置: "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-static {v4, v3}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    :L34
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$34;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$34;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$34;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$34;->onClick(Landroid/content/DialogInterface;I)V
    # registers=5 ins=3 tries=1
    iget-object v3, v2, Lcom/palai/prootsmoke/MainActivity$34;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v4, Landroid/content/Intent;
    const-string v0, "android.settings.ACTION_NOTIFICATION_LISTENER_SETTINGS"
    invoke-direct {v4, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    invoke-virtual {v3, v4}, Lcom/palai/prootsmoke/MainActivity;->startActivity(Landroid/content/Intent;)V
    goto :L34
    move-exception v3
    iget-object v4, v2, Lcom/palai/prootsmoke/MainActivity$34;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[SENSE] 打不开通知设置: "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-static {v4, v3}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    :L34
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$35;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;
.field final synthetic val$b:Landroid/app/AlertDialog$Builder;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$35;-><init>(Lcom/palai/prootsmoke/MainActivity;Landroid/app/AlertDialog$Builder;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$35;->this$0:Lcom/palai/prootsmoke/MainActivity;
    iput-object v2, v0, Lcom/palai/prootsmoke/MainActivity$35;->val$b:Landroid/app/AlertDialog$Builder;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$35;->run()V
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/MainActivity$35;->val$b:Landroid/app/AlertDialog$Builder;
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$36;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$36;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$36;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$36;->onClick(Landroid/content/DialogInterface;I)V
    # registers=3 ins=3 tries=0
    iget-object v1, v0, Lcom/palai/prootsmoke/MainActivity$36;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mrequestOverlay(Lcom/palai/prootsmoke/MainActivity;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$37;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;
.field final synthetic val$ab:Landroid/app/AlertDialog$Builder;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$37;-><init>(Lcom/palai/prootsmoke/MainActivity;Landroid/app/AlertDialog$Builder;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$37;->this$0:Lcom/palai/prootsmoke/MainActivity;
    iput-object v2, v0, Lcom/palai/prootsmoke/MainActivity$37;->val$ab:Landroid/app/AlertDialog$Builder;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$37;->run()V
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/MainActivity$37;->val$ab:Landroid/app/AlertDialog$Builder;
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$38$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/MainActivity$38;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$38$1;-><init>(Lcom/palai/prootsmoke/MainActivity$38;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$38$1;->this$1:Lcom/palai/prootsmoke/MainActivity$38;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$38$1;->run()V
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/MainActivity$38$1;->this$1:Lcom/palai/prootsmoke/MainActivity$38;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$38;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mcanDrawOverlays(Lcom/palai/prootsmoke/MainActivity;)Z
    move-result v0
    if-eqz v0, :L27
    invoke-static {}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$sfgetpetWinOn()Ljava/util/concurrent/atomic/AtomicBoolean;
    move-result-object v0
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z
    move-result v0
    if-nez v0, :L27
    iget-object v0, v1, Lcom/palai/prootsmoke/MainActivity$38$1;->this$1:Lcom/palai/prootsmoke/MainActivity$38;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$38;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mstartPetWindow(Lcom/palai/prootsmoke/MainActivity;)V
    :L27
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$38;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$38;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$38;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$38;->run()V
    # registers=4 ins=1 tries=0
    const/16 v0, #7797
    const v1, #90000
    const-string v2, "127.0.0.1"
    invoke-static {v2, v0, v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$smwaitPortOpen(Ljava/lang/String;II)Z
    move-result v0
    if-nez v0, :L21
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$38;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v1, "[PET] 7797 端口超时未就绪，仍尝试启动桌宠（可能显示空白）"
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    goto :L28
    :L21
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$38;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v1, "[PET] 7797 端口已就绪，启动桌宠悬浮窗"
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    :L28
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$38;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetroot(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/LinearLayout;
    move-result-object v0
    new-instance v1, Lcom/palai/prootsmoke/MainActivity$38$1;
    invoke-direct {v1, v3}, Lcom/palai/prootsmoke/MainActivity$38$1;-><init>(Lcom/palai/prootsmoke/MainActivity$38;)V
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->post(Ljava/lang/Runnable;)Z
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$3;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$3;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$3;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$3;->onClick(Landroid/view/View;)V
    # registers=3 ins=2 tries=0
    iget-object v2, v1, Lcom/palai/prootsmoke/MainActivity$3;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const/4 v0, #0
    invoke-static {v2, v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mshowGuide(Lcom/palai/prootsmoke/MainActivity;I)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$4$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/MainActivity$4;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$4$1;-><init>(Lcom/palai/prootsmoke/MainActivity$4;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$4$1;->this$1:Lcom/palai/prootsmoke/MainActivity$4;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$4$1;->run()V
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/MainActivity$4$1;->this$1:Lcom/palai/prootsmoke/MainActivity$4;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$4;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mboot(Lcom/palai/prootsmoke/MainActivity;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$4;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$4;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$4;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$4;->onClick(Landroid/view/View;)V
    # registers=3 ins=2 tries=0
    new-instance v2, Ljava/lang/Thread;
    new-instance v0, Lcom/palai/prootsmoke/MainActivity$4$1;
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/MainActivity$4$1;-><init>(Lcom/palai/prootsmoke/MainActivity$4;)V
    invoke-direct {v2, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V
    invoke-virtual {v2}, Ljava/lang/Thread;->start()V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$5;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$5;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$5;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$5;->onClick(Landroid/view/View;)V
    # registers=3 ins=2 tries=0
    iget-object v2, v1, Lcom/palai/prootsmoke/MainActivity$5;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v2
    if-nez v2, :L9
    return-void 
    :L9
    iget-object v2, v1, Lcom/palai/prootsmoke/MainActivity$5;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const/4 v0, #0
    invoke-static {v2, v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fputpetRetry(Lcom/palai/prootsmoke/MainActivity;I)V
    iget-object v2, v1, Lcom/palai/prootsmoke/MainActivity$5;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v2, v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mloadPetWithRetry(Lcom/palai/prootsmoke/MainActivity;I)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$6;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$6;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$6;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$6;->onClick(Landroid/view/View;)V
    # registers=5 ins=2 tries=1
    iget-object v4, v3, Lcom/palai/prootsmoke/MainActivity$6;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v0, Landroid/content/Intent;
    iget-object v1, v3, Lcom/palai/prootsmoke/MainActivity$6;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-class v2, Lcom/palai/prootsmoke/PetActivity;
    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    invoke-virtual {v4, v0}, Lcom/palai/prootsmoke/MainActivity;->startActivity(Landroid/content/Intent;)V
    iget-object v4, v3, Lcom/palai/prootsmoke/MainActivity$6;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v0, "[PET] 启动全屏桌宠 (PetActivity)"
    invoke-static {v4, v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    goto :L43
    move-exception v4
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$6;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "[PET] 启动 PetActivity 失败: "
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v4
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-static {v0, v4}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    :L43
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$7;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$7;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$7;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$7;->onClick(Landroid/view/View;)V
    # registers=3 ins=2 tries=0
    iget-object v2, v1, Lcom/palai/prootsmoke/MainActivity$7;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v2
    if-nez v2, :L9
    return-void 
    :L9
    iget-object v2, v1, Lcom/palai/prootsmoke/MainActivity$7;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v2
    const-string v0, "http://127.0.0.1:17788/"
    invoke-virtual {v2, v0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    iget-object v2, v1, Lcom/palai/prootsmoke/MainActivity$7;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v0, "[PET] 切回控制台 -> http://127.0.0.1:17788/"
    invoke-static {v2, v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$8;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$8;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$8;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$8;->onClick(Landroid/view/View;)V
    # registers=2 ins=2 tries=0
    iget-object v1, v0, Lcom/palai/prootsmoke/MainActivity$8;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mopenSenseSettings(Lcom/palai/prootsmoke/MainActivity;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/MainActivity$9;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$9;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$9;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$9;->onClick(Landroid/view/View;)V
    # registers=2 ins=2 tries=0
    iget-object v1, v0, Lcom/palai/prootsmoke/MainActivity$9;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mshowAlphaDialog(Lcom/palai/prootsmoke/MainActivity;)V
    return-void 
.end method

.class public Lcom/palai/prootsmoke/MainActivity;
.super Landroid/app/Activity;

.field private static final PET_MAX_RETRY:I
.field private static final PET_RETRY_INTERVAL:I
.field private static final REQ_MIC:I
.field private static final REQ_OVERLAY:I
.field private static final TAG:Ljava/lang/String;
.field private static final petWinOn:Ljava/util/concurrent/atomic/AtomicBoolean;
.field private volatile booting:Z
.field private volatile coreReady:Z
.field private logScroll:Landroid/widget/ScrollView;
.field private pendingLink:Ljava/lang/String;
.field private pendingName:Ljava/lang/String;
.field private petRetry:I
.field private root:Landroid/widget/LinearLayout;
.field private statusTv:Landroid/widget/TextView;
.field private tv:Landroid/widget/TextView;
.field private web:Landroid/webkit/WebView;

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetlogScroll(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/ScrollView;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity;->logScroll:Landroid/widget/ScrollView;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetroot(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/LinearLayout;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity;->root:Landroid/widget/LinearLayout;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetstatusTv(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/TextView;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity;->statusTv:Landroid/widget/TextView;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgettv(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/TextView;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity;->tv:Landroid/widget/TextView;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity;->web:Landroid/webkit/WebView;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fputpetRetry(Lcom/palai/prootsmoke/MainActivity;I)V
    # registers=2 ins=2 tries=0
    iput v1, v0, Lcom/palai/prootsmoke/MainActivity;->petRetry:I
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mboot(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/MainActivity;->boot()V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mcanDrawOverlays(Lcom/palai/prootsmoke/MainActivity;)Z
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/MainActivity;->canDrawOverlays()Z
    move-result v0
    return v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mloadPetWithRetry(Lcom/palai/prootsmoke/MainActivity;I)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->loadPetWithRetry(I)V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mopenSenseSettings(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/MainActivity;->openSenseSettings()V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mpushAlphaToService(Lcom/palai/prootsmoke/MainActivity;F)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->pushAlphaToService(F)V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mrequestOverlay(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/MainActivity;->requestOverlay()V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mshowAlphaDialog(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/MainActivity;->showAlphaDialog()V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mshowGuide(Lcom/palai/prootsmoke/MainActivity;I)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->showGuide(I)V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mstartPetWindow(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/MainActivity;->startPetWindow()V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mstartPetWindowWhenReady(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/MainActivity;->startPetWindowWhenReady()V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mtogglePetWindow(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/MainActivity;->togglePetWindow()V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/MainActivity;->-$$Nest$sfgetpetWinOn()Ljava/util/concurrent/atomic/AtomicBoolean;
    # registers=1 ins=0 tries=0
    sget-object v0, Lcom/palai/prootsmoke/MainActivity;->petWinOn:Ljava/util/concurrent/atomic/AtomicBoolean;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/MainActivity;->-$$Nest$smwaitPortOpen(Ljava/lang/String;II)Z
    # registers=3 ins=3 tries=0
    invoke-static {v0, v1, v2}, Lcom/palai/prootsmoke/MainActivity;->waitPortOpen(Ljava/lang/String;II)Z
    move-result v0
    return v0
.end method

# direct access=0x10008
.method static constructor Lcom/palai/prootsmoke/MainActivity;-><clinit>()V
    # registers=2 ins=0 tries=0
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;
    const/4 v1, #0
    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V
    sput-object v0, Lcom/palai/prootsmoke/MainActivity;->petWinOn:Ljava/util/concurrent/atomic/AtomicBoolean;
    return-void 
.end method

# direct access=0x10001
.method public constructor Lcom/palai/prootsmoke/MainActivity;-><init>()V
    # registers=3 ins=1 tries=0
    invoke-direct {v2}, Landroid/app/Activity;-><init>()V
    const/4 v0, #0
    iput-boolean v0, v2, Lcom/palai/prootsmoke/MainActivity;->coreReady:Z
    iput-boolean v0, v2, Lcom/palai/prootsmoke/MainActivity;->booting:Z
    const/4 v1, #0
    iput-object v1, v2, Lcom/palai/prootsmoke/MainActivity;->pendingName:Ljava/lang/String;
    iput-object v1, v2, Lcom/palai/prootsmoke/MainActivity;->pendingLink:Ljava/lang/String;
    iput v0, v2, Lcom/palai/prootsmoke/MainActivity;->petRetry:I
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/MainActivity;->askMicOnce()V
    # registers=6 ins=1 tries=1
    const-string v0, "mic_asked"
    const-string v1, "android.permission.RECORD_AUDIO"
    invoke-virtual {v5, v1}, Lcom/palai/prootsmoke/MainActivity;->checkSelfPermission(Ljava/lang/String;)I
    move-result v2
    if-nez v2, :L11
    return-void 
    :L11
    const-string v2, "coopanion"
    const/4 v3, #0
    invoke-virtual {v5, v2, v3}, Lcom/palai/prootsmoke/MainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v2
    invoke-interface {v2, v0, v3}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z
    move-result v4
    if-eqz v4, :L25
    return-void 
    :L25
    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v2
    const/4 v4, #1
    invoke-interface {v2, v0, v4}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    new-array v0, v4, [Ljava/lang/String;
    aput-object v1, v0, v3
    const/16 v1, #10087
    invoke-virtual {v5, v0, v1}, Lcom/palai/prootsmoke/MainActivity;->requestPermissions([Ljava/lang/String;I)V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/MainActivity;->boot()V
    # registers=3 ins=1 tries=1
    iget-boolean v0, v2, Lcom/palai/prootsmoke/MainActivity;->booting:Z
    if-eqz v0, :L10
    const-string v0, "[BOOT] 已在启动中，忽略重复调用"
    invoke-direct {v2, v0}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    return-void 
    :L10
    const/4 v0, #1
    iput-boolean v0, v2, Lcom/palai/prootsmoke/MainActivity;->booting:Z
    const/4 v0, #0
    invoke-direct {v2}, Lcom/palai/prootsmoke/MainActivity;->doBoot()V
    iput-boolean v0, v2, Lcom/palai/prootsmoke/MainActivity;->booting:Z
    return-void 
    move-exception v1
    iput-boolean v0, v2, Lcom/palai/prootsmoke/MainActivity;->booting:Z
    throw v1
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/MainActivity;->canDrawOverlays()Z
    # registers=2 ins=1 tries=1
    invoke-static {v1}, Landroid/provider/Settings;->canDrawOverlays(Landroid/content/Context;)Z
    move-result v0
    return v0
    const/4 v0, #0
    return v0
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/MainActivity;->copyN(Ljava/io/InputStream;Ljava/io/OutputStream;J)V
    # registers=8 ins=4 tries=0
    const/high16 v0, #int 0x10000
    new-array v1, v0, [B
    :L4
    const-wide/16 v2, #0
    cmp-long v2, v6, v2
    if-lez v2, :L30
    int-to-long v2, v0
    invoke-static {v2, v3, v6, v7}, Ljava/lang/Math;->min(JJ)J
    move-result-wide v2
    long-to-int v2, v2
    const/4 v3, #0
    invoke-virtual {v4, v1, v3, v2}, Ljava/io/InputStream;->read([BII)I
    move-result v2
    if-gez v2, :L24
    goto :L30
    :L24
    invoke-virtual {v5, v1, v3, v2}, Ljava/io/OutputStream;->write([BII)V
    int-to-long v2, v2
    sub-long/2addr v6, v2
    goto :L4
    :L30
    return-void 
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/MainActivity;->cstr([BII)Ljava/lang/String;
    # registers=5 ins=3 tries=1
    move v0, v3
    :L1
    add-int v1, v3, v4
    if-ge v0, v1, :L12
    aget-byte v1, v2, v0
    if-eqz v1, :L12
    add-int/lit8 v0, v0, #1
    goto :L1
    :L12
    new-instance v4, Ljava/lang/String;
    sub-int/2addr v0, v3
    const-string v1, "UTF-8"
    invoke-direct {v4, v2, v3, v0, v1}, Ljava/lang/String;-><init>([BIILjava/lang/String;)V
    return-object v4
    const-string v2, ""
    return-object v2
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/MainActivity;->deleteRec(Ljava/io/File;)V
    # registers=6 ins=2 tries=0
    if-eqz v5, :L36
    invoke-virtual {v5}, Ljava/io/File;->exists()Z
    move-result v0
    if-nez v0, :L9
    goto :L36
    :L9
    invoke-virtual {v5}, Ljava/io/File;->isDirectory()Z
    move-result v0
    if-eqz v0, :L33
    invoke-virtual {v5}, Ljava/io/File;->listFiles()[Ljava/io/File;
    move-result-object v0
    if-eqz v0, :L33
    array-length v1, v0
    const/4 v2, #0
    :L23
    if-ge v2, v1, :L33
    aget-object v3, v0, v2
    invoke-direct {v4, v3}, Lcom/palai/prootsmoke/MainActivity;->deleteRec(Ljava/io/File;)V
    add-int/lit8 v2, v2, #1
    goto :L23
    :L33
    invoke-virtual {v5}, Ljava/io/File;->delete()Z
    :L36
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/MainActivity;->doBoot()V
    # registers=22 ins=1 tries=16
    move-object/from16 v1, v21
    const-string v0, "1"
    const-string v2, "rootfs-v8-"
    const-string v3, "-"
    const-string v4, "payload.asset"
    const-string v5, "-b"
    new-instance v6, Ljava/lang/StringBuilder;
    const-string v7, "[BOOT] 日志文件 = "
    invoke-direct {v6, v7}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    const/4 v7, #0
    invoke-virtual {v1, v7}, Lcom/palai/prootsmoke/MainActivity;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;
    move-result-object v8
    if-eqz v8, :L35
    invoke-virtual {v1, v7}, Lcom/palai/prootsmoke/MainActivity;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;
    move-result-object v7
    invoke-virtual {v7}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;
    move-result-object v7
    goto :L37
    :L35
    const-string v7, "?"
    :L37
    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v6
    const-string v7, "/coop-run.log"
    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v6
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v6
    invoke-direct {v1, v6}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    invoke-virtual/range {v21..v21}, Lcom/palai/prootsmoke/MainActivity;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;
    move-result-object v6
    iget-object v6, v6, Landroid/content/pm/ApplicationInfo;->nativeLibraryDir:Ljava/lang/String;
    invoke-virtual/range {v21..v21}, Lcom/palai/prootsmoke/MainActivity;->getAssets()Landroid/content/res/AssetManager;
    move-result-object v11
    invoke-virtual {v11, v4}, Landroid/content/res/AssetManager;->openFd(Ljava/lang/String;)Landroid/content/res/AssetFileDescriptor;
    move-result-object v11
    invoke-virtual {v11}, Landroid/content/res/AssetFileDescriptor;->getLength()J
    move-result-wide v12
    invoke-virtual {v11}, Landroid/content/res/AssetFileDescriptor;->close()V
    goto :L105
    const-wide/16 v12, #-1
    invoke-virtual/range {v21..v21}, Lcom/palai/prootsmoke/MainActivity;->getAssets()Landroid/content/res/AssetManager;
    move-result-object v11
    invoke-virtual {v11, v4}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;
    move-result-object v11
    const/high16 v14, #int 0x10000
    new-array v14, v14, [B
    const-wide/16 v15, #0
    :L92
    invoke-virtual {v11, v14}, Ljava/io/InputStream;->read([B)I
    move-result v7
    if-lez v7, :L101
    int-to-long v7, v7
    add-long/2addr v15, v7
    goto :L92
    :L101
    invoke-virtual {v11}, Ljava/io/InputStream;->close()V
    move-wide v12, v15
    :L105
    const/4 v7, #0
    invoke-virtual/range {v21..v21}, Lcom/palai/prootsmoke/MainActivity;->getPackageManager()Landroid/content/pm/PackageManager;
    move-result-object v8
    invoke-virtual/range {v21..v21}, Lcom/palai/prootsmoke/MainActivity;->getPackageName()Ljava/lang/String;
    move-result-object v11
    invoke-virtual {v8, v11, v7}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;
    move-result-object v8
    iget v8, v8, Landroid/content/pm/PackageInfo;->versionCode:I
    int-to-long v14, v8
    goto :L124
    const-wide/16 v14, #0
    :L124
    new-instance v8, Ljava/io/File;
    invoke-virtual/range {v21..v21}, Lcom/palai/prootsmoke/MainActivity;->getFilesDir()Ljava/io/File;
    move-result-object v11
    new-instance v9, Ljava/lang/StringBuilder;
    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {v9, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v9
    invoke-virtual {v9, v14, v15}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    move-result-object v9
    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v9
    invoke-virtual {v9, v12, v13}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    move-result-object v9
    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v9
    invoke-direct {v8, v11, v9}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V
    new-instance v9, Ljava/io/File;
    new-instance v10, Ljava/lang/StringBuilder;
    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V
    const-string v11, ".ok-v8-"
    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v10
    invoke-virtual {v10, v14, v15}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    move-result-object v10
    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v10
    invoke-virtual {v10, v12, v13}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    move-result-object v10
    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v10
    invoke-direct {v9, v8, v10}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V
    invoke-virtual {v9}, Ljava/io/File;->exists()Z
    move-result v10
    if-nez v10, :L553
    new-instance v10, Ljava/lang/StringBuilder;
    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V
    const-string v11, "[0] 检测到新指纹，解压到新目录 rootfs-v8-"
    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v10
    invoke-virtual {v10, v14, v15}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    move-result-object v10
    invoke-virtual {v10, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3, v12, v13}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    move-result-object v3
    const-string v10, " ..."
    invoke-virtual {v3, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-direct {v1, v3}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    new-instance v3, Ljava/lang/StringBuilder;
    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V
    const-string v10, "[1] 解压 rootfs (payload="
    invoke-virtual {v3, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3, v12, v13}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    move-result-object v3
    const-string v10, "B, 耐心等 1-2 分钟) ..."
    invoke-virtual {v3, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-direct {v1, v3}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v10
    invoke-virtual {v8}, Ljava/io/File;->mkdirs()Z
    invoke-virtual/range {v21..v21}, Lcom/palai/prootsmoke/MainActivity;->getAssets()Landroid/content/res/AssetManager;
    move-result-object v3
    invoke-virtual {v3, v4}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;
    move-result-object v3
    invoke-direct {v1, v3, v8}, Lcom/palai/prootsmoke/MainActivity;->extractTarGz(Ljava/io/InputStream;Ljava/io/File;)V
    invoke-direct {v1, v8}, Lcom/palai/prootsmoke/MainActivity;->fixPerms(Ljava/io/File;)V
    const/4 v3, #5
    new-array v4, v3, [[Ljava/lang/String;
    const/4 v12, #2
    new-array v13, v12, [Ljava/lang/String;
    const-string v14, "app/coop-stage/node_modules/sherpa-onnx-node/node_modules/sherpa-onnx-linux-arm64/sherpa-onnx.node"
    aput-object v14, v13, v7
    const-string v14, "804112"
    const/4 v15, #1
    aput-object v14, v13, v15
    aput-object v13, v4, v7
    new-array v13, v12, [Ljava/lang/String;
    const-string v14, "app/coop-stage/node_modules/sherpa-onnx-node/node_modules/sherpa-onnx-linux-arm64/libonnxruntime.so"
    aput-object v14, v13, v7
    const-string v14, "34606912"
    const/4 v15, #1
    aput-object v14, v13, v15
    aput-object v13, v4, v15
    new-array v13, v12, [Ljava/lang/String;
    const-string v14, "app/coop-stage/node_modules/sherpa-onnx-node/node_modules/sherpa-onnx-linux-arm64/libsherpa-onnx-c-api.so"
    aput-object v14, v13, v7
    const-string v14, "4613032"
    aput-object v14, v13, v15
    aput-object v13, v4, v12
    new-array v13, v12, [Ljava/lang/String;
    const-string v14, "app/coop-stage/node_modules/sherpa-onnx-node/node_modules/sherpa-onnx-linux-arm64/libsherpa-onnx-cxx-api.so"
    aput-object v14, v13, v7
    const-string v14, "281200"
    const/4 v15, #1
    aput-object v14, v13, v15
    const/4 v14, #3
    aput-object v13, v4, v14
    new-array v12, v12, [Ljava/lang/String;
    const-string v13, "bin/node"
    aput-object v13, v12, v7
    const-string v13, "123024744"
    const/4 v14, #1
    aput-object v13, v12, v14
    const/4 v13, #4
    aput-object v12, v4, v13
    move v12, v7
    move v13, v12
    :L353
    if-ge v12, v3, :L459
    aget-object v14, v4, v12
    new-instance v15, Ljava/io/File;
    aget-object v3, v14, v7
    invoke-direct {v15, v8, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V
    const/4 v3, #1
    aget-object v17, v14, v3
    move-object/from16 v18, v8
    invoke-static/range {v17..v17}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J
    move-result-wide v7
    invoke-virtual {v15}, Ljava/io/File;->exists()Z
    move-result v17
    if-eqz v17, :L387
    invoke-virtual {v15}, Ljava/io/File;->length()J
    move-result-wide v19
    move-object v15, v4
    move-wide/from16 v3, v19
    goto :L390
    :L387
    move-object v15, v4
    const-wide/16 v3, #-1
    :L390
    cmp-long v19, v3, v7
    if-eqz v19, :L448
    add-int/lit8 v13, v13, #1
    move/from16 v19, v13
    new-instance v13, Ljava/lang/StringBuilder;
    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V
    move-object/from16 v20, v15
    const-string v15, "[CHK] MISMATCH "
    invoke-virtual {v13, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v13
    const/4 v15, #0
    aget-object v14, v14, v15
    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v13
    const-string v14, " got="
    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v13
    invoke-virtual {v13, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    move-result-object v3
    const-string v4, " want="
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3, v7, v8}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-direct {v1, v3}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    move/from16 v13, v19
    goto :L450
    :L448
    move-object/from16 v20, v15
    :L450
    add-int/lit8 v12, v12, #1
    move-object/from16 v8, v18
    move-object/from16 v4, v20
    const/4 v3, #5
    const/4 v7, #0
    goto :L353
    :L459
    move-object/from16 v18, v8
    new-instance v3, Ljava/lang/StringBuilder;
    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V
    const-string v4, "[CHK] critical files: "
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    rsub-int/lit8 v4, v13, #5
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v3
    const-string v4, "/"
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    const/4 v4, #5
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v3
    const-string v4, " OK"
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    if-lez v13, :L500
    const-string v4, "  <-- !!! 解压有问题，语音会失败"
    goto :L502
    :L500
    const-string v4, ""
    :L502
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-direct {v1, v3}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    goto :L516
    move-object/from16 v18, v8
    :L516
    invoke-virtual {v9}, Ljava/io/File;->createNewFile()Z
    new-instance v3, Ljava/lang/StringBuilder;
    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V
    const-string v4, "    完成 "
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v7
    sub-long/2addr v7, v10
    invoke-virtual {v3, v7, v8}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    move-result-object v3
    const-string v4, "ms"
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-direct {v1, v3}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    goto :L560
    :L553
    move-object/from16 v18, v8
    const-string v3, "[1] rootfs 已解压（指纹一致）"
    invoke-direct {v1, v3}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    :L560
    invoke-virtual/range {v21..v21}, Lcom/palai/prootsmoke/MainActivity;->getFilesDir()Ljava/io/File;
    move-result-object v3
    invoke-virtual {v3}, Ljava/io/File;->listFiles()[Ljava/io/File;
    move-result-object v3
    if-eqz v3, :L630
    invoke-virtual/range {v18..v18}, Ljava/io/File;->getName()Ljava/lang/String;
    move-result-object v4
    array-length v7, v3
    const/4 v8, #0
    :L576
    if-ge v8, v7, :L630
    aget-object v9, v3, v8
    invoke-virtual {v9}, Ljava/io/File;->getName()Ljava/lang/String;
    move-result-object v10
    invoke-virtual {v9}, Ljava/io/File;->isDirectory()Z
    move-result v11
    if-eqz v11, :L627
    invoke-virtual {v10, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v11
    if-eqz v11, :L627
    invoke-virtual {v10, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v11
    if-nez v11, :L627
    invoke-direct {v1, v9}, Lcom/palai/prootsmoke/MainActivity;->deleteRec(Ljava/io/File;)V
    new-instance v9, Ljava/lang/StringBuilder;
    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V
    const-string v11, "[0b] 清理旧 rootfs 目录: "
    invoke-virtual {v9, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v9
    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v9
    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v9
    invoke-direct {v1, v9}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    :L627
    add-int/lit8 v8, v8, #1
    goto :L576
    :L630
    new-instance v2, Ljava/io/File;
    invoke-virtual/range {v21..v21}, Lcom/palai/prootsmoke/MainActivity;->getFilesDir()Ljava/io/File;
    move-result-object v3
    const-string v4, "ptmp"
    invoke-direct {v2, v3, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V
    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z
    const/4 v3, #1
    const/4 v4, #0
    invoke-virtual {v2, v3, v4}, Ljava/io/File;->setReadable(ZZ)Z
    invoke-virtual {v2, v3, v4}, Ljava/io/File;->setWritable(ZZ)Z
    invoke-virtual {v2, v3, v4}, Ljava/io/File;->setExecutable(ZZ)Z
    const-string v4, "[2] 启动 Coopanion Core ..."
    invoke-direct {v1, v4}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    new-instance v4, Ljava/util/ArrayList;
    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V
    new-instance v7, Ljava/lang/StringBuilder;
    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v7
    const-string v8, "/libproot.so"
    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v7
    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v7
    invoke-interface {v4, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    const-string v7, "-0"
    invoke-interface {v4, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    const-string v7, "-r"
    invoke-interface {v4, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    invoke-virtual/range {v18..v18}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;
    move-result-object v7
    invoke-interface {v4, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    const-string v7, "--link2symlink"
    invoke-interface {v4, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    const-string v7, "/dev"
    invoke-interface {v4, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    const-string v7, "/proc"
    invoke-interface {v4, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    const-string v7, "/sys"
    invoke-interface {v4, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    new-instance v5, Ljava/lang/StringBuilder;
    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
    const-string v7, ":/hostlib"
    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v5
    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    const-string v5, "-w"
    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    const-string v5, "/app/coop-stage"
    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    new-instance v5, Ljava/io/File;
    const-string v7, "app/boot.sh"
    move-object/from16 v8, v18
    invoke-direct {v5, v8, v7}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V
    invoke-virtual {v5}, Ljava/io/File;->exists()Z
    move-result v5
    if-eqz v5, :L794
    const-string v5, "/bin/sh"
    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    const-string v5, "/app/boot.sh"
    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    goto :L814
    :L794
    const-string v5, "[1b] 未找到 boot.sh，直接用 run-core.mjs 兜底启动 ..."
    invoke-direct {v1, v5}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    const-string v5, "/bin/node"
    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    const-string v5, "--experimental-transform-types"
    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    const-string v5, "run-core.mjs"
    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :L814
    new-instance v5, Ljava/lang/ProcessBuilder;
    invoke-direct {v5, v4}, Ljava/lang/ProcessBuilder;-><init>(Ljava/util/List;)V
    const/4 v4, #1
    invoke-virtual {v5, v4}, Ljava/lang/ProcessBuilder;->redirectErrorStream(Z)Ljava/lang/ProcessBuilder;
    invoke-virtual {v5, v8}, Ljava/lang/ProcessBuilder;->directory(Ljava/io/File;)Ljava/lang/ProcessBuilder;
    invoke-virtual {v5}, Ljava/lang/ProcessBuilder;->environment()Ljava/util/Map;
    move-result-object v4
    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;
    move-result-object v2
    const-string v7, "TMPDIR"
    invoke-interface {v4, v7, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    const-string v7, "TMP"
    invoke-interface {v4, v7, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    const-string v7, "TEMP"
    invoke-interface {v4, v7, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    const-string v7, "PROOT_TMP_DIR"
    invoke-interface {v4, v7, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    const-string v2, "PROOT_LOADER"
    new-instance v7, Ljava/lang/StringBuilder;
    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v7
    const-string v9, "/libprootloader.so"
    invoke-virtual {v7, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v7
    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v7
    invoke-interface {v4, v2, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    const-string v2, "PROOT_LOADER_32"
    new-instance v7, Ljava/lang/StringBuilder;
    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v6
    const-string v7, "/libprootloader32.so"
    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v6
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v6
    invoke-interface {v4, v2, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    const-string v2, "PROOT_NO_SECCOMP"
    invoke-interface {v4, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    const-string v2, "HOME"
    const-string v6, "/root"
    invoke-interface {v4, v2, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    const-string v2, "LANG"
    const-string v6, "en_US.UTF-8"
    invoke-interface {v4, v2, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    const-string v2, "TZ"
    const-string v6, "Asia/Shanghai"
    invoke-interface {v4, v2, v6}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    const-string v2, "CORTICO_SUPERVISED"
    invoke-interface {v4, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    const-string v0, "LD_PRELOAD"
    invoke-interface {v4, v0}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;
    invoke-virtual {v5}, Ljava/lang/ProcessBuilder;->start()Ljava/lang/Process;
    move-result-object v0
    new-instance v2, Ljava/io/BufferedReader;
    new-instance v4, Ljava/io/InputStreamReader;
    invoke-virtual {v0}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;
    move-result-object v5
    invoke-direct {v4, v5}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V
    invoke-direct {v2, v4}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    :L956
    const/16 v17, #0
    :L958
    invoke-virtual {v2}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;
    move-result-object v4
    if-eqz v4, :L1006
    invoke-direct {v1, v4}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    const-string v5, "core已启动"
    invoke-virtual {v4, v5}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v4
    if-eqz v4, :L995
    iget-boolean v4, v1, Lcom/palai/prootsmoke/MainActivity;->coreReady:Z
    if-nez v4, :L995
    const/4 v4, #1
    iput-boolean v4, v1, Lcom/palai/prootsmoke/MainActivity;->coreReady:Z
    new-instance v4, Ljava/lang/Thread;
    new-instance v5, Lcom/palai/prootsmoke/MainActivity$17;
    invoke-direct {v5, v1}, Lcom/palai/prootsmoke/MainActivity$17;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    invoke-direct {v4, v5}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V
    invoke-virtual {v4}, Ljava/lang/Thread;->start()V
    :L995
    const/4 v4, #1
    add-int/lit8 v5, v17, #1
    const/16 v6, #500
    if-le v5, v6, :L1003
    goto :L956
    :L1003
    move/from16 v17, v5
    goto :L958
    :L1006
    invoke-virtual {v0}, Ljava/lang/Process;->waitFor()I
    move-result v0
    new-instance v2, Ljava/io/File;
    const-string v4, "app/coop-stage/home/companion/data/.restart-request"
    invoke-direct {v2, v8, v4}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V
    invoke-virtual {v2}, Ljava/io/File;->exists()Z
    move-result v4
    if-eqz v4, :L1058
    invoke-virtual {v2}, Ljava/io/File;->delete()Z
    const-string v0, "[!] 检测到重启请求：扩展已安装，正在重启内核以生效 ..."
    invoke-direct {v1, v0}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    const-string v0, "[!] 重启中，请稍等 10~30 秒，控制台页面会自动刷新。"
    invoke-direct {v1, v0}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    const/4 v0, #0
    iput-boolean v0, v1, Lcom/palai/prootsmoke/MainActivity;->coreReady:Z
    const-wide/16 v2, #1000
    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V
    new-instance v0, Ljava/lang/Thread;
    new-instance v2, Lcom/palai/prootsmoke/MainActivity$18;
    invoke-direct {v2, v1}, Lcom/palai/prootsmoke/MainActivity$18;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    invoke-direct {v0, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V
    return-void 
    :L1058
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    const-string v3, "[4] core 进程结束 rc="
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-direct {v1, v0}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    goto :L1103
    move-exception v0
    new-instance v2, Ljava/lang/StringBuilder;
    const-string v3, "[EXC] "
    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    invoke-direct {v1, v2}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V
    :L1103
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/MainActivity;->extractTarGz(Ljava/io/InputStream;Ljava/io/File;)V
    # registers=19 ins=3 tries=2
    move-object/from16 v0, v16
    move-object/from16 v1, v18
    new-instance v2, Ljava/io/BufferedInputStream;
    new-instance v3, Ljava/util/zip/GZIPInputStream;
    move-object/from16 v4, v17
    invoke-direct {v3, v4}, Ljava/util/zip/GZIPInputStream;-><init>(Ljava/io/InputStream;)V
    const/high16 v4, #int 0x10000
    invoke-direct {v2, v3, v4}, Ljava/io/BufferedInputStream;-><init>(Ljava/io/InputStream;I)V
    const/16 v3, #512
    new-array v5, v3, [B
    :L22
    invoke-static {v2, v5, v3}, Lcom/palai/prootsmoke/MainActivity;->readFull(Ljava/io/InputStream;[BI)I
    move-result v6
    if-ge v6, v3, :L30
    goto/16 :L592
    :L30
    const/4 v6, #0
    move v7, v6
    :L32
    if-ge v7, v3, :L592
    aget-byte v8, v5, v7
    if-eqz v8, :L584
    const/16 v7, #100
    invoke-static {v5, v6, v7}, Lcom/palai/prootsmoke/MainActivity;->cstr([BII)Ljava/lang/String;
    move-result-object v8
    const/16 v9, #124
    const/16 v10, #12
    invoke-static {v5, v9, v10}, Lcom/palai/prootsmoke/MainActivity;->parseOct([BII)J
    move-result-wide v9
    const/16 v11, #8
    invoke-static {v5, v7, v11}, Lcom/palai/prootsmoke/MainActivity;->parseOct([BII)J
    move-result-wide v11
    const/16 v13, #156
    aget-byte v13, v5, v13
    int-to-char v13, v13
    const/16 v14, #157
    invoke-static {v5, v14, v7}, Lcom/palai/prootsmoke/MainActivity;->cstr([BII)Ljava/lang/String;
    move-result-object v7
    const/16 v14, #345
    const/16 v15, #155
    invoke-static {v5, v14, v15}, Lcom/palai/prootsmoke/MainActivity;->cstr([BII)Ljava/lang/String;
    move-result-object v14
    invoke-virtual {v14}, Ljava/lang/String;->length()I
    move-result v15
    const-string v3, "/"
    if-lez v15, :L106
    new-instance v15, Ljava/lang/StringBuilder;
    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {v15, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v14
    invoke-virtual {v14, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v14
    invoke-virtual {v14, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v8
    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v8
    :L106
    const-string v14, "\"
    invoke-virtual {v8, v14, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;
    move-result-object v8
    :L112
    const-string v14, "./"
    invoke-virtual {v8, v14}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v15
    const/4 v4, #2
    if-eqz v15, :L128
    invoke-virtual {v8, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v8
    const/high16 v4, #int 0x10000
    goto :L112
    :L128
    invoke-virtual {v8, v3}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z
    move-result v15
    const/4 v4, #1
    if-eqz v15, :L146
    invoke-virtual {v8}, Ljava/lang/String;->length()I
    move-result v15
    sub-int/2addr v15, v4
    invoke-virtual {v8, v6, v15}, Ljava/lang/String;->substring(II)Ljava/lang/String;
    move-result-object v8
    const/4 v4, #2
    goto :L128
    :L146
    invoke-virtual {v8}, Ljava/lang/String;->length()I
    move-result v15
    if-nez v15, :L161
    invoke-static {v2, v9, v10}, Lcom/palai/prootsmoke/MainActivity;->skipExactly(Ljava/io/InputStream;J)V
    :L155
    const/16 v3, #512
    const/high16 v4, #int 0x10000
    goto/16 :L22
    :L161
    const-string v15, "UTF-8"
    const/16 v6, #76
    if-eq v13, v6, :L539
    const/16 v6, #75
    if-ne v13, v6, :L173
    goto/16 :L539
    :L173
    const/16 v6, #120
    if-eq v13, v6, :L459
    const/16 v6, #103
    if-ne v13, v6, :L183
    goto/16 :L459
    :L183
    iget-object v6, v0, Lcom/palai/prootsmoke/MainActivity;->pendingName:Ljava/lang/String;
    const/4 v15, #0
    if-eqz v6, :L198
    invoke-virtual {v6}, Ljava/lang/String;->length()I
    move-result v6
    if-lez v6, :L198
    iget-object v8, v0, Lcom/palai/prootsmoke/MainActivity;->pendingName:Ljava/lang/String;
    iput-object v15, v0, Lcom/palai/prootsmoke/MainActivity;->pendingName:Ljava/lang/String;
    :L198
    iget-object v6, v0, Lcom/palai/prootsmoke/MainActivity;->pendingLink:Ljava/lang/String;
    if-eqz v6, :L212
    invoke-virtual {v6}, Ljava/lang/String;->length()I
    move-result v6
    if-lez v6, :L212
    iget-object v7, v0, Lcom/palai/prootsmoke/MainActivity;->pendingLink:Ljava/lang/String;
    iput-object v15, v0, Lcom/palai/prootsmoke/MainActivity;->pendingLink:Ljava/lang/String;
    :L212
    invoke-virtual {v8, v14}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v6
    if-eqz v6, :L224
    const/4 v6, #2
    invoke-virtual {v8, v6}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v8
    goto :L212
    :L224
    invoke-virtual {v8, v3}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z
    move-result v6
    if-eqz v6, :L241
    invoke-virtual {v8}, Ljava/lang/String;->length()I
    move-result v6
    sub-int/2addr v6, v4
    const/4 v14, #0
    invoke-virtual {v8, v14, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;
    move-result-object v8
    goto :L224
    :L241
    invoke-virtual {v8}, Ljava/lang/String;->length()I
    move-result v3
    if-nez v3, :L251
    invoke-static {v2, v9, v10}, Lcom/palai/prootsmoke/MainActivity;->skipExactly(Ljava/io/InputStream;J)V
    goto :L155
    :L251
    new-instance v3, Ljava/io/File;
    invoke-direct {v3, v1, v8}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V
    const/16 v6, #53
    if-ne v13, v6, :L267
    invoke-virtual {v3}, Ljava/io/File;->mkdirs()Z
    :L263
    const/high16 v14, #int 0x10000
    goto/16 :L454
    :L267
    const/16 v6, #50
    if-ne v13, v6, :L314
    invoke-virtual {v3}, Ljava/io/File;->exists()Z
    move-result v6
    if-eqz v6, :L280
    invoke-virtual {v3}, Ljava/io/File;->delete()Z
    :L280
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;
    move-result-object v6
    const/4 v8, #4
    new-array v8, v8, [Ljava/lang/String;
    const-string v11, "ln"
    const/4 v12, #0
    aput-object v11, v8, v12
    const-string v11, "-sf"
    aput-object v11, v8, v4
    const/4 v4, #2
    aput-object v7, v8, v4
    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;
    move-result-object v3
    const/4 v4, #3
    aput-object v3, v8, v4
    invoke-virtual {v6, v8}, Ljava/lang/Runtime;->exec([Ljava/lang/String;)Ljava/lang/Process;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/Process;->waitFor()I
    goto :L263
    :L314
    const/16 v6, #49
    if-ne v13, v6, :L380
    new-instance v6, Ljava/io/File;
    invoke-direct {v6, v1, v7}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V
    invoke-virtual {v3}, Ljava/io/File;->getParentFile()Ljava/io/File;
    move-result-object v7
    if-eqz v7, :L332
    invoke-virtual {v7}, Ljava/io/File;->mkdirs()Z
    :L332
    invoke-virtual {v3}, Ljava/io/File;->exists()Z
    move-result v7
    if-eqz v7, :L341
    invoke-virtual {v3}, Ljava/io/File;->delete()Z
    :L341
    new-instance v7, Ljava/io/FileInputStream;
    invoke-direct {v7, v6}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    new-instance v6, Ljava/io/FileOutputStream;
    invoke-direct {v6, v3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    const/high16 v14, #int 0x10000
    new-array v8, v14, [B
    :L355
    invoke-virtual {v7, v8}, Ljava/io/FileInputStream;->read([B)I
    move-result v11
    if-lez v11, :L366
    const/4 v12, #0
    invoke-virtual {v6, v8, v12, v11}, Ljava/io/FileOutputStream;->write([BII)V
    goto :L355
    :L366
    const/4 v12, #0
    invoke-virtual {v7}, Ljava/io/FileInputStream;->close()V
    invoke-virtual {v6}, Ljava/io/FileOutputStream;->close()V
    invoke-virtual {v3, v4, v12}, Ljava/io/File;->setReadable(ZZ)Z
    invoke-virtual {v3, v4, v12}, Ljava/io/File;->setExecutable(ZZ)Z
    goto :L454
    :L380
    const/high16 v14, #int 0x10000
    invoke-virtual {v3}, Ljava/io/File;->getParentFile()Ljava/io/File;
    move-result-object v6
    if-eqz v6, :L391
    invoke-virtual {v6}, Ljava/io/File;->mkdirs()Z
    :L391
    new-instance v6, Ljava/io/FileOutputStream;
    invoke-direct {v6, v3}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    invoke-static {v2, v6, v9, v10}, Lcom/palai/prootsmoke/MainActivity;->copyN(Ljava/io/InputStream;Ljava/io/OutputStream;J)V
    invoke-virtual {v6}, Ljava/io/FileOutputStream;->close()V
    const/4 v6, #0
    invoke-virtual {v3, v4, v6}, Ljava/io/File;->setReadable(ZZ)Z
    invoke-virtual {v3, v4, v6}, Ljava/io/File;->setWritable(ZZ)Z
    const-wide/16 v6, #73
    and-long/2addr v6, v11
    const-wide/16 v11, #0
    cmp-long v6, v6, v11
    if-nez v6, :L450
    const-string v6, "bin/"
    invoke-virtual {v8, v6}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v6
    if-nez v6, :L450
    const-string v6, ".so"
    invoke-virtual {v8, v6}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z
    move-result v6
    if-nez v6, :L450
    const-string v6, ".so.6"
    invoke-virtual {v8, v6}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z
    move-result v6
    if-nez v6, :L450
    const-string v6, "app/"
    invoke-virtual {v8, v6}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v6
    if-eqz v6, :L454
    :L450
    const/4 v6, #0
    invoke-virtual {v3, v4, v6}, Ljava/io/File;->setExecutable(ZZ)Z
    :L454
    invoke-static {v2, v9, v10}, Lcom/palai/prootsmoke/MainActivity;->skipPad(Ljava/io/InputStream;J)V
    goto/16 :L579
    :L459
    const/4 v6, #0
    const/high16 v14, #int 0x10000
    long-to-int v3, v9
    new-array v4, v3, [B
    invoke-static {v2, v4, v3}, Lcom/palai/prootsmoke/MainActivity;->readFull(Ljava/io/InputStream;[BI)I
    new-instance v7, Ljava/lang/String;
    invoke-direct {v7, v4, v6, v3, v15}, Ljava/lang/String;-><init>([BIILjava/lang/String;)V
    const-string v3, "
"
    invoke-virtual {v7, v3}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    move-result-object v3
    array-length v4, v3
    const/4 v6, #0
    :L481
    if-ge v6, v4, :L535
    aget-object v7, v3, v6
    const/16 v8, #32
    invoke-virtual {v7, v8}, Ljava/lang/String;->indexOf(I)I
    move-result v8
    if-gtz v8, :L494
    goto :L532
    :L494
    add-int/lit8 v8, v8, #1
    invoke-virtual {v7, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v7
    const-string v8, "path="
    invoke-virtual {v7, v8}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v8
    if-eqz v8, :L516
    const/4 v8, #5
    invoke-virtual {v7, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v7
    iput-object v7, v0, Lcom/palai/prootsmoke/MainActivity;->pendingName:Ljava/lang/String;
    goto :L532
    :L516
    const-string v8, "linkpath="
    invoke-virtual {v7, v8}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v8
    if-eqz v8, :L532
    const/16 v8, #9
    invoke-virtual {v7, v8}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v7
    iput-object v7, v0, Lcom/palai/prootsmoke/MainActivity;->pendingLink:Ljava/lang/String;
    :L532
    add-int/lit8 v6, v6, #1
    goto :L481
    :L535
    invoke-static {v2, v9, v10}, Lcom/palai/prootsmoke/MainActivity;->skipPad(Ljava/io/InputStream;J)V
    goto :L579
    :L539
    const/high16 v14, #int 0x10000
    long-to-int v3, v9
    new-array v4, v3, [B
    invoke-static {v2, v4, v3}, Lcom/palai/prootsmoke/MainActivity;->readFull(Ljava/io/InputStream;[BI)I
    new-instance v6, Ljava/lang/String;
    const/4 v8, #0
    invoke-direct {v6, v4, v8, v3, v15}, Ljava/lang/String;-><init>([BIILjava/lang/String;)V
    invoke-virtual {v6, v8}, Ljava/lang/String;->indexOf(I)I
    move-result v3
    if-ltz v3, :L563
    invoke-virtual {v6, v8, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;
    move-result-object v6
    :L563
    invoke-virtual {v6}, Ljava/lang/String;->trim()Ljava/lang/String;
    move-result-object v3
    const/16 v4, #76
    if-ne v13, v4, :L574
    iput-object v3, v0, Lcom/palai/prootsmoke/MainActivity;->pendingName:Ljava/lang/String;
    goto :L576
    :L574
    iput-object v3, v0, Lcom/palai/prootsmoke/MainActivity;->pendingLink:Ljava/lang/String;
    :L576
    invoke-static {v2, v9, v10}, Lcom/palai/prootsmoke/MainActivity;->skipPad(Ljava/io/InputStream;J)V
    :L579
    move v4, v14
    const/16 v3, #512
    goto/16 :L22
    :L584
    move v14, v4
    move v8, v6
    add-int/lit8 v7, v7, #1
    const/16 v3, #512
    goto/16 :L32
    :L592
    invoke-virtual {v2}, Ljava/io/BufferedInputStream;->close()V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/MainActivity;->fixPerms(Ljava/io/File;)V
    # registers=5 ins=2 tries=0
    invoke-virtual {v4}, Ljava/io/File;->isDirectory()Z
    move-result v0
    const/4 v1, #0
    if-eqz v0, :L24
    invoke-virtual {v4}, Ljava/io/File;->listFiles()[Ljava/io/File;
    move-result-object v4
    if-eqz v4, :L83
    array-length v0, v4
    :L14
    if-ge v1, v0, :L83
    aget-object v2, v4, v1
    invoke-direct {v3, v2}, Lcom/palai/prootsmoke/MainActivity;->fixPerms(Ljava/io/File;)V
    add-int/lit8 v1, v1, #1
    goto :L14
    :L24
    invoke-virtual {v4}, Ljava/io/File;->getName()Ljava/lang/String;
    move-result-object v0
    const-string v2, "node"
    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, :L76
    const-string v2, "busybox"
    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-nez v2, :L76
    const-string v2, ".so"
    invoke-virtual {v0, v2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z
    move-result v2
    if-nez v2, :L76
    const-string v2, ".so.6"
    invoke-virtual {v0, v2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z
    move-result v2
    if-nez v2, :L76
    const-string v2, ".sh"
    invoke-virtual {v0, v2}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z
    move-result v2
    if-nez v2, :L76
    const-string v2, "run-core.mjs"
    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v0
    if-eqz v0, :L83
    :L76
    const/4 v0, #1
    invoke-virtual {v4, v0, v1}, Ljava/io/File;->setExecutable(ZZ)Z
    invoke-virtual {v4, v0, v1}, Ljava/io/File;->setReadable(ZZ)Z
    :L83
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/MainActivity;->loadPetWithRetry(I)V
    # registers=6 ins=2 tries=0
    iget-object v0, v4, Lcom/palai/prootsmoke/MainActivity;->web:Landroid/webkit/WebView;
    if-nez v0, :L5
    return-void 
    :L5
    iput v5, v4, Lcom/palai/prootsmoke/MainActivity;->petRetry:I
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[PET] load pet page (attempt "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    add-int/lit8 v1, v5, #1
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v1, "/20) ..."
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-direct {v4, v0}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    new-instance v0, Lcom/palai/prootsmoke/MainActivity$19;
    invoke-direct {v0, v4, v5}, Lcom/palai/prootsmoke/MainActivity$19;-><init>(Lcom/palai/prootsmoke/MainActivity;I)V
    invoke-virtual {v4, v0}, Lcom/palai/prootsmoke/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    new-instance v0, Landroid/os/Handler;
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;
    move-result-object v1
    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
    new-instance v1, Lcom/palai/prootsmoke/MainActivity$20;
    invoke-direct {v1, v4, v5}, Lcom/palai/prootsmoke/MainActivity$20;-><init>(Lcom/palai/prootsmoke/MainActivity;I)V
    const-wide/16 v2, #2500
    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    # registers=5 ins=2 tries=1
    const-string v0, "ProotSmoke"
    invoke-static {v0, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    const/4 v0, #0
    invoke-virtual {v3, v0}, Lcom/palai/prootsmoke/MainActivity;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;
    move-result-object v0
    if-nez v0, :L16
    invoke-virtual {v3}, Lcom/palai/prootsmoke/MainActivity;->getFilesDir()Ljava/io/File;
    move-result-object v0
    :L16
    new-instance v1, Ljava/io/File;
    const-string v2, "coop-run.log"
    invoke-direct {v1, v0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V
    new-instance v0, Ljava/io/FileOutputStream;
    const/4 v2, #1
    invoke-direct {v0, v1, v2}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;Z)V
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    const-string v2, "
"
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    const-string v2, "UTF-8"
    invoke-virtual {v1, v2}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B
    move-result-object v1
    invoke-virtual {v0, v1}, Ljava/io/FileOutputStream;->write([B)V
    invoke-virtual {v0}, Ljava/io/FileOutputStream;->close()V
    new-instance v0, Lcom/palai/prootsmoke/MainActivity$2;
    invoke-direct {v0, v3, v4}, Lcom/palai/prootsmoke/MainActivity$2;-><init>(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    invoke-virtual {v3, v0}, Lcom/palai/prootsmoke/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/MainActivity;->openSenseSettings()V
    # registers=6 ins=1 tries=0
    invoke-direct {v5}, Lcom/palai/prootsmoke/MainActivity;->senseStatus()[Ljava/lang/String;
    move-result-object v0
    const/4 v1, #0
    aget-object v1, v0, v1
    const/4 v2, #1
    aget-object v0, v0, v2
    new-instance v2, Ljava/lang/StringBuilder;
    const-string v3, "[SENSE] usage="
    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v2
    const-string v3, " notif="
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    invoke-direct {v5, v2}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    new-instance v2, Landroid/app/AlertDialog$Builder;
    invoke-direct {v2, v5}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V
    const-string v3, "手机感知授权"
    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;
    new-instance v3, Ljava/lang/StringBuilder;
    const-string v4, "桌宠要「感知手机」，需要两个独立开关（都不涉及无障碍）：

① 使用情况访问："
    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    const-string v3, "
    → 让桌宠知道你在用哪个 App

② 通知使用权："
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v1, "
    → 让桌宠知道你收到了什么通知

点下面按钮逐个打开，在系统设置里找到本应用（Coopanion）打开开关，然后返回。"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v2, v0}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;
    new-instance v0, Lcom/palai/prootsmoke/MainActivity$33;
    invoke-direct {v0, v5}, Lcom/palai/prootsmoke/MainActivity$33;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    const-string v1, "① 使用情况访问"
    invoke-virtual {v2, v1, v0}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    new-instance v0, Lcom/palai/prootsmoke/MainActivity$34;
    invoke-direct {v0, v5}, Lcom/palai/prootsmoke/MainActivity$34;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    const-string v1, "② 通知使用权"
    invoke-virtual {v2, v1, v0}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    const-string v0, "关闭"
    const/4 v1, #0
    invoke-virtual {v2, v0, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    new-instance v0, Lcom/palai/prootsmoke/MainActivity$35;
    invoke-direct {v0, v5, v2}, Lcom/palai/prootsmoke/MainActivity$35;-><init>(Lcom/palai/prootsmoke/MainActivity;Landroid/app/AlertDialog$Builder;)V
    invoke-virtual {v5, v0}, Lcom/palai/prootsmoke/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    return-void 
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/MainActivity;->parseOct([BII)J
    # registers=8 ins=3 tries=0
    const-wide/16 v0, #0
    move v2, v6
    :L3
    add-int v3, v6, v7
    if-ge v2, v3, :L36
    aget-byte v3, v5, v2
    and-int/lit16 v51, #255
    if-eqz v3, :L36
    const/16 v4, #32
    if-ne v3, v4, :L18
    goto :L36
    :L18
    const/16 v4, #48
    if-lt v3, v4, :L33
    const/16 v4, #55
    if-le v3, v4, :L27
    goto :L33
    :L27
    const/4 v4, #3
    shl-long/2addr v0, v4
    add-int/lit8 v3, v3, #-48
    int-to-long v3, v3
    add-long/2addr v0, v3
    :L33
    add-int/lit8 v2, v2, #1
    goto :L3
    :L36
    return-wide v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/MainActivity;->pushAlphaToService(F)V
    # registers=4 ins=2 tries=1
    const-string v0, "coopanion"
    const/4 v1, #0
    invoke-virtual {v2, v0, v1}, Lcom/palai/prootsmoke/MainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    const-string v1, "pet_alpha"
    invoke-interface {v0, v1, v3}, Landroid/content/SharedPreferences$Editor;->putFloat(Ljava/lang/String;F)Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    new-instance v0, Landroid/content/Intent;
    const-class v1, Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0, v2, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    const-string v1, "com.palai.prootsmoke.SET_ALPHA"
    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;
    const-string v1, "alpha"
    invoke-virtual {v0, v1, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;F)Landroid/content/Intent;
    invoke-virtual {v2, v0}, Lcom/palai/prootsmoke/MainActivity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    return-void 
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/MainActivity;->readFull(Ljava/io/InputStream;[BI)I
    # registers=5 ins=3 tries=0
    const/4 v0, #0
    :L1
    if-ge v0, v4, :L14
    sub-int v1, v4, v0
    invoke-virtual {v2, v3, v0, v1}, Ljava/io/InputStream;->read([BII)I
    move-result v1
    if-gez v1, :L12
    goto :L14
    :L12
    add-int/2addr v0, v1
    goto :L1
    :L14
    return v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/MainActivity;->requestOverlay()V
    # registers=5 ins=1 tries=1
    const-string v0, "package:"
    new-instance v1, Landroid/content/Intent;
    const-string v2, "android.settings.action.MANAGE_OVERLAY_PERMISSION"
    new-instance v3, Ljava/lang/StringBuilder;
    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v4}, Lcom/palai/prootsmoke/MainActivity;->getPackageName()Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v0
    invoke-direct {v1, v2, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V
    const/16 v0, #10086
    invoke-virtual {v4, v1, v0}, Lcom/palai/prootsmoke/MainActivity;->startActivityForResult(Landroid/content/Intent;I)V
    const-string v0, "状态: 请先允许「显示在其他应用上层」，回来再点一次"
    invoke-direct {v4, v0}, Lcom/palai/prootsmoke/MainActivity;->setStatus(Ljava/lang/String;)V
    goto :L60
    move-exception v0
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "[PET] 权限页打不开: "
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-direct {v4, v0}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    :L60
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/MainActivity;->senseStatus()[Ljava/lang/String;
    # registers=7 ins=1 tries=2
    invoke-virtual {v6}, Lcom/palai/prootsmoke/MainActivity;->getApplicationContext()Landroid/content/Context;
    move-result-object v0
    invoke-static {v0}, Lcom/palai/prootsmoke/SenseBridge;->get(Landroid/content/Context;)Lcom/palai/prootsmoke/SenseBridge;
    move-result-object v0
    goto :L10
    const/4 v0, #0
    :L10
    const/4 v1, #1
    const/4 v2, #0
    const-class v3, Lcom/palai/prootsmoke/SenseBridge;
    const-string v4, "hasUsageAccess"
    new-array v5, v2, [Ljava/lang/Class;
    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    move-result-object v3
    invoke-virtual {v3, v1}, Ljava/lang/reflect/Method;->setAccessible(Z)V
    new-array v4, v2, [Ljava/lang/Object;
    invoke-virtual {v3, v0, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    move-result-object v0
    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v0
    goto :L38
    const-string v0, "未知"
    :L38
    invoke-virtual {v6}, Lcom/palai/prootsmoke/MainActivity;->getApplicationContext()Landroid/content/Context;
    move-result-object v3
    invoke-static {v3}, Lcom/palai/prootsmoke/NotifListenerService;->isEnabled(Landroid/content/Context;)Z
    move-result v3
    invoke-static {v3}, Ljava/lang/String;->valueOf(Z)Ljava/lang/String;
    move-result-object v3
    const/4 v4, #2
    new-array v4, v4, [Ljava/lang/String;
    aput-object v0, v4, v2
    aput-object v3, v4, v1
    return-object v4
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/MainActivity;->setStatus(Ljava/lang/String;)V
    # registers=3 ins=2 tries=0
    new-instance v0, Lcom/palai/prootsmoke/MainActivity$1;
    invoke-direct {v0, v1, v2}, Lcom/palai/prootsmoke/MainActivity$1;-><init>(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    invoke-virtual {v1, v0}, Lcom/palai/prootsmoke/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/MainActivity;->showAlphaDialog()V
    # registers=9 ins=1 tries=0
    const-string v0, "coopanion"
    const/4 v1, #0
    invoke-virtual {v8, v0, v1}, Lcom/palai/prootsmoke/MainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0
    const-string v1, "pet_alpha"
    const/high16 v2, #int 0x3f800000
    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getFloat(Ljava/lang/String;F)F
    move-result v1
    new-instance v2, Landroid/widget/SeekBar;
    invoke-direct {v2, v8}, Landroid/widget/SeekBar;-><init>(Landroid/content/Context;)V
    const/16 v3, #90
    invoke-virtual {v2, v3}, Landroid/widget/SeekBar;->setMax(I)V
    const v3, #1036831949
    sub-float v3, v1, v3
    const/high16 v4, #int 0x42c80000
    mul-float/2addr v3, v4
    invoke-static {v3}, Ljava/lang/Math;->round(F)I
    move-result v3
    invoke-virtual {v2, v3}, Landroid/widget/SeekBar;->setProgress(I)V
    new-instance v3, Landroid/widget/TextView;
    invoke-direct {v3, v8}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V
    const/16 v5, #30
    const/16 v6, #10
    const/16 v7, #40
    invoke-virtual {v3, v7, v5, v7, v6}, Landroid/widget/TextView;->setPadding(IIII)V
    new-instance v5, Ljava/lang/StringBuilder;
    const-string v6, "桌宠透明度："
    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    mul-float/2addr v1, v4
    invoke-static {v1}, Ljava/lang/Math;->round(F)I
    move-result v1
    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v1
    const-string v4, "%"
    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v3, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    new-instance v1, Landroid/widget/LinearLayout;
    invoke-direct {v1, v8}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V
    const/4 v4, #1
    invoke-virtual {v1, v4}, Landroid/widget/LinearLayout;->setOrientation(I)V
    invoke-virtual {v1, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    new-instance v4, Lcom/palai/prootsmoke/MainActivity$31;
    invoke-direct {v4, v8, v3}, Lcom/palai/prootsmoke/MainActivity$31;-><init>(Lcom/palai/prootsmoke/MainActivity;Landroid/widget/TextView;)V
    invoke-virtual {v2, v4}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V
    new-instance v2, Landroid/app/AlertDialog$Builder;
    invoke-direct {v2, v8}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V
    const-string v3, "桌宠透明度"
    invoke-virtual {v2, v3}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;
    move-result-object v2
    invoke-virtual {v2, v1}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;
    move-result-object v1
    const-string v2, "确定"
    const/4 v3, #0
    invoke-virtual {v1, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    move-result-object v1
    new-instance v2, Lcom/palai/prootsmoke/MainActivity$32;
    invoke-direct {v2, v8, v0}, Lcom/palai/prootsmoke/MainActivity$32;-><init>(Lcom/palai/prootsmoke/MainActivity;Landroid/content/SharedPreferences;)V
    const-string v0, "恢复 100%"
    invoke-virtual {v1, v0, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    move-result-object v0
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/MainActivity;->showGuide(I)V
    # registers=7 ins=2 tries=0
    new-instance v0, Landroid/app/AlertDialog$Builder;
    invoke-direct {v0, v5}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V
    const/4 v1, #0
    if-nez v6, :L35
    const-string v6, "欢迎使用 Coopanion（1/5）"
    invoke-virtual {v0, v6}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;
    const-string v6, "这是一个「住在你手机里」的 AI 桌宠。

接下来 4 步，我带你把该开的都开好，大约 2 分钟：

① 启动内核（自动）
② 把桌宠召唤到手机桌面
③ 给桌宠开「感知手机」的两个开关
④ 让桌宠学会说话（模型 + Key）

随时可以重新点顶部「新手引导」再看一遍。"
    invoke-virtual {v0, v6}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;
    new-instance v6, Lcom/palai/prootsmoke/MainActivity$21;
    invoke-direct {v6, v5}, Lcom/palai/prootsmoke/MainActivity$21;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    const-string v2, "开始"
    invoke-virtual {v0, v2, v6}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    const-string v6, "跳过"
    invoke-virtual {v0, v6, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    goto/16 :L207
    :L35
    const/4 v2, #1
    const-string v3, "下一步"
    if-ne v6, v2, :L70
    const-string v6, "第 1 步：启动内核（2/5）"
    invoke-virtual {v0, v6}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;
    const-string v6, "App 会自动在后台启动内核（Coopanion 的大脑）。

· 屏幕下方会滚动显示日志
· 看到「core已启动」就算好了
· 如果卡住了，点顶部「重试启动」

注意：内核在后台跑，请保持 App 不要被系统杀掉
（建议在最近任务里把本 App 加锁 / 允许后台运行）。"
    invoke-virtual {v0, v6}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;
    new-instance v6, Lcom/palai/prootsmoke/MainActivity$22;
    invoke-direct {v6, v5}, Lcom/palai/prootsmoke/MainActivity$22;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    invoke-virtual {v0, v3, v6}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    new-instance v6, Lcom/palai/prootsmoke/MainActivity$23;
    invoke-direct {v6, v5}, Lcom/palai/prootsmoke/MainActivity$23;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    const-string v1, "重试启动"
    invoke-virtual {v0, v1, v6}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    goto/16 :L207
    :L70
    const/4 v4, #2
    if-ne v6, v4, :L102
    const-string v6, "第 2 步：把桌宠召唤到桌面（3/5）"
    invoke-virtual {v0, v6}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;
    const-string v6, "桌宠有两种样子：

【App 内】点顶部「看桌宠」，就在这个页面里显示。

【悬浮在桌面上】点顶部「桌宠悬浮窗」——
它就会飘在所有 App 上面，像一个小生命趴在桌面。

· 第一次点会跳去系统设置，请打开「显示在其他应用上层 / 悬浮窗」权限
· 打开后回到 App，再点一次「桌宠悬浮窗」即可
· 再点一次是关闭"
    invoke-virtual {v0, v6}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;
    new-instance v6, Lcom/palai/prootsmoke/MainActivity$24;
    invoke-direct {v6, v5}, Lcom/palai/prootsmoke/MainActivity$24;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    const-string v1, "现在就召唤"
    invoke-virtual {v0, v1, v6}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    new-instance v6, Lcom/palai/prootsmoke/MainActivity$25;
    invoke-direct {v6, v5}, Lcom/palai/prootsmoke/MainActivity$25;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    invoke-virtual {v0, v3, v6}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    goto :L207
    :L102
    const/4 v4, #3
    if-ne v6, v4, :L182
    invoke-direct {v5}, Lcom/palai/prootsmoke/MainActivity;->senseStatus()[Ljava/lang/String;
    move-result-object v6
    const-string v1, "第 3 步：让桌宠感知手机（4/5）"
    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v4, "桌宠想知道「你在用哪个 App」「谁给你发消息了」，
需要你在系统里打开两个开关（都跟无障碍无关，可以放心开）：

① 使用情况访问 —— 当前："
    invoke-direct {v1, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    const/4 v4, #0
    aget-object v4, v6, v4
    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    const-string v4, "
   作用：知道你在用微信 / 在看视频 / 在打游戏

② 通知使用权 —— 当前："
    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    aget-object v6, v6, v2
    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v6
    const-string v1, "
   作用：知道谁给你发了消息

点下面按钮会跳到系统设置，找到「Coopanion」打开开关，再返回本页。"
    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v6
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v6
    invoke-virtual {v0, v6}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;
    new-instance v6, Lcom/palai/prootsmoke/MainActivity$26;
    invoke-direct {v6, v5}, Lcom/palai/prootsmoke/MainActivity$26;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    const-string v1, "① 使用情况访问"
    invoke-virtual {v0, v1, v6}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    new-instance v6, Lcom/palai/prootsmoke/MainActivity$27;
    invoke-direct {v6, v5}, Lcom/palai/prootsmoke/MainActivity$27;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    const-string v1, "② 通知使用权"
    invoke-virtual {v0, v1, v6}, Landroid/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    new-instance v6, Lcom/palai/prootsmoke/MainActivity$28;
    invoke-direct {v6, v5}, Lcom/palai/prootsmoke/MainActivity$28;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    invoke-virtual {v0, v3, v6}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    goto :L207
    :L182
    const-string v6, "第 4 步：让桌宠开口说话（5/5）"
    invoke-virtual {v0, v6}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;
    const-string v6, "桌宠要说话，得先接上一家大模型：

1. 打开「控制台」（顶部按钮）
2. 去「模型供应商」页，选一家（DeepSeek / 通义 / Kimi /
   GLM / 豆包 / 千帆 / MiniMax / 阶跃 / OpenRouter）
3. 把你申请到的 API Key 贴进去，保存

小提示：第一次使用时，桌宠自己也会冒泡问你要 Key，
跟着气泡点就行 —— 那是官方自带的引导。

全部就绪后，桌宠就会「活」过来啦！"
    invoke-virtual {v0, v6}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;
    new-instance v6, Lcom/palai/prootsmoke/MainActivity$29;
    invoke-direct {v6, v5}, Lcom/palai/prootsmoke/MainActivity$29;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    const-string v2, "打开控制台"
    invoke-virtual {v0, v2, v6}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    const-string v6, "完成"
    invoke-virtual {v0, v6, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    :L207
    new-instance v6, Lcom/palai/prootsmoke/MainActivity$30;
    invoke-direct {v6, v5, v0}, Lcom/palai/prootsmoke/MainActivity$30;-><init>(Lcom/palai/prootsmoke/MainActivity;Landroid/app/AlertDialog$Builder;)V
    invoke-virtual {v5, v6}, Lcom/palai/prootsmoke/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    return-void 
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/MainActivity;->skipExactly(Ljava/io/InputStream;J)V
    # registers=9 ins=3 tries=0
    move-wide v0, v7
    :L1
    const-wide/16 v2, #0
    cmp-long v4, v0, v2
    if-lez v4, :L26
    invoke-virtual {v6, v0, v1}, Ljava/io/InputStream;->skip(J)J
    move-result-wide v4
    cmp-long v2, v4, v2
    if-gtz v2, :L24
    invoke-virtual {v6}, Ljava/io/InputStream;->read()I
    move-result v2
    if-gez v2, :L22
    goto :L26
    :L22
    const-wide/16 v4, #1
    :L24
    sub-long/2addr v0, v4
    goto :L1
    :L26
    invoke-static {v6, v7, v8}, Lcom/palai/prootsmoke/MainActivity;->skipPad(Ljava/io/InputStream;J)V
    return-void 
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/MainActivity;->skipPad(Ljava/io/InputStream;J)V
    # registers=7 ins=3 tries=0
    const-wide/16 v0, #512
    rem-long/2addr v5, v0
    sub-long v5, v0, v5
    rem-long/2addr v5, v0
    :L6
    const-wide/16 v0, #0
    cmp-long v2, v5, v0
    if-lez v2, :L23
    invoke-virtual {v4, v5, v6}, Ljava/io/InputStream;->skip(J)J
    move-result-wide v2
    cmp-long v0, v2, v0
    if-gtz v0, :L21
    goto :L23
    :L21
    sub-long/2addr v5, v2
    goto :L6
    :L23
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/MainActivity;->startPetWindow()V
    # registers=4 ins=1 tries=1
    new-instance v0, Landroid/content/Intent;
    const-class v1, Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0, v3, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v2, #26
    if-lt v1, v2, :L17
    invoke-virtual {v3, v0}, Lcom/palai/prootsmoke/MainActivity;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;
    goto :L20
    :L17
    invoke-virtual {v3, v0}, Lcom/palai/prootsmoke/MainActivity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :L20
    sget-object v0, Lcom/palai/prootsmoke/MainActivity;->petWinOn:Ljava/util/concurrent/atomic/AtomicBoolean;
    const/4 v1, #1
    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V
    const-string v0, "coopanion"
    const/4 v2, #0
    invoke-virtual {v3, v0, v2}, Lcom/palai/prootsmoke/MainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    const-string v2, "pet_window_wanted"
    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    invoke-direct {v3, v1}, Lcom/palai/prootsmoke/MainActivity;->syncPetSw(Z)V
    const-string v0, "[PET] 桌宠悬浮窗已启动 -> http://127.0.0.1:7797/pet"
    invoke-direct {v3, v0}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    const-string v0, "状态: 桌宠已上桌面（可拖动）"
    invoke-direct {v3, v0}, Lcom/palai/prootsmoke/MainActivity;->setStatus(Ljava/lang/String;)V
    goto :L79
    move-exception v0
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "[PET] 启动失败: "
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-direct {v3, v0}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    :L79
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/MainActivity;->startPetWindowWhenReady()V
    # registers=3 ins=1 tries=0
    new-instance v0, Ljava/lang/Thread;
    new-instance v1, Lcom/palai/prootsmoke/MainActivity$38;
    invoke-direct {v1, v2}, Lcom/palai/prootsmoke/MainActivity$38;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/MainActivity;->syncPetSw(Z)V
    # registers=2 ins=2 tries=0
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/MainActivity;->togglePetWindow()V
    # registers=4 ins=1 tries=0
    sget-object v0, Lcom/palai/prootsmoke/MainActivity;->petWinOn:Ljava/util/concurrent/atomic/AtomicBoolean;
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z
    move-result v1
    if-eqz v1, :L55
    new-instance v1, Landroid/content/Intent;
    const-class v2, Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v1, v3, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    invoke-virtual {v3, v1}, Lcom/palai/prootsmoke/MainActivity;->stopService(Landroid/content/Intent;)Z
    const/4 v1, #0
    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V
    invoke-direct {v3, v1}, Lcom/palai/prootsmoke/MainActivity;->syncPetSw(Z)V
    const-string v0, "coopanion"
    invoke-virtual {v3, v0, v1}, Lcom/palai/prootsmoke/MainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    const-string v2, "pet_window_wanted"
    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    const-string v0, "[PET] 悬浮窗已关闭"
    invoke-direct {v3, v0}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    const-string v0, "状态: 桌宠悬浮窗已关闭"
    invoke-direct {v3, v0}, Lcom/palai/prootsmoke/MainActivity;->setStatus(Ljava/lang/String;)V
    return-void 
    :L55
    invoke-direct {v3}, Lcom/palai/prootsmoke/MainActivity;->canDrawOverlays()Z
    move-result v0
    if-nez v0, :L106
    const-string v0, "[PET] 缺少悬浮窗权限，去申请"
    invoke-direct {v3, v0}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    new-instance v0, Landroid/app/AlertDialog$Builder;
    invoke-direct {v0, v3}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V
    const-string v1, "需要「悬浮窗」权限"
    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;
    const-string v1, "桌宠要飘在手机桌面上，需要你允许它「显示在其他应用上层」。

点「去允许」→ 在系统设置里找到 Coopanion → 打开开关 → 返回 App。

返回后会自动把桌宠召唤出来，不用再点一次。"
    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;
    new-instance v1, Lcom/palai/prootsmoke/MainActivity$36;
    invoke-direct {v1, v3}, Lcom/palai/prootsmoke/MainActivity$36;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    const-string v2, "去允许"
    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    const-string v1, "取消"
    const/4 v2, #0
    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
    new-instance v1, Lcom/palai/prootsmoke/MainActivity$37;
    invoke-direct {v1, v3, v0}, Lcom/palai/prootsmoke/MainActivity$37;-><init>(Lcom/palai/prootsmoke/MainActivity;Landroid/app/AlertDialog$Builder;)V
    invoke-virtual {v3, v1}, Lcom/palai/prootsmoke/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    return-void 
    :L106
    invoke-direct {v3}, Lcom/palai/prootsmoke/MainActivity;->startPetWindow()V
    return-void 
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/MainActivity;->waitPortOpen(Ljava/lang/String;II)Z
    # registers=7 ins=3 tries=5
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v0
    int-to-long v2, v6
    add-long/2addr v0, v2
    :L6
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v2
    cmp-long v6, v2, v0
    if-gez v6, :L47
    const/4 v6, #0
    new-instance v2, Ljava/net/Socket;
    invoke-direct {v2}, Ljava/net/Socket;-><init>()V
    new-instance v6, Ljava/net/InetSocketAddress;
    invoke-direct {v6, v4, v5}, Ljava/net/InetSocketAddress;-><init>(Ljava/lang/String;I)V
    const/16 v3, #1200
    invoke-virtual {v2, v6, v3}, Ljava/net/Socket;->connect(Ljava/net/SocketAddress;I)V
    invoke-virtual {v2}, Ljava/net/Socket;->close()V
    const/4 v4, #1
    return v4
    move-object v6, v2
    const-wide/16 v2, #700
    invoke-static {v2, v3}, Ljava/lang/Thread;->sleep(J)V
    if-eqz v6, :L6
    invoke-virtual {v6}, Ljava/net/Socket;->close()V
    goto :L6
    :L47
    const/4 v4, #0
    return v4
.end method

# virtual access=0x4
.method protected Lcom/palai/prootsmoke/MainActivity;->onActivityResult(IILandroid/content/Intent;)V
    # registers=4 ins=4 tries=0
    invoke-super {v0, v1, v2, v3}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V
    const/16 v2, #10086
    if-ne v1, v2, :L21
    invoke-direct {v0}, Lcom/palai/prootsmoke/MainActivity;->canDrawOverlays()Z
    move-result v1
    if-eqz v1, :L21
    const-string v1, "[PET] 权限已授予，自动开启悬浮窗"
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    invoke-direct {v0}, Lcom/palai/prootsmoke/MainActivity;->startPetWindow()V
    :L21
    return-void 
.end method

# virtual access=0x4
.method protected Lcom/palai/prootsmoke/MainActivity;->onCreate(Landroid/os/Bundle;)V
    # registers=8 ins=2 tries=4
    invoke-super {v6, v7}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V
    invoke-static {v6}, Lcom/palai/prootsmoke/AppLog;->init(Landroid/content/Context;)V
    const-string v7, "[BOOT] ===== MainActivity onCreate ====="
    invoke-static {v7}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    new-instance v7, Landroid/widget/LinearLayout;
    invoke-direct {v7, v6}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V
    iput-object v7, v6, Lcom/palai/prootsmoke/MainActivity;->root:Landroid/widget/LinearLayout;
    const/4 v0, #1
    invoke-virtual {v7, v0}, Landroid/widget/LinearLayout;->setOrientation(I)V
    const/4 v7, #0
    invoke-virtual {v6}, Lcom/palai/prootsmoke/MainActivity;->getResources()Landroid/content/res/Resources;
    move-result-object v1
    const-string v2, "status_bar_height"
    const-string v3, "dimen"
    const-string v4, "android"
    invoke-virtual {v1, v2, v3, v4}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I
    move-result v1
    if-lez v1, :L48
    invoke-virtual {v6}, Lcom/palai/prootsmoke/MainActivity;->getResources()Landroid/content/res/Resources;
    move-result-object v2
    invoke-virtual {v2, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I
    move-result v1
    goto :L49
    :L48
    move v1, v7
    :L49
    iget-object v2, v6, Lcom/palai/prootsmoke/MainActivity;->root:Landroid/widget/LinearLayout;
    invoke-virtual {v2, v7, v1, v7, v7}, Landroid/widget/LinearLayout;->setPadding(IIII)V
    new-instance v1, Landroid/widget/HorizontalScrollView;
    invoke-direct {v1, v6}, Landroid/widget/HorizontalScrollView;-><init>(Landroid/content/Context;)V
    invoke-virtual {v1, v7}, Landroid/widget/HorizontalScrollView;->setHorizontalScrollBarEnabled(Z)V
    new-instance v2, Landroid/widget/LinearLayout;
    invoke-direct {v2, v6}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V
    invoke-virtual {v2, v7}, Landroid/widget/LinearLayout;->setOrientation(I)V
    invoke-virtual {v1, v2}, Landroid/widget/HorizontalScrollView;->addView(Landroid/view/View;)V
    new-instance v3, Landroid/widget/Button;
    invoke-direct {v3, v6}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V
    const-string v4, "新手引导"
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V
    new-instance v4, Lcom/palai/prootsmoke/MainActivity$3;
    invoke-direct {v4, v6}, Lcom/palai/prootsmoke/MainActivity$3;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    new-instance v3, Landroid/widget/Button;
    invoke-direct {v3, v6}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V
    const-string v4, "重试启动"
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V
    new-instance v4, Lcom/palai/prootsmoke/MainActivity$4;
    invoke-direct {v4, v6}, Lcom/palai/prootsmoke/MainActivity$4;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    new-instance v3, Landroid/widget/Button;
    invoke-direct {v3, v6}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V
    const-string v4, "看桌宠"
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V
    new-instance v4, Lcom/palai/prootsmoke/MainActivity$5;
    invoke-direct {v4, v6}, Lcom/palai/prootsmoke/MainActivity$5;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    new-instance v3, Landroid/widget/Button;
    invoke-direct {v3, v6}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V
    const-string v4, "全屏桌宠"
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V
    new-instance v4, Lcom/palai/prootsmoke/MainActivity$6;
    invoke-direct {v4, v6}, Lcom/palai/prootsmoke/MainActivity$6;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    new-instance v3, Landroid/widget/Button;
    invoke-direct {v3, v6}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V
    const-string v4, "控制台"
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V
    new-instance v4, Lcom/palai/prootsmoke/MainActivity$7;
    invoke-direct {v4, v6}, Lcom/palai/prootsmoke/MainActivity$7;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    new-instance v3, Landroid/widget/Button;
    invoke-direct {v3, v6}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V
    const-string v4, "手机感知"
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V
    new-instance v4, Lcom/palai/prootsmoke/MainActivity$8;
    invoke-direct {v4, v6}, Lcom/palai/prootsmoke/MainActivity$8;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    new-instance v3, Landroid/widget/Button;
    invoke-direct {v3, v6}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V
    const-string v4, "透明度"
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V
    new-instance v4, Lcom/palai/prootsmoke/MainActivity$9;
    invoke-direct {v4, v6}, Lcom/palai/prootsmoke/MainActivity$9;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    new-instance v3, Landroid/widget/Button;
    invoke-direct {v3, v6}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V
    const-string v4, "日志"
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V
    new-instance v4, Lcom/palai/prootsmoke/MainActivity$10;
    invoke-direct {v4, v6}, Lcom/palai/prootsmoke/MainActivity$10;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    invoke-virtual {v3, v4}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    new-instance v4, Landroid/widget/Button;
    invoke-direct {v4, v6}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V
    const-string v5, "修复"
    invoke-virtual {v4, v5}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V
    new-instance v5, Lcom/palai/prootsmoke/MainActivity$11;
    invoke-direct {v5, v6}, Lcom/palai/prootsmoke/MainActivity$11;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    invoke-virtual {v4, v5}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    invoke-virtual {v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    iget-object v2, v6, Lcom/palai/prootsmoke/MainActivity;->root:Landroid/widget/LinearLayout;
    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    new-instance v1, Landroid/widget/TextView;
    invoke-direct {v1, v6}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V
    iput-object v1, v6, Lcom/palai/prootsmoke/MainActivity;->statusTv:Landroid/widget/TextView;
    const/high16 v2, #int 0x41800000
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextSize(F)V
    iget-object v1, v6, Lcom/palai/prootsmoke/MainActivity;->statusTv:Landroid/widget/TextView;
    const/16 v2, #20
    invoke-virtual {v1, v2, v2, v2, v2}, Landroid/widget/TextView;->setPadding(IIII)V
    iget-object v1, v6, Lcom/palai/prootsmoke/MainActivity;->statusTv:Landroid/widget/TextView;
    const-string v2, "状态: 准备中..."
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    iget-object v1, v6, Lcom/palai/prootsmoke/MainActivity;->root:Landroid/widget/LinearLayout;
    iget-object v2, v6, Lcom/palai/prootsmoke/MainActivity;->statusTv:Landroid/widget/TextView;
    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    new-instance v1, Landroid/widget/TextView;
    invoke-direct {v1, v6}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V
    iput-object v1, v6, Lcom/palai/prootsmoke/MainActivity;->tv:Landroid/widget/TextView;
    const/high16 v2, #int 0x41100000
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setTextSize(F)V
    iget-object v1, v6, Lcom/palai/prootsmoke/MainActivity;->tv:Landroid/widget/TextView;
    const-string v2, "=== Coopanion Android 宿主 ===
"
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    new-instance v1, Landroid/widget/ScrollView;
    invoke-direct {v1, v6}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V
    iput-object v1, v6, Lcom/palai/prootsmoke/MainActivity;->logScroll:Landroid/widget/ScrollView;
    iget-object v2, v6, Lcom/palai/prootsmoke/MainActivity;->tv:Landroid/widget/TextView;
    invoke-virtual {v1, v2}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V
    const/16 v2, #8
    invoke-virtual {v1, v2}, Landroid/widget/ScrollView;->setVisibility(I)V
    new-instance v2, Landroid/widget/LinearLayout$LayoutParams;
    const/high16 v3, #int 0x3f800000
    const/4 v4, #-1
    invoke-direct {v2, v4, v7, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V
    iget-object v3, v6, Lcom/palai/prootsmoke/MainActivity;->root:Landroid/widget/LinearLayout;
    invoke-virtual {v3, v1, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    new-instance v1, Landroid/webkit/WebView;
    invoke-direct {v1, v6}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V
    iput-object v1, v6, Lcom/palai/prootsmoke/MainActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v1}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v1
    invoke-virtual {v1, v0}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V
    iget-object v1, v6, Lcom/palai/prootsmoke/MainActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v1}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v1
    invoke-virtual {v1, v0}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V
    iget-object v0, v6, Lcom/palai/prootsmoke/MainActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v0
    invoke-virtual {v0, v7}, Landroid/webkit/WebSettings;->setMixedContentMode(I)V
    iget-object v0, v6, Lcom/palai/prootsmoke/MainActivity;->web:Landroid/webkit/WebView;
    const/4 v1, #2
    const/4 v2, #0
    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->setLayerType(ILandroid/graphics/Paint;)V
    iget-object v0, v6, Lcom/palai/prootsmoke/MainActivity;->web:Landroid/webkit/WebView;
    new-instance v1, Lcom/palai/prootsmoke/MainActivity$12;
    invoke-direct {v1, v6}, Lcom/palai/prootsmoke/MainActivity$12;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V
    iget-object v0, v6, Lcom/palai/prootsmoke/MainActivity;->web:Landroid/webkit/WebView;
    new-instance v1, Lcom/palai/prootsmoke/MainActivity$13;
    invoke-direct {v1, v6}, Lcom/palai/prootsmoke/MainActivity$13;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V
    new-instance v0, Landroid/widget/LinearLayout$LayoutParams;
    const/high16 v1, #int 0x40000000
    invoke-direct {v0, v4, v7, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V
    iget-object v1, v6, Lcom/palai/prootsmoke/MainActivity;->root:Landroid/widget/LinearLayout;
    iget-object v2, v6, Lcom/palai/prootsmoke/MainActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v1, v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    iget-object v0, v6, Lcom/palai/prootsmoke/MainActivity;->root:Landroid/widget/LinearLayout;
    invoke-virtual {v6, v0}, Lcom/palai/prootsmoke/MainActivity;->setContentView(Landroid/view/View;)V
    invoke-direct {v6}, Lcom/palai/prootsmoke/MainActivity;->askMicOnce()V
    invoke-virtual {v6}, Lcom/palai/prootsmoke/MainActivity;->getApplicationContext()Landroid/content/Context;
    move-result-object v0
    invoke-static {v0}, Lcom/palai/prootsmoke/SenseBridge;->get(Landroid/content/Context;)Lcom/palai/prootsmoke/SenseBridge;
    move-result-object v0
    invoke-virtual {v0}, Lcom/palai/prootsmoke/SenseBridge;->start()V
    const-string v0, "[SENSE] bridge started on 127.0.0.1:17899"
    invoke-direct {v6, v0}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    goto :L466
    move-exception v0
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "[SENSE] bridge start failed: "
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-direct {v6, v0}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    :L466
    iget-object v0, v6, Lcom/palai/prootsmoke/MainActivity;->root:Landroid/widget/LinearLayout;
    new-instance v1, Lcom/palai/prootsmoke/MainActivity$14;
    invoke-direct {v1, v6}, Lcom/palai/prootsmoke/MainActivity$14;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    const-wide/16 v2, #1200
    invoke-virtual {v0, v1, v2, v3}, Landroid/widget/LinearLayout;->postDelayed(Ljava/lang/Runnable;J)Z
    goto :L498
    move-exception v0
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "[GUIDE] 自动引导失败: "
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-direct {v6, v0}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    :L498
    const-string v0, "coopanion"
    invoke-virtual {v6, v0, v7}, Lcom/palai/prootsmoke/MainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0
    const-string v1, "pet_window_wanted"
    invoke-interface {v0, v1, v7}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z
    move-result v7
    if-eqz v7, :L544
    iget-object v7, v6, Lcom/palai/prootsmoke/MainActivity;->root:Landroid/widget/LinearLayout;
    new-instance v0, Lcom/palai/prootsmoke/MainActivity$15;
    invoke-direct {v0, v6}, Lcom/palai/prootsmoke/MainActivity$15;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    const-wide/16 v1, #2500
    invoke-virtual {v7, v0, v1, v2}, Landroid/widget/LinearLayout;->postDelayed(Ljava/lang/Runnable;J)Z
    goto :L544
    move-exception v7
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[PET] 自动恢复悬浮窗失败: "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v7
    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v7
    invoke-direct {v6, v7}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    :L544
    new-instance v7, Ljava/lang/Thread;
    new-instance v0, Lcom/palai/prootsmoke/MainActivity$16;
    invoke-direct {v0, v6}, Lcom/palai/prootsmoke/MainActivity$16;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    invoke-direct {v7, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V
    invoke-virtual {v7}, Ljava/lang/Thread;->start()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    # registers=4 ins=4 tries=0
    invoke-super {v0, v1, v2, v3}, Landroid/app/Activity;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    const/16 v2, #10087
    if-ne v1, v2, :L32
    array-length v1, v3
    const/4 v2, #0
    if-lez v1, :L16
    aget v1, v3, v2
    if-nez v1, :L16
    const/4 v2, #1
    :L16
    if-eqz v2, :L21
    const-string v1, "已授权"
    goto :L23
    :L21
    const-string v1, "被拒绝"
    :L23
    const-string v2, "[MIC] 麦克风权限"
    invoke-virtual {v2, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->log(Ljava/lang/String;)V
    :L32
    return-void 
.end method

.class public Lcom/palai/prootsmoke/NotifListenerService;
.super Landroid/service/notification/NotificationListenerService;

.field private static volatile connected:Z

# direct access=0x10008
.method static constructor Lcom/palai/prootsmoke/NotifListenerService;-><clinit>()V
    # registers=0 ins=0 tries=0
    return-void 
.end method

# direct access=0x10001
.method public constructor Lcom/palai/prootsmoke/NotifListenerService;-><init>()V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Landroid/service/notification/NotificationListenerService;-><init>()V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/NotifListenerService;->appLabel(Ljava/lang/String;)Ljava/lang/String;
    # registers=4 ins=2 tries=1
    invoke-virtual {v2}, Lcom/palai/prootsmoke/NotifListenerService;->getPackageManager()Landroid/content/pm/PackageManager;
    move-result-object v0
    const/4 v1, #0
    invoke-virtual {v0, v3, v1}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->getApplicationLabel(Landroid/content/pm/ApplicationInfo;)Ljava/lang/CharSequence;
    move-result-object v0
    if-nez v0, :L16
    goto :L20
    :L16
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;
    move-result-object v3
    :L20
    return-object v3
.end method

# direct access=0x9
.method public static Lcom/palai/prootsmoke/NotifListenerService;->isConnected()Z
    # registers=1 ins=0 tries=0
    sget-boolean v0, Lcom/palai/prootsmoke/NotifListenerService;->connected:Z
    return v0
.end method

# direct access=0x9
.method public static Lcom/palai/prootsmoke/NotifListenerService;->isEnabled(Landroid/content/Context;)Z
    # registers=3 ins=1 tries=1
    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
    move-result-object v0
    const-string v1, "enabled_notification_listeners"
    invoke-static {v0, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    if-eqz v0, :L32
    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v2
    if-eqz v2, :L32
    const/4 v2, #1
    return v2
    :L32
    const/4 v2, #0
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/NotifListenerService;->onListenerConnected()V
    # registers=2 ins=1 tries=0
    const/4 v0, #1
    sput-boolean v0, Lcom/palai/prootsmoke/NotifListenerService;->connected:Z
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/NotifListenerService;->onListenerDisconnected()V
    # registers=2 ins=1 tries=0
    const/4 v0, #0
    sput-boolean v0, Lcom/palai/prootsmoke/NotifListenerService;->connected:Z
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/NotifListenerService;->onNotificationPosted(Landroid/service/notification/StatusBarNotification;)V
    # registers=10 ins=2 tries=2
    if-eqz v9, :L101
    invoke-virtual {v9}, Landroid/service/notification/StatusBarNotification;->getNotification()Landroid/app/Notification;
    move-result-object v0
    if-nez v0, :L9
    goto :L101
    :L9
    invoke-virtual {v9}, Landroid/service/notification/StatusBarNotification;->getPackageName()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v9}, Landroid/service/notification/StatusBarNotification;->getNotification()Landroid/app/Notification;
    move-result-object v0
    iget-object v0, v0, Landroid/app/Notification;->extras:Landroid/os/Bundle;
    const/4 v1, #0
    if-nez v0, :L24
    move-object v3, v1
    goto :L30
    :L24
    const-string v3, "android.title"
    invoke-virtual {v0, v3}, Landroid/os/Bundle;->getCharSequence(Ljava/lang/String;)Ljava/lang/CharSequence;
    move-result-object v3
    :L30
    if-nez v0, :L33
    goto :L39
    :L33
    const-string v1, "android.text"
    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getCharSequence(Ljava/lang/String;)Ljava/lang/CharSequence;
    move-result-object v1
    :L39
    if-nez v1, :L52
    if-eqz v0, :L52
    const-string v4, "android.bigText"
    invoke-virtual {v0, v4}, Landroid/os/Bundle;->getCharSequence(Ljava/lang/String;)Ljava/lang/CharSequence;
    move-result-object v0
    if-eqz v0, :L52
    move-object v1, v0
    :L52
    const-string v0, ""
    if-nez v3, :L58
    move-object v4, v0
    goto :L63
    :L58
    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;
    move-result-object v3
    move-object v4, v3
    :L63
    if-nez v1, :L66
    goto :L70
    :L66
    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;
    move-result-object v0
    :L70
    move-object v5, v0
    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z
    move-result v0
    if-eqz v0, :L84
    invoke-virtual {v5}, Ljava/lang/String;->isEmpty()Z
    move-result v0
    if-eqz v0, :L84
    return-void 
    :L84
    invoke-static {}, Lcom/palai/prootsmoke/SenseBridge;->peek()Lcom/palai/prootsmoke/SenseBridge;
    move-result-object v1
    if-eqz v1, :L101
    invoke-direct {v8, v2}, Lcom/palai/prootsmoke/NotifListenerService;->appLabel(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v9}, Landroid/service/notification/StatusBarNotification;->getPostTime()J
    move-result-wide v6
    invoke-virtual/range {v1..v7}, Lcom/palai/prootsmoke/SenseBridge;->addNotification(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V
    :L101
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetActivity$1;
.super Landroid/webkit/WebChromeClient;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetActivity$1;-><init>(Lcom/palai/prootsmoke/PetActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetActivity$1;->this$0:Lcom/palai/prootsmoke/PetActivity;
    invoke-direct {v0}, Landroid/webkit/WebChromeClient;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$1;->onPermissionRequest(Landroid/webkit/PermissionRequest;)V
    # registers=8 ins=2 tries=1
    invoke-virtual {v7}, Landroid/webkit/PermissionRequest;->getResources()[Ljava/lang/String;
    move-result-object v0
    array-length v1, v0
    const/4 v2, #0
    move v3, v2
    :L7
    if-ge v2, v1, :L23
    aget-object v4, v0, v2
    const-string v5, "android.webkit.resource.AUDIO_CAPTURE"
    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v4
    if-eqz v4, :L20
    const/4 v3, #1
    :L20
    add-int/lit8 v2, v2, #1
    goto :L7
    :L23
    if-eqz v3, :L38
    const-string v0, "[PETACT][MIC] WebView 请求麦克风 -> 已放行"
    invoke-static {v0}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    invoke-virtual {v7}, Landroid/webkit/PermissionRequest;->getResources()[Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v7, v0}, Landroid/webkit/PermissionRequest;->grant([Ljava/lang/String;)V
    goto :L61
    :L38
    invoke-virtual {v7}, Landroid/webkit/PermissionRequest;->deny()V
    goto :L61
    move-exception v7
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[PETACT][MIC] onPermissionRequest err: "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v7
    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v7
    invoke-static {v7}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    :L61
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$1;->onShowFileChooser(Landroid/webkit/WebView;Landroid/webkit/ValueCallback;Landroid/webkit/WebChromeClient$FileChooserParams;)Z
    # registers=5 ins=4 tries=2
    const-string v2, "[PETACT][FILE] onShowFileChooser"
    invoke-static {v2}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    iget-object v2, v1, Lcom/palai/prootsmoke/PetActivity$1;->this$0:Lcom/palai/prootsmoke/PetActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/PetActivity;->-$$Nest$fgetfilePathCallback(Lcom/palai/prootsmoke/PetActivity;)Landroid/webkit/ValueCallback;
    move-result-object v2
    const/4 v4, #0
    if-eqz v2, :L23
    iget-object v2, v1, Lcom/palai/prootsmoke/PetActivity$1;->this$0:Lcom/palai/prootsmoke/PetActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/PetActivity;->-$$Nest$fgetfilePathCallback(Lcom/palai/prootsmoke/PetActivity;)Landroid/webkit/ValueCallback;
    move-result-object v2
    invoke-interface {v2, v4}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V
    :L23
    iget-object v2, v1, Lcom/palai/prootsmoke/PetActivity$1;->this$0:Lcom/palai/prootsmoke/PetActivity;
    invoke-static {v2, v3}, Lcom/palai/prootsmoke/PetActivity;->-$$Nest$fputfilePathCallback(Lcom/palai/prootsmoke/PetActivity;Landroid/webkit/ValueCallback;)V
    new-instance v2, Landroid/content/Intent;
    const-string v3, "android.intent.action.GET_CONTENT"
    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    const-string v3, "android.intent.category.OPENABLE"
    invoke-virtual {v2, v3}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;
    const-string v3, "image/*"
    invoke-virtual {v2, v3}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;
    iget-object v3, v1, Lcom/palai/prootsmoke/PetActivity$1;->this$0:Lcom/palai/prootsmoke/PetActivity;
    const-string v0, "select image"
    invoke-static {v2, v0}, Landroid/content/Intent;->createChooser(Landroid/content/Intent;Ljava/lang/CharSequence;)Landroid/content/Intent;
    move-result-object v2
    const/16 v0, #20819
    invoke-virtual {v3, v2, v0}, Lcom/palai/prootsmoke/PetActivity;->startActivityForResult(Landroid/content/Intent;I)V
    const/4 v2, #1
    return v2
    move-exception v2
    new-instance v3, Ljava/lang/StringBuilder;
    const-string v0, "[PETACT][FILE] err: "
    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    invoke-static {v2}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    iget-object v2, v1, Lcom/palai/prootsmoke/PetActivity$1;->this$0:Lcom/palai/prootsmoke/PetActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/PetActivity;->-$$Nest$fgetfilePathCallback(Lcom/palai/prootsmoke/PetActivity;)Landroid/webkit/ValueCallback;
    move-result-object v2
    if-eqz v2, :L101
    iget-object v2, v1, Lcom/palai/prootsmoke/PetActivity$1;->this$0:Lcom/palai/prootsmoke/PetActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/PetActivity;->-$$Nest$fgetfilePathCallback(Lcom/palai/prootsmoke/PetActivity;)Landroid/webkit/ValueCallback;
    move-result-object v2
    invoke-interface {v2, v4}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V
    iget-object v2, v1, Lcom/palai/prootsmoke/PetActivity$1;->this$0:Lcom/palai/prootsmoke/PetActivity;
    invoke-static {v2, v4}, Lcom/palai/prootsmoke/PetActivity;->-$$Nest$fputfilePathCallback(Lcom/palai/prootsmoke/PetActivity;Landroid/webkit/ValueCallback;)V
    :L101
    const/4 v2, #0
    return v2
.end method

.class Lcom/palai/prootsmoke/PetActivity$2$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/PetActivity$2;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetActivity$2$1;-><init>(Lcom/palai/prootsmoke/PetActivity$2;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetActivity$2$1;->this$1:Lcom/palai/prootsmoke/PetActivity$2;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1041
.method public bridge synthetic Lcom/palai/prootsmoke/PetActivity$2$1;->onReceiveValue(Ljava/lang/Object;)V
    # registers=2 ins=2 tries=0
    check-cast v1, Ljava/lang/String;
    invoke-virtual {v0, v1}, Lcom/palai/prootsmoke/PetActivity$2$1;->onReceiveValue(Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$2$1;->onReceiveValue(Ljava/lang/String;)V
    # registers=4 ins=2 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[PETACT] probe -> "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-static {v3}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetActivity$2;
.super Landroid/webkit/WebViewClient;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetActivity$2;-><init>(Lcom/palai/prootsmoke/PetActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetActivity$2;->this$0:Lcom/palai/prootsmoke/PetActivity;
    invoke-direct {v0}, Landroid/webkit/WebViewClient;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$2;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    # registers=5 ins=3 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[PETACT] onPageFinished: "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v4
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-static {v4}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    new-instance v4, Lcom/palai/prootsmoke/PetActivity$2$1;
    invoke-direct {v4, v2}, Lcom/palai/prootsmoke/PetActivity$2$1;-><init>(Lcom/palai/prootsmoke/PetActivity$2;)V
    const-string v0, "(function(){try{var e=document.getElementById('pet');var g=(function tick(){window.__rc=(window.__rc||0)+1;requestAnimationFrame(tick);})();return 'petEl='+(e?'yes':'NO')+' raf='+(typeof requestAnimationFrame)+' vp='+innerWidth+'x'+innerHeight;}catch(err){return 'err '+err;}})()"
    invoke-virtual {v3, v0, v4}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetActivity$3;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetActivity$3;-><init>(Lcom/palai/prootsmoke/PetActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetActivity$3;->this$0:Lcom/palai/prootsmoke/PetActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$3;->onClick(Landroid/view/View;)V
    # registers=2 ins=2 tries=0
    iget-object v1, v0, Lcom/palai/prootsmoke/PetActivity$3;->this$0:Lcom/palai/prootsmoke/PetActivity;
    invoke-virtual {v1}, Lcom/palai/prootsmoke/PetActivity;->finish()V
    return-void 
.end method

.class public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;
.super Ljava/lang/Object;

# direct access=0x10001
.method public constructor Lcom/palai/prootsmoke/PetActivity$PetHostBridge;-><init>()V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;->focus()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;->grabFocus()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;->hide()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;->jsw(Ljava/lang/String;)V
    # registers=4 ins=2 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[JS] "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-static {v3}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;->onCursor()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;->openDress()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;->releaseFocus()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;->reportPetRect(IIII)V
    # registers=5 ins=5 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;->sampleBackdrop()Ljava/lang/String;
    # registers=2 ins=1 tries=0
    const/4 v0, #0
    return-object v0
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;->setInteractive(Z)V
    # registers=2 ins=2 tries=0
    return-void 
.end method

.class public Lcom/palai/prootsmoke/PetActivity;
.super Landroid/app/Activity;

.field private static final PET_URL:Ljava/lang/String;
.field private static final REQ_FILE:I
.field private filePathCallback:Landroid/webkit/ValueCallback;
.field private root:Landroid/widget/FrameLayout;
.field private web:Landroid/webkit/WebView;

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetActivity;->-$$Nest$fgetfilePathCallback(Lcom/palai/prootsmoke/PetActivity;)Landroid/webkit/ValueCallback;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/PetActivity;->filePathCallback:Landroid/webkit/ValueCallback;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetActivity;->-$$Nest$fputfilePathCallback(Lcom/palai/prootsmoke/PetActivity;Landroid/webkit/ValueCallback;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetActivity;->filePathCallback:Landroid/webkit/ValueCallback;
    return-void 
.end method

# direct access=0x10001
.method public constructor Lcom/palai/prootsmoke/PetActivity;-><init>()V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Landroid/app/Activity;-><init>()V
    return-void 
.end method

# virtual access=0x4
.method protected Lcom/palai/prootsmoke/PetActivity;->onActivityResult(IILandroid/content/Intent;)V
    # registers=7 ins=4 tries=0
    const/16 v0, #20819
    if-ne v4, v0, :L60
    const/4 v4, #-1
    const/4 v0, #1
    const/4 v1, #0
    const/4 v2, #0
    if-ne v5, v4, :L27
    if-eqz v6, :L27
    invoke-virtual {v6}, Landroid/content/Intent;->getData()Landroid/net/Uri;
    move-result-object v4
    if-eqz v4, :L27
    new-array v4, v0, [Landroid/net/Uri;
    invoke-virtual {v6}, Landroid/content/Intent;->getData()Landroid/net/Uri;
    move-result-object v5
    aput-object v5, v4, v1
    goto :L28
    :L27
    move-object v4, v2
    :L28
    iget-object v5, v3, Lcom/palai/prootsmoke/PetActivity;->filePathCallback:Landroid/webkit/ValueCallback;
    if-eqz v5, :L37
    invoke-interface {v5, v4}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V
    iput-object v2, v3, Lcom/palai/prootsmoke/PetActivity;->filePathCallback:Landroid/webkit/ValueCallback;
    :L37
    new-instance v5, Ljava/lang/StringBuilder;
    const-string v6, "[PETACT][FILE] onActivityResult ok="
    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    if-eqz v4, :L47
    goto :L48
    :L47
    move v0, v1
    :L48
    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
    move-result-object v4
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-static {v4}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    goto :L63
    :L60
    invoke-super {v3, v4, v5, v6}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V
    :L63
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity;->onBackPressed()V
    # registers=1 ins=1 tries=0
    invoke-virtual {v0}, Lcom/palai/prootsmoke/PetActivity;->finish()V
    return-void 
.end method

# virtual access=0x4
.method protected Lcom/palai/prootsmoke/PetActivity;->onCreate(Landroid/os/Bundle;)V
    # registers=8 ins=2 tries=2
    const-string v0, "android.permission.RECORD_AUDIO"
    invoke-super {v6, v7}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V
    invoke-static {v6}, Lcom/palai/prootsmoke/AppLog;->init(Landroid/content/Context;)V
    const-string v7, "[PETACT] ===== PetActivity onCreate ====="
    invoke-static {v7}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    invoke-virtual {v6}, Lcom/palai/prootsmoke/PetActivity;->getIntent()Landroid/content/Intent;
    move-result-object v7
    const/4 v1, #1
    const/4 v2, #0
    if-eqz v7, :L35
    invoke-virtual {v6}, Lcom/palai/prootsmoke/PetActivity;->getIntent()Landroid/content/Intent;
    move-result-object v7
    const-string v3, "transparent"
    invoke-virtual {v7, v3, v2}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z
    move-result v7
    if-eqz v7, :L35
    move v7, v1
    goto :L36
    :L35
    move v7, v2
    :L36
    if-eqz v7, :L59
    invoke-virtual {v6}, Lcom/palai/prootsmoke/PetActivity;->getWindow()Landroid/view/Window;
    move-result-object v3
    new-instance v4, Landroid/graphics/drawable/ColorDrawable;
    invoke-direct {v4, v2}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V
    invoke-virtual {v3, v4}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V
    invoke-virtual {v6}, Lcom/palai/prootsmoke/PetActivity;->getWindow()Landroid/view/Window;
    move-result-object v3
    const/16 v4, #32
    invoke-virtual {v3, v4}, Landroid/view/Window;->addFlags(I)V
    :L59
    invoke-virtual {v6}, Lcom/palai/prootsmoke/PetActivity;->getWindow()Landroid/view/Window;
    move-result-object v3
    const/16 v4, #1024
    invoke-virtual {v3, v4, v4}, Landroid/view/Window;->setFlags(II)V
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v4, #28
    if-lt v3, v4, :L84
    invoke-virtual {v6}, Lcom/palai/prootsmoke/PetActivity;->getWindow()Landroid/view/Window;
    move-result-object v3
    invoke-virtual {v3}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;
    move-result-object v3
    iput v1, v3, Landroid/view/WindowManager$LayoutParams;->layoutInDisplayCutoutMode:I
    :L84
    new-instance v3, Landroid/widget/FrameLayout;
    invoke-direct {v3, v6}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V
    iput-object v3, v6, Lcom/palai/prootsmoke/PetActivity;->root:Landroid/widget/FrameLayout;
    const v4, #-16052460
    if-eqz v7, :L98
    move v5, v2
    goto :L99
    :L98
    move v5, v4
    :L99
    invoke-virtual {v3, v5}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V
    new-instance v3, Landroid/webkit/WebView;
    invoke-direct {v3, v6}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V
    iput-object v3, v6, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v3}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v3
    invoke-virtual {v3, v1}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V
    invoke-virtual {v3, v1}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V
    invoke-virtual {v3, v2}, Landroid/webkit/WebSettings;->setMixedContentMode(I)V
    invoke-virtual {v3, v1}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V
    invoke-virtual {v3, v2}, Landroid/webkit/WebSettings;->setMediaPlaybackRequiresUserGesture(Z)V
    invoke-virtual {v3, v2}, Landroid/webkit/WebSettings;->setUseWideViewPort(Z)V
    invoke-virtual {v3, v2}, Landroid/webkit/WebSettings;->setLoadWithOverviewMode(Z)V
    invoke-virtual {v3, v2}, Landroid/webkit/WebSettings;->setSupportZoom(Z)V
    invoke-virtual {v3, v2}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V
    invoke-virtual {v3, v2}, Landroid/webkit/WebSettings;->setDisplayZoomControls(Z)V
    iget-object v3, v6, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    if-eqz v7, :L148
    move v4, v2
    :L148
    invoke-virtual {v3, v4}, Landroid/webkit/WebView;->setBackgroundColor(I)V
    iget-object v7, v6, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    new-instance v3, Lcom/palai/prootsmoke/PetActivity$PetHostBridge;
    invoke-direct {v3}, Lcom/palai/prootsmoke/PetActivity$PetHostBridge;-><init>()V
    const-string v4, "petHostNative"
    invoke-virtual {v7, v3, v4}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V
    iget-object v7, v6, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    new-instance v3, Lcom/palai/prootsmoke/PetActivity$PetHostBridge;
    invoke-direct {v3}, Lcom/palai/prootsmoke/PetActivity$PetHostBridge;-><init>()V
    const-string v4, "petHost"
    invoke-virtual {v7, v3, v4}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V
    iget-object v7, v6, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    new-instance v3, Lcom/palai/prootsmoke/PetActivity$1;
    invoke-direct {v3, v6}, Lcom/palai/prootsmoke/PetActivity$1;-><init>(Lcom/palai/prootsmoke/PetActivity;)V
    invoke-virtual {v7, v3}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V
    iget-object v7, v6, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    new-instance v3, Lcom/palai/prootsmoke/PetActivity$2;
    invoke-direct {v3, v6}, Lcom/palai/prootsmoke/PetActivity$2;-><init>(Lcom/palai/prootsmoke/PetActivity;)V
    invoke-virtual {v7, v3}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V
    iget-object v7, v6, Lcom/palai/prootsmoke/PetActivity;->root:Landroid/widget/FrameLayout;
    iget-object v3, v6, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    new-instance v4, Landroid/widget/FrameLayout$LayoutParams;
    const/4 v5, #-1
    invoke-direct {v4, v5, v5}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V
    invoke-virtual {v7, v3, v4}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    new-instance v7, Landroid/widget/LinearLayout;
    invoke-direct {v7, v6}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V
    invoke-virtual {v7, v2}, Landroid/widget/LinearLayout;->setOrientation(I)V
    new-instance v3, Landroid/widget/FrameLayout$LayoutParams;
    const/4 v4, #-2
    invoke-direct {v3, v4, v4}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V
    const/16 v4, #53
    iput v4, v3, Landroid/widget/FrameLayout$LayoutParams;->gravity:I
    const/16 v4, #40
    iput v4, v3, Landroid/widget/FrameLayout$LayoutParams;->topMargin:I
    const/16 v4, #24
    iput v4, v3, Landroid/widget/FrameLayout$LayoutParams;->rightMargin:I
    new-instance v4, Landroid/widget/Button;
    invoke-direct {v4, v6}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V
    const-string v5, "✕ 退出"
    invoke-virtual {v4, v5}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V
    const v5, #1057803469
    invoke-virtual {v4, v5}, Landroid/widget/Button;->setAlpha(F)V
    new-instance v5, Lcom/palai/prootsmoke/PetActivity$3;
    invoke-direct {v5, v6}, Lcom/palai/prootsmoke/PetActivity$3;-><init>(Lcom/palai/prootsmoke/PetActivity;)V
    invoke-virtual {v4, v5}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    invoke-virtual {v7, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    iget-object v4, v6, Lcom/palai/prootsmoke/PetActivity;->root:Landroid/widget/FrameLayout;
    invoke-virtual {v4, v7, v3}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    iget-object v7, v6, Lcom/palai/prootsmoke/PetActivity;->root:Landroid/widget/FrameLayout;
    invoke-virtual {v6, v7}, Lcom/palai/prootsmoke/PetActivity;->setContentView(Landroid/view/View;)V
    invoke-virtual {v6, v0}, Lcom/palai/prootsmoke/PetActivity;->checkSelfPermission(Ljava/lang/String;)I
    move-result v7
    if-eqz v7, :L286
    new-array v7, v1, [Ljava/lang/String;
    aput-object v0, v7, v2
    const/16 v0, #10088
    invoke-virtual {v6, v7, v0}, Lcom/palai/prootsmoke/PetActivity;->requestPermissions([Ljava/lang/String;I)V
    :L286
    iget-object v7, v6, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    const-string v0, "http://127.0.0.1:7797/pet?host=app"
    invoke-virtual {v7, v0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    const-string v7, "[PETACT] loadUrl -> http://127.0.0.1:7797/pet?host=app"
    invoke-static {v7}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x4
.method protected Lcom/palai/prootsmoke/PetActivity;->onDestroy()V
    # registers=3 ins=1 tries=1
    iget-object v0, v2, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    if-eqz v0, :L17
    const-string v1, "about:blank"
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    iget-object v0, v2, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v0}, Landroid/webkit/WebView;->destroy()V
    const/4 v0, #0
    iput-object v0, v2, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    :L17
    invoke-super {v2}, Landroid/app/Activity;->onDestroy()V
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindowService$10;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$10;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$10;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$10;->onKey(Landroid/view/View;ILandroid/view/KeyEvent;)Z
    # registers=4 ins=4 tries=0
    invoke-virtual {v3}, Landroid/view/KeyEvent;->getAction()I
    move-result v1
    if-nez v1, :L19
    const/16 v1, #67
    if-ne v2, v1, :L19
    iget-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$10;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    const-string v2, "Backspace"
    invoke-static {v1, v2}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mpushKeyToPage(Lcom/palai/prootsmoke/PetWindowService;Ljava/lang/String;)V
    const/4 v1, #1
    return v1
    :L19
    const/4 v1, #0
    return v1
.end method

.class Lcom/palai/prootsmoke/PetWindowService$11$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/PetWindowService$11;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$11$1;-><init>(Lcom/palai/prootsmoke/PetWindowService$11;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$11$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$11;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$11$1;->run()V
    # registers=3 ins=1 tries=1
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$11$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$11;
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService$11;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/PetWindowService;)Landroid/webkit/WebView;
    move-result-object v0
    const-string v1, "http://127.0.0.1:7797/pet"
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    const-string v0, "PetWindow"
    const-string v1, "[PET] loadUrl(布局就绪后) -> http://127.0.0.1:7797/pet"
    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindowService$11;
.super Ljava/lang/Object;

.field loaded:Z
.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$11;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$11;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    const/4 v1, #0
    iput-boolean v1, v0, Lcom/palai/prootsmoke/PetWindowService$11;->loaded:Z
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$11;->onLayoutChange(Landroid/view/View;IIIIIIII)V
    # registers=10 ins=10 tries=0
    iget-boolean v1, v0, Lcom/palai/prootsmoke/PetWindowService$11;->loaded:Z
    if-eqz v1, :L5
    return-void 
    :L5
    sub-int/2addr v4, v2
    if-lez v4, :L31
    sub-int/2addr v5, v3
    if-gtz v5, :L12
    goto :L31
    :L12
    const/4 v1, #1
    iput-boolean v1, v0, Lcom/palai/prootsmoke/PetWindowService$11;->loaded:Z
    iget-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$11;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetui(Lcom/palai/prootsmoke/PetWindowService;)Landroid/os/Handler;
    move-result-object v1
    new-instance v2, Lcom/palai/prootsmoke/PetWindowService$11$1;
    invoke-direct {v2, v0}, Lcom/palai/prootsmoke/PetWindowService$11$1;-><init>(Lcom/palai/prootsmoke/PetWindowService$11;)V
    const-wide/16 v3, #32
    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    :L31
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindowService$12;
.super Ljava/lang/Object;

.field fired:Z
.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$12;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$12;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    const/4 v1, #0
    iput-boolean v1, v0, Lcom/palai/prootsmoke/PetWindowService$12;->fired:Z
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$12;->run()V
    # registers=3 ins=1 tries=1
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$12;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/PetWindowService;)Landroid/webkit/WebView;
    move-result-object v0
    invoke-virtual {v0}, Landroid/webkit/WebView;->getUrl()Ljava/lang/String;
    move-result-object v0
    if-nez v0, :L30
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$12;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/PetWindowService;)Landroid/webkit/WebView;
    move-result-object v0
    const-string v1, "http://127.0.0.1:7797/pet"
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    const-string v0, "PetWindow"
    const-string v1, "[PET] loadUrl(兜底超时) -> http://127.0.0.1:7797/pet"
    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :L30
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindowService$13;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;
.field final synthetic val$wv:Landroid/webkit/WebView;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$13;-><init>(Lcom/palai/prootsmoke/PetWindowService;Landroid/webkit/WebView;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$13;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    iput-object v2, v0, Lcom/palai/prootsmoke/PetWindowService$13;->val$wv:Landroid/webkit/WebView;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$13;->run()V
    # registers=4 ins=1 tries=1
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$13;->val$wv:Landroid/webkit/WebView;
    invoke-virtual {v0}, Landroid/webkit/WebView;->invalidate()V
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$13;->val$wv:Landroid/webkit/WebView;
    const-string v1, "(function(){try{if(window.__repaintHack)return 0;window.__repaintHack=1;var els=document.querySelectorAll('#pet,#bubble,#menu,.pet,.whale,svg,canvas');for(var i=0;i<els.length;i++){var e=els[i];var t=e.style.transform;e.style.transform=(t||'')+' translateZ(0)';void e.offsetHeight;e.style.transform=t||'';}window.dispatchEvent(new Event('resize'));window.__repaintHack=0;return 1;}catch(e){return 0;}})()"
    const/4 v2, #0
    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindowService$14;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$14;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$14;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$14;->run()V
    # registers=4 ins=1 tries=1
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$14;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mqueryPetRect(Lcom/palai/prootsmoke/PetWindowService;)V
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$14;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetui(Lcom/palai/prootsmoke/PetWindowService;)Landroid/os/Handler;
    move-result-object v0
    const-wide/16 v1, #80
    invoke-virtual {v0, v3, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindowService$15;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$15;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$15;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1041
.method public bridge synthetic Lcom/palai/prootsmoke/PetWindowService$15;->onReceiveValue(Ljava/lang/Object;)V
    # registers=2 ins=2 tries=0
    check-cast v1, Ljava/lang/String;
    invoke-virtual {v0, v1}, Lcom/palai/prootsmoke/PetWindowService$15;->onReceiveValue(Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$15;->onReceiveValue(Ljava/lang/String;)V
    # registers=14 ins=2 tries=1
    const-string v0, "probe box=["
    if-eqz v13, :L216
    invoke-virtual {v13}, Ljava/lang/String;->length()I
    move-result v1
    const/4 v2, #3
    if-ge v1, v2, :L13
    goto/16 :L216
    :L13
    const-string v1, """
    const-string v3, ""
    invoke-virtual {v13, v1, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;
    move-result-object v13
    const/16 v1, #124
    invoke-virtual {v13, v1}, Ljava/lang/String;->lastIndexOf(I)I
    move-result v1
    if-gez v1, :L30
    return-void 
    :L30
    const/4 v3, #0
    invoke-virtual {v13, v3, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;
    move-result-object v4
    const/4 v5, #1
    add-int/2addr v1, v5
    invoke-virtual {v13, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v13
    const-string v1, "1"
    invoke-virtual {v13, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v13
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v6
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService$15;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetlastProbeLog(Lcom/palai/prootsmoke/PetWindowService;)J
    move-result-wide v8
    sub-long v8, v6, v8
    const-wide/16 v10, #1000
    cmp-long v1, v8, v10
    if-lez v1, :L98
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService$15;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1, v6, v7}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fputlastProbeLog(Lcom/palai/prootsmoke/PetWindowService;J)V
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService$15;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    new-instance v6, Ljava/lang/StringBuilder;
    invoke-direct {v6, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v6, "] focused="
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static {v1, v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mdiag(Lcom/palai/prootsmoke/PetWindowService;Ljava/lang/String;)V
    :L98
    iget-object v0, v12, Lcom/palai/prootsmoke/PetWindowService$15;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0, v13}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mapplyInputFocus(Lcom/palai/prootsmoke/PetWindowService;Z)V
    invoke-virtual {v4}, Ljava/lang/String;->length()I
    move-result v13
    const/4 v0, #5
    if-ge v13, v0, :L111
    return-void 
    :L111
    const-string v13, ","
    invoke-virtual {v4, v13}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    move-result-object v13
    array-length v0, v13
    const/4 v1, #4
    if-ge v0, v1, :L122
    return-void 
    :L122
    iget-object v0, v12, Lcom/palai/prootsmoke/PetWindowService$15;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-virtual {v0}, Lcom/palai/prootsmoke/PetWindowService;->getResources()Landroid/content/res/Resources;
    move-result-object v0
    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;
    move-result-object v0
    iget v0, v0, Landroid/util/DisplayMetrics;->density:F
    aget-object v1, v13, v3
    invoke-static {v1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F
    move-result v1
    mul-float/2addr v1, v0
    float-to-int v1, v1
    aget-object v3, v13, v5
    invoke-static {v3}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F
    move-result v3
    mul-float/2addr v3, v0
    float-to-int v3, v3
    const/4 v4, #2
    aget-object v5, v13, v4
    invoke-static {v5}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F
    move-result v5
    mul-float/2addr v5, v0
    float-to-int v5, v5
    aget-object v13, v13, v2
    invoke-static {v13}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F
    move-result v13
    mul-float/2addr v13, v0
    float-to-int v13, v13
    iget-object v0, v12, Lcom/palai/prootsmoke/PetWindowService$15;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    add-int v2, v1, v5
    int-to-float v6, v2
    const/high16 v7, #int 0x40000000
    div-float/2addr v6, v7
    invoke-static {v0, v6}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fputpetX(Lcom/palai/prootsmoke/PetWindowService;F)V
    iget-object v0, v12, Lcom/palai/prootsmoke/PetWindowService$15;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    add-int v6, v3, v13
    int-to-float v8, v6
    div-float/2addr v8, v7
    invoke-static {v0, v8}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fputpetY(Lcom/palai/prootsmoke/PetWindowService;F)V
    sub-int/2addr v5, v1
    add-int/lit8 v5, v5, #80
    const/16 v0, #520
    invoke-static {v5, v0}, Ljava/lang/Math;->max(II)I
    move-result v1
    sub-int/2addr v13, v3
    add-int/lit8 v13, v13, #80
    invoke-static {v13, v0}, Ljava/lang/Math;->max(II)I
    move-result v13
    div-int/2addr v2, v4
    div-int/lit8 v0, v1, #2
    sub-int/2addr v2, v0
    div-int/2addr v6, v4
    div-int/lit8 v0, v13, #2
    sub-int/2addr v6, v0
    iget-object v0, v12, Lcom/palai/prootsmoke/PetWindowService$15;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0, v2, v6, v1, v13}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$msizeTouchTo(Lcom/palai/prootsmoke/PetWindowService;IIII)V
    :L216
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindowService$16$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/PetWindowService$16;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$16$1;-><init>(Lcom/palai/prootsmoke/PetWindowService$16;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$16$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$16;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$16$1;->run()V
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$16$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$16;
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mfocusImeAndShow(Lcom/palai/prootsmoke/PetWindowService;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindowService$16$2;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/PetWindowService$16;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$16$2;-><init>(Lcom/palai/prootsmoke/PetWindowService$16;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$16$2;->this$1:Lcom/palai/prootsmoke/PetWindowService$16;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$16$2;->run()V
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$16$2;->this$1:Lcom/palai/prootsmoke/PetWindowService$16;
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mfocusImeAndShow(Lcom/palai/prootsmoke/PetWindowService;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindowService$16;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;
.field final synthetic val$on:Z

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$16;-><init>(Lcom/palai/prootsmoke/PetWindowService;Z)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    iput-boolean v2, v0, Lcom/palai/prootsmoke/PetWindowService$16;->val$on:Z
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$16;->run()V
    # registers=5 ins=1 tries=3
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v0
    if-eqz v0, :L66
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v0
    if-eqz v0, :L66
    iget-boolean v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->val$on:Z
    if-eqz v0, :L33
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v0
    iget v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I
    and-int/lit8 v1, v1, #-9
    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I
    goto :L45
    :L33
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v0
    iget v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I
    or-int/lit8 v1, v1, #8
    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I
    :L45
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetwm(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager;
    move-result-object v0
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v1
    iget-object v2, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v2}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v2
    invoke-interface {v0, v1, v2}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :L66
    iget-boolean v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->val$on:Z
    if-eqz v0, :L103
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetui(Lcom/palai/prootsmoke/PetWindowService;)Landroid/os/Handler;
    move-result-object v0
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$16$1;
    invoke-direct {v1, v4}, Lcom/palai/prootsmoke/PetWindowService$16$1;-><init>(Lcom/palai/prootsmoke/PetWindowService$16;)V
    const-wide/16 v2, #120
    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetui(Lcom/palai/prootsmoke/PetWindowService;)Landroid/os/Handler;
    move-result-object v0
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$16$2;
    invoke-direct {v1, v4}, Lcom/palai/prootsmoke/PetWindowService$16$2;-><init>(Lcom/palai/prootsmoke/PetWindowService$16;)V
    const-wide/16 v2, #450
    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    goto :L181
    :L103
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetimeProxy(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/EditText;
    move-result-object v0
    if-eqz v0, :L164
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    const-string v1, "input_method"
    invoke-virtual {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/view/inputmethod/InputMethodManager;
    const/4 v1, #0
    if-eqz v0, :L137
    iget-object v2, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v2}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetimeProxy(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/EditText;
    move-result-object v2
    invoke-virtual {v2}, Landroid/widget/EditText;->getWindowToken()Landroid/os/IBinder;
    move-result-object v2
    invoke-virtual {v0, v2, v1}, Landroid/view/inputmethod/InputMethodManager;->hideSoftInputFromWindow(Landroid/os/IBinder;I)Z
    :L137
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetimeProxy(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/EditText;
    move-result-object v0
    invoke-virtual {v0}, Landroid/widget/EditText;->clearFocus()V
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetimeProxy(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/EditText;
    move-result-object v0
    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setFocusable(Z)V
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetimeProxy(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/EditText;
    move-result-object v0
    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setFocusableInTouchMode(Z)V
    :L164
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v0
    if-eqz v0, :L181
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v0
    invoke-virtual {v0}, Landroid/widget/FrameLayout;->clearFocus()V
    :L181
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindowService$17;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;
.field final synthetic val$fh:I
.field final synthetic val$fw:I
.field final synthetic val$fx:I
.field final synthetic val$fy:I

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$17;-><init>(Lcom/palai/prootsmoke/PetWindowService;IIII)V
    # registers=6 ins=6 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$17;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    iput v2, v0, Lcom/palai/prootsmoke/PetWindowService$17;->val$fx:I
    iput v3, v0, Lcom/palai/prootsmoke/PetWindowService$17;->val$fy:I
    iput v4, v0, Lcom/palai/prootsmoke/PetWindowService$17;->val$fw:I
    iput v5, v0, Lcom/palai/prootsmoke/PetWindowService$17;->val$fh:I
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$17;->run()V
    # registers=4 ins=1 tries=1
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$17;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v0
    iget v1, v3, Lcom/palai/prootsmoke/PetWindowService$17;->val$fx:I
    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->x:I
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$17;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v0
    iget v1, v3, Lcom/palai/prootsmoke/PetWindowService$17;->val$fy:I
    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->y:I
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$17;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v0
    iget v1, v3, Lcom/palai/prootsmoke/PetWindowService$17;->val$fw:I
    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->width:I
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$17;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v0
    iget v1, v3, Lcom/palai/prootsmoke/PetWindowService$17;->val$fh:I
    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->height:I
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$17;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetwm(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager;
    move-result-object v0
    iget-object v1, v3, Lcom/palai/prootsmoke/PetWindowService$17;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v1
    iget-object v2, v3, Lcom/palai/prootsmoke/PetWindowService$17;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v2}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v2
    invoke-interface {v0, v1, v2}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindowService$1;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;
.field final synthetic val$a:F

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$1;-><init>(Lcom/palai/prootsmoke/PetWindowService;F)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$1;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    iput v2, v0, Lcom/palai/prootsmoke/PetWindowService$1;->val$a:F
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$1;->run()V
    # registers=5 ins=1 tries=1
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$1;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    iget v1, v4, Lcom/palai/prootsmoke/PetWindowService$1;->val$a:F
    const/4 v2, #0
    cmpg-float v3, v1, v2
    if-gez v3, :L11
    :L9
    move v1, v2
    goto :L18
    :L11
    const/high16 v2, #int 0x3f800000
    cmpl-float v3, v1, v2
    if-lez v3, :L18
    goto :L9
    :L18
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fputpetAlpha(Lcom/palai/prootsmoke/PetWindowService;F)V
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$1;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v0
    if-eqz v0, :L72
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$1;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v0
    if-eqz v0, :L72
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$1;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v0
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService$1;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetpetAlpha(Lcom/palai/prootsmoke/PetWindowService;)F
    move-result v1
    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->alpha:F
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$1;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetwm(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager;
    move-result-object v0
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService$1;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v1
    iget-object v2, v4, Lcom/palai/prootsmoke/PetWindowService$1;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v2}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v2
    invoke-interface {v0, v1, v2}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :L72
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindowService$2;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;
.field final synthetic val$type:I

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$2;-><init>(Lcom/palai/prootsmoke/PetWindowService;I)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$2;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    iput v2, v0, Lcom/palai/prootsmoke/PetWindowService$2;->val$type:I
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$2;->run()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$2;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    iget v1, v2, Lcom/palai/prootsmoke/PetWindowService$2;->val$type:I
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mbuildAndAttachLayers(Lcom/palai/prootsmoke/PetWindowService;I)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindowService$3;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;
.field final synthetic val$done:Ljava/lang/Runnable;
.field final synthetic val$finished:[Z
.field final synthetic val$holder:Landroid/widget/FrameLayout;
.field final synthetic val$warm:Landroid/webkit/WebView;
.field final synthetic val$wm0:Landroid/view/WindowManager;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$3;-><init>(Lcom/palai/prootsmoke/PetWindowService;[ZLandroid/view/WindowManager;Landroid/widget/FrameLayout;Landroid/webkit/WebView;Ljava/lang/Runnable;)V
    # registers=7 ins=7 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$3;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    iput-object v2, v0, Lcom/palai/prootsmoke/PetWindowService$3;->val$finished:[Z
    iput-object v3, v0, Lcom/palai/prootsmoke/PetWindowService$3;->val$wm0:Landroid/view/WindowManager;
    iput-object v4, v0, Lcom/palai/prootsmoke/PetWindowService$3;->val$holder:Landroid/widget/FrameLayout;
    iput-object v5, v0, Lcom/palai/prootsmoke/PetWindowService$3;->val$warm:Landroid/webkit/WebView;
    iput-object v6, v0, Lcom/palai/prootsmoke/PetWindowService$3;->val$done:Ljava/lang/Runnable;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$3;->run()V
    # registers=4 ins=1 tries=2
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$3;->val$finished:[Z
    const/4 v1, #0
    aget-boolean v2, v0, v1
    if-eqz v2, :L8
    return-void 
    :L8
    const/4 v2, #1
    aput-boolean v2, v0, v1
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$3;->val$wm0:Landroid/view/WindowManager;
    iget-object v1, v3, Lcom/palai/prootsmoke/PetWindowService$3;->val$holder:Landroid/widget/FrameLayout;
    invoke-interface {v0, v1}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$3;->val$warm:Landroid/webkit/WebView;
    invoke-virtual {v0}, Landroid/webkit/WebView;->stopLoading()V
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$3;->val$warm:Landroid/webkit/WebView;
    invoke-virtual {v0}, Landroid/webkit/WebView;->destroy()V
    const-string v0, "PetWindow"
    const-string v1, "[PET] 渲染器预热完成 → 开始正式挂载"
    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$3;->val$done:Ljava/lang/Runnable;
    invoke-interface {v0}, Ljava/lang/Runnable;->run()V
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindowService$4;
.super Landroid/webkit/WebViewClient;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;
.field final synthetic val$finish:Ljava/lang/Runnable;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$4;-><init>(Lcom/palai/prootsmoke/PetWindowService;Ljava/lang/Runnable;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$4;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    iput-object v2, v0, Lcom/palai/prootsmoke/PetWindowService$4;->val$finish:Ljava/lang/Runnable;
    invoke-direct {v0}, Landroid/webkit/WebViewClient;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$4;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    # registers=5 ins=3 tries=0
    const-string v3, "PetWindow"
    const-string v4, "[PET] 预热页加载完成，再等 400ms 让合成器落定"
    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    iget-object v3, v2, Lcom/palai/prootsmoke/PetWindowService$4;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v3}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetui(Lcom/palai/prootsmoke/PetWindowService;)Landroid/os/Handler;
    move-result-object v3
    iget-object v4, v2, Lcom/palai/prootsmoke/PetWindowService$4;->val$finish:Ljava/lang/Runnable;
    const-wide/16 v0, #400
    invoke-virtual {v3, v4, v0, v1}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindowService$5;
.super Landroid/webkit/WebViewClient;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$5;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$5;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0}, Landroid/webkit/WebViewClient;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$5;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    # registers=5 ins=3 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[PET] onPageFinished "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v4
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    const-string v0, "PetWindow"
    invoke-static {v0, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    const-string v4, "(function(){ if (window.petHost) return 'already'; if (typeof petHostNative === 'undefined') return 'no-bridge'; window.petHost = {   setInteractive: function(on){ try{ petHostNative.setInteractive(!!on); }catch(e){} },   focus: function(){ try{ petHostNative.focus(); }catch(e){} },   grabFocus: function(){ try{ petHostNative.grabFocus(); }catch(e){} },   releaseFocus: function(){ try{ petHostNative.releaseFocus(); }catch(e){} },   hide: function(){ try{ petHostNative.hide(); }catch(e){} },   openDress: function(){ try{ petHostNative.openDress(); }catch(e){} },   setAlpha: function(f){ try{ petHostNative.setAlpha(f); }catch(e){} },   getAlpha: function(){ try{ return petHostNative.getAlpha(); }catch(e){ return 1; } },   openApp: function(n){ try{ return !!petHostNative.openApp(String(n)); }catch(e){ return false; } },   onCursor: function(cb){ (window.__petCursorSubs=window.__petCursorSubs||[]).push(cb); },   sampleBackdrop: function(){ return null; } }; document.body.classList.remove('tab'); document.body.classList.add('desk'); return 'ok';})()"
    const/4 v0, #0
    invoke-virtual {v3, v4, v0}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    iget-object v4, v2, Lcom/palai/prootsmoke/PetWindowService$5;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v4, v3}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mstartRepaintWatchdog(Lcom/palai/prootsmoke/PetWindowService;Landroid/webkit/WebView;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$5;->onPageStarted(Landroid/webkit/WebView;Ljava/lang/String;Landroid/graphics/Bitmap;)V
    # registers=4 ins=4 tries=0
    const-string v2, "(function(){ if (window.petHost) return 'already'; if (typeof petHostNative === 'undefined') return 'no-bridge'; window.petHost = {   setInteractive: function(on){ try{ petHostNative.setInteractive(!!on); }catch(e){} },   focus: function(){ try{ petHostNative.focus(); }catch(e){} },   grabFocus: function(){ try{ petHostNative.grabFocus(); }catch(e){} },   releaseFocus: function(){ try{ petHostNative.releaseFocus(); }catch(e){} },   hide: function(){ try{ petHostNative.hide(); }catch(e){} },   openDress: function(){ try{ petHostNative.openDress(); }catch(e){} },   setAlpha: function(f){ try{ petHostNative.setAlpha(f); }catch(e){} },   getAlpha: function(){ try{ return petHostNative.getAlpha(); }catch(e){ return 1; } },   openApp: function(n){ try{ return !!petHostNative.openApp(String(n)); }catch(e){ return false; } },   onCursor: function(cb){ (window.__petCursorSubs=window.__petCursorSubs||[]).push(cb); },   sampleBackdrop: function(){ return null; } }; document.body.classList.remove('tab'); document.body.classList.add('desk'); return 'ok';})()"
    const/4 v3, #0
    invoke-virtual {v1, v2, v3}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindowService$6;
.super Landroid/webkit/WebChromeClient;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$6;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$6;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0}, Landroid/webkit/WebChromeClient;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$6;->onConsoleMessage(Landroid/webkit/ConsoleMessage;)Z
    # registers=4 ins=2 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[PET-JS] "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v3}, Landroid/webkit/ConsoleMessage;->message()Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    const-string v0, "PetWindow"
    invoke-static {v0, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    const/4 v3, #1
    return v3
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$6;->onPermissionRequest(Landroid/webkit/PermissionRequest;)V
    # registers=9 ins=2 tries=1
    const-string v0, "PetWindow"
    invoke-virtual {v8}, Landroid/webkit/PermissionRequest;->getResources()[Ljava/lang/String;
    move-result-object v1
    array-length v2, v1
    const/4 v3, #0
    move v4, v3
    :L9
    if-ge v3, v2, :L25
    aget-object v5, v1, v3
    const-string v6, "android.webkit.resource.AUDIO_CAPTURE"
    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v5
    if-eqz v5, :L22
    const/4 v4, #1
    :L22
    add-int/lit8 v3, v3, #1
    goto :L9
    :L25
    if-eqz v4, :L40
    const-string v1, "[PET][MIC] WebView 请求麦克风 -> 已放行"
    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    invoke-virtual {v8}, Landroid/webkit/PermissionRequest;->getResources()[Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v8, v1}, Landroid/webkit/PermissionRequest;->grant([Ljava/lang/String;)V
    goto :L63
    :L40
    invoke-virtual {v8}, Landroid/webkit/PermissionRequest;->deny()V
    goto :L63
    move-exception v8
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "[PET][MIC] onPermissionRequest err: "
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v8
    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v8
    invoke-static {v0, v8}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :L63
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindowService$7;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$7;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$7;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$7;->onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    # registers=3 ins=3 tries=0
    iget-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$7;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1, v2}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mforwardToWeb(Lcom/palai/prootsmoke/PetWindowService;Landroid/view/MotionEvent;)Z
    const/4 v1, #1
    return v1
.end method

.class interface abstract Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;
.super Ljava/lang/Object;

# virtual access=0x401
.method public abstract Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;->onClearLocal()V
    # (no code)
.end method

# virtual access=0x401
.method public abstract Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;->onCommit(Ljava/lang/String;)V
    # (no code)
.end method

# virtual access=0x401
.method public abstract Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;->onDelete()V
    # (no code)
.end method

.class Lcom/palai/prootsmoke/PetWindowService$8$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/PetWindowService$8;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$8$1;-><init>(Lcom/palai/prootsmoke/PetWindowService$8;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$8$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$8;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$8$1;->onClearLocal()V
    # registers=3 ins=1 tries=1
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$8$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$8;
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService$8;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetimeProxy(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/EditText;
    move-result-object v0
    const-string v1, ""
    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$8$1;->onCommit(Ljava/lang/String;)V
    # registers=3 ins=2 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$8$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$8;
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService$8;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0, v2}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mpushTextToPage(Lcom/palai/prootsmoke/PetWindowService;Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$8$1;->onDelete()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$8$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$8;
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService$8;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    const-string v1, "Backspace"
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mpushKeyToPage(Lcom/palai/prootsmoke/PetWindowService;Ljava/lang/String;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindowService$8;
.super Landroid/widget/EditText;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$8;-><init>(Lcom/palai/prootsmoke/PetWindowService;Landroid/content/Context;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$8;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0, v2}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$8;->onCreateInputConnection(Landroid/view/inputmethod/EditorInfo;)Landroid/view/inputmethod/InputConnection;
    # registers=4 ins=2 tries=0
    invoke-super {v2, v3}, Landroid/widget/EditText;->onCreateInputConnection(Landroid/view/inputmethod/EditorInfo;)Landroid/view/inputmethod/InputConnection;
    move-result-object v3
    if-nez v3, :L8
    const/4 v3, #0
    return-object v3
    :L8
    new-instance v0, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$8$1;
    invoke-direct {v1, v2}, Lcom/palai/prootsmoke/PetWindowService$8$1;-><init>(Lcom/palai/prootsmoke/PetWindowService$8;)V
    invoke-direct {v0, v3, v1}, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;-><init>(Landroid/view/inputmethod/InputConnection;Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;)V
    return-object v0
.end method

.class Lcom/palai/prootsmoke/PetWindowService$9;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$9;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$9;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$9;->afterTextChanged(Landroid/text/Editable;)V
    # registers=3 ins=2 tries=1
    invoke-interface {v2}, Landroid/text/Editable;->length()I
    move-result v0
    if-nez v0, :L7
    return-void 
    :L7
    invoke-static {v2}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$sm_isComposing(Landroid/text/Editable;)Z
    move-result v0
    if-eqz v0, :L14
    return-void 
    :L14
    invoke-interface {v2}, Landroid/text/Editable;->clear()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$9;->beforeTextChanged(Ljava/lang/CharSequence;III)V
    # registers=5 ins=5 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$9;->onTextChanged(Ljava/lang/CharSequence;III)V
    # registers=5 ins=5 tries=0
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;
.super Ljava/lang/Object;

.field private final base:Landroid/view/inputmethod/InputConnection;
.field private final sink:Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;-><init>(Landroid/view/inputmethod/InputConnection;Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;)V
    # registers=3 ins=3 tries=0
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    iput-object v2, v0, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->sink:Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->beginBatchEdit()Z
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0}, Landroid/view/inputmethod/InputConnection;->beginBatchEdit()Z
    move-result v0
    return v0
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->clearMetaKeyStates(I)Z
    # registers=3 ins=2 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2}, Landroid/view/inputmethod/InputConnection;->clearMetaKeyStates(I)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->closeConnection()V
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0}, Landroid/view/inputmethod/InputConnection;->closeConnection()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->commitCompletion(Landroid/view/inputmethod/CompletionInfo;)Z
    # registers=3 ins=2 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2}, Landroid/view/inputmethod/InputConnection;->commitCompletion(Landroid/view/inputmethod/CompletionInfo;)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->commitContent(Landroid/view/inputmethod/InputContentInfo;ILandroid/os/Bundle;)Z
    # registers=5 ins=4 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2, v3, v4}, Landroid/view/inputmethod/InputConnection;->commitContent(Landroid/view/inputmethod/InputContentInfo;ILandroid/os/Bundle;)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->commitCorrection(Landroid/view/inputmethod/CorrectionInfo;)Z
    # registers=3 ins=2 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2}, Landroid/view/inputmethod/InputConnection;->commitCorrection(Landroid/view/inputmethod/CorrectionInfo;)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->commitText(Ljava/lang/CharSequence;I)Z
    # registers=5 ins=3 tries=3
    if-eqz v3, :L17
    invoke-interface {v3}, Ljava/lang/CharSequence;->length()I
    move-result v0
    if-lez v0, :L17
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->sink:Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;
    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;
    move-result-object v1
    invoke-interface {v0, v1}, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;->onCommit(Ljava/lang/String;)V
    :L17
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v3, v4}, Landroid/view/inputmethod/InputConnection;->commitText(Ljava/lang/CharSequence;I)Z
    iget-object v3, v2, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->sink:Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;
    invoke-interface {v3}, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;->onClearLocal()V
    const/4 v3, #1
    return v3
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->deleteSurroundingText(II)Z
    # registers=4 ins=3 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2, v3}, Landroid/view/inputmethod/InputConnection;->deleteSurroundingText(II)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->deleteSurroundingTextInCodePoints(II)Z
    # registers=4 ins=3 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2, v3}, Landroid/view/inputmethod/InputConnection;->deleteSurroundingTextInCodePoints(II)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->endBatchEdit()Z
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z
    move-result v0
    return v0
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->finishComposingText()Z
    # registers=4 ins=1 tries=3
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    const/16 v1, #4096
    const/4 v2, #0
    invoke-interface {v0, v1, v2}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;
    move-result-object v0
    if-eqz v0, :L26
    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I
    move-result v1
    if-lez v1, :L26
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;
    move-result-object v0
    iget-object v1, v3, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->sink:Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;
    invoke-interface {v1, v0}, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;->onCommit(Ljava/lang/String;)V
    :L26
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0}, Landroid/view/inputmethod/InputConnection;->finishComposingText()Z
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->sink:Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;
    invoke-interface {v0}, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;->onClearLocal()V
    const/4 v0, #1
    return v0
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->getCursorCapsMode(I)I
    # registers=3 ins=2 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2}, Landroid/view/inputmethod/InputConnection;->getCursorCapsMode(I)I
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->getExtractedText(Landroid/view/inputmethod/ExtractedTextRequest;I)Landroid/view/inputmethod/ExtractedText;
    # registers=4 ins=3 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2, v3}, Landroid/view/inputmethod/InputConnection;->getExtractedText(Landroid/view/inputmethod/ExtractedTextRequest;I)Landroid/view/inputmethod/ExtractedText;
    move-result-object v2
    return-object v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->getHandler()Landroid/os/Handler;
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0}, Landroid/view/inputmethod/InputConnection;->getHandler()Landroid/os/Handler;
    move-result-object v0
    return-object v0
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->getSelectedText(I)Ljava/lang/CharSequence;
    # registers=3 ins=2 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2}, Landroid/view/inputmethod/InputConnection;->getSelectedText(I)Ljava/lang/CharSequence;
    move-result-object v2
    return-object v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->getTextAfterCursor(II)Ljava/lang/CharSequence;
    # registers=4 ins=3 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2, v3}, Landroid/view/inputmethod/InputConnection;->getTextAfterCursor(II)Ljava/lang/CharSequence;
    move-result-object v2
    return-object v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;
    # registers=4 ins=3 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2, v3}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;
    move-result-object v2
    return-object v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->performContextMenuAction(I)Z
    # registers=3 ins=2 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2}, Landroid/view/inputmethod/InputConnection;->performContextMenuAction(I)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->performEditorAction(I)Z
    # registers=3 ins=2 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2}, Landroid/view/inputmethod/InputConnection;->performEditorAction(I)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->performPrivateCommand(Ljava/lang/String;Landroid/os/Bundle;)Z
    # registers=4 ins=3 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2, v3}, Landroid/view/inputmethod/InputConnection;->performPrivateCommand(Ljava/lang/String;Landroid/os/Bundle;)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->reportFullscreenMode(Z)Z
    # registers=3 ins=2 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2}, Landroid/view/inputmethod/InputConnection;->reportFullscreenMode(Z)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->requestCursorUpdates(I)Z
    # registers=3 ins=2 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2}, Landroid/view/inputmethod/InputConnection;->requestCursorUpdates(I)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->sendKeyEvent(Landroid/view/KeyEvent;)Z
    # registers=4 ins=2 tries=1
    if-eqz v3, :L21
    invoke-virtual {v3}, Landroid/view/KeyEvent;->getAction()I
    move-result v0
    if-nez v0, :L21
    invoke-virtual {v3}, Landroid/view/KeyEvent;->getKeyCode()I
    move-result v0
    const/16 v1, #67
    if-ne v0, v1, :L21
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->sink:Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;
    invoke-interface {v0}, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;->onDelete()V
    :L21
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v3}, Landroid/view/inputmethod/InputConnection;->sendKeyEvent(Landroid/view/KeyEvent;)Z
    move-result v3
    return v3
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->setComposingRegion(II)Z
    # registers=4 ins=3 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2, v3}, Landroid/view/inputmethod/InputConnection;->setComposingRegion(II)Z
    const/4 v2, #1
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->setComposingText(Ljava/lang/CharSequence;I)Z
    # registers=4 ins=3 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2, v3}, Landroid/view/inputmethod/InputConnection;->setComposingText(Ljava/lang/CharSequence;I)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->setSelection(II)Z
    # registers=4 ins=3 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2, v3}, Landroid/view/inputmethod/InputConnection;->setSelection(II)Z
    move-result v2
    return v2
.end method

.class Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
.field final synthetic val$a:F

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;-><init>(Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;F)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iput v2, v0, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->val$a:F
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->run()V
    # registers=5 ins=1 tries=1
    const-string v0, "[PET] setAlpha="
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v1, v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    iget v2, v4, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->val$a:F
    invoke-static {v1, v2}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fputpetAlpha(Lcom/palai/prootsmoke/PetWindowService;F)V
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v1, v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v1
    if-eqz v1, :L70
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v1, v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v1
    if-eqz v1, :L70
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v1, v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v1
    iget v2, v4, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->val$a:F
    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->alpha:F
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v1, v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetwm(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager;
    move-result-object v1
    iget-object v2, v4, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v2, v2, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v2}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v2
    iget-object v3, v4, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v3, v3, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v3}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v3
    invoke-interface {v1, v2, v3}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :L70
    const-string v1, "PetWindow"
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget v0, v4, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->val$a:F
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$2;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$2;-><init>(Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$2;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$2;->run()V
    # registers=3 ins=1 tries=2
    const/16 v0, #8
    iget-object v1, v2, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$2;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v1, v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v1
    if-eqz v1, :L23
    iget-object v1, v2, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$2;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v1, v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v1
    invoke-virtual {v1, v0}, Landroid/widget/FrameLayout;->setVisibility(I)V
    :L23
    iget-object v1, v2, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$2;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v1, v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v1
    if-eqz v1, :L44
    iget-object v1, v2, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$2;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v1, v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v1
    invoke-virtual {v1, v0}, Landroid/widget/FrameLayout;->setVisibility(I)V
    :L44
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$3;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
.field final synthetic val$ctx:Landroid/content/Context;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$3;-><init>(Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;Landroid/content/Context;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$3;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iput-object v2, v0, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$3;->val$ctx:Landroid/content/Context;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$3;->run()V
    # registers=4 ins=1 tries=1
    new-instance v0, Landroid/content/Intent;
    const-string v1, "android.intent.action.VIEW"
    const-string v2, "http://127.0.0.1:7797/dress"
    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v2
    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V
    const/high16 v1, #int 0x10000000
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;
    iget-object v1, v3, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$3;->val$ctx:Landroid/content/Context;
    invoke-virtual {v1, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    return-void 
.end method

.class public final synthetic Lcom/palai/prootsmoke/PetWindowService$PetHostBridge-IA;
.super Ljava/lang/Object;

.class Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;

# direct access=0x10002
.method private constructor Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# direct access=0x11000
.method synthetic constructor Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;-><init>(Lcom/palai/prootsmoke/PetWindowService;Lcom/palai/prootsmoke/PetWindowService$PetHostBridge-IA;)V
    # registers=3 ins=3 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->focus()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->getAlpha()F
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetpetAlpha(Lcom/palai/prootsmoke/PetWindowService;)F
    move-result v0
    return v0
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->grabFocus()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->hide()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetui(Lcom/palai/prootsmoke/PetWindowService;)Landroid/os/Handler;
    move-result-object v0
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$2;
    invoke-direct {v1, v2}, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$2;-><init>(Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;)V
    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->openApp(Ljava/lang/String;)Z
    # registers=14 ins=2 tries=1
    const-string v0, "PetWindow"
    const/4 v1, #0
    if-nez v13, :L6
    return v1
    :L6
    invoke-virtual {v13}, Ljava/lang/String;->trim()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z
    move-result v3
    if-eqz v3, :L21
    return v1
    :L21
    iget-object v3, v12, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-virtual {v3}, Lcom/palai/prootsmoke/PetWindowService;->getPackageManager()Landroid/content/pm/PackageManager;
    move-result-object v3
    new-instance v4, Landroid/content/Intent;
    const-string v5, "android.intent.action.MAIN"
    invoke-direct {v4, v5}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    const-string v5, "android.intent.category.LAUNCHER"
    invoke-virtual {v4, v5}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;
    invoke-virtual {v3, v4, v1}, Landroid/content/pm/PackageManager;->queryIntentActivities(Landroid/content/Intent;I)Ljava/util/List;
    move-result-object v4
    invoke-interface {v4}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v4
    const/4 v5, #-1
    const/4 v6, #0
    move v7, v5
    :L50
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z
    move-result v8
    if-eqz v8, :L154
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v8
    check-cast v8, Landroid/content/pm/ResolveInfo;
    if-eqz v8, :L50
    iget-object v9, v8, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;
    if-nez v9, :L69
    goto :L50
    :L69
    iget-object v9, v8, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;
    iget-object v9, v9, Landroid/content/pm/ActivityInfo;->packageName:Ljava/lang/String;
    invoke-virtual {v8, v3}, Landroid/content/pm/ResolveInfo;->loadLabel(Landroid/content/pm/PackageManager;)Ljava/lang/CharSequence;
    move-result-object v8
    if-nez v8, :L82
    const-string v8, ""
    goto :L86
    :L82
    invoke-virtual {v8}, Ljava/lang/Object;->toString()Ljava/lang/String;
    move-result-object v8
    :L86
    invoke-virtual {v8}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;
    move-result-object v8
    invoke-virtual {v9}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;
    move-result-object v10
    invoke-virtual {v10, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v11
    if-eqz v11, :L103
    const/16 v8, #1000
    goto :L149
    :L103
    invoke-virtual {v8, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v11
    if-eqz v11, :L112
    const/16 v8, #900
    goto :L149
    :L112
    invoke-virtual {v8, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v11
    if-eqz v11, :L130
    invoke-virtual {v8}, Ljava/lang/String;->length()I
    move-result v8
    invoke-virtual {v2}, Ljava/lang/String;->length()I
    move-result v10
    sub-int/2addr v8, v10
    rsub-int/lit16 v136, #700
    goto :L149
    :L130
    invoke-virtual {v10, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v8
    if-eqz v8, :L148
    invoke-virtual {v10}, Ljava/lang/String;->length()I
    move-result v8
    invoke-virtual {v2}, Ljava/lang/String;->length()I
    move-result v10
    sub-int/2addr v8, v10
    rsub-int/lit16 v136, #500
    goto :L149
    :L148
    move v8, v5
    :L149
    if-le v8, v7, :L50
    move v7, v8
    move-object v6, v9
    goto :L50
    :L154
    if-eqz v6, :L232
    if-gez v7, :L159
    goto :L232
    :L159
    invoke-virtual {v3, v6}, Landroid/content/pm/PackageManager;->getLaunchIntentForPackage(Ljava/lang/String;)Landroid/content/Intent;
    move-result-object v2
    if-nez v2, :L188
    new-instance v13, Ljava/lang/StringBuilder;
    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "[PET] openApp 无启动入口: "
    invoke-virtual {v13, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v13
    invoke-virtual {v13, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v13
    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v13
    invoke-static {v0, v13}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    return v1
    :L188
    const/high16 v3, #int 0x10000000
    invoke-virtual {v2, v3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;
    iget-object v3, v12, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-virtual {v3, v2}, Lcom/palai/prootsmoke/PetWindowService;->startActivity(Landroid/content/Intent;)V
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    const-string v3, "[PET] openApp 启动 "
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v13
    const-string v2, " -> "
    invoke-virtual {v13, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v13
    invoke-virtual {v13, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v13
    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v13
    invoke-static {v0, v13}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    const/4 v13, #1
    return v13
    :L232
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    const-string v3, "[PET] openApp 没找到: "
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v13
    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v13
    invoke-static {v0, v13}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    return v1
    move-exception v13
    new-instance v2, Ljava/lang/StringBuilder;
    const-string v3, "[PET] openApp 失败: "
    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v13
    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v13
    invoke-static {v0, v13}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    return v1
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->openDress()V
    # registers=4 ins=1 tries=0
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetui(Lcom/palai/prootsmoke/PetWindowService;)Landroid/os/Handler;
    move-result-object v1
    new-instance v2, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$3;
    invoke-direct {v2, v3, v0}, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$3;-><init>(Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;Landroid/content/Context;)V
    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->releaseFocus()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->setAlpha(F)V
    # registers=5 ins=2 tries=1
    const/4 v0, #0
    cmpg-float v1, v4, v0
    if-gez v1, :L6
    move v4, v0
    :L6
    const/high16 v0, #int 0x3f800000
    cmpl-float v1, v4, v0
    if-lez v1, :L13
    move v4, v0
    :L13
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    const-string v1, "coopanion"
    const/4 v2, #0
    invoke-virtual {v0, v1, v2}, Lcom/palai/prootsmoke/PetWindowService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    const-string v1, "pet_alpha"
    invoke-interface {v0, v1, v4}, Landroid/content/SharedPreferences$Editor;->putFloat(Ljava/lang/String;F)Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetui(Lcom/palai/prootsmoke/PetWindowService;)Landroid/os/Handler;
    move-result-object v0
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;
    invoke-direct {v1, v3, v4}, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;-><init>(Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;F)V
    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->setInteractive(Z)V
    # registers=4 ins=2 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[PET] setInteractive="
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    const-string v0, "PetWindow"
    invoke-static {v0, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    return-void 
.end method

.class public Lcom/palai/prootsmoke/PetWindowService;
.super Landroid/app/Service;

.field private static final CHANNEL:Ljava/lang/String;
.field private static final KEY_ALPHA:Ljava/lang/String;
.field private static final NOTI_ID:I
.field private static final PET_HOST_SHIM:Ljava/lang/String;
.field private static final PET_URL:Ljava/lang/String;
.field private static final PREF:Ljava/lang/String;
.field private static final TAG:Ljava/lang/String;
.field private static final TOUCH_SIZE:I
.field private volatile firstLoadReloaded:Z
.field private final followTick:Ljava/lang/Runnable;
.field private imeProxy:Landroid/widget/EditText;
.field private volatile inputFocusOn:Z
.field private lastFocusLog:J
.field private lastProbeLog:J
.field private lastTouchH:I
.field private lastTouchW:I
.field private lastTouchX:I
.field private lastTouchY:I
.field private petAlpha:F
.field private volatile petX:F
.field private volatile petY:F
.field private screenH:I
.field private screenW:I
.field private showBox:Landroid/widget/FrameLayout;
.field private showLp:Landroid/view/WindowManager$LayoutParams;
.field private touchBox:Landroid/widget/FrameLayout;
.field private touchLp:Landroid/view/WindowManager$LayoutParams;
.field private ui:Landroid/os/Handler;
.field private web:Landroid/webkit/WebView;
.field private wm:Landroid/view/WindowManager;

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetimeProxy(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/EditText;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetlastProbeLog(Lcom/palai/prootsmoke/PetWindowService;)J
    # registers=3 ins=1 tries=0
    iget-wide v0, v2, Lcom/palai/prootsmoke/PetWindowService;->lastProbeLog:J
    return-wide v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetpetAlpha(Lcom/palai/prootsmoke/PetWindowService;)F
    # registers=1 ins=1 tries=0
    iget v0, v0, Lcom/palai/prootsmoke/PetWindowService;->petAlpha:F
    return v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService;->showBox:Landroid/widget/FrameLayout;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService;->showLp:Landroid/view/WindowManager$LayoutParams;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService;->touchBox:Landroid/widget/FrameLayout;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService;->touchLp:Landroid/view/WindowManager$LayoutParams;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetui(Lcom/palai/prootsmoke/PetWindowService;)Landroid/os/Handler;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService;->ui:Landroid/os/Handler;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/PetWindowService;)Landroid/webkit/WebView;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetwm(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService;->wm:Landroid/view/WindowManager;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fputlastProbeLog(Lcom/palai/prootsmoke/PetWindowService;J)V
    # registers=3 ins=3 tries=0
    iput-wide v1, v0, Lcom/palai/prootsmoke/PetWindowService;->lastProbeLog:J
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fputpetAlpha(Lcom/palai/prootsmoke/PetWindowService;F)V
    # registers=2 ins=2 tries=0
    iput v1, v0, Lcom/palai/prootsmoke/PetWindowService;->petAlpha:F
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fputpetX(Lcom/palai/prootsmoke/PetWindowService;F)V
    # registers=2 ins=2 tries=0
    iput v1, v0, Lcom/palai/prootsmoke/PetWindowService;->petX:F
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fputpetY(Lcom/palai/prootsmoke/PetWindowService;F)V
    # registers=2 ins=2 tries=0
    iput v1, v0, Lcom/palai/prootsmoke/PetWindowService;->petY:F
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mapplyInputFocus(Lcom/palai/prootsmoke/PetWindowService;Z)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->applyInputFocus(Z)V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mbuildAndAttachLayers(Lcom/palai/prootsmoke/PetWindowService;I)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->buildAndAttachLayers(I)V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mdiag(Lcom/palai/prootsmoke/PetWindowService;Ljava/lang/String;)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->diag(Ljava/lang/String;)V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mfocusImeAndShow(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/PetWindowService;->focusImeAndShow()V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mforwardToWeb(Lcom/palai/prootsmoke/PetWindowService;Landroid/view/MotionEvent;)Z
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->forwardToWeb(Landroid/view/MotionEvent;)Z
    move-result v0
    return v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mpushKeyToPage(Lcom/palai/prootsmoke/PetWindowService;Ljava/lang/String;)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->pushKeyToPage(Ljava/lang/String;)V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mpushTextToPage(Lcom/palai/prootsmoke/PetWindowService;Ljava/lang/String;)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->pushTextToPage(Ljava/lang/String;)V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mqueryPetRect(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/PetWindowService;->queryPetRect()V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$msizeTouchTo(Lcom/palai/prootsmoke/PetWindowService;IIII)V
    # registers=5 ins=5 tries=0
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/palai/prootsmoke/PetWindowService;->sizeTouchTo(IIII)V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mstartRepaintWatchdog(Lcom/palai/prootsmoke/PetWindowService;Landroid/webkit/WebView;)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->startRepaintWatchdog(Landroid/webkit/WebView;)V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$sm_isComposing(Landroid/text/Editable;)Z
    # registers=1 ins=1 tries=0
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->_isComposing(Landroid/text/Editable;)Z
    move-result v0
    return v0
.end method

# direct access=0x10001
.method public constructor Lcom/palai/prootsmoke/PetWindowService;-><init>()V
    # registers=4 ins=1 tries=0
    invoke-direct {v3}, Landroid/app/Service;-><init>()V
    const/high16 v0, #int 0x3f800000
    iput v0, v3, Lcom/palai/prootsmoke/PetWindowService;->petAlpha:F
    const/4 v0, #0
    iput-boolean v0, v3, Lcom/palai/prootsmoke/PetWindowService;->firstLoadReloaded:Z
    const/high16 v1, #int 0xbf800000
    iput v1, v3, Lcom/palai/prootsmoke/PetWindowService;->petX:F
    iput v1, v3, Lcom/palai/prootsmoke/PetWindowService;->petY:F
    const/high16 v1, #int 0x80000000
    iput v1, v3, Lcom/palai/prootsmoke/PetWindowService;->lastTouchX:I
    iput v1, v3, Lcom/palai/prootsmoke/PetWindowService;->lastTouchY:I
    iput v1, v3, Lcom/palai/prootsmoke/PetWindowService;->lastTouchW:I
    iput v1, v3, Lcom/palai/prootsmoke/PetWindowService;->lastTouchH:I
    new-instance v1, Landroid/os/Handler;
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;
    move-result-object v2
    invoke-direct {v1, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
    iput-object v1, v3, Lcom/palai/prootsmoke/PetWindowService;->ui:Landroid/os/Handler;
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$14;
    invoke-direct {v1, v3}, Lcom/palai/prootsmoke/PetWindowService$14;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    iput-object v1, v3, Lcom/palai/prootsmoke/PetWindowService;->followTick:Ljava/lang/Runnable;
    iput-boolean v0, v3, Lcom/palai/prootsmoke/PetWindowService;->inputFocusOn:Z
    const-wide/16 v0, #0
    iput-wide v0, v3, Lcom/palai/prootsmoke/PetWindowService;->lastFocusLog:J
    iput-wide v0, v3, Lcom/palai/prootsmoke/PetWindowService;->lastProbeLog:J
    return-void 
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/PetWindowService;->_isComposing(Landroid/text/Editable;)Z
    # registers=6 ins=1 tries=1
    const/4 v0, #0
    invoke-interface {v5}, Landroid/text/Editable;->length()I
    move-result v1
    const-class v2, Ljava/lang/Object;
    invoke-interface {v5, v0, v1, v2}, Landroid/text/Editable;->getSpans(IILjava/lang/Class;)[Ljava/lang/Object;
    move-result-object v1
    array-length v2, v1
    move v3, v0
    :L13
    if-ge v3, v2, :L30
    aget-object v4, v1, v3
    invoke-interface {v5, v4}, Landroid/text/Editable;->getSpanFlags(Ljava/lang/Object;)I
    move-result v4
    and-int/lit16 v68, #256
    if-eqz v4, :L27
    const/4 v5, #1
    return v5
    :L27
    add-int/lit8 v3, v3, #1
    goto :L13
    :L30
    return v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->applyInputFocus(Z)V
    # registers=8 ins=2 tries=0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v0
    iget-boolean v2, v6, Lcom/palai/prootsmoke/PetWindowService;->inputFocusOn:Z
    if-eq v7, v2, :L55
    iget-wide v2, v6, Lcom/palai/prootsmoke/PetWindowService;->lastFocusLog:J
    sub-long v2, v0, v2
    const-wide/16 v4, #300
    cmp-long v2, v2, v4
    if-lez v2, :L55
    iput-wide v0, v6, Lcom/palai/prootsmoke/PetWindowService;->lastFocusLog:J
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "inputFocus="
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v1, " -> NOT_FOCUSABLE "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    if-eqz v7, :L42
    const-string v1, "OFF"
    goto :L44
    :L42
    const-string v1, "ON"
    :L44
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-direct {v6, v0}, Lcom/palai/prootsmoke/PetWindowService;->diag(Ljava/lang/String;)V
    :L55
    iget-boolean v0, v6, Lcom/palai/prootsmoke/PetWindowService;->inputFocusOn:Z
    if-ne v7, v0, :L60
    return-void 
    :L60
    iput-boolean v7, v6, Lcom/palai/prootsmoke/PetWindowService;->inputFocusOn:Z
    iget-object v0, v6, Lcom/palai/prootsmoke/PetWindowService;->ui:Landroid/os/Handler;
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$16;
    invoke-direct {v1, v6, v7}, Lcom/palai/prootsmoke/PetWindowService$16;-><init>(Lcom/palai/prootsmoke/PetWindowService;Z)V
    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->buildAndAttachLayers(I)V
    # registers=14 ins=2 tries=4
    const-string v0, "PetWindow"
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    const/4 v2, #0
    invoke-direct {v1, v12, v2}, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;-><init>(Lcom/palai/prootsmoke/PetWindowService;Lcom/palai/prootsmoke/PetWindowService$PetHostBridge-IA;)V
    iget-object v2, v12, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    const-string v3, "petHostNative"
    invoke-virtual {v2, v1, v3}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V
    new-instance v1, Lcom/palai/prootsmoke/VoiceBridge;
    invoke-direct {v1, v12, v2}, Lcom/palai/prootsmoke/VoiceBridge;-><init>(Landroid/content/Context;Landroid/webkit/WebView;)V
    const-string v3, "petVoiceNative"
    invoke-virtual {v2, v1, v3}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    new-instance v2, Lcom/palai/prootsmoke/PetWindowService$5;
    invoke-direct {v2, v12}, Lcom/palai/prootsmoke/PetWindowService$5;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    new-instance v2, Lcom/palai/prootsmoke/PetWindowService$6;
    invoke-direct {v2, v12}, Lcom/palai/prootsmoke/PetWindowService$6;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V
    new-instance v1, Landroid/widget/FrameLayout;
    invoke-direct {v1, v12}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V
    iput-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->showBox:Landroid/widget/FrameLayout;
    const/4 v2, #0
    invoke-virtual {v1, v2}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->showBox:Landroid/widget/FrameLayout;
    iget-object v3, v12, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    new-instance v4, Landroid/widget/FrameLayout$LayoutParams;
    const/4 v5, #-1
    invoke-direct {v4, v5, v5}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V
    invoke-virtual {v1, v3, v4}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    new-instance v1, Landroid/view/WindowManager$LayoutParams;
    const v10, #66328
    const/4 v11, #-3
    const/4 v7, #-1
    const/4 v8, #-1
    move-object v6, v1
    move v9, v13
    invoke-direct/range {v6..v11}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V
    iput-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->showLp:Landroid/view/WindowManager$LayoutParams;
    const/high16 v1, #int 0x3f800000
    const-string v3, "coopanion"
    invoke-virtual {v12, v3, v2}, Lcom/palai/prootsmoke/PetWindowService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v3
    const-string v4, "pet_alpha"
    invoke-interface {v3, v4, v1}, Landroid/content/SharedPreferences;->getFloat(Ljava/lang/String;F)F
    move-result v3
    iput v3, v12, Lcom/palai/prootsmoke/PetWindowService;->petAlpha:F
    iget v3, v12, Lcom/palai/prootsmoke/PetWindowService;->petAlpha:F
    const/4 v4, #0
    cmpg-float v3, v3, v4
    if-gez v3, :L109
    iput v4, v12, Lcom/palai/prootsmoke/PetWindowService;->petAlpha:F
    :L109
    iget v3, v12, Lcom/palai/prootsmoke/PetWindowService;->petAlpha:F
    cmpl-float v3, v3, v1
    if-lez v3, :L117
    iput v1, v12, Lcom/palai/prootsmoke/PetWindowService;->petAlpha:F
    :L117
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->showLp:Landroid/view/WindowManager$LayoutParams;
    iget v3, v12, Lcom/palai/prootsmoke/PetWindowService;->petAlpha:F
    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->alpha:F
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->showLp:Landroid/view/WindowManager$LayoutParams;
    const v3, #8388659
    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->gravity:I
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->showLp:Landroid/view/WindowManager$LayoutParams;
    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->x:I
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->showLp:Landroid/view/WindowManager$LayoutParams;
    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->y:I
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->wm:Landroid/view/WindowManager;
    iget-object v4, v12, Lcom/palai/prootsmoke/PetWindowService;->showBox:Landroid/widget/FrameLayout;
    iget-object v5, v12, Lcom/palai/prootsmoke/PetWindowService;->showLp:Landroid/view/WindowManager$LayoutParams;
    invoke-interface {v1, v4, v5}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    iget-object v4, v12, Lcom/palai/prootsmoke/PetWindowService;->showBox:Landroid/widget/FrameLayout;
    invoke-static {v12, v4, v4}, Lcom/palai/prootsmoke/PetKeyboardGuard;->install(Landroid/content/Context;Landroid/view/View;Landroid/view/View;)V
    const-string v1, "[PET] 显示层已挂载（全屏穿透）"
    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    goto :L177
    move-exception v1
    new-instance v4, Ljava/lang/StringBuilder;
    const-string v5, "[PET] 显示层 addView 失败: "
    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :L177
    new-instance v1, Landroid/widget/FrameLayout;
    invoke-direct {v1, v12}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V
    iput-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->touchBox:Landroid/widget/FrameLayout;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetKeyboardGuard;->setTouchLayer(Landroid/view/View;)V
    invoke-virtual {v1, v2}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->touchBox:Landroid/widget/FrameLayout;
    new-instance v4, Lcom/palai/prootsmoke/PetWindowService$7;
    invoke-direct {v4, v12}, Lcom/palai/prootsmoke/PetWindowService$7;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    invoke-virtual {v1, v4}, Landroid/widget/FrameLayout;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V
    new-instance v1, Landroid/view/WindowManager$LayoutParams;
    const/16 v9, #808
    const/4 v10, #-3
    const/16 v6, #520
    const/16 v7, #520
    move-object v5, v1
    move v8, v13
    invoke-direct/range {v5..v10}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V
    iput-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->touchLp:Landroid/view/WindowManager$LayoutParams;
    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->gravity:I
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->touchLp:Landroid/view/WindowManager$LayoutParams;
    iput v2, v13, Landroid/view/WindowManager$LayoutParams;->x:I
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->touchLp:Landroid/view/WindowManager$LayoutParams;
    iput v2, v13, Landroid/view/WindowManager$LayoutParams;->y:I
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->touchLp:Landroid/view/WindowManager$LayoutParams;
    const/16 v1, #16
    iput v1, v13, Landroid/view/WindowManager$LayoutParams;->softInputMode:I
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->touchBox:Landroid/widget/FrameLayout;
    invoke-virtual {v13, v2}, Landroid/widget/FrameLayout;->setFocusable(Z)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->touchBox:Landroid/widget/FrameLayout;
    invoke-virtual {v13, v2}, Landroid/widget/FrameLayout;->setFocusableInTouchMode(Z)V
    new-instance v13, Lcom/palai/prootsmoke/PetWindowService$8;
    invoke-direct {v13, v12, v12}, Lcom/palai/prootsmoke/PetWindowService$8;-><init>(Lcom/palai/prootsmoke/PetWindowService;Landroid/content/Context;)V
    iput-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v13, v2}, Landroid/widget/EditText;->setBackgroundColor(I)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v13, v2}, Landroid/widget/EditText;->setTextColor(I)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v13, v2}, Landroid/widget/EditText;->setCursorVisible(Z)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    const v1, #33554438
    invoke-virtual {v13, v1}, Landroid/widget/EditText;->setImeOptions(I)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    const/4 v1, #1
    invoke-virtual {v13, v1}, Landroid/widget/EditText;->setInputType(I)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v13, v1}, Landroid/widget/EditText;->setSingleLine(Z)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v13, v2}, Landroid/widget/EditText;->setFocusable(Z)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v13, v2}, Landroid/widget/EditText;->setFocusableInTouchMode(Z)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    new-instance v2, Lcom/palai/prootsmoke/PetWindowService$9;
    invoke-direct {v2, v12}, Lcom/palai/prootsmoke/PetWindowService$9;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    invoke-virtual {v13, v2}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    new-instance v2, Lcom/palai/prootsmoke/PetWindowService$10;
    invoke-direct {v2, v12}, Lcom/palai/prootsmoke/PetWindowService$10;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    invoke-virtual {v13, v2}, Landroid/widget/EditText;->setOnKeyListener(Landroid/view/View$OnKeyListener;)V
    new-instance v13, Landroid/widget/FrameLayout$LayoutParams;
    invoke-direct {v13, v1, v1}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->touchBox:Landroid/widget/FrameLayout;
    iget-object v2, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v1, v2, v13}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->wm:Landroid/view/WindowManager;
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->touchBox:Landroid/widget/FrameLayout;
    iget-object v2, v12, Lcom/palai/prootsmoke/PetWindowService;->touchLp:Landroid/view/WindowManager$LayoutParams;
    invoke-interface {v13, v1, v2}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    const-string v13, "[PET] 触摸层已挂载 520x520"
    invoke-static {v0, v13}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    goto :L357
    move-exception v13
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "[PET] 触摸层 addView 失败: "
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v13
    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v13
    invoke-static {v0, v13}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :L357
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->showBox:Landroid/widget/FrameLayout;
    new-instance v0, Lcom/palai/prootsmoke/PetWindowService$11;
    invoke-direct {v0, v12}, Lcom/palai/prootsmoke/PetWindowService$11;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    invoke-virtual {v13, v0}, Landroid/widget/FrameLayout;->addOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->ui:Landroid/os/Handler;
    new-instance v0, Lcom/palai/prootsmoke/PetWindowService$12;
    invoke-direct {v0, v12}, Lcom/palai/prootsmoke/PetWindowService$12;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    const-wide/16 v1, #1000
    invoke-virtual {v13, v0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->ui:Landroid/os/Handler;
    iget-object v0, v12, Lcom/palai/prootsmoke/PetWindowService;->followTick:Ljava/lang/Runnable;
    const-wide/16 v1, #300
    invoke-virtual {v13, v0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->diag(Ljava/lang/String;)V
    # registers=7 ins=2 tries=1
    const-string v0, "["
    const-string v1, "[DIAG] "
    const-string v2, "PetWindow"
    new-instance v3, Ljava/lang/StringBuilder;
    invoke-direct {v3, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    invoke-static {v2, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    new-instance v1, Ljava/io/FileOutputStream;
    const-string v2, "/sdcard/Download/coop-diag.txt"
    const/4 v3, #1
    invoke-direct {v1, v2, v3}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;Z)V
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v3
    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v2, "] "
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v6
    const-string v0, "
"
    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v6
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v6
    const-string v0, "UTF-8"
    invoke-virtual {v6, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B
    move-result-object v6
    invoke-virtual {v1, v6}, Ljava/io/FileOutputStream;->write([B)V
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->flush()V
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->focusImeAndShow()V
    # registers=5 ins=1 tries=1
    const-string v0, "[PET] 已请求 IME（hasFocus="
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    if-nez v1, :L7
    return-void 
    :L7
    const/4 v2, #1
    invoke-virtual {v1, v2}, Landroid/widget/EditText;->setFocusable(Z)V
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v1, v2}, Landroid/widget/EditText;->setFocusableInTouchMode(Z)V
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v1}, Landroid/widget/EditText;->requestFocus()Z
    const-string v1, "input_method"
    invoke-virtual {v4, v1}, Lcom/palai/prootsmoke/PetWindowService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Landroid/view/inputmethod/InputMethodManager;
    if-eqz v1, :L36
    iget-object v3, v4, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v1, v3, v2}, Landroid/view/inputmethod/InputMethodManager;->showSoftInput(Landroid/view/View;I)Z
    :L36
    const-string v1, "PetWindow"
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v0}, Landroid/widget/EditText;->hasFocus()Z
    move-result v0
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v2, "）"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->forwardToWeb(Landroid/view/MotionEvent;)Z
    # registers=22 ins=2 tries=1
    move-object/from16 v0, v20
    move-object/from16 v1, v21
    iget-object v2, v0, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    const/4 v3, #0
    if-nez v2, :L10
    return v3
    :L10
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getPointerCount()I
    move-result v9
    new-array v10, v9, [Landroid/view/MotionEvent$PointerProperties;
    new-array v11, v9, [Landroid/view/MotionEvent$PointerCoords;
    move v2, v3
    :L19
    if-ge v2, v9, :L88
    new-instance v4, Landroid/view/MotionEvent$PointerProperties;
    invoke-direct {v4}, Landroid/view/MotionEvent$PointerProperties;-><init>()V
    invoke-virtual {v1, v2}, Landroid/view/MotionEvent;->getPointerId(I)I
    move-result v5
    iput v5, v4, Landroid/view/MotionEvent$PointerProperties;->id:I
    invoke-virtual {v1, v2}, Landroid/view/MotionEvent;->getToolType(I)I
    move-result v5
    iput v5, v4, Landroid/view/MotionEvent$PointerProperties;->toolType:I
    aput-object v4, v10, v2
    new-instance v4, Landroid/view/MotionEvent$PointerCoords;
    invoke-direct {v4}, Landroid/view/MotionEvent$PointerCoords;-><init>()V
    if-nez v2, :L52
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getRawX()F
    move-result v5
    goto :L56
    :L52
    invoke-virtual {v1, v2}, Landroid/view/MotionEvent;->getX(I)F
    move-result v5
    :L56
    iput v5, v4, Landroid/view/MotionEvent$PointerCoords;->x:F
    if-nez v2, :L65
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getRawY()F
    move-result v5
    goto :L69
    :L65
    invoke-virtual {v1, v2}, Landroid/view/MotionEvent;->getY(I)F
    move-result v5
    :L69
    iput v5, v4, Landroid/view/MotionEvent$PointerCoords;->y:F
    invoke-virtual {v1, v2}, Landroid/view/MotionEvent;->getPressure(I)F
    move-result v5
    iput v5, v4, Landroid/view/MotionEvent$PointerCoords;->pressure:F
    invoke-virtual {v1, v2}, Landroid/view/MotionEvent;->getSize(I)F
    move-result v5
    iput v5, v4, Landroid/view/MotionEvent$PointerCoords;->size:F
    aput-object v4, v11, v2
    add-int/lit8 v2, v2, #1
    goto :L19
    :L88
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getDownTime()J
    move-result-wide v4
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getEventTime()J
    move-result-wide v6
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getAction()I
    move-result v8
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getMetaState()I
    move-result v12
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getButtonState()I
    move-result v13
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getXPrecision()F
    move-result v14
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getYPrecision()F
    move-result v15
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getDeviceId()I
    move-result v16
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getEdgeFlags()I
    move-result v17
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getSource()I
    move-result v18
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getFlags()I
    move-result v19
    invoke-static/range {v4..v19}, Landroid/view/MotionEvent;->obtain(JJII[Landroid/view/MotionEvent$PointerProperties;[Landroid/view/MotionEvent$PointerCoords;IIFFIIII)Landroid/view/MotionEvent;
    move-result-object v1
    iget-object v2, v0, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    invoke-virtual {v2, v1}, Landroid/webkit/WebView;->dispatchTouchEvent(Landroid/view/MotionEvent;)Z
    move-result v2
    invoke-virtual {v1}, Landroid/view/MotionEvent;->recycle()V
    return v2
    return v3
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/PetWindowService;->jsStr(Ljava/lang/String;)Ljava/lang/String;
    # registers=6 ins=1 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, """
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    const/4 v1, #0
    :L8
    invoke-virtual {v5}, Ljava/lang/String;->length()I
    move-result v2
    const/16 v3, #34
    if-ge v1, v2, :L83
    invoke-virtual {v5, v1}, Ljava/lang/String;->charAt(I)C
    move-result v2
    const/16 v4, #92
    if-eq v2, v3, :L73
    if-ne v2, v4, :L27
    goto :L73
    :L27
    const/16 v3, #10
    if-ne v2, v3, :L37
    const-string v2, "\n"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :L80
    :L37
    const/16 v3, #13
    if-ne v2, v3, :L47
    const-string v2, "\r"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :L80
    :L47
    const/16 v3, #32
    if-ge v2, v3, :L69
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v2
    filled-new-array {v2}, Landroid/widget/TextView;->setTextSize(F)V
    move-result-object v2
    const-string v3, "\u%04x"
    invoke-static {v3, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :L80
    :L69
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    goto :L80
    :L73
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    :L80
    add-int/lit8 v1, v1, #1
    goto :L8
    :L83
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    move-result-object v5
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v5
    return-object v5
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->pushKeyToPage(Ljava/lang/String;)V
    # registers=4 ins=2 tries=0
    iget-object v3, v2, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    if-nez v3, :L5
    return-void 
    :L5
    const-string v0, "(function(){try{var ae=document.activeElement;var el=null;if(ae && (ae.tagName==='INPUT'||ae.tagName==='TEXTAREA')) el=ae;if(!el) el=document.querySelector('#bubble input,#bubble textarea,.d-body input,.d-body textarea');if(!el) return 'no-target';el.value=(el.value||'').slice(0,-1);el.dispatchEvent(new Event('input',{bubbles:true}));return 'ok';}catch(e){return 'err';}})()"
    const/4 v1, #0
    invoke-virtual {v3, v0, v1}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->pushTextToPage(Ljava/lang/String;)V
    # registers=4 ins=2 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    if-nez v0, :L5
    return-void 
    :L5
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "(function(){try{var ae=document.activeElement;var el=null;if(ae && (ae.tagName==='INPUT'||ae.tagName==='TEXTAREA')) el=ae;if(!el) el=document.querySelector('#bubble input,#bubble textarea,.d-body input,.d-body textarea,input:focus,textarea:focus');if(!el) return 'no-target';el.value=(el.value||'')+"
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-static {v3}, Lcom/palai/prootsmoke/PetWindowService;->jsStr(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    const-string v0, ";el.dispatchEvent(new Event('input',{bubbles:true}));return 'ok';}catch(e){return 'err';}})()"
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    const/4 v1, #0
    invoke-virtual {v0, v3, v1}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->queryPetRect()V
    # registers=4 ins=1 tries=0
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    if-nez v0, :L5
    return-void 
    :L5
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$15;
    invoke-direct {v1, v3}, Lcom/palai/prootsmoke/PetWindowService$15;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    const-string v2, "(function(){try{var box='';try{if(window.__petUnionRect)box=window.__petUnionRect()||'';}catch(e0){}if(!box){function r(id){var e=document.getElementById(id);  if(!e) return null; var st=window.getComputedStyle(e);  if(st.display==='none'||st.visibility==='hidden'||e.hidden) return null;  var b=e.getBoundingClientRect(); if(b.width<1&&b.height<1) return null; return b; }var ids=['pet','pet2','pet3','pet4','bubble','bubble2','bubble3','bubble4','menu','tools'];var arr=[];for(var i=0;i<ids.length;i++){var q=r(ids[i]); if(q) arr.push(q);}if(arr.length){var l=1e9,t=1e9,rr=-1e9,b=-1e9;  for(var k=0;k<arr.length;k++){var q=arr[k];    if(q.left<l)l=q.left; if(q.top<t)t=q.top;    if(q.right>rr)rr=q.right; if(q.bottom>b)b=q.bottom; }  box=l+','+t+','+rr+','+b; }}var ae=document.activeElement;var focused = !!(ae && (ae.tagName==='INPUT'||ae.tagName==='TEXTAREA'||ae.isContentEditable));return box+'|'+(focused?'1':'0');}catch(err){return '';}})()"
    invoke-virtual {v0, v2, v1}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->showPetWindow()V
    # registers=5 ins=1 tries=0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v1, #26
    if-lt v0, v1, :L9
    const/16 v0, #2038
    goto :L11
    :L9
    const/16 v0, #2002
    :L11
    new-instance v1, Landroid/webkit/WebView;
    invoke-direct {v1, v4}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V
    iput-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    invoke-virtual {v1}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v1
    const/4 v2, #1
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V
    const/4 v3, #0
    invoke-virtual {v1, v3}, Landroid/webkit/WebSettings;->setMixedContentMode(I)V
    invoke-virtual {v1, v3}, Landroid/webkit/WebSettings;->setMediaPlaybackRequiresUserGesture(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setUseWideViewPort(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setLoadWithOverviewMode(Z)V
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    invoke-virtual {v1, v3}, Landroid/webkit/WebView;->setBackgroundColor(I)V
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    const/4 v2, #0
    invoke-virtual {v1, v3, v2}, Landroid/webkit/WebView;->setLayerType(ILandroid/graphics/Paint;)V
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    invoke-virtual {v1, v3}, Landroid/webkit/WebView;->setVerticalScrollBarEnabled(Z)V
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    invoke-virtual {v1, v3}, Landroid/webkit/WebView;->setHorizontalScrollBarEnabled(Z)V
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    const/4 v2, #2
    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->setOverScrollMode(I)V
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$2;
    invoke-direct {v1, v4, v0}, Lcom/palai/prootsmoke/PetWindowService$2;-><init>(Lcom/palai/prootsmoke/PetWindowService;I)V
    invoke-direct {v4, v1}, Lcom/palai/prootsmoke/PetWindowService;->warmUpRenderer(Ljava/lang/Runnable;)V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->sizeTouchTo(IIII)V
    # registers=13 ins=5 tries=0
    iget v0, v8, Lcom/palai/prootsmoke/PetWindowService;->lastTouchX:I
    if-ne v9, v0, :L17
    iget v0, v8, Lcom/palai/prootsmoke/PetWindowService;->lastTouchY:I
    if-ne v10, v0, :L17
    iget v0, v8, Lcom/palai/prootsmoke/PetWindowService;->lastTouchW:I
    if-ne v11, v0, :L17
    iget v0, v8, Lcom/palai/prootsmoke/PetWindowService;->lastTouchH:I
    if-ne v12, v0, :L17
    return-void 
    :L17
    iput v9, v8, Lcom/palai/prootsmoke/PetWindowService;->lastTouchX:I
    iput v10, v8, Lcom/palai/prootsmoke/PetWindowService;->lastTouchY:I
    iput v11, v8, Lcom/palai/prootsmoke/PetWindowService;->lastTouchW:I
    iput v12, v8, Lcom/palai/prootsmoke/PetWindowService;->lastTouchH:I
    iget-object v0, v8, Lcom/palai/prootsmoke/PetWindowService;->ui:Landroid/os/Handler;
    new-instance v7, Lcom/palai/prootsmoke/PetWindowService$17;
    move-object v1, v7
    move-object v2, v8
    move v3, v9
    move v4, v10
    move v5, v11
    move v6, v12
    invoke-direct/range {v1..v6}, Lcom/palai/prootsmoke/PetWindowService$17;-><init>(Lcom/palai/prootsmoke/PetWindowService;IIII)V
    invoke-virtual {v0, v7}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->startForegroundCompat()V
    # registers=8 ins=1 tries=0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/4 v1, #0
    const/4 v2, #1
    const-string v3, "coopanion_pet"
    const/16 v4, #26
    if-lt v0, v4, :L31
    const-string v0, "notification"
    invoke-virtual {v7, v0}, Lcom/palai/prootsmoke/PetWindowService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/app/NotificationManager;
    new-instance v5, Landroid/app/NotificationChannel;
    const-string v6, "桌宠运行中"
    invoke-direct {v5, v3, v6, v2}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V
    invoke-virtual {v5, v1}, Landroid/app/NotificationChannel;->setShowBadge(Z)V
    invoke-virtual {v0, v5}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V
    :L31
    new-instance v0, Landroid/content/Intent;
    const-class v5, Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0, v7, v5}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    const/high16 v5, #int 0xc000000
    invoke-static {v7, v1, v0, v5}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;
    move-result-object v0
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I
    if-lt v1, v4, :L54
    new-instance v1, Landroid/app/Notification$Builder;
    invoke-direct {v1, v7, v3}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V
    goto :L59
    :L54
    new-instance v1, Landroid/app/Notification$Builder;
    invoke-direct {v1, v7}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;)V
    :L59
    const-string v3, "Coopanion"
    invoke-virtual {v1, v3}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;
    move-result-object v3
    const-string v4, "桌宠正在运行"
    invoke-virtual {v3, v4}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;
    move-result-object v3
    const v4, #17301561
    invoke-virtual {v3, v4}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;
    move-result-object v3
    invoke-virtual {v3, v0}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;
    move-result-object v0
    invoke-virtual {v0, v2}, Landroid/app/Notification$Builder;->setOngoing(Z)Landroid/app/Notification$Builder;
    const/16 v0, #8801
    invoke-virtual {v1}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;
    move-result-object v1
    invoke-virtual {v7, v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->startForeground(ILandroid/app/Notification;)V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->startRepaintWatchdog(Landroid/webkit/WebView;)V
    # registers=9 ins=2 tries=0
    const/4 v0, #0
    :L1
    const/16 v1, #40
    if-ge v0, v1, :L22
    iget-object v1, v7, Lcom/palai/prootsmoke/PetWindowService;->ui:Landroid/os/Handler;
    new-instance v2, Lcom/palai/prootsmoke/PetWindowService$13;
    invoke-direct {v2, v7, v8}, Lcom/palai/prootsmoke/PetWindowService$13;-><init>(Lcom/palai/prootsmoke/PetWindowService;Landroid/webkit/WebView;)V
    add-int/lit8 v0, v0, #1
    int-to-long v3, v0
    const-wide/16 v5, #200
    mul-long/2addr v3, v5
    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    goto :L1
    :L22
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->warmUpRenderer(Ljava/lang/Runnable;)V
    # registers=21 ins=2 tries=3
    move-object/from16 v8, v19
    const-string v9, "PetWindow"
    const-string v10, "[PET] 预热窗口挂载失败，跳过预热: "
    new-instance v0, Landroid/webkit/WebView;
    invoke-direct {v0, v8}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V
    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v1
    const/4 v2, #1
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V
    const/4 v3, #0
    invoke-virtual {v1, v3}, Landroid/webkit/WebSettings;->setMixedContentMode(I)V
    invoke-virtual {v0, v3}, Landroid/webkit/WebView;->setBackgroundColor(I)V
    const/4 v1, #0
    invoke-virtual {v0, v3, v1}, Landroid/webkit/WebView;->setLayerType(ILandroid/graphics/Paint;)V
    const-string v1, "window"
    invoke-virtual {v8, v1}, Lcom/palai/prootsmoke/PetWindowService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v1
    move-object v11, v1
    check-cast v11, Landroid/view/WindowManager;
    new-instance v12, Landroid/widget/FrameLayout;
    invoke-direct {v12, v8}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V
    invoke-virtual {v12, v3}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V
    new-instance v1, Landroid/widget/FrameLayout$LayoutParams;
    invoke-direct {v1, v2, v2}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V
    invoke-virtual {v12, v0, v1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    new-instance v7, Landroid/view/WindowManager$LayoutParams;
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v4, #26
    if-lt v1, v4, :L72
    const/16 v1, #2038
    goto :L74
    :L72
    const/16 v1, #2002
    :L74
    move/from16 v16, v1
    const/16 v17, #24
    const/16 v18, #-3
    const/4 v14, #1
    const/4 v15, #1
    move-object v13, v7
    invoke-direct/range {v13..v18}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V
    const v1, #8388659
    iput v1, v7, Landroid/view/WindowManager$LayoutParams;->gravity:I
    new-array v4, v2, [Z
    aput-boolean v3, v4, v3
    new-instance v13, Lcom/palai/prootsmoke/PetWindowService$3;
    move-object v1, v13
    move-object/from16 v2, v19
    move-object v3, v4
    move-object v4, v11
    move-object v5, v12
    move-object v6, v0
    move-object v14, v7
    move-object/from16 v7, v20
    invoke-direct/range {v1..v7}, Lcom/palai/prootsmoke/PetWindowService$3;-><init>(Lcom/palai/prootsmoke/PetWindowService;[ZLandroid/view/WindowManager;Landroid/widget/FrameLayout;Landroid/webkit/WebView;Ljava/lang/Runnable;)V
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$4;
    invoke-direct {v1, v8, v13}, Lcom/palai/prootsmoke/PetWindowService$4;-><init>(Lcom/palai/prootsmoke/PetWindowService;Ljava/lang/Runnable;)V
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V
    invoke-interface {v11, v12, v14}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    const-string v1, "http://127.0.0.1:7797/pet"
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    iget-object v0, v8, Lcom/palai/prootsmoke/PetWindowService;->ui:Landroid/os/Handler;
    const-wide/16 v1, #2500
    invoke-virtual {v0, v13, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    goto :L178
    move-exception v0
    move-object v1, v0
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0, v10}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static {v9, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    invoke-interface {v13}, Ljava/lang/Runnable;->run()V
    return-void 
    move-exception v0
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "[PET] 预热异常，跳过预热: "
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static {v9, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    invoke-interface/range {v20..v20}, Ljava/lang/Runnable;->run()V
    :L178
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService;->onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    # registers=2 ins=2 tries=0
    const/4 v1, #0
    return-object v1
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService;->onCreate()V
    # registers=3 ins=1 tries=0
    invoke-super {v2}, Landroid/app/Service;->onCreate()V
    invoke-direct {v2}, Lcom/palai/prootsmoke/PetWindowService;->startForegroundCompat()V
    const-string v0, "window"
    invoke-virtual {v2, v0}, Lcom/palai/prootsmoke/PetWindowService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/view/WindowManager;
    iput-object v0, v2, Lcom/palai/prootsmoke/PetWindowService;->wm:Landroid/view/WindowManager;
    new-instance v0, Landroid/util/DisplayMetrics;
    invoke-direct {v0}, Landroid/util/DisplayMetrics;-><init>()V
    iget-object v1, v2, Lcom/palai/prootsmoke/PetWindowService;->wm:Landroid/view/WindowManager;
    invoke-interface {v1}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;
    move-result-object v1
    invoke-virtual {v1, v0}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V
    iget v1, v0, Landroid/util/DisplayMetrics;->widthPixels:I
    iput v1, v2, Lcom/palai/prootsmoke/PetWindowService;->screenW:I
    iget v0, v0, Landroid/util/DisplayMetrics;->heightPixels:I
    iput v0, v2, Lcom/palai/prootsmoke/PetWindowService;->screenH:I
    invoke-direct {v2}, Lcom/palai/prootsmoke/PetWindowService;->showPetWindow()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService;->onDestroy()V
    # registers=5 ins=1 tries=4
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService;->ui:Landroid/os/Handler;
    const/4 v1, #0
    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacksAndMessages(Ljava/lang/Object;)V
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    if-eqz v0, :L35
    const-string v0, "input_method"
    invoke-virtual {v4, v0}, Lcom/palai/prootsmoke/PetWindowService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/view/inputmethod/InputMethodManager;
    if-eqz v0, :L30
    iget-object v2, v4, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v2}, Landroid/widget/EditText;->getWindowToken()Landroid/os/IBinder;
    move-result-object v2
    const/4 v3, #0
    invoke-virtual {v0, v2, v3}, Landroid/view/inputmethod/InputMethodManager;->hideSoftInputFromWindow(Landroid/os/IBinder;I)Z
    :L30
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v0}, Landroid/widget/EditText;->clearFocus()V
    :L35
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    if-eqz v0, :L51
    const-string v2, "about:blank"
    invoke-virtual {v0, v2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    invoke-virtual {v0}, Landroid/webkit/WebView;->destroy()V
    iput-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    :L51
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService;->touchBox:Landroid/widget/FrameLayout;
    if-eqz v0, :L60
    iget-object v2, v4, Lcom/palai/prootsmoke/PetWindowService;->wm:Landroid/view/WindowManager;
    invoke-interface {v2, v0}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    :L60
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService;->showBox:Landroid/widget/FrameLayout;
    if-eqz v0, :L69
    iget-object v2, v4, Lcom/palai/prootsmoke/PetWindowService;->wm:Landroid/view/WindowManager;
    invoke-interface {v2, v0}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    :L69
    iput-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->touchBox:Landroid/widget/FrameLayout;
    iput-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->showBox:Landroid/widget/FrameLayout;
    invoke-super {v4}, Landroid/app/Service;->onDestroy()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService;->onStartCommand(Landroid/content/Intent;II)I
    # registers=4 ins=4 tries=1
    if-eqz v1, :L32
    const-string v2, "com.palai.prootsmoke.SET_ALPHA"
    invoke-virtual {v1}, Landroid/content/Intent;->getAction()Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-eqz v2, :L32
    const-string v2, "alpha"
    iget v3, v0, Lcom/palai/prootsmoke/PetWindowService;->petAlpha:F
    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->getFloatExtra(Ljava/lang/String;F)F
    move-result v1
    iget-object v2, v0, Lcom/palai/prootsmoke/PetWindowService;->ui:Landroid/os/Handler;
    new-instance v3, Lcom/palai/prootsmoke/PetWindowService$1;
    invoke-direct {v3, v0, v1}, Lcom/palai/prootsmoke/PetWindowService$1;-><init>(Lcom/palai/prootsmoke/PetWindowService;F)V
    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :L32
    const/4 v1, #1
    return v1
.end method

.class public final Lcom/palai/prootsmoke/R$mipmap;
.super Ljava/lang/Object;

.field public static ic_launcher:I
.field public static ic_launcher_round:I

# direct access=0x10002
.method private constructor Lcom/palai/prootsmoke/R$mipmap;-><init>()V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

.class public final Lcom/palai/prootsmoke/R$style;
.super Ljava/lang/Object;

.field public static AppTheme:I
.field public static PetTheme:I

# direct access=0x10002
.method private constructor Lcom/palai/prootsmoke/R$style;-><init>()V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

.class public final Lcom/palai/prootsmoke/R;
.super Ljava/lang/Object;

# direct access=0x10002
.method private constructor Lcom/palai/prootsmoke/R;-><init>()V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

.class Lcom/palai/prootsmoke/RepairActivity$1;
.super Landroid/webkit/WebChromeClient;

.field final synthetic this$0:Lcom/palai/prootsmoke/RepairActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/RepairActivity$1;-><init>(Lcom/palai/prootsmoke/RepairActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/RepairActivity$1;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-direct {v0}, Landroid/webkit/WebChromeClient;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/RepairActivity$1;->onShowFileChooser(Landroid/webkit/WebView;Landroid/webkit/ValueCallback;Landroid/webkit/WebChromeClient$FileChooserParams;)Z
    # registers=5 ins=4 tries=2
    const-string v2, "[REPAIRACT][FILE] onShowFileChooser"
    invoke-static {v2}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    iget-object v2, v1, Lcom/palai/prootsmoke/RepairActivity$1;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fgetfilePathCallback(Lcom/palai/prootsmoke/RepairActivity;)Landroid/webkit/ValueCallback;
    move-result-object v2
    const/4 v4, #0
    if-eqz v2, :L23
    iget-object v2, v1, Lcom/palai/prootsmoke/RepairActivity$1;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fgetfilePathCallback(Lcom/palai/prootsmoke/RepairActivity;)Landroid/webkit/ValueCallback;
    move-result-object v2
    invoke-interface {v2, v4}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V
    :L23
    iget-object v2, v1, Lcom/palai/prootsmoke/RepairActivity$1;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-static {v2, v3}, Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fputfilePathCallback(Lcom/palai/prootsmoke/RepairActivity;Landroid/webkit/ValueCallback;)V
    new-instance v2, Landroid/content/Intent;
    const-string v3, "android.intent.action.GET_CONTENT"
    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    const-string v3, "android.intent.category.OPENABLE"
    invoke-virtual {v2, v3}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;
    const-string v3, "image/*"
    invoke-virtual {v2, v3}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;
    iget-object v3, v1, Lcom/palai/prootsmoke/RepairActivity$1;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    const-string v0, "select image"
    invoke-static {v2, v0}, Landroid/content/Intent;->createChooser(Landroid/content/Intent;Ljava/lang/CharSequence;)Landroid/content/Intent;
    move-result-object v2
    const/16 v0, #20818
    invoke-virtual {v3, v2, v0}, Lcom/palai/prootsmoke/RepairActivity;->startActivityForResult(Landroid/content/Intent;I)V
    const/4 v2, #1
    return v2
    move-exception v2
    new-instance v3, Ljava/lang/StringBuilder;
    const-string v0, "[REPAIRACT][FILE] err: "
    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    invoke-static {v2}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    iget-object v2, v1, Lcom/palai/prootsmoke/RepairActivity$1;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fgetfilePathCallback(Lcom/palai/prootsmoke/RepairActivity;)Landroid/webkit/ValueCallback;
    move-result-object v2
    if-eqz v2, :L101
    iget-object v2, v1, Lcom/palai/prootsmoke/RepairActivity$1;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fgetfilePathCallback(Lcom/palai/prootsmoke/RepairActivity;)Landroid/webkit/ValueCallback;
    move-result-object v2
    invoke-interface {v2, v4}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V
    iget-object v2, v1, Lcom/palai/prootsmoke/RepairActivity$1;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-static {v2, v4}, Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fputfilePathCallback(Lcom/palai/prootsmoke/RepairActivity;Landroid/webkit/ValueCallback;)V
    :L101
    const/4 v2, #0
    return v2
.end method

.class Lcom/palai/prootsmoke/RepairActivity$2;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/RepairActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/RepairActivity$2;-><init>(Lcom/palai/prootsmoke/RepairActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/RepairActivity$2;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/RepairActivity$2;->onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    # registers=3 ins=3 tries=1
    invoke-virtual {v2}, Landroid/view/MotionEvent;->getAction()I
    move-result v2
    if-nez v2, :L9
    invoke-virtual {v1}, Landroid/view/View;->requestFocus()Z
    :L9
    const/4 v1, #0
    return v1
.end method

.class Lcom/palai/prootsmoke/RepairActivity$3;
.super Landroid/webkit/WebViewClient;

.field final synthetic this$0:Lcom/palai/prootsmoke/RepairActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/RepairActivity$3;-><init>(Lcom/palai/prootsmoke/RepairActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/RepairActivity$3;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-direct {v0}, Landroid/webkit/WebViewClient;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/RepairActivity$3;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    # registers=5 ins=3 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[REPAIRACT] onPageFinished: "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v4
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-static {v4}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    const-string v4, "(function(){ if(window.__imeHack) return; window.__imeHack=1;document.addEventListener('focusin',function(ev){  var t=ev.target; if(!t) return;  var tag=(t.tagName||'').toUpperCase();  if(tag==='INPUT'||tag==='TEXTAREA'||t.isContentEditable){    try{ window.__wantIme=1; }catch(e){}  }},true);window.__imeProbe=function(){var a=document.activeElement;  return (a&&(a.tagName==='INPUT'||a.tagName==='TEXTAREA'||a.isContentEditable))?1:0;};})()"
    const/4 v0, #0
    invoke-virtual {v3, v4, v0}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    iget-object v4, v2, Lcom/palai/prootsmoke/RepairActivity$3;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-static {v4, v3}, Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$mstartImeWatchdog(Lcom/palai/prootsmoke/RepairActivity;Landroid/webkit/WebView;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/RepairActivity$4;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/RepairActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/RepairActivity$4;-><init>(Lcom/palai/prootsmoke/RepairActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/RepairActivity$4;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/RepairActivity$4;->onClick(Landroid/view/View;)V
    # registers=2 ins=2 tries=0
    iget-object v1, v0, Lcom/palai/prootsmoke/RepairActivity$4;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-virtual {v1}, Lcom/palai/prootsmoke/RepairActivity;->finish()V
    return-void 
.end method

.class Lcom/palai/prootsmoke/RepairActivity$5$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/RepairActivity$5;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/RepairActivity$5$1;-><init>(Lcom/palai/prootsmoke/RepairActivity$5;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/RepairActivity$5$1;->this$1:Lcom/palai/prootsmoke/RepairActivity$5;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1041
.method public bridge synthetic Lcom/palai/prootsmoke/RepairActivity$5$1;->onReceiveValue(Ljava/lang/Object;)V
    # registers=2 ins=2 tries=0
    check-cast v1, Ljava/lang/String;
    invoke-virtual {v0, v1}, Lcom/palai/prootsmoke/RepairActivity$5$1;->onReceiveValue(Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/RepairActivity$5$1;->onReceiveValue(Ljava/lang/String;)V
    # registers=5 ins=2 tries=0
    const/4 v0, #1
    const/4 v1, #0
    if-eqz v4, :L14
    const-string v2, "1"
    invoke-virtual {v4, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v4
    if-eqz v4, :L14
    move v4, v0
    goto :L15
    :L14
    move v4, v1
    :L15
    if-eqz v4, :L42
    iget-object v2, v3, Lcom/palai/prootsmoke/RepairActivity$5$1;->this$1:Lcom/palai/prootsmoke/RepairActivity$5;
    iget-object v2, v2, Lcom/palai/prootsmoke/RepairActivity$5;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fgetimeShown(Lcom/palai/prootsmoke/RepairActivity;)Z
    move-result v2
    if-nez v2, :L42
    iget-object v4, v3, Lcom/palai/prootsmoke/RepairActivity$5$1;->this$1:Lcom/palai/prootsmoke/RepairActivity$5;
    iget-object v4, v4, Lcom/palai/prootsmoke/RepairActivity$5;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-static {v4, v0}, Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fputimeShown(Lcom/palai/prootsmoke/RepairActivity;Z)V
    iget-object v4, v3, Lcom/palai/prootsmoke/RepairActivity$5$1;->this$1:Lcom/palai/prootsmoke/RepairActivity$5;
    iget-object v4, v4, Lcom/palai/prootsmoke/RepairActivity$5;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-static {v4}, Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$mshowImeNow(Lcom/palai/prootsmoke/RepairActivity;)V
    goto :L51
    :L42
    if-nez v4, :L51
    iget-object v4, v3, Lcom/palai/prootsmoke/RepairActivity$5$1;->this$1:Lcom/palai/prootsmoke/RepairActivity$5;
    iget-object v4, v4, Lcom/palai/prootsmoke/RepairActivity$5;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-static {v4, v1}, Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fputimeShown(Lcom/palai/prootsmoke/RepairActivity;Z)V
    :L51
    return-void 
.end method

.class Lcom/palai/prootsmoke/RepairActivity$5;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/RepairActivity;
.field final synthetic val$v:Landroid/webkit/WebView;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/RepairActivity$5;-><init>(Lcom/palai/prootsmoke/RepairActivity;Landroid/webkit/WebView;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/RepairActivity$5;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    iput-object v2, v0, Lcom/palai/prootsmoke/RepairActivity$5;->val$v:Landroid/webkit/WebView;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/RepairActivity$5;->run()V
    # registers=4 ins=1 tries=1
    iget-object v0, v3, Lcom/palai/prootsmoke/RepairActivity$5;->val$v:Landroid/webkit/WebView;
    if-nez v0, :L5
    return-void 
    :L5
    const-string v1, "(window.__imeProbe?window.__imeProbe():0)"
    new-instance v2, Lcom/palai/prootsmoke/RepairActivity$5$1;
    invoke-direct {v2, v3}, Lcom/palai/prootsmoke/RepairActivity$5$1;-><init>(Lcom/palai/prootsmoke/RepairActivity$5;)V
    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    iget-object v0, v3, Lcom/palai/prootsmoke/RepairActivity$5;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fgetimeHandler(Lcom/palai/prootsmoke/RepairActivity;)Landroid/os/Handler;
    move-result-object v0
    if-eqz v0, :L34
    iget-object v0, v3, Lcom/palai/prootsmoke/RepairActivity$5;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fgetimeHandler(Lcom/palai/prootsmoke/RepairActivity;)Landroid/os/Handler;
    move-result-object v0
    const-wide/16 v1, #400
    invoke-virtual {v0, v3, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    :L34
    return-void 
.end method

.class public Lcom/palai/prootsmoke/RepairActivity;
.super Landroid/app/Activity;

.field private static final REPAIR_URL:Ljava/lang/String;
.field private static final REQ_FILE:I
.field private filePathCallback:Landroid/webkit/ValueCallback;
.field private imeHandler:Landroid/os/Handler;
.field private imeShown:Z
.field private web:Landroid/webkit/WebView;

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fgetfilePathCallback(Lcom/palai/prootsmoke/RepairActivity;)Landroid/webkit/ValueCallback;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/RepairActivity;->filePathCallback:Landroid/webkit/ValueCallback;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fgetimeHandler(Lcom/palai/prootsmoke/RepairActivity;)Landroid/os/Handler;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/RepairActivity;->imeHandler:Landroid/os/Handler;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fgetimeShown(Lcom/palai/prootsmoke/RepairActivity;)Z
    # registers=1 ins=1 tries=0
    iget-boolean v0, v0, Lcom/palai/prootsmoke/RepairActivity;->imeShown:Z
    return v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fputfilePathCallback(Lcom/palai/prootsmoke/RepairActivity;Landroid/webkit/ValueCallback;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/RepairActivity;->filePathCallback:Landroid/webkit/ValueCallback;
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fputimeShown(Lcom/palai/prootsmoke/RepairActivity;Z)V
    # registers=2 ins=2 tries=0
    iput-boolean v1, v0, Lcom/palai/prootsmoke/RepairActivity;->imeShown:Z
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$mshowImeNow(Lcom/palai/prootsmoke/RepairActivity;)V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/RepairActivity;->showImeNow()V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$mstartImeWatchdog(Lcom/palai/prootsmoke/RepairActivity;Landroid/webkit/WebView;)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/RepairActivity;->startImeWatchdog(Landroid/webkit/WebView;)V
    return-void 
.end method

# direct access=0x10001
.method public constructor Lcom/palai/prootsmoke/RepairActivity;-><init>()V
    # registers=2 ins=1 tries=0
    invoke-direct {v1}, Landroid/app/Activity;-><init>()V
    const/4 v0, #0
    iput-boolean v0, v1, Lcom/palai/prootsmoke/RepairActivity;->imeShown:Z
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/RepairActivity;->showImeNow()V
    # registers=4 ins=1 tries=1
    iget-object v0, v3, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    if-nez v0, :L5
    return-void 
    :L5
    invoke-virtual {v0}, Landroid/webkit/WebView;->requestFocus()Z
    const-string v0, "input_method"
    invoke-virtual {v3, v0}, Lcom/palai/prootsmoke/RepairActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/view/inputmethod/InputMethodManager;
    if-eqz v0, :L49
    iget-object v1, v3, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    const/4 v2, #1
    invoke-virtual {v0, v1, v2}, Landroid/view/inputmethod/InputMethodManager;->showSoftInput(Landroid/view/View;I)Z
    const-string v0, "[REPAIRACT][IME] showSoftInput requested"
    invoke-static {v0}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    goto :L49
    move-exception v0
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "[REPAIRACT][IME] err: "
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static {v0}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    :L49
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/RepairActivity;->startImeWatchdog(Landroid/webkit/WebView;)V
    # registers=5 ins=2 tries=0
    iget-object v0, v3, Lcom/palai/prootsmoke/RepairActivity;->imeHandler:Landroid/os/Handler;
    if-nez v0, :L15
    new-instance v0, Landroid/os/Handler;
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;
    move-result-object v1
    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
    iput-object v0, v3, Lcom/palai/prootsmoke/RepairActivity;->imeHandler:Landroid/os/Handler;
    :L15
    new-instance v0, Lcom/palai/prootsmoke/RepairActivity$5;
    invoke-direct {v0, v3, v4}, Lcom/palai/prootsmoke/RepairActivity$5;-><init>(Lcom/palai/prootsmoke/RepairActivity;Landroid/webkit/WebView;)V
    iget-object v4, v3, Lcom/palai/prootsmoke/RepairActivity;->imeHandler:Landroid/os/Handler;
    const-wide/16 v1, #600
    invoke-virtual {v4, v0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    return-void 
.end method

# virtual access=0x4
.method protected Lcom/palai/prootsmoke/RepairActivity;->onActivityResult(IILandroid/content/Intent;)V
    # registers=8 ins=4 tries=1
    const/16 v0, #20818
    if-ne v5, v0, :L97
    const/4 v0, #-1
    const/4 v1, #1
    const/4 v2, #0
    const/4 v3, #0
    if-ne v6, v0, :L27
    if-eqz v7, :L27
    invoke-virtual {v7}, Landroid/content/Intent;->getData()Landroid/net/Uri;
    move-result-object v0
    if-eqz v0, :L27
    new-array v0, v1, [Landroid/net/Uri;
    invoke-virtual {v7}, Landroid/content/Intent;->getData()Landroid/net/Uri;
    move-result-object v7
    aput-object v7, v0, v3
    goto :L28
    :L27
    move-object v0, v2
    :L28
    iget-object v7, v4, Lcom/palai/prootsmoke/RepairActivity;->filePathCallback:Landroid/webkit/ValueCallback;
    if-eqz v7, :L37
    invoke-interface {v7, v0}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V
    iput-object v2, v4, Lcom/palai/prootsmoke/RepairActivity;->filePathCallback:Landroid/webkit/ValueCallback;
    :L37
    new-instance v7, Ljava/lang/StringBuilder;
    const-string v2, "[REPAIRACT][FILE] onActivityResult req="
    invoke-direct {v7, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v5
    const-string v7, " res="
    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v5
    const-string v6, " ok="
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
    if-eqz v0, :L67
    goto :L68
    :L67
    move v1, v3
    :L68
    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
    move-result-object v5
    const-string v6, " uri="
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
    if-eqz v0, :L83
    aget-object v6, v0, v3
    goto :L85
    :L83
    const-string v6, "null"
    :L85
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v5
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v5
    invoke-static {v5}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    goto :L100
    :L97
    invoke-super {v4, v5, v6, v7}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V
    :L100
    return-void 
.end method

# virtual access=0x4
.method protected Lcom/palai/prootsmoke/RepairActivity;->onCreate(Landroid/os/Bundle;)V
    # registers=6 ins=2 tries=1
    invoke-super {v4, v5}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V
    invoke-static {v4}, Lcom/palai/prootsmoke/AppLog;->init(Landroid/content/Context;)V
    const-string v5, "[REPAIRACT] ===== RepairActivity onCreate ====="
    invoke-static {v5}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    invoke-virtual {v4}, Lcom/palai/prootsmoke/RepairActivity;->getWindow()Landroid/view/Window;
    move-result-object v5
    const/16 v0, #1024
    invoke-virtual {v5, v0, v0}, Landroid/view/Window;->setFlags(II)V
    invoke-virtual {v4}, Lcom/palai/prootsmoke/RepairActivity;->getWindow()Landroid/view/Window;
    move-result-object v5
    const/16 v0, #16
    invoke-virtual {v5, v0}, Landroid/view/Window;->setSoftInputMode(I)V
    new-instance v5, Landroid/widget/FrameLayout;
    invoke-direct {v5, v4}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V
    const v0, #-16052460
    invoke-virtual {v5, v0}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V
    new-instance v1, Landroid/webkit/WebView;
    invoke-direct {v1, v4}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V
    iput-object v1, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v1}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v1
    const/4 v2, #1
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V
    const/4 v3, #0
    invoke-virtual {v1, v3}, Landroid/webkit/WebSettings;->setMixedContentMode(I)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V
    invoke-virtual {v1, v3}, Landroid/webkit/WebSettings;->setMediaPlaybackRequiresUserGesture(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDatabaseEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setSupportZoom(Z)V
    invoke-virtual {v1, v3}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setAllowContentAccess(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptCanOpenWindowsAutomatically(Z)V
    iget-object v1, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->setFocusable(Z)V
    iget-object v1, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->setFocusableInTouchMode(Z)V
    iget-object v1, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->setClickable(Z)V
    iget-object v1, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v1}, Landroid/webkit/WebView;->requestFocus()Z
    iget-object v1, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v1, v0}, Landroid/webkit/WebView;->setBackgroundColor(I)V
    iget-object v0, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    new-instance v1, Lcom/palai/prootsmoke/RepairActivity$1;
    invoke-direct {v1, v4}, Lcom/palai/prootsmoke/RepairActivity$1;-><init>(Lcom/palai/prootsmoke/RepairActivity;)V
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V
    iget-object v0, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    new-instance v1, Lcom/palai/prootsmoke/RepairActivity$2;
    invoke-direct {v1, v4}, Lcom/palai/prootsmoke/RepairActivity$2;-><init>(Lcom/palai/prootsmoke/RepairActivity;)V
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V
    iget-object v0, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    new-instance v1, Lcom/palai/prootsmoke/RepairActivity$3;
    invoke-direct {v1, v4}, Lcom/palai/prootsmoke/RepairActivity$3;-><init>(Lcom/palai/prootsmoke/RepairActivity;)V
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V
    iget-object v0, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    new-instance v1, Landroid/widget/FrameLayout$LayoutParams;
    const/4 v2, #-1
    invoke-direct {v1, v2, v2}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V
    invoke-virtual {v5, v0, v1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    new-instance v0, Landroid/widget/LinearLayout;
    invoke-direct {v0, v4}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V
    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V
    new-instance v1, Landroid/widget/FrameLayout$LayoutParams;
    const/4 v2, #-2
    invoke-direct {v1, v2, v2}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V
    const/16 v2, #51
    iput v2, v1, Landroid/widget/FrameLayout$LayoutParams;->gravity:I
    const/16 v2, #40
    iput v2, v1, Landroid/widget/FrameLayout$LayoutParams;->topMargin:I
    const/16 v2, #20
    iput v2, v1, Landroid/widget/FrameLayout$LayoutParams;->leftMargin:I
    new-instance v2, Landroid/widget/Button;
    invoke-direct {v2, v4}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V
    const-string v3, "‹ 返回"
    invoke-virtual {v2, v3}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V
    const v3, #1058642330
    invoke-virtual {v2, v3}, Landroid/widget/Button;->setAlpha(F)V
    new-instance v3, Lcom/palai/prootsmoke/RepairActivity$4;
    invoke-direct {v3, v4}, Lcom/palai/prootsmoke/RepairActivity$4;-><init>(Lcom/palai/prootsmoke/RepairActivity;)V
    invoke-virtual {v2, v3}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    invoke-virtual {v5, v0, v1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    invoke-virtual {v4, v5}, Lcom/palai/prootsmoke/RepairActivity;->setContentView(Landroid/view/View;)V
    iget-object v5, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    const-string v0, "http://127.0.0.1:7797/repair"
    invoke-virtual {v5, v0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    const-string v5, "[REPAIRACT] loadUrl -> http://127.0.0.1:7797/repair"
    invoke-static {v5}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x4
.method protected Lcom/palai/prootsmoke/RepairActivity;->onDestroy()V
    # registers=4 ins=1 tries=2
    const/4 v0, #0
    iget-object v1, v3, Lcom/palai/prootsmoke/RepairActivity;->imeHandler:Landroid/os/Handler;
    if-eqz v1, :L8
    invoke-virtual {v1, v0}, Landroid/os/Handler;->removeCallbacksAndMessages(Ljava/lang/Object;)V
    :L8
    iget-object v1, v3, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    if-eqz v1, :L24
    const-string v2, "about:blank"
    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    iget-object v1, v3, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v1}, Landroid/webkit/WebView;->destroy()V
    iput-object v0, v3, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    :L24
    invoke-super {v3}, Landroid/app/Activity;->onDestroy()V
    return-void 
.end method

.class public final synthetic Lcom/palai/prootsmoke/SenseBridge$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;

.field public final synthetic f$0:Lcom/palai/prootsmoke/SenseBridge;

# direct access=0x11001
.method public synthetic constructor Lcom/palai/prootsmoke/SenseBridge$$ExternalSyntheticLambda0;-><init>(Lcom/palai/prootsmoke/SenseBridge;)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    iput-object v1, v0, Lcom/palai/prootsmoke/SenseBridge$$ExternalSyntheticLambda0;->f$0:Lcom/palai/prootsmoke/SenseBridge;
    return-void 
.end method

# virtual access=0x11
.method public final Lcom/palai/prootsmoke/SenseBridge$$ExternalSyntheticLambda0;->run()V
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/SenseBridge$$ExternalSyntheticLambda0;->f$0:Lcom/palai/prootsmoke/SenseBridge;
    invoke-static {v0}, Lcom/palai/prootsmoke/SenseBridge;->$r8$lambda$IUo89o2fw9stkETEq7IynT6S0sk(Lcom/palai/prootsmoke/SenseBridge;)V
    return-void 
.end method

.class public final synthetic Lcom/palai/prootsmoke/SenseBridge$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;

.field public final synthetic f$0:Lcom/palai/prootsmoke/SenseBridge;
.field public final synthetic f$1:Ljava/net/Socket;

# direct access=0x11001
.method public synthetic constructor Lcom/palai/prootsmoke/SenseBridge$$ExternalSyntheticLambda1;-><init>(Lcom/palai/prootsmoke/SenseBridge;Ljava/net/Socket;)V
    # registers=3 ins=3 tries=0
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    iput-object v1, v0, Lcom/palai/prootsmoke/SenseBridge$$ExternalSyntheticLambda1;->f$0:Lcom/palai/prootsmoke/SenseBridge;
    iput-object v2, v0, Lcom/palai/prootsmoke/SenseBridge$$ExternalSyntheticLambda1;->f$1:Ljava/net/Socket;
    return-void 
.end method

# virtual access=0x11
.method public final Lcom/palai/prootsmoke/SenseBridge$$ExternalSyntheticLambda1;->run()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/SenseBridge$$ExternalSyntheticLambda1;->f$0:Lcom/palai/prootsmoke/SenseBridge;
    iget-object v1, v2, Lcom/palai/prootsmoke/SenseBridge$$ExternalSyntheticLambda1;->f$1:Ljava/net/Socket;
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/SenseBridge;->$r8$lambda$CN_0ZWdmF93s_ZMCumFomHqzwGM(Lcom/palai/prootsmoke/SenseBridge;Ljava/net/Socket;)V
    return-void 
.end method

.class public final Lcom/palai/prootsmoke/SenseBridge;
.super Ljava/lang/Object;

.field private static final NOTIF_CAP:I
.field public static final PORT:I
.field private static volatile instance:Lcom/palai/prootsmoke/SenseBridge;
.field private final ctx:Landroid/content/Context;
.field private notifSeq:J
.field private final notifs:Ljava/util/List;
.field private volatile running:Z
.field private server:Ljava/net/ServerSocket;
.field private thread:Ljava/lang/Thread;

# direct access=0x1009
.method public static synthetic Lcom/palai/prootsmoke/SenseBridge;->$r8$lambda$CN_0ZWdmF93s_ZMCumFomHqzwGM(Lcom/palai/prootsmoke/SenseBridge;Ljava/net/Socket;)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/SenseBridge;->lambda$loop$0(Ljava/net/Socket;)V
    return-void 
.end method

# direct access=0x1009
.method public static synthetic Lcom/palai/prootsmoke/SenseBridge;->$r8$lambda$IUo89o2fw9stkETEq7IynT6S0sk(Lcom/palai/prootsmoke/SenseBridge;)V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/SenseBridge;->loop()V
    return-void 
.end method

# direct access=0x10002
.method private constructor Lcom/palai/prootsmoke/SenseBridge;-><init>(Landroid/content/Context;)V
    # registers=4 ins=2 tries=0
    invoke-direct {v2}, Ljava/lang/Object;-><init>()V
    new-instance v0, Ljava/util/ArrayList;
    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V
    iput-object v0, v2, Lcom/palai/prootsmoke/SenseBridge;->notifs:Ljava/util/List;
    const-wide/16 v0, #0
    iput-wide v0, v2, Lcom/palai/prootsmoke/SenseBridge;->notifSeq:J
    iput-object v3, v2, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->appLabel(Ljava/lang/String;)Ljava/lang/String;
    # registers=4 ins=2 tries=1
    iget-object v0, v2, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;
    move-result-object v0
    const/4 v1, #0
    invoke-virtual {v0, v3, v1}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->getApplicationLabel(Landroid/content/pm/ApplicationInfo;)Ljava/lang/CharSequence;
    move-result-object v0
    if-nez v0, :L18
    goto :L22
    :L18
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;
    move-result-object v3
    :L22
    return-object v3
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->currentAppJson()Lorg/json/JSONObject;
    # registers=6 ins=1 tries=2
    new-instance v0, Lorg/json/JSONObject;
    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V
    invoke-direct {v5}, Lcom/palai/prootsmoke/SenseBridge;->foregroundPackage()Ljava/lang/String;
    move-result-object v1
    const-string v2, "pkg"
    const-string v3, ""
    if-nez v1, :L17
    move-object v4, v3
    goto :L18
    :L17
    move-object v4, v1
    :L18
    invoke-virtual {v0, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const-string v2, "label"
    if-nez v1, :L26
    goto :L30
    :L26
    invoke-direct {v5, v1}, Lcom/palai/prootsmoke/SenseBridge;->appLabel(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v3
    :L30
    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const-string v1, "ts"
    invoke-direct {v5}, Lcom/palai/prootsmoke/SenseBridge;->nowIso()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    return-object v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->foregroundPackage()Ljava/lang/String;
    # registers=9 ins=1 tries=1
    const/4 v0, #0
    iget-object v1, v8, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    const-string v2, "usagestats"
    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v1
    move-object v2, v1
    check-cast v2, Landroid/app/usage/UsageStatsManager;
    if-eqz v2, :L69
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v6
    const-wide/32 v3, #3600000L
    sub-long v4, v6, v3
    const/4 v3, #0
    invoke-virtual/range {v2..v7}, Landroid/app/usage/UsageStatsManager;->queryUsageStats(IJJ)Ljava/util/List;
    move-result-object v1
    if-eqz v1, :L69
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v1
    move-object v2, v0
    :L35
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z
    move-result v3
    if-eqz v3, :L63
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v3
    check-cast v3, Landroid/app/usage/UsageStats;
    if-eqz v2, :L61
    invoke-virtual {v3}, Landroid/app/usage/UsageStats;->getLastTimeUsed()J
    move-result-wide v4
    invoke-virtual {v2}, Landroid/app/usage/UsageStats;->getLastTimeUsed()J
    move-result-wide v6
    cmp-long v4, v4, v6
    if-lez v4, :L35
    :L61
    move-object v2, v3
    goto :L35
    :L63
    if-eqz v2, :L69
    invoke-virtual {v2}, Landroid/app/usage/UsageStats;->getPackageName()Ljava/lang/String;
    move-result-object v0
    :L69
    return-object v0
.end method

# direct access=0x20009
.method public static Lcom/palai/prootsmoke/SenseBridge;->get(Landroid/content/Context;)Lcom/palai/prootsmoke/SenseBridge;
    # registers=3 ins=1 tries=2
    const-class v0, Lcom/palai/prootsmoke/SenseBridge;
    monitor-enter v0
    sget-object v1, Lcom/palai/prootsmoke/SenseBridge;->instance:Lcom/palai/prootsmoke/SenseBridge;
    if-nez v1, :L18
    new-instance v1, Lcom/palai/prootsmoke/SenseBridge;
    invoke-virtual {v2}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;
    move-result-object v2
    invoke-direct {v1, v2}, Lcom/palai/prootsmoke/SenseBridge;-><init>(Landroid/content/Context;)V
    sput-object v1, Lcom/palai/prootsmoke/SenseBridge;->instance:Lcom/palai/prootsmoke/SenseBridge;
    :L18
    sget-object v2, Lcom/palai/prootsmoke/SenseBridge;->instance:Lcom/palai/prootsmoke/SenseBridge;
    monitor-exit v0
    return-object v2
    move-exception v2
    monitor-exit v0
    throw v2
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->handle(Ljava/net/Socket;)V
    # registers=9 ins=2 tries=5
    const-string v0, " "
    new-instance v1, Ljava/io/BufferedReader;
    new-instance v2, Ljava/io/InputStreamReader;
    invoke-virtual {v8}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;
    move-result-object v3
    sget-object v4, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;
    invoke-direct {v2, v3, v4}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/nio/charset/Charset;)V
    invoke-direct {v1, v2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;
    move-result-object v2
    if-nez v2, :L28
    invoke-virtual {v8}, Ljava/net/Socket;->close()V
    return-void 
    :L28
    const-string v3, "/"
    invoke-virtual {v2, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    move-result-object v2
    array-length v4, v2
    const/4 v5, #2
    if-lt v4, v5, :L41
    const/4 v3, #1
    aget-object v3, v2, v3
    :L41
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;
    move-result-object v2
    if-eqz v2, :L54
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z
    move-result v2
    if-nez v2, :L54
    goto :L41
    :L54
    const-string v1, "/health"
    invoke-virtual {v3, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v1
    const/16 v2, #200
    if-eqz v1, :L70
    invoke-direct {v7}, Lcom/palai/prootsmoke/SenseBridge;->healthJson()Ljava/lang/String;
    move-result-object v1
    :L68
    move v3, v2
    goto :L159
    :L70
    const-string v1, "/state"
    invoke-virtual {v3, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v1
    if-eqz v1, :L83
    invoke-direct {v7}, Lcom/palai/prootsmoke/SenseBridge;->stateJson()Ljava/lang/String;
    move-result-object v1
    goto :L68
    :L83
    const-string v1, "/notifications"
    invoke-virtual {v3, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v1
    if-eqz v1, :L155
    const-string v1, "since="
    invoke-virtual {v3, v1}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I
    move-result v1
    if-ltz v1, :L148
    add-int/lit8 v1, v1, #6
    new-instance v4, Ljava/lang/StringBuilder;
    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V
    :L106
    invoke-virtual {v3}, Ljava/lang/String;->length()I
    move-result v5
    if-ge v1, v5, :L133
    invoke-virtual {v3, v1}, Ljava/lang/String;->charAt(I)C
    move-result v5
    invoke-static {v5}, Ljava/lang/Character;->isDigit(C)Z
    move-result v5
    if-eqz v5, :L133
    add-int/lit8 v5, v1, #1
    invoke-virtual {v3, v1}, Ljava/lang/String;->charAt(I)C
    move-result v1
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    move v1, v5
    goto :L106
    :L133
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->length()I
    move-result v1
    if-lez v1, :L148
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J
    move-result-wide v3
    goto :L150
    :L148
    const-wide/16 v3, #0
    :L150
    invoke-direct {v7, v3, v4}, Lcom/palai/prootsmoke/SenseBridge;->notificationsJson(J)Ljava/lang/String;
    move-result-object v1
    goto :L68
    :L155
    const-string v1, "{}"
    const/16 v3, #404
    :L159
    sget-object v4, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;
    invoke-virtual {v1, v4}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B
    move-result-object v1
    invoke-virtual {v8}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;
    move-result-object v4
    new-instance v5, Ljava/lang/StringBuilder;
    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V
    const-string v6, "HTTP/1.1 "
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v5
    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    if-ne v3, v2, :L193
    const-string v2, "OK"
    goto :L195
    :L193
    const-string v2, "Not Found"
    :L195
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v2, "
Content-Type: application/json; charset=utf-8
Content-Length: "
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    array-length v2, v1
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v2, "
Connection: close

"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    sget-object v2, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;
    invoke-virtual {v0, v2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B
    move-result-object v0
    invoke-virtual {v4, v0}, Ljava/io/OutputStream;->write([B)V
    invoke-virtual {v4, v1}, Ljava/io/OutputStream;->write([B)V
    invoke-virtual {v4}, Ljava/io/OutputStream;->flush()V
    invoke-virtual {v8}, Ljava/net/Socket;->close()V
    goto :L244
    move-exception v0
    invoke-virtual {v8}, Ljava/net/Socket;->close()V
    throw v0
    :L244
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->hasUsageAccess()Z
    # registers=6 ins=1 tries=1
    const/4 v0, #0
    iget-object v1, v5, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    const-string v2, "appops"
    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Landroid/app/AppOpsManager;
    if-nez v1, :L14
    return v0
    :L14
    const-string v2, "android:get_usage_stats"
    invoke-static {}, Landroid/os/Process;->myUid()I
    move-result v3
    iget-object v4, v5, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    invoke-virtual {v4}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v4
    invoke-virtual {v1, v2, v3, v4}, Landroid/app/AppOpsManager;->checkOpNoThrow(Ljava/lang/String;ILjava/lang/String;)I
    move-result v1
    if-nez v1, :L33
    const/4 v0, #1
    :L33
    return v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->healthJson()Ljava/lang/String;
    # registers=5 ins=1 tries=1
    new-instance v0, Lorg/json/JSONObject;
    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V
    const-string v1, "usage"
    invoke-direct {v4}, Lcom/palai/prootsmoke/SenseBridge;->hasUsageAccess()Z
    move-result v2
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    const-string v1, "notif"
    iget-object v2, v4, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    invoke-static {v2}, Lcom/palai/prootsmoke/NotifListenerService;->isEnabled(Landroid/content/Context;)Z
    move-result v2
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    const-string v1, "accessibility"
    invoke-direct {v4}, Lcom/palai/prootsmoke/SenseBridge;->isAccessibilityOn()Z
    move-result v2
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    new-instance v1, Lorg/json/JSONObject;
    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V
    const-string v2, "ok"
    const/4 v3, #1
    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    const-string v2, "sources"
    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;
    move-result-object v0
    return-object v0
    const-string v0, "{"ok":true,"sources":{}}"
    return-object v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->isAccessibilityOn()Z
    # registers=4 ins=1 tries=1
    const/4 v0, #0
    iget-object v1, v3, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
    move-result-object v1
    const-string v2, "enabled_accessibility_services"
    invoke-static {v1, v2}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    if-eqz v1, :L28
    iget-object v2, v3, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v1
    if-eqz v1, :L28
    const/4 v0, #1
    :L28
    return v0
.end method

# direct access=0x1002
.method private synthetic Lcom/palai/prootsmoke/SenseBridge;->lambda$loop$0(Ljava/net/Socket;)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/SenseBridge;->handle(Ljava/net/Socket;)V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->loop()V
    # registers=5 ins=1 tries=1
    new-instance v0, Ljava/net/ServerSocket;
    const-string v1, "127.0.0.1"
    invoke-static {v1}, Ljava/net/InetAddress;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;
    move-result-object v1
    const/16 v2, #17899
    const/16 v3, #8
    invoke-direct {v0, v2, v3, v1}, Ljava/net/ServerSocket;-><init>(IILjava/net/InetAddress;)V
    iput-object v0, v4, Lcom/palai/prootsmoke/SenseBridge;->server:Ljava/net/ServerSocket;
    :L17
    iget-boolean v0, v4, Lcom/palai/prootsmoke/SenseBridge;->running:Z
    if-eqz v0, :L46
    iget-object v0, v4, Lcom/palai/prootsmoke/SenseBridge;->server:Ljava/net/ServerSocket;
    invoke-virtual {v0}, Ljava/net/ServerSocket;->accept()Ljava/net/Socket;
    move-result-object v0
    new-instance v1, Ljava/lang/Thread;
    new-instance v2, Lcom/palai/prootsmoke/SenseBridge$$ExternalSyntheticLambda1;
    invoke-direct {v2, v4, v0}, Lcom/palai/prootsmoke/SenseBridge$$ExternalSyntheticLambda1;-><init>(Lcom/palai/prootsmoke/SenseBridge;Ljava/net/Socket;)V
    const-string v0, "sense-bridge-conn"
    invoke-direct {v1, v2, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V
    goto :L17
    const/4 v0, #0
    iput-boolean v0, v4, Lcom/palai/prootsmoke/SenseBridge;->running:Z
    :L46
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->notificationsJson(J)Ljava/lang/String;
    # registers=10 ins=3 tries=5
    new-instance v0, Lorg/json/JSONObject;
    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V
    new-instance v1, Lorg/json/JSONArray;
    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V
    monitor-enter v7
    iget-object v2, v7, Lcom/palai/prootsmoke/SenseBridge;->notifs:Ljava/util/List;
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v2
    :L17
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z
    move-result v3
    if-eqz v3, :L45
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v3
    check-cast v3, Lorg/json/JSONObject;
    const-string v4, "seq"
    const-wide/16 v5, #0
    invoke-virtual {v3, v4, v5, v6}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J
    move-result-wide v4
    cmp-long v4, v4, v8
    if-ltz v4, :L17
    invoke-virtual {v1, v3}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    goto :L17
    :L45
    const-string v8, "cursor"
    iget-wide v2, v7, Lcom/palai/prootsmoke/SenseBridge;->notifSeq:J
    invoke-virtual {v0, v8, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;
    monitor-exit v7
    const-string v8, "items"
    invoke-virtual {v0, v8, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;
    move-result-object v8
    return-object v8
    move-exception v8
    monitor-exit v7
    throw v8
    const-string v8, "{"cursor":0,"items":[]}"
    return-object v8
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->nowIso()Ljava/lang/String;
    # registers=4 ins=1 tries=0
    new-instance v0, Ljava/text/SimpleDateFormat;
    const-string v1, "yyyy-MM-dd'T'HH:mm:ssXXX"
    sget-object v2, Ljava/util/Locale;->US:Ljava/util/Locale;
    invoke-direct {v0, v1, v2}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V
    new-instance v1, Ljava/util/Date;
    invoke-direct {v1}, Ljava/util/Date;-><init>()V
    invoke-virtual {v0, v1}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

# direct access=0x9
.method public static Lcom/palai/prootsmoke/SenseBridge;->peek()Lcom/palai/prootsmoke/SenseBridge;
    # registers=1 ins=0 tries=0
    sget-object v0, Lcom/palai/prootsmoke/SenseBridge;->instance:Lcom/palai/prootsmoke/SenseBridge;
    return-object v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->powerJson()Lorg/json/JSONObject;
    # registers=9 ins=1 tries=2
    new-instance v0, Lorg/json/JSONObject;
    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V
    iget-object v1, v8, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    new-instance v2, Landroid/content/IntentFilter;
    const-string v3, "android.intent.action.BATTERY_CHANGED"
    invoke-direct {v2, v3}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V
    const/4 v3, #0
    invoke-virtual {v1, v3, v2}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;
    move-result-object v1
    const-string v2, "level"
    const/4 v3, #0
    const/4 v4, #-1
    if-eqz v1, :L64
    const-string v5, "status"
    invoke-virtual {v1, v5, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v5
    const/4 v6, #2
    if-eq v5, v6, :L37
    const/4 v6, #5
    if-ne v5, v6, :L38
    :L37
    const/4 v3, #1
    :L38
    invoke-virtual {v1, v2, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v5
    const-string v6, "scale"
    const/16 v7, #100
    invoke-virtual {v1, v6, v7}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v1
    if-ltz v5, :L64
    if-lez v1, :L64
    int-to-float v4, v5
    const/high16 v5, #int 0x42c80000
    mul-float/2addr v4, v5
    int-to-float v1, v1
    div-float/2addr v4, v1
    invoke-static {v4}, Ljava/lang/Math;->round(F)I
    move-result v4
    :L64
    const-string v1, "charging"
    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    invoke-virtual {v0, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    return-object v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->screenJson()Lorg/json/JSONObject;
    # registers=7 ins=1 tries=1
    new-instance v0, Lorg/json/JSONObject;
    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V
    iget-object v1, v6, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    const-string v2, "power"
    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Landroid/os/PowerManager;
    const/4 v2, #1
    const/4 v3, #0
    if-eqz v1, :L27
    invoke-virtual {v1}, Landroid/os/PowerManager;->isInteractive()Z
    move-result v1
    if-eqz v1, :L27
    move v1, v2
    goto :L28
    :L27
    move v1, v3
    :L28
    iget-object v4, v6, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    const-string v5, "keyguard"
    invoke-virtual {v4, v5}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v4
    check-cast v4, Landroid/app/KeyguardManager;
    if-eqz v4, :L47
    invoke-virtual {v4}, Landroid/app/KeyguardManager;->isKeyguardLocked()Z
    move-result v4
    if-eqz v4, :L47
    goto :L48
    :L47
    move v2, v3
    :L48
    const-string v3, "on"
    invoke-virtual {v0, v3, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    const-string v1, "locked"
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    return-object v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->stateJson()Ljava/lang/String;
    # registers=4 ins=1 tries=1
    new-instance v0, Lorg/json/JSONObject;
    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V
    const-string v1, "app"
    invoke-direct {v3}, Lcom/palai/prootsmoke/SenseBridge;->currentAppJson()Lorg/json/JSONObject;
    move-result-object v2
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const-string v1, "screen"
    invoke-direct {v3}, Lcom/palai/prootsmoke/SenseBridge;->screenJson()Lorg/json/JSONObject;
    move-result-object v2
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const-string v1, "power"
    invoke-direct {v3}, Lcom/palai/prootsmoke/SenseBridge;->powerJson()Lorg/json/JSONObject;
    move-result-object v2
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;
    move-result-object v0
    return-object v0
    const-string v0, "{}"
    return-object v0
.end method

# virtual access=0x20001
.method public Lcom/palai/prootsmoke/SenseBridge;->addNotification(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V
    # registers=11 ins=7 tries=4
    const-string v9, "n"
    monitor-enter v4
    iget-wide v0, v4, Lcom/palai/prootsmoke/SenseBridge;->notifSeq:J
    const-wide/16 v2, #1
    add-long/2addr v0, v2
    iput-wide v0, v4, Lcom/palai/prootsmoke/SenseBridge;->notifSeq:J
    new-instance v10, Lorg/json/JSONObject;
    invoke-direct {v10}, Lorg/json/JSONObject;-><init>()V
    const-string v0, "seq"
    iget-wide v1, v4, Lcom/palai/prootsmoke/SenseBridge;->notifSeq:J
    invoke-virtual {v10, v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;
    const-string v0, "id"
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget-wide v2, v4, Lcom/palai/prootsmoke/SenseBridge;->notifSeq:J
    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    move-result-object v9
    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v9
    invoke-virtual {v10, v0, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const-string v9, "pkg"
    if-nez v5, :L48
    const-string v5, ""
    :L48
    invoke-virtual {v10, v9, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const-string v5, "app"
    if-nez v6, :L57
    const-string v6, ""
    :L57
    invoke-virtual {v10, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const-string v5, "title"
    if-nez v7, :L66
    const-string v7, ""
    :L66
    invoke-virtual {v10, v5, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const-string v5, "text"
    if-nez v8, :L75
    const-string v8, ""
    :L75
    invoke-virtual {v10, v5, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    iget-object v5, v4, Lcom/palai/prootsmoke/SenseBridge;->notifs:Ljava/util/List;
    invoke-interface {v5, v10}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :L83
    iget-object v5, v4, Lcom/palai/prootsmoke/SenseBridge;->notifs:Ljava/util/List;
    invoke-interface {v5}, Ljava/util/List;->size()I
    move-result v5
    const/16 v6, #64
    if-le v5, v6, :L100
    iget-object v5, v4, Lcom/palai/prootsmoke/SenseBridge;->notifs:Ljava/util/List;
    const/4 v6, #0
    invoke-interface {v5, v6}, Ljava/util/List;->remove(I)Ljava/lang/Object;
    goto :L83
    :L100
    monitor-exit v4
    return-void 
    move-exception v5
    monitor-exit v4
    throw v5
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/SenseBridge;->start()V
    # registers=5 ins=1 tries=0
    iget-boolean v0, v4, Lcom/palai/prootsmoke/SenseBridge;->running:Z
    if-eqz v0, :L5
    return-void 
    :L5
    const/4 v0, #1
    iput-boolean v0, v4, Lcom/palai/prootsmoke/SenseBridge;->running:Z
    new-instance v1, Ljava/lang/Thread;
    new-instance v2, Lcom/palai/prootsmoke/SenseBridge$$ExternalSyntheticLambda0;
    invoke-direct {v2, v4}, Lcom/palai/prootsmoke/SenseBridge$$ExternalSyntheticLambda0;-><init>(Lcom/palai/prootsmoke/SenseBridge;)V
    const-string v3, "sense-bridge"
    invoke-direct {v1, v2, v3}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V
    iput-object v1, v4, Lcom/palai/prootsmoke/SenseBridge;->thread:Ljava/lang/Thread;
    invoke-virtual {v1, v0}, Ljava/lang/Thread;->setDaemon(Z)V
    iget-object v0, v4, Lcom/palai/prootsmoke/SenseBridge;->thread:Ljava/lang/Thread;
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/SenseBridge;->stop()V
    # registers=2 ins=1 tries=1
    const/4 v0, #0
    iput-boolean v0, v1, Lcom/palai/prootsmoke/SenseBridge;->running:Z
    iget-object v0, v1, Lcom/palai/prootsmoke/SenseBridge;->server:Ljava/net/ServerSocket;
    if-eqz v0, :L10
    invoke-virtual {v0}, Ljava/net/ServerSocket;->close()V
    :L10
    const/4 v0, #0
    iput-object v0, v1, Lcom/palai/prootsmoke/SenseBridge;->server:Ljava/net/ServerSocket;
    return-void 
.end method

