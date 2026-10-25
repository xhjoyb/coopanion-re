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
    and-int/lit16 v3, v3, #255
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

