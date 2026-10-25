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

