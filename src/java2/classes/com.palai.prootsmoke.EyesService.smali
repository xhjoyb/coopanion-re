.class public final Lcom/palai/prootsmoke/EyesService;
.super Landroid/accessibilityservice/AccessibilityService;

.field private static final CAPTURE_ATTEMPTS:I
.field private static final CAPTURE_WAIT_MS:J
.field private static final FRAME_CACHE_MS:J
.field private static final MAX_STALE_MS:J
.field private static final MIN_CAPTURE_GAP_MS:J
.field public static final PORT:I
.field private static volatile imeListener:Lcom/palai/prootsmoke/EyesService$ImeListener;
.field private static volatile instance:Lcom/palai/prootsmoke/EyesService;
.field private static volatile lastImeNotifyAt:J
.field private acceptThread:Ljava/lang/Thread;
.field private captureExecutor:Ljava/util/concurrent/ExecutorService;
.field private volatile foregroundPkg:Ljava/lang/String;
.field private volatile lastError:Ljava/lang/String;
.field private volatile lastHeight:I
.field private volatile lastJpeg:[B
.field private volatile lastJpegAt:J
.field private volatile lastRequestAt:J
.field private volatile lastWidth:I
.field private volatile running:Z
.field private server:Ljava/net/ServerSocket;
.field private workers:Ljava/util/concurrent/ExecutorService;

# direct access=0x10001
.method public constructor Lcom/palai/prootsmoke/EyesService;-><init>()V
    # registers=2 ins=1 tries=0
    invoke-direct {v1}, Landroid/accessibilityservice/AccessibilityService;-><init>()V
    const-string v0, ""
    iput-object v0, v1, Lcom/palai/prootsmoke/EyesService;->foregroundPkg:Ljava/lang/String;
    iput-object v0, v1, Lcom/palai/prootsmoke/EyesService;->lastError:Ljava/lang/String;
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/EyesService;->acceptLoop()V
    # registers=5 ins=1 tries=3
    new-instance v0, Ljava/net/ServerSocket;
    const-string v1, "127.0.0.1"
    invoke-static {v1}, Ljava/net/InetAddress;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;
    move-result-object v1
    const/16 v2, #17898
    const/16 v3, #16
    invoke-direct {v0, v2, v3, v1}, Ljava/net/ServerSocket;-><init>(IILjava/net/InetAddress;)V
    iput-object v0, v4, Lcom/palai/prootsmoke/EyesService;->server:Ljava/net/ServerSocket;
    :L17
    iget-boolean v1, v4, Lcom/palai/prootsmoke/EyesService;->running:Z
    if-eqz v1, :L49
    invoke-virtual {v0}, Ljava/net/ServerSocket;->accept()Ljava/net/Socket;
    move-result-object v1
    const/16 v2, #20000
    invoke-virtual {v1, v2}, Ljava/net/Socket;->setSoTimeout(I)V
    goto :L32
    move-exception v2
    :L32
    iget-object v2, v4, Lcom/palai/prootsmoke/EyesService;->workers:Ljava/util/concurrent/ExecutorService;
    if-eqz v2, :L45
    new-instance v3, Lcom/palai/prootsmoke/EyesService$2;
    invoke-direct {v3, v4, v1}, Lcom/palai/prootsmoke/EyesService$2;-><init>(Lcom/palai/prootsmoke/EyesService;Ljava/net/Socket;)V
    invoke-interface {v2, v3}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V
    goto :L48
    :L45
    invoke-direct {v4, v1}, Lcom/palai/prootsmoke/EyesService;->close(Ljava/net/Socket;)V
    :L48
    goto :L17
    :L49
    goto :L64
    move-exception v0
    iget-boolean v1, v4, Lcom/palai/prootsmoke/EyesService;->running:Z
    if-eqz v1, :L61
    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v0
    iput-object v0, v4, Lcom/palai/prootsmoke/EyesService;->lastError:Ljava/lang/String;
    :L61
    const/4 v0, #0
    iput-boolean v0, v4, Lcom/palai/prootsmoke/EyesService;->running:Z
    :L64
    return-void 
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/EyesService;->access$000(Lcom/palai/prootsmoke/EyesService;)V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/EyesService;->acceptLoop()V
    return-void 
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/EyesService;->access$100(Lcom/palai/prootsmoke/EyesService;Ljava/net/Socket;)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/EyesService;->handle(Ljava/net/Socket;)V
    return-void 
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/EyesService;->access$300()Lcom/palai/prootsmoke/EyesService;
    # registers=1 ins=0 tries=0
    sget-object v0, Lcom/palai/prootsmoke/EyesService;->instance:Lcom/palai/prootsmoke/EyesService;
    return-object v0
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/EyesService;->access$402(Lcom/palai/prootsmoke/EyesService;I)I
    # registers=2 ins=2 tries=0
    iput v1, v0, Lcom/palai/prootsmoke/EyesService;->lastWidth:I
    return v1
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/EyesService;->access$502(Lcom/palai/prootsmoke/EyesService;I)I
    # registers=2 ins=2 tries=0
    iput v1, v0, Lcom/palai/prootsmoke/EyesService;->lastHeight:I
    return v1
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/EyesService;->captureOnce(II)[B
    # registers=14 ins=3 tries=2
    new-instance v7, Ljava/util/concurrent/atomic/AtomicReference;
    invoke-direct {v7}, Ljava/util/concurrent/atomic/AtomicReference;-><init>()V
    new-instance v8, Ljava/util/concurrent/atomic/AtomicReference;
    invoke-direct {v8}, Ljava/util/concurrent/atomic/AtomicReference;-><init>()V
    new-instance v9, Ljava/util/concurrent/CountDownLatch;
    const/4 v0, #1
    invoke-direct {v9, v0}, Ljava/util/concurrent/CountDownLatch;-><init>(I)V
    const/4 v10, #0
    iget-object v1, v11, Lcom/palai/prootsmoke/EyesService;->captureExecutor:Ljava/util/concurrent/ExecutorService;
    move-object v0, v11
    move v2, v12
    move v3, v13
    move-object v4, v7
    move-object v5, v8
    move-object v6, v9
    invoke-static/range {v0..v6}, Lcom/palai/prootsmoke/EyesService$Api30;->capture(Landroid/accessibilityservice/AccessibilityService;Ljava/util/concurrent/ExecutorService;IILjava/util/concurrent/atomic/AtomicReference;Ljava/util/concurrent/atomic/AtomicReference;Ljava/util/concurrent/CountDownLatch;)V
    nop 
    sget-object v12, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;
    const-wide/16 v0, #9000
    invoke-virtual {v9, v0, v1, v12}, Ljava/util/concurrent/CountDownLatch;->await(JLjava/util/concurrent/TimeUnit;)Z
    nop 
    invoke-virtual {v7}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;
    move-result-object v12
    check-cast v12, [B
    if-eqz v12, :L49
    array-length v13, v12
    if-lez v13, :L49
    return-object v12
    :L49
    invoke-virtual {v8}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;
    move-result-object v12
    if-eqz v12, :L62
    invoke-virtual {v8}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;
    move-result-object v12
    check-cast v12, Ljava/lang/String;
    goto :L64
    :L62
    const-string v12, "截屏超时"
    :L64
    iput-object v12, v11, Lcom/palai/prootsmoke/EyesService;->lastError:Ljava/lang/String;
    return-object v10
    move-exception v12
    return-object v10
    move-exception v12
    invoke-static {v12}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v12
    iput-object v12, v11, Lcom/palai/prootsmoke/EyesService;->lastError:Ljava/lang/String;
    return-object v10
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/EyesService;->close(Ljava/net/Socket;)V
    # registers=2 ins=2 tries=1
    invoke-virtual {v1}, Ljava/net/Socket;->close()V
    goto :L5
    move-exception v1
    :L5
    return-void 
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/EyesService;->collect(Landroid/view/accessibility/AccessibilityNodeInfo;Lorg/json/JSONArray;I)V
    # registers=10 ins=3 tries=5
    const-string v0, ","
    if-eqz v7, :L220
    const/16 v1, #32
    if-gt v9, v1, :L220
    invoke-virtual {v8}, Lorg/json/JSONArray;->length()I
    move-result v1
    const/16 v2, #500
    if-lt v1, v2, :L18
    goto/16 :L220
    :L18
    invoke-virtual {v7}, Landroid/view/accessibility/AccessibilityNodeInfo;->getText()Ljava/lang/CharSequence;
    move-result-object v1
    invoke-static {v1}, Lcom/palai/prootsmoke/EyesService;->safe(Ljava/lang/CharSequence;)Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v7}, Landroid/view/accessibility/AccessibilityNodeInfo;->getContentDescription()Ljava/lang/CharSequence;
    move-result-object v2
    invoke-static {v2}, Lcom/palai/prootsmoke/EyesService;->safe(Ljava/lang/CharSequence;)Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v1}, Ljava/lang/String;->length()I
    move-result v3
    if-lez v3, :L42
    move-object v3, v1
    goto :L43
    :L42
    move-object v3, v2
    :L43
    invoke-virtual {v3}, Ljava/lang/String;->length()I
    move-result v4
    if-lez v4, :L182
    new-instance v4, Lorg/json/JSONObject;
    invoke-direct {v4}, Lorg/json/JSONObject;-><init>()V
    const-string v5, "t"
    const/16 v6, #160
    invoke-static {v3, v6}, Lcom/palai/prootsmoke/EyesService;->trim(Ljava/lang/String;I)Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v4, v5, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    invoke-virtual {v1}, Ljava/lang/String;->length()I
    move-result v1
    if-lez v1, :L88
    invoke-virtual {v2}, Ljava/lang/String;->length()I
    move-result v1
    if-lez v1, :L88
    const-string v1, "d"
    const/16 v3, #80
    invoke-static {v2, v3}, Lcom/palai/prootsmoke/EyesService;->trim(Ljava/lang/String;I)Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v4, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :L88
    new-instance v1, Landroid/graphics/Rect;
    invoke-direct {v1}, Landroid/graphics/Rect;-><init>()V
    invoke-virtual {v7, v1}, Landroid/view/accessibility/AccessibilityNodeInfo;->getBoundsInScreen(Landroid/graphics/Rect;)V
    const-string v2, "b"
    new-instance v3, Ljava/lang/StringBuilder;
    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V
    iget v5, v1, Landroid/graphics/Rect;->left:I
    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    iget v5, v1, Landroid/graphics/Rect;->top:I
    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    iget v5, v1, Landroid/graphics/Rect;->right:I
    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    iget v1, v1, Landroid/graphics/Rect;->bottom:I
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v4, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    invoke-virtual {v7}, Landroid/view/accessibility/AccessibilityNodeInfo;->getClassName()Ljava/lang/CharSequence;
    move-result-object v0
    invoke-static {v0}, Lcom/palai/prootsmoke/EyesService;->safe(Ljava/lang/CharSequence;)Ljava/lang/String;
    move-result-object v0
    const/16 v1, #46
    invoke-virtual {v0, v1}, Ljava/lang/String;->lastIndexOf(I)I
    move-result v1
    if-ltz v1, :L168
    add-int/lit8 v1, v1, #1
    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v0
    :L168
    invoke-virtual {v0}, Ljava/lang/String;->length()I
    move-result v1
    if-lez v1, :L179
    const-string v1, "c"
    invoke-virtual {v4, v1, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :L179
    invoke-virtual {v8, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    :L182
    invoke-virtual {v7}, Landroid/view/accessibility/AccessibilityNodeInfo;->getChildCount()I
    move-result v0
    const/4 v1, #0
    :L187
    if-ge v1, v0, :L217
    invoke-virtual {v7, v1}, Landroid/view/accessibility/AccessibilityNodeInfo;->getChild(I)Landroid/view/accessibility/AccessibilityNodeInfo;
    move-result-object v2
    if-nez v2, :L196
    goto :L207
    :L196
    add-int/lit8 v3, v9, #1
    invoke-static {v2, v8, v3}, Lcom/palai/prootsmoke/EyesService;->collect(Landroid/view/accessibility/AccessibilityNodeInfo;Lorg/json/JSONArray;I)V
    invoke-virtual {v2}, Landroid/view/accessibility/AccessibilityNodeInfo;->recycle()V
    goto :L207
    move-exception v2
    nop 
    :L207
    add-int/lit8 v1, v1, #1
    goto :L187
    move-exception v7
    invoke-virtual {v2}, Landroid/view/accessibility/AccessibilityNodeInfo;->recycle()V
    goto :L216
    move-exception v8
    :L216
    throw v7
    :L217
    goto :L219
    move-exception v7
    :L219
    return-void 
    :L220
    return-void 
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/EyesService;->escape(Ljava/lang/String;)Ljava/lang/String;
    # registers=6 ins=1 tries=0
    if-nez v5, :L5
    const-string v5, ""
    return-object v5
    :L5
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-virtual {v5}, Ljava/lang/String;->length()I
    move-result v1
    add-int/lit8 v1, v1, #8
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(I)V
    const/4 v1, #0
    :L17
    invoke-virtual {v5}, Ljava/lang/String;->length()I
    move-result v2
    if-ge v1, v2, :L88
    invoke-virtual {v5, v1}, Ljava/lang/String;->charAt(I)C
    move-result v2
    const/16 v3, #34
    const/16 v4, #92
    if-eq v2, v3, :L78
    if-ne v2, v4, :L36
    goto :L78
    :L36
    const/16 v3, #10
    if-ne v2, v3, :L46
    const-string v2, "\n"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :L85
    :L46
    const/16 v3, #13
    if-ne v2, v3, :L56
    const-string v2, "\r"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :L85
    :L56
    const/16 v3, #9
    if-ne v2, v3, :L66
    const-string v2, "\t"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :L85
    :L66
    const/16 v3, #32
    if-ge v2, v3, :L74
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    goto :L85
    :L74
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    goto :L85
    :L78
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    :L85
    add-int/lit8 v1, v1, #1
    goto :L17
    :L88
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v5
    return-object v5
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/EyesService;->handle(Ljava/net/Socket;)V
    # registers=9 ins=2 tries=4
    new-instance v0, Ljava/io/BufferedReader;
    new-instance v1, Ljava/io/InputStreamReader;
    invoke-virtual {v8}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;
    move-result-object v2
    sget-object v3, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;
    invoke-direct {v1, v2, v3}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/nio/charset/Charset;)V
    invoke-direct {v0, v1}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    invoke-virtual {v0}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;
    move-result-object v1
    if-nez v1, :L29
    invoke-direct {v7, v8}, Lcom/palai/prootsmoke/EyesService;->close(Ljava/net/Socket;)V
    invoke-direct {v7, v8}, Lcom/palai/prootsmoke/EyesService;->close(Ljava/net/Socket;)V
    return-void 
    :L29
    const/4 v2, #0
    move v3, v2
    :L31
    invoke-virtual {v0}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;
    move-result-object v4
    const/4 v5, #1
    if-eqz v4, :L49
    invoke-virtual {v4}, Ljava/lang/String;->length()I
    move-result v4
    if-lez v4, :L49
    add-int/2addr v3, v5
    const/16 v4, #64
    if-le v3, v4, :L31
    :L49
    const-string v0, " "
    invoke-virtual {v1, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    move-result-object v0
    array-length v1, v0
    const/4 v3, #2
    const-string v4, "/"
    if-lt v1, v3, :L64
    aget-object v0, v0, v5
    goto :L65
    :L64
    move-object v0, v4
    :L65
    nop 
    const-string v1, ""
    const/16 v3, #63
    invoke-virtual {v0, v3}, Ljava/lang/String;->indexOf(I)I
    move-result v3
    if-ltz v3, :L88
    invoke-virtual {v0, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;
    move-result-object v1
    add-int/2addr v3, v5
    invoke-virtual {v0, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v0
    move-object v6, v1
    move-object v1, v0
    move-object v0, v6
    :L88
    const-string v2, "/health"
    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v2
    const/16 v3, #200
    if-eqz v2, :L106
    invoke-direct {v7}, Lcom/palai/prootsmoke/EyesService;->healthJson()Ljava/lang/String;
    move-result-object v0
    invoke-direct {v7, v8, v3, v0}, Lcom/palai/prootsmoke/EyesService;->sendJson(Ljava/net/Socket;ILjava/lang/String;)V
    goto :L197
    :L106
    const-string v2, "/screen.jpg"
    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v2
    if-nez v2, :L186
    const-string v2, "/screen"
    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v2
    if-eqz v2, :L123
    goto :L186
    :L123
    const-string v1, "/ui"
    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v1
    if-eqz v1, :L139
    invoke-direct {v7}, Lcom/palai/prootsmoke/EyesService;->uiJson()Ljava/lang/String;
    move-result-object v0
    invoke-direct {v7, v8, v3, v0}, Lcom/palai/prootsmoke/EyesService;->sendJson(Ljava/net/Socket;ILjava/lang/String;)V
    goto :L197
    :L139
    const-string v1, "/open_settings"
    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v1
    if-eqz v1, :L155
    invoke-direct {v7}, Lcom/palai/prootsmoke/EyesService;->openSettings()Ljava/lang/String;
    move-result-object v0
    invoke-direct {v7, v8, v3, v0}, Lcom/palai/prootsmoke/EyesService;->sendJson(Ljava/net/Socket;ILjava/lang/String;)V
    goto :L197
    :L155
    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v1
    if-nez v1, :L178
    const-string v1, "/help"
    invoke-virtual {v0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v0
    if-eqz v0, :L170
    goto :L178
    :L170
    const-string v0, "{"ok":false,"error":"NOT_FOUND"}"
    const/16 v1, #404
    invoke-direct {v7, v8, v1, v0}, Lcom/palai/prootsmoke/EyesService;->sendJson(Ljava/net/Socket;ILjava/lang/String;)V
    goto :L197
    :L178
    invoke-direct {v7}, Lcom/palai/prootsmoke/EyesService;->helpJson()Ljava/lang/String;
    move-result-object v0
    invoke-direct {v7, v8, v3, v0}, Lcom/palai/prootsmoke/EyesService;->sendJson(Ljava/net/Socket;ILjava/lang/String;)V
    goto :L197
    :L186
    invoke-direct {v7, v8, v1}, Lcom/palai/prootsmoke/EyesService;->sendScreen(Ljava/net/Socket;Ljava/lang/String;)V
    goto :L197
    move-exception v0
    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v0
    iput-object v0, v7, Lcom/palai/prootsmoke/EyesService;->lastError:Ljava/lang/String;
    :L197
    invoke-direct {v7, v8}, Lcom/palai/prootsmoke/EyesService;->close(Ljava/net/Socket;)V
    nop 
    return-void 
    move-exception v0
    invoke-direct {v7, v8}, Lcom/palai/prootsmoke/EyesService;->close(Ljava/net/Socket;)V
    throw v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/EyesService;->healthJson()Ljava/lang/String;
    # registers=9 ins=1 tries=1
    new-instance v0, Lorg/json/JSONObject;
    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V
    const-string v1, "ok"
    const/4 v2, #1
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    const-string v1, "service"
    const-string v3, "coopanion-eyes"
    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const-string v1, "sdk"
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I
    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    const-string v1, "canScreenshot"
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v4, #30
    const/4 v5, #0
    if-lt v3, v4, :L35
    goto :L36
    :L35
    move v2, v5
    :L36
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    const-string v1, "pkg"
    iget-object v2, v8, Lcom/palai/prootsmoke/EyesService;->foregroundPkg:Ljava/lang/String;
    if-nez v2, :L48
    const-string v2, ""
    goto :L50
    :L48
    iget-object v2, v8, Lcom/palai/prootsmoke/EyesService;->foregroundPkg:Ljava/lang/String;
    :L50
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const-string v1, "frameWidth"
    iget v2, v8, Lcom/palai/prootsmoke/EyesService;->lastWidth:I
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    const-string v1, "frameHeight"
    iget v2, v8, Lcom/palai/prootsmoke/EyesService;->lastHeight:I
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    const-string v1, "frameAgeMs"
    iget-object v2, v8, Lcom/palai/prootsmoke/EyesService;->lastJpeg:[B
    if-nez v2, :L76
    const-wide/16 v2, #-1
    goto :L83
    :L76
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v2
    iget-wide v6, v8, Lcom/palai/prootsmoke/EyesService;->lastJpegAt:J
    sub-long/2addr v2, v6
    :L83
    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;
    const-string v1, "frameBytes"
    iget-object v2, v8, Lcom/palai/prootsmoke/EyesService;->lastJpeg:[B
    if-nez v2, :L93
    :L92
    goto :L97
    :L93
    iget-object v2, v8, Lcom/palai/prootsmoke/EyesService;->lastJpeg:[B
    array-length v5, v2
    goto :L92
    :L97
    invoke-virtual {v0, v1, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    const-string v1, "error"
    iget-object v2, v8, Lcom/palai/prootsmoke/EyesService;->lastError:Ljava/lang/String;
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    nop 
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;
    move-result-object v0
    return-object v0
    move-exception v0
    const-string v0, "{"ok":true,"service":"coopanion-eyes"}"
    return-object v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/EyesService;->helpJson()Ljava/lang/String;
    # registers=2 ins=1 tries=0
    const-string v0, "{"ok":true,"service":"coopanion-eyes","routes":["/health","/screen.jpg?max=720&q=62","/ui","/open_settings"]}"
    return-object v0
.end method

# direct access=0x9
.method public static Lcom/palai/prootsmoke/EyesService;->imeHeight()I
    # registers=2 ins=0 tries=0
    sget-object v0, Lcom/palai/prootsmoke/EyesService;->instance:Lcom/palai/prootsmoke/EyesService;
    const/4 v1, #0
    if-nez v0, :L6
    return v1
    :L6
    invoke-static {v0}, Lcom/palai/prootsmoke/EyesService;->imeHeightOf(Lcom/palai/prootsmoke/EyesService;)I
    move-result v0
    if-lez v0, :L13
    move v1, v0
    :L13
    return v1
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/EyesService;->imeHeightOf(Lcom/palai/prootsmoke/EyesService;)I
    # registers=13 ins=1 tries=13
    const/4 v0, #0
    invoke-virtual {v12}, Lcom/palai/prootsmoke/EyesService;->getResources()Landroid/content/res/Resources;
    move-result-object v1
    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;
    move-result-object v1
    iget v1, v1, Landroid/util/DisplayMetrics;->heightPixels:I
    nop 
    invoke-static {v12}, Lcom/palai/prootsmoke/EyesService;->imePackages(Lcom/palai/prootsmoke/EyesService;)Ljava/util/Set;
    move-result-object v2
    nop 
    nop 
    invoke-virtual {v12}, Lcom/palai/prootsmoke/EyesService;->getWindows()Ljava/util/List;
    move-result-object v12
    if-nez v12, :L25
    return v0
    :L25
    invoke-interface {v12}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v12
    move v3, v0
    move v4, v3
    :L31
    invoke-interface {v12}, Ljava/util/Iterator;->hasNext()Z
    move-result v5
    if-eqz v5, :L185
    invoke-interface {v12}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v5
    check-cast v5, Landroid/view/accessibility/AccessibilityWindowInfo;
    if-nez v5, :L46
    goto :L31
    :L46
    invoke-virtual {v5}, Landroid/view/accessibility/AccessibilityWindowInfo;->getType()I
    move-result v6
    const-string v7, ""
    invoke-virtual {v5}, Landroid/view/accessibility/AccessibilityWindowInfo;->getRoot()Landroid/view/accessibility/AccessibilityNodeInfo;
    move-result-object v8
    invoke-virtual {v8}, Landroid/view/accessibility/AccessibilityNodeInfo;->getPackageName()Ljava/lang/CharSequence;
    move-result-object v8
    invoke-static {v8}, Lcom/palai/prootsmoke/EyesService;->safe(Ljava/lang/CharSequence;)Ljava/lang/String;
    move-result-object v7
    goto :L66
    move-exception v8
    :L66
    const/4 v8, #2
    const/4 v9, #1
    if-eq v6, v8, :L87
    if-eqz v7, :L85
    invoke-virtual {v7}, Ljava/lang/String;->length()I
    move-result v6
    if-lez v6, :L85
    invoke-interface {v2, v7}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z
    move-result v6
    if-eqz v6, :L85
    goto :L87
    :L85
    move v6, v0
    goto :L88
    :L87
    move v6, v9
    :L88
    if-nez v6, :L96
    invoke-virtual {v5}, Landroid/view/accessibility/AccessibilityWindowInfo;->recycle()V
    goto :L31
    move-exception v5
    goto :L31
    :L96
    new-instance v6, Landroid/graphics/Rect;
    invoke-direct {v6}, Landroid/graphics/Rect;-><init>()V
    invoke-virtual {v5, v6}, Landroid/view/accessibility/AccessibilityWindowInfo;->getBoundsInScreen(Landroid/graphics/Rect;)V
    invoke-virtual {v6}, Landroid/graphics/Rect;->width()I
    move-result v7
    const/16 v8, #60
    if-lt v7, v8, :L168
    invoke-virtual {v6}, Landroid/graphics/Rect;->height()I
    move-result v7
    if-ge v7, v8, :L119
    goto :L168
    :L119
    iget v7, v6, Landroid/graphics/Rect;->bottom:I
    add-int/lit16 v8, v1, #-200
    if-ge v7, v8, :L131
    invoke-virtual {v5}, Landroid/view/accessibility/AccessibilityWindowInfo;->recycle()V
    goto :L31
    move-exception v5
    goto :L31
    :L131
    nop 
    invoke-virtual {v6}, Landroid/graphics/Rect;->height()I
    move-result v4
    int-to-double v6, v1
    const-wide v10, #4606281698874543309L
    mul-double/2addr v6, v10
    double-to-int v6, v6
    if-lt v4, v6, :L154
    invoke-virtual {v5}, Landroid/view/accessibility/AccessibilityWindowInfo;->recycle()V
    goto :L152
    move-exception v4
    nop 
    :L152
    move v4, v9
    goto :L31
    :L154
    if-le v4, v3, :L157
    move v3, v4
    :L157
    invoke-virtual {v5}, Landroid/view/accessibility/AccessibilityWindowInfo;->recycle()V
    goto :L163
    move-exception v4
    nop 
    :L163
    move v4, v9
    goto :L183
    move-exception v4
    move v4, v9
    goto :L177
    :L168
    invoke-virtual {v5}, Landroid/view/accessibility/AccessibilityWindowInfo;->recycle()V
    goto/16 :L31
    move-exception v5
    goto/16 :L31
    move-exception v6
    :L177
    invoke-virtual {v5}, Landroid/view/accessibility/AccessibilityWindowInfo;->recycle()V
    goto :L183
    move-exception v5
    nop 
    :L183
    goto/16 :L31
    :L185
    nop 
    if-lez v3, :L189
    return v3
    :L189
    if-eqz v4, :L192
    const/4 v0, #-1
    :L192
    return v0
    move-exception v12
    return v0
    move-exception v12
    return v0
.end method

# direct access=0x9
.method public static Lcom/palai/prootsmoke/EyesService;->imeHeightSmart()I
    # registers=1 ins=0 tries=0
    sget-object v0, Lcom/palai/prootsmoke/EyesService;->instance:Lcom/palai/prootsmoke/EyesService;
    if-nez v0, :L6
    const/4 v0, #0
    return v0
    :L6
    invoke-static {v0}, Lcom/palai/prootsmoke/EyesService;->imeHeightOf(Lcom/palai/prootsmoke/EyesService;)I
    move-result v0
    return v0
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/EyesService;->imePackages(Lcom/palai/prootsmoke/EyesService;)Ljava/util/Set;
    # registers=5 ins=1 tries=1
    new-instance v0, Ljava/util/HashSet;
    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V
    const-string v1, "input_method"
    invoke-virtual {v4, v1}, Lcom/palai/prootsmoke/EyesService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v4
    check-cast v4, Landroid/view/inputmethod/InputMethodManager;
    if-eqz v4, :L88
    invoke-virtual {v4}, Landroid/view/inputmethod/InputMethodManager;->getEnabledInputMethodList()Ljava/util/List;
    move-result-object v1
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v1
    :L23
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z
    move-result v2
    if-eqz v2, :L51
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Landroid/view/inputmethod/InputMethodInfo;
    if-eqz v2, :L50
    invoke-virtual {v2}, Landroid/view/inputmethod/InputMethodInfo;->getPackageName()Ljava/lang/String;
    move-result-object v3
    if-eqz v3, :L50
    invoke-virtual {v2}, Landroid/view/inputmethod/InputMethodInfo;->getPackageName()Ljava/lang/String;
    move-result-object v2
    invoke-interface {v0, v2}, Ljava/util/Set;->add(Ljava/lang/Object;)Z
    :L50
    goto :L23
    :L51
    invoke-virtual {v4}, Landroid/view/inputmethod/InputMethodManager;->getInputMethodList()Ljava/util/List;
    move-result-object v4
    invoke-interface {v4}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v4
    :L59
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z
    move-result v1
    if-eqz v1, :L88
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Landroid/view/inputmethod/InputMethodInfo;
    if-eqz v1, :L86
    invoke-virtual {v1}, Landroid/view/inputmethod/InputMethodInfo;->getPackageName()Ljava/lang/String;
    move-result-object v2
    if-eqz v2, :L86
    invoke-virtual {v1}, Landroid/view/inputmethod/InputMethodInfo;->getPackageName()Ljava/lang/String;
    move-result-object v1
    invoke-interface {v0, v1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z
    :L86
    goto :L59
    move-exception v4
    :L88
    nop 
    return-object v0
.end method

# direct access=0x9
.method public static Lcom/palai/prootsmoke/EyesService;->imeVisible()Z
    # registers=6 ins=0 tries=8
    sget-object v0, Lcom/palai/prootsmoke/EyesService;->instance:Lcom/palai/prootsmoke/EyesService;
    const/4 v1, #0
    if-nez v0, :L6
    return v1
    :L6
    invoke-virtual {v0}, Lcom/palai/prootsmoke/EyesService;->getWindows()Ljava/util/List;
    move-result-object v0
    if-nez v0, :L13
    return v1
    :L13
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v0
    :L17
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z
    move-result v2
    if-eqz v2, :L92
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Landroid/view/accessibility/AccessibilityWindowInfo;
    if-nez v2, :L32
    goto :L17
    :L32
    invoke-virtual {v2}, Landroid/view/accessibility/AccessibilityWindowInfo;->getType()I
    move-result v3
    const/4 v4, #2
    if-eq v3, v4, :L45
    invoke-virtual {v2}, Landroid/view/accessibility/AccessibilityWindowInfo;->recycle()V
    goto :L17
    move-exception v2
    goto :L17
    :L45
    new-instance v3, Landroid/graphics/Rect;
    invoke-direct {v3}, Landroid/graphics/Rect;-><init>()V
    invoke-virtual {v2, v3}, Landroid/view/accessibility/AccessibilityWindowInfo;->getBoundsInScreen(Landroid/graphics/Rect;)V
    invoke-virtual {v3}, Landroid/graphics/Rect;->width()I
    move-result v4
    const/16 v5, #40
    if-lt v4, v5, :L78
    invoke-virtual {v3}, Landroid/graphics/Rect;->height()I
    move-result v3
    const/16 v4, #60
    if-ge v3, v4, :L70
    goto :L78
    :L70
    nop 
    invoke-virtual {v2}, Landroid/view/accessibility/AccessibilityWindowInfo;->recycle()V
    goto :L76
    move-exception v0
    :L76
    const/4 v0, #1
    return v0
    :L78
    invoke-virtual {v2}, Landroid/view/accessibility/AccessibilityWindowInfo;->recycle()V
    goto :L17
    move-exception v2
    goto :L17
    move-exception v0
    invoke-virtual {v2}, Landroid/view/accessibility/AccessibilityWindowInfo;->recycle()V
    goto :L90
    move-exception v2
    :L90
    throw v0
    move-exception v0
    :L92
    nop 
    return v1
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/EyesService;->intParam(Ljava/lang/String;Ljava/lang/String;I)I
    # registers=8 ins=3 tries=1
    if-eqz v5, :L58
    invoke-virtual {v5}, Ljava/lang/String;->length()I
    move-result v0
    if-nez v0, :L9
    goto :L58
    :L9
    const-string v0, "&"
    invoke-virtual {v5, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    move-result-object v5
    const/4 v0, #0
    move v1, v0
    :L17
    array-length v2, v5
    if-ge v1, v2, :L57
    aget-object v2, v5, v1
    const-string v3, "="
    invoke-virtual {v2, v3}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    move-result-object v2
    array-length v3, v2
    const/4 v4, #2
    if-ne v3, v4, :L54
    aget-object v3, v2, v0
    invoke-virtual {v3, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v3
    if-eqz v3, :L54
    const/4 v5, #1
    aget-object v5, v2, v5
    invoke-virtual {v5}, Ljava/lang/String;->trim()Ljava/lang/String;
    move-result-object v5
    invoke-static {v5}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    move-result v5
    return v5
    move-exception v5
    return v7
    :L54
    add-int/lit8 v1, v1, #1
    goto :L17
    :L57
    return v7
    :L58
    return v7
.end method

# direct access=0x9
.method public static Lcom/palai/prootsmoke/EyesService;->isRunning()Z
    # registers=1 ins=0 tries=0
    sget-object v0, Lcom/palai/prootsmoke/EyesService;->instance:Lcom/palai/prootsmoke/EyesService;
    if-eqz v0, :L10
    iget-boolean v0, v0, Lcom/palai/prootsmoke/EyesService;->running:Z
    if-eqz v0, :L10
    const/4 v0, #1
    goto :L11
    :L10
    const/4 v0, #0
    :L11
    return v0
.end method

# direct access=0x20002
.method private Lcom/palai/prootsmoke/EyesService;->jpeg(II)[B
    # registers=13 ins=3 tries=8
    monitor-enter v10
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v0
    iget-object v2, v10, Lcom/palai/prootsmoke/EyesService;->lastJpeg:[B
    const-wide/16 v3, #700
    if-eqz v2, :L22
    iget-wide v5, v10, Lcom/palai/prootsmoke/EyesService;->lastJpegAt:J
    sub-long/2addr v0, v5
    cmp-long v0, v0, v3
    if-gez v0, :L22
    iget-object v11, v10, Lcom/palai/prootsmoke/EyesService;->lastJpeg:[B
    monitor-exit v10
    return-object v11
    :L22
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v1, #30
    const/4 v2, #0
    if-ge v0, v1, :L35
    const-string v11, "需要 Android 11 及以上才能后台截屏"
    iput-object v11, v10, Lcom/palai/prootsmoke/EyesService;->lastError:Ljava/lang/String;
    monitor-exit v10
    return-object v2
    :L35
    nop 
    const/4 v0, #0
    move-object v1, v2
    :L38
    const/4 v5, #3
    if-ge v0, v5, :L101
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v5
    iget-wide v7, v10, Lcom/palai/prootsmoke/EyesService;->lastRequestAt:J
    sub-long/2addr v5, v7
    const-wide/16 v7, #1200
    cmp-long v9, v5, v7
    if-gez v9, :L61
    sub-long/2addr v7, v5
    invoke-static {v7, v8}, Ljava/lang/Thread;->sleep(J)V
    goto :L61
    move-exception v11
    goto :L101
    :L61
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v5
    iput-wide v5, v10, Lcom/palai/prootsmoke/EyesService;->lastRequestAt:J
    invoke-direct {v10, v11, v12}, Lcom/palai/prootsmoke/EyesService;->captureOnce(II)[B
    move-result-object v1
    if-eqz v1, :L90
    array-length v5, v1
    if-lez v5, :L90
    iput-object v1, v10, Lcom/palai/prootsmoke/EyesService;->lastJpeg:[B
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v11
    iput-wide v11, v10, Lcom/palai/prootsmoke/EyesService;->lastJpegAt:J
    const-string v11, ""
    iput-object v11, v10, Lcom/palai/prootsmoke/EyesService;->lastError:Ljava/lang/String;
    monitor-exit v10
    return-object v1
    :L90
    iget-object v1, v10, Lcom/palai/prootsmoke/EyesService;->lastError:Ljava/lang/String;
    invoke-static {v3, v4}, Ljava/lang/Thread;->sleep(J)V
    nop 
    add-int/lit8 v0, v0, #1
    goto :L38
    move-exception v11
    nop 
    :L101
    if-nez v1, :L105
    const-string v1, "截屏失败"
    :L105
    iput-object v1, v10, Lcom/palai/prootsmoke/EyesService;->lastError:Ljava/lang/String;
    iget-object v11, v10, Lcom/palai/prootsmoke/EyesService;->lastJpeg:[B
    if-eqz v11, :L128
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v11
    iget-wide v0, v10, Lcom/palai/prootsmoke/EyesService;->lastJpegAt:J
    sub-long/2addr v11, v0
    const-wide/16 v0, #2500
    cmp-long v11, v11, v0
    if-gtz v11, :L128
    iget-object v11, v10, Lcom/palai/prootsmoke/EyesService;->lastJpeg:[B
    monitor-exit v10
    return-object v11
    :L128
    monitor-exit v10
    return-object v2
    move-exception v11
    monitor-exit v10
    throw v11
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/EyesService;->notifyIme(I)V
    # registers=8 ins=1 tries=1
    sget-object v0, Lcom/palai/prootsmoke/EyesService;->imeListener:Lcom/palai/prootsmoke/EyesService$ImeListener;
    if-nez v0, :L5
    return-void 
    :L5
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J
    move-result-wide v1
    sget-wide v3, Lcom/palai/prootsmoke/EyesService;->lastImeNotifyAt:J
    sub-long v3, v1, v3
    const-wide/16 v5, #60
    cmp-long v3, v3, v5
    if-gez v3, :L20
    return-void 
    :L20
    sput-wide v1, Lcom/palai/prootsmoke/EyesService;->lastImeNotifyAt:J
    invoke-interface {v0, v7}, Lcom/palai/prootsmoke/EyesService$ImeListener;->onImeHeight(I)V
    goto :L27
    move-exception v7
    :L27
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/EyesService;->openSettings()Ljava/lang/String;
    # registers=5 ins=1 tries=2
    const-string v0, "ok"
    new-instance v1, Lorg/json/JSONObject;
    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V
    new-instance v2, Landroid/content/Intent;
    const-string v3, "android.settings.ACCESSIBILITY_SETTINGS"
    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    const/high16 v3, #int 0x10000000
    invoke-virtual {v2, v3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;
    invoke-virtual {v4, v2}, Lcom/palai/prootsmoke/EyesService;->startActivity(Landroid/content/Intent;)V
    const/4 v2, #1
    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    const-string v2, "opened"
    const-string v3, "accessibility"
    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    goto :L50
    move-exception v2
    const/4 v3, #0
    invoke-virtual {v1, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    const-string v0, "error"
    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v1, v0, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    goto :L50
    move-exception v0
    :L50
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

# direct access=0x9
.method public static Lcom/palai/prootsmoke/EyesService;->peek()Lcom/palai/prootsmoke/EyesService;
    # registers=1 ins=0 tries=0
    sget-object v0, Lcom/palai/prootsmoke/EyesService;->instance:Lcom/palai/prootsmoke/EyesService;
    return-object v0
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/EyesService;->safe(Ljava/lang/CharSequence;)Ljava/lang/String;
    # registers=1 ins=1 tries=0
    if-nez v0, :L5
    const-string v0, ""
    goto :L9
    :L5
    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;
    move-result-object v0
    :L9
    return-object v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/EyesService;->sendJson(Ljava/net/Socket;ILjava/lang/String;)V
    # registers=6 ins=4 tries=1
    sget-object v0, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;
    invoke-virtual {v5, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B
    move-result-object v5
    invoke-virtual {v3}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;
    move-result-object v3
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    const-string v1, "HTTP/1.1 "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v0
    const/16 v1, #200
    if-ne v4, v1, :L32
    const-string v4, " OK"
    goto :L34
    :L32
    const-string v4, " ERR"
    :L34
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v4
    const-string v0, "
Content-Type: application/json; charset=utf-8
Content-Length: "
    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v4
    array-length v0, v5
    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v4
    const-string v0, "
Cache-Control: no-store
Connection: close

"
    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v4
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    sget-object v0, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;
    invoke-virtual {v4, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B
    move-result-object v4
    invoke-virtual {v3, v4}, Ljava/io/OutputStream;->write([B)V
    invoke-virtual {v3, v5}, Ljava/io/OutputStream;->write([B)V
    invoke-virtual {v3}, Ljava/io/OutputStream;->flush()V
    goto :L76
    move-exception v3
    :L76
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/EyesService;->sendScreen(Ljava/net/Socket;Ljava/lang/String;)V
    # registers=8 ins=3 tries=2
    const-string v0, "max"
    const/16 v1, #720
    invoke-static {v7, v0, v1}, Lcom/palai/prootsmoke/EyesService;->intParam(Ljava/lang/String;Ljava/lang/String;I)I
    move-result v0
    const-string v1, "q"
    const/16 v2, #62
    invoke-static {v7, v1, v2}, Lcom/palai/prootsmoke/EyesService;->intParam(Ljava/lang/String;Ljava/lang/String;I)I
    move-result v7
    const/16 v1, #120
    if-ge v0, v1, :L21
    move v0, v1
    :L21
    const/16 v1, #2160
    if-le v0, v1, :L26
    move v0, v1
    :L26
    const/16 v1, #20
    if-ge v7, v1, :L31
    move v7, v1
    :L31
    const/16 v1, #95
    if-le v7, v1, :L36
    move v7, v1
    :L36
    nop 
    invoke-direct {v5, v0, v7}, Lcom/palai/prootsmoke/EyesService;->jpeg(II)[B
    move-result-object v7
    goto :L50
    move-exception v7
    invoke-static {v7}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v7
    iput-object v7, v5, Lcom/palai/prootsmoke/EyesService;->lastError:Ljava/lang/String;
    const/4 v7, #0
    :L50
    if-eqz v7, :L167
    array-length v0, v7
    if-nez v0, :L56
    goto :L167
    :L56
    invoke-virtual {v6}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;
    move-result-object v6
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    const-string v1, "HTTP/1.1 200 OK
Content-Type: image/jpeg
Content-Length: "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    array-length v1, v7
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v1, "
X-Width: "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    iget v1, v5, Lcom/palai/prootsmoke/EyesService;->lastWidth:I
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v1, "
X-Height: "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    iget v1, v5, Lcom/palai/prootsmoke/EyesService;->lastHeight:I
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v1, "
X-Pkg: "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    iget-object v1, v5, Lcom/palai/prootsmoke/EyesService;->foregroundPkg:Ljava/lang/String;
    invoke-static {v1}, Lcom/palai/prootsmoke/EyesService;->escape(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v1, "
X-Age-Ms: "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v1
    iget-wide v3, v5, Lcom/palai/prootsmoke/EyesService;->lastJpegAt:J
    sub-long/2addr v1, v3
    const-wide/16 v3, #0
    invoke-static {v3, v4, v1, v2}, Ljava/lang/Math;->max(JJ)J
    move-result-wide v1
    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v1, "
Cache-Control: no-store
Connection: close

"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    sget-object v1, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;
    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B
    move-result-object v0
    invoke-virtual {v6, v0}, Ljava/io/OutputStream;->write([B)V
    invoke-virtual {v6, v7}, Ljava/io/OutputStream;->write([B)V
    invoke-virtual {v6}, Ljava/io/OutputStream;->flush()V
    goto :L166
    move-exception v6
    :L166
    return-void 
    :L167
    new-instance v7, Ljava/lang/StringBuilder;
    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V
    const-string v0, "{"ok":false,"error":""
    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v7
    iget-object v0, v5, Lcom/palai/prootsmoke/EyesService;->lastError:Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->length()I
    move-result v0
    if-nez v0, :L189
    const-string v0, "NO_FRAME"
    goto :L191
    :L189
    iget-object v0, v5, Lcom/palai/prootsmoke/EyesService;->lastError:Ljava/lang/String;
    :L191
    invoke-static {v0}, Lcom/palai/prootsmoke/EyesService;->escape(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v7
    const-string v0, "","sdk":"
    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v7
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v7
    const-string v0, "}"
    invoke-virtual {v7, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v7
    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v7
    const/16 v0, #503
    invoke-direct {v5, v6, v0, v7}, Lcom/palai/prootsmoke/EyesService;->sendJson(Ljava/net/Socket;ILjava/lang/String;)V
    return-void 
.end method

# direct access=0x9
.method public static Lcom/palai/prootsmoke/EyesService;->setImeListener(Lcom/palai/prootsmoke/EyesService$ImeListener;)V
    # registers=2 ins=1 tries=1
    sput-object v1, Lcom/palai/prootsmoke/EyesService;->imeListener:Lcom/palai/prootsmoke/EyesService$ImeListener;
    if-eqz v1, :L10
    const/4 v0, #0
    invoke-interface {v1, v0}, Lcom/palai/prootsmoke/EyesService$ImeListener;->onImeHeight(I)V
    goto :L10
    move-exception v1
    :L10
    return-void 
.end method

# direct access=0x20002
.method private Lcom/palai/prootsmoke/EyesService;->startServer()V
    # registers=5 ins=1 tries=2
    monitor-enter v4
    iget-boolean v0, v4, Lcom/palai/prootsmoke/EyesService;->running:Z
    if-eqz v0, :L7
    monitor-exit v4
    return-void 
    :L7
    const/4 v0, #1
    iput-boolean v0, v4, Lcom/palai/prootsmoke/EyesService;->running:Z
    invoke-static {}, Ljava/util/concurrent/Executors;->newCachedThreadPool()Ljava/util/concurrent/ExecutorService;
    move-result-object v1
    iput-object v1, v4, Lcom/palai/prootsmoke/EyesService;->workers:Ljava/util/concurrent/ExecutorService;
    invoke-static {}, Ljava/util/concurrent/Executors;->newSingleThreadExecutor()Ljava/util/concurrent/ExecutorService;
    move-result-object v1
    iput-object v1, v4, Lcom/palai/prootsmoke/EyesService;->captureExecutor:Ljava/util/concurrent/ExecutorService;
    new-instance v1, Ljava/lang/Thread;
    new-instance v2, Lcom/palai/prootsmoke/EyesService$1;
    invoke-direct {v2, v4}, Lcom/palai/prootsmoke/EyesService$1;-><init>(Lcom/palai/prootsmoke/EyesService;)V
    const-string v3, "coop-eyes"
    invoke-direct {v1, v2, v3}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V
    iput-object v1, v4, Lcom/palai/prootsmoke/EyesService;->acceptThread:Ljava/lang/Thread;
    invoke-virtual {v1, v0}, Ljava/lang/Thread;->setDaemon(Z)V
    iget-object v0, v4, Lcom/palai/prootsmoke/EyesService;->acceptThread:Ljava/lang/Thread;
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V
    monitor-exit v4
    return-void 
    move-exception v0
    monitor-exit v4
    throw v0
.end method

# direct access=0x20002
.method private Lcom/palai/prootsmoke/EyesService;->stopServer()V
    # registers=2 ins=1 tries=3
    monitor-enter v1
    const/4 v0, #0
    iput-boolean v0, v1, Lcom/palai/prootsmoke/EyesService;->running:Z
    iget-object v0, v1, Lcom/palai/prootsmoke/EyesService;->server:Ljava/net/ServerSocket;
    if-eqz v0, :L11
    invoke-virtual {v0}, Ljava/net/ServerSocket;->close()V
    :L11
    goto :L13
    move-exception v0
    :L13
    const/4 v0, #0
    iput-object v0, v1, Lcom/palai/prootsmoke/EyesService;->server:Ljava/net/ServerSocket;
    iget-object v0, v1, Lcom/palai/prootsmoke/EyesService;->workers:Ljava/util/concurrent/ExecutorService;
    if-eqz v0, :L23
    invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdownNow()Ljava/util/List;
    :L23
    iget-object v0, v1, Lcom/palai/prootsmoke/EyesService;->captureExecutor:Ljava/util/concurrent/ExecutorService;
    if-eqz v0, :L30
    invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdownNow()Ljava/util/List;
    :L30
    monitor-exit v1
    return-void 
    move-exception v0
    monitor-exit v1
    throw v0
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/EyesService;->trim(Ljava/lang/String;I)Ljava/lang/String;
    # registers=4 ins=2 tries=0
    if-nez v2, :L5
    const-string v2, ""
    return-object v2
    :L5
    const/16 v0, #10
    const/16 v1, #32
    invoke-virtual {v2, v0, v1}, Ljava/lang/String;->replace(CC)Ljava/lang/String;
    move-result-object v2
    const/16 v0, #13
    invoke-virtual {v2, v0, v1}, Ljava/lang/String;->replace(CC)Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/String;->length()I
    move-result v0
    if-gt v0, v3, :L30
    goto :L54
    :L30
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    const/4 v1, #0
    invoke-virtual {v2, v1, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v2
    const-string v3, "…"
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    :L54
    return-object v2
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/EyesService;->uiJson()Ljava/lang/String;
    # registers=9 ins=1 tries=6
    const-string v0, "pkg"
    const-string v1, "ok"
    new-instance v2, Lorg/json/JSONObject;
    invoke-direct {v2}, Lorg/json/JSONObject;-><init>()V
    const/4 v3, #0
    const/4 v4, #1
    invoke-virtual {v2, v1, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    iget-object v5, v8, Lcom/palai/prootsmoke/EyesService;->foregroundPkg:Ljava/lang/String;
    if-nez v5, :L21
    const-string v5, ""
    goto :L23
    :L21
    iget-object v5, v8, Lcom/palai/prootsmoke/EyesService;->foregroundPkg:Ljava/lang/String;
    :L23
    invoke-virtual {v2, v0, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const-string v5, "screenOn"
    invoke-virtual {v2, v5, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    invoke-virtual {v8}, Lcom/palai/prootsmoke/EyesService;->getRootInActiveWindow()Landroid/view/accessibility/AccessibilityNodeInfo;
    move-result-object v4
    new-instance v5, Lorg/json/JSONArray;
    invoke-direct {v5}, Lorg/json/JSONArray;-><init>()V
    if-eqz v4, :L75
    invoke-static {v4, v5, v3}, Lcom/palai/prootsmoke/EyesService;->collect(Landroid/view/accessibility/AccessibilityNodeInfo;Lorg/json/JSONArray;I)V
    invoke-virtual {v4}, Landroid/view/accessibility/AccessibilityNodeInfo;->getPackageName()Ljava/lang/CharSequence;
    move-result-object v6
    invoke-static {v6}, Lcom/palai/prootsmoke/EyesService;->safe(Ljava/lang/CharSequence;)Ljava/lang/String;
    move-result-object v6
    invoke-virtual {v6}, Ljava/lang/String;->length()I
    move-result v7
    if-lez v7, :L62
    invoke-virtual {v2, v0, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :L62
    invoke-virtual {v4}, Landroid/view/accessibility/AccessibilityNodeInfo;->recycle()V
    goto :L75
    move-exception v0
    goto :L75
    move-exception v0
    invoke-virtual {v4}, Landroid/view/accessibility/AccessibilityNodeInfo;->recycle()V
    goto :L74
    move-exception v4
    :L74
    throw v0
    :L75
    const-string v0, "count"
    invoke-virtual {v5}, Lorg/json/JSONArray;->length()I
    move-result v4
    invoke-virtual {v2, v0, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    const-string v0, "items"
    invoke-virtual {v2, v0, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    goto :L105
    move-exception v0
    invoke-virtual {v2, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    const-string v1, "error"
    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v2, v1, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    goto :L105
    move-exception v0
    :L105
    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/EyesService;->onAccessibilityEvent(Landroid/view/accessibility/AccessibilityEvent;)V
    # registers=4 ins=2 tries=2
    if-nez v3, :L3
    return-void 
    :L3
    invoke-virtual {v3}, Landroid/view/accessibility/AccessibilityEvent;->getPackageName()Ljava/lang/CharSequence;
    move-result-object v0
    if-eqz v0, :L21
    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I
    move-result v1
    if-lez v1, :L21
    invoke-interface {v0}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;
    move-result-object v0
    iput-object v0, v2, Lcom/palai/prootsmoke/EyesService;->foregroundPkg:Ljava/lang/String;
    :L21
    goto :L23
    move-exception v0
    :L23
    invoke-virtual {v3}, Landroid/view/accessibility/AccessibilityEvent;->getEventType()I
    move-result v3
    const/high16 v0, #int 0x400000
    if-eq v3, v0, :L39
    const/16 v0, #32
    if-eq v3, v0, :L39
    const/16 v0, #2048
    if-ne v3, v0, :L46
    :L39
    invoke-static {}, Lcom/palai/prootsmoke/EyesService;->imeHeight()I
    move-result v3
    invoke-static {v3}, Lcom/palai/prootsmoke/EyesService;->notifyIme(I)V
    :L46
    goto :L48
    move-exception v3
    :L48
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/EyesService;->onDestroy()V
    # registers=2 ins=1 tries=0
    invoke-direct {v1}, Lcom/palai/prootsmoke/EyesService;->stopServer()V
    const/4 v0, #0
    sput-object v0, Lcom/palai/prootsmoke/EyesService;->instance:Lcom/palai/prootsmoke/EyesService;
    invoke-super {v1}, Landroid/accessibilityservice/AccessibilityService;->onDestroy()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/EyesService;->onInterrupt()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x4
.method protected Lcom/palai/prootsmoke/EyesService;->onServiceConnected()V
    # registers=1 ins=1 tries=0
    invoke-super {v0}, Landroid/accessibilityservice/AccessibilityService;->onServiceConnected()V
    sput-object v0, Lcom/palai/prootsmoke/EyesService;->instance:Lcom/palai/prootsmoke/EyesService;
    invoke-direct {v0}, Lcom/palai/prootsmoke/EyesService;->startServer()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/EyesService;->onUnbind(Landroid/content/Intent;)Z
    # registers=3 ins=2 tries=0
    invoke-direct {v1}, Lcom/palai/prootsmoke/EyesService;->stopServer()V
    const/4 v0, #0
    sput-object v0, Lcom/palai/prootsmoke/EyesService;->instance:Lcom/palai/prootsmoke/EyesService;
    invoke-super {v1, v2}, Landroid/accessibilityservice/AccessibilityService;->onUnbind(Landroid/content/Intent;)Z
    move-result v2
    return v2
.end method

