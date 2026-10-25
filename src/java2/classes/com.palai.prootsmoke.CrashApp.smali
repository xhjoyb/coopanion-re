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

