.class final Lcom/palai/prootsmoke/EyesService$Api30;
.super Ljava/lang/Object;

# direct access=0x10002
.method private constructor Lcom/palai/prootsmoke/EyesService$Api30;-><init>()V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/EyesService$Api30;->access$200(Landroid/accessibilityservice/AccessibilityService$ScreenshotResult;II)[B
    # registers=3 ins=3 tries=0
    invoke-static {v0, v1, v2}, Lcom/palai/prootsmoke/EyesService$Api30;->encode(Landroid/accessibilityservice/AccessibilityService$ScreenshotResult;II)[B
    move-result-object v0
    return-object v0
.end method

# direct access=0x8
.method static Lcom/palai/prootsmoke/EyesService$Api30;->capture(Landroid/accessibilityservice/AccessibilityService;Ljava/util/concurrent/ExecutorService;IILjava/util/concurrent/atomic/AtomicReference;Ljava/util/concurrent/atomic/AtomicReference;Ljava/util/concurrent/CountDownLatch;)V
    # registers=14 ins=7 tries=0
    new-instance v6, Lcom/palai/prootsmoke/EyesService$Api30$1;
    move-object v0, v6
    move-object v1, v11
    move v2, v9
    move v3, v10
    move-object v4, v12
    move-object v5, v13
    invoke-direct/range {v0..v5}, Lcom/palai/prootsmoke/EyesService$Api30$1;-><init>(Ljava/util/concurrent/atomic/AtomicReference;IILjava/util/concurrent/atomic/AtomicReference;Ljava/util/concurrent/CountDownLatch;)V
    const/4 v9, #0
    invoke-virtual {v7, v9, v8, v6}, Landroid/accessibilityservice/AccessibilityService;->takeScreenshot(ILjava/util/concurrent/Executor;Landroid/accessibilityservice/AccessibilityService$TakeScreenshotCallback;)V
    return-void 
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/EyesService$Api30;->encode(Landroid/accessibilityservice/AccessibilityService$ScreenshotResult;II)[B
    # registers=6 ins=3 tries=1
    invoke-virtual {v3}, Landroid/accessibilityservice/AccessibilityService$ScreenshotResult;->getHardwareBuffer()Landroid/hardware/HardwareBuffer;
    move-result-object v0
    invoke-virtual {v3}, Landroid/accessibilityservice/AccessibilityService$ScreenshotResult;->getColorSpace()Landroid/graphics/ColorSpace;
    move-result-object v3
    invoke-static {v0, v3}, Landroid/graphics/Bitmap;->wrapHardwareBuffer(Landroid/hardware/HardwareBuffer;Landroid/graphics/ColorSpace;)Landroid/graphics/Bitmap;
    move-result-object v3
    if-eqz v3, :L116
    sget-object v0, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;
    const/4 v1, #0
    invoke-virtual {v3, v0, v1}, Landroid/graphics/Bitmap;->copy(Landroid/graphics/Bitmap$Config;Z)Landroid/graphics/Bitmap;
    move-result-object v0
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V
    nop 
    if-eqz v0, :L103
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getWidth()I
    move-result v3
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->getHeight()I
    move-result v1
    nop 
    if-le v3, v4, :L57
    int-to-float v1, v1
    int-to-float v2, v4
    int-to-float v3, v3
    div-float/2addr v2, v3
    mul-float/2addr v1, v2
    invoke-static {v1}, Ljava/lang/Math;->round(F)I
    move-result v3
    const/4 v1, #1
    invoke-static {v1, v3}, Ljava/lang/Math;->max(II)I
    move-result v3
    invoke-static {v0, v4, v3, v1}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;
    move-result-object v3
    goto :L58
    :L57
    move-object v3, v0
    :L58
    invoke-static {}, Lcom/palai/prootsmoke/EyesService;->access$300()Lcom/palai/prootsmoke/EyesService;
    move-result-object v4
    if-eqz v4, :L78
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->getWidth()I
    move-result v1
    invoke-static {v4, v1}, Lcom/palai/prootsmoke/EyesService;->access$402(Lcom/palai/prootsmoke/EyesService;I)I
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->getHeight()I
    move-result v1
    invoke-static {v4, v1}, Lcom/palai/prootsmoke/EyesService;->access$502(Lcom/palai/prootsmoke/EyesService;I)I
    :L78
    new-instance v4, Ljava/io/ByteArrayOutputStream;
    const/high16 v1, #int 0x40000
    invoke-direct {v4, v1}, Ljava/io/ByteArrayOutputStream;-><init>(I)V
    sget-object v1, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;
    invoke-virtual {v3, v1, v5, v4}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z
    if-eq v3, v0, :L95
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V
    :L95
    invoke-virtual {v0}, Landroid/graphics/Bitmap;->recycle()V
    invoke-virtual {v4}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B
    move-result-object v3
    return-object v3
    :L103
    new-instance v3, Ljava/lang/IllegalStateException;
    const-string v4, "画面转换失败"
    invoke-direct {v3, v4}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V
    throw v3
    move-exception v4
    invoke-virtual {v3}, Landroid/graphics/Bitmap;->recycle()V
    throw v4
    :L116
    new-instance v3, Ljava/lang/IllegalStateException;
    const-string v4, "拿不到画面"
    invoke-direct {v3, v4}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V
    throw v3
.end method

