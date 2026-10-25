.class Lcom/palai/prootsmoke/EyesService$1;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/EyesService;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/EyesService$1;-><init>(Lcom/palai/prootsmoke/EyesService;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/EyesService$1;->this$0:Lcom/palai/prootsmoke/EyesService;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/EyesService$1;->run()V
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/EyesService$1;->this$0:Lcom/palai/prootsmoke/EyesService;
    invoke-static {v0}, Lcom/palai/prootsmoke/EyesService;->access$000(Lcom/palai/prootsmoke/EyesService;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/EyesService$2;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/EyesService;
.field final synthetic val$socket:Ljava/net/Socket;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/EyesService$2;-><init>(Lcom/palai/prootsmoke/EyesService;Ljava/net/Socket;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/EyesService$2;->this$0:Lcom/palai/prootsmoke/EyesService;
    iput-object v2, v0, Lcom/palai/prootsmoke/EyesService$2;->val$socket:Ljava/net/Socket;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/EyesService$2;->run()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/EyesService$2;->this$0:Lcom/palai/prootsmoke/EyesService;
    iget-object v1, v2, Lcom/palai/prootsmoke/EyesService$2;->val$socket:Ljava/net/Socket;
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/EyesService;->access$100(Lcom/palai/prootsmoke/EyesService;Ljava/net/Socket;)V
    return-void 
.end method

.class Lcom/palai/prootsmoke/EyesService$Api30$1;
.super Ljava/lang/Object;

.field final synthetic val$fail:Ljava/util/concurrent/atomic/AtomicReference;
.field final synthetic val$latch:Ljava/util/concurrent/CountDownLatch;
.field final synthetic val$maxW:I
.field final synthetic val$out:Ljava/util/concurrent/atomic/AtomicReference;
.field final synthetic val$quality:I

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/EyesService$Api30$1;-><init>(Ljava/util/concurrent/atomic/AtomicReference;IILjava/util/concurrent/atomic/AtomicReference;Ljava/util/concurrent/CountDownLatch;)V
    # registers=6 ins=6 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/EyesService$Api30$1;->val$out:Ljava/util/concurrent/atomic/AtomicReference;
    iput v2, v0, Lcom/palai/prootsmoke/EyesService$Api30$1;->val$maxW:I
    iput v3, v0, Lcom/palai/prootsmoke/EyesService$Api30$1;->val$quality:I
    iput-object v4, v0, Lcom/palai/prootsmoke/EyesService$Api30$1;->val$fail:Ljava/util/concurrent/atomic/AtomicReference;
    iput-object v5, v0, Lcom/palai/prootsmoke/EyesService$Api30$1;->val$latch:Ljava/util/concurrent/CountDownLatch;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/EyesService$Api30$1;->onFailure(I)V
    # registers=5 ins=2 tries=0
    iget-object v0, v3, Lcom/palai/prootsmoke/EyesService$Api30$1;->val$fail:Ljava/util/concurrent/atomic/AtomicReference;
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "截屏失败(code="
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v4
    const-string v1, ")"
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v4
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-virtual {v0, v4}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V
    iget-object v4, v3, Lcom/palai/prootsmoke/EyesService$Api30$1;->val$latch:Ljava/util/concurrent/CountDownLatch;
    invoke-virtual {v4}, Ljava/util/concurrent/CountDownLatch;->countDown()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/EyesService$Api30$1;->onSuccess(Landroid/accessibilityservice/AccessibilityService$ScreenshotResult;)V
    # registers=5 ins=2 tries=5
    iget-object v0, v3, Lcom/palai/prootsmoke/EyesService$Api30$1;->val$out:Ljava/util/concurrent/atomic/AtomicReference;
    iget v1, v3, Lcom/palai/prootsmoke/EyesService$Api30$1;->val$maxW:I
    iget v2, v3, Lcom/palai/prootsmoke/EyesService$Api30$1;->val$quality:I
    invoke-static {v4, v1, v2}, Lcom/palai/prootsmoke/EyesService$Api30;->access$200(Landroid/accessibilityservice/AccessibilityService$ScreenshotResult;II)[B
    move-result-object v1
    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V
    invoke-virtual {v4}, Landroid/accessibilityservice/AccessibilityService$ScreenshotResult;->getHardwareBuffer()Landroid/hardware/HardwareBuffer;
    move-result-object v4
    invoke-virtual {v4}, Landroid/hardware/HardwareBuffer;->close()V
    goto :L40
    move-exception v4
    goto :L42
    move-exception v0
    iget-object v1, v3, Lcom/palai/prootsmoke/EyesService$Api30$1;->val$fail:Ljava/util/concurrent/atomic/AtomicReference;
    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v1, v0}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V
    invoke-virtual {v4}, Landroid/accessibilityservice/AccessibilityService$ScreenshotResult;->getHardwareBuffer()Landroid/hardware/HardwareBuffer;
    move-result-object v4
    invoke-virtual {v4}, Landroid/hardware/HardwareBuffer;->close()V
    :L40
    goto :L42
    move-exception v4
    :L42
    iget-object v4, v3, Lcom/palai/prootsmoke/EyesService$Api30$1;->val$latch:Ljava/util/concurrent/CountDownLatch;
    invoke-virtual {v4}, Ljava/util/concurrent/CountDownLatch;->countDown()V
    nop 
    return-void 
    move-exception v0
    invoke-virtual {v4}, Landroid/accessibilityservice/AccessibilityService$ScreenshotResult;->getHardwareBuffer()Landroid/hardware/HardwareBuffer;
    move-result-object v4
    invoke-virtual {v4}, Landroid/hardware/HardwareBuffer;->close()V
    goto :L59
    move-exception v4
    :L59
    iget-object v4, v3, Lcom/palai/prootsmoke/EyesService$Api30$1;->val$latch:Ljava/util/concurrent/CountDownLatch;
    invoke-virtual {v4}, Ljava/util/concurrent/CountDownLatch;->countDown()V
    throw v0
.end method

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

.class public interface abstract Lcom/palai/prootsmoke/EyesService$ImeListener;
.super Ljava/lang/Object;

# virtual access=0x401
.method public abstract Lcom/palai/prootsmoke/EyesService$ImeListener;->onImeHeight(I)V
    # (no code)
.end method

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

.class Lcom/palai/prootsmoke/PetKeyboardGuard$1;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetKeyboardGuard;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetKeyboardGuard$1;-><init>(Lcom/palai/prootsmoke/PetKeyboardGuard;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetKeyboardGuard$1;->this$0:Lcom/palai/prootsmoke/PetKeyboardGuard;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetKeyboardGuard$1;->run()V
    # registers=4 ins=1 tries=1
    iget-object v0, v3, Lcom/palai/prootsmoke/PetKeyboardGuard$1;->this$0:Lcom/palai/prootsmoke/PetKeyboardGuard;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetKeyboardGuard;->access$000(Lcom/palai/prootsmoke/PetKeyboardGuard;)V
    goto :L31
    move-exception v0
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "tick failed: "
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    const-string v1, "PetKb"
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :L31
    iget-object v0, v3, Lcom/palai/prootsmoke/PetKeyboardGuard$1;->this$0:Lcom/palai/prootsmoke/PetKeyboardGuard;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetKeyboardGuard;->access$100(Lcom/palai/prootsmoke/PetKeyboardGuard;)Landroid/os/Handler;
    move-result-object v0
    const-wide/16 v1, #150
    invoke-virtual {v0, v3, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetKeyboardGuard$2;
.super Ljava/lang/Object;

.field final synthetic val$self:Lcom/palai/prootsmoke/PetKeyboardGuard;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetKeyboardGuard$2;-><init>(Lcom/palai/prootsmoke/PetKeyboardGuard;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetKeyboardGuard$2;->val$self:Lcom/palai/prootsmoke/PetKeyboardGuard;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetKeyboardGuard$2;->onImeHeight(I)V
    # registers=3 ins=2 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetKeyboardGuard$2;->val$self:Lcom/palai/prootsmoke/PetKeyboardGuard;
    invoke-static {v0, v2}, Lcom/palai/prootsmoke/PetKeyboardGuard;->access$200(Lcom/palai/prootsmoke/PetKeyboardGuard;I)V
    return-void 
.end method

.class public final Lcom/palai/prootsmoke/PetKeyboardGuard;
.super Ljava/lang/Object;

.field private static final IME_RATIO:F
.field private static final INTERVAL_MS:J
.field private static final TAG:Ljava/lang/String;
.field private static volatile current:Lcom/palai/prootsmoke/PetKeyboardGuard;
.field private static volatile touchLayer:Landroid/view/View;
.field private final app:Landroid/content/Context;
.field private lastHeight:I
.field private lastSource:Ljava/lang/String;
.field private reportedOnce:Z
.field private volatile root:Landroid/view/View;
.field private final screenH:I
.field private seq:J
.field private volatile target:Landroid/view/View;
.field private final tick:Ljava/lang/Runnable;
.field private final ui:Landroid/os/Handler;
.field private web:Landroid/webkit/WebView;

# direct access=0x10002
.method private constructor Lcom/palai/prootsmoke/PetKeyboardGuard;-><init>(Landroid/content/Context;Landroid/view/View;Landroid/view/View;)V
    # registers=6 ins=4 tries=0
    invoke-direct {v2}, Ljava/lang/Object;-><init>()V
    new-instance v0, Landroid/os/Handler;
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;
    move-result-object v1
    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
    iput-object v0, v2, Lcom/palai/prootsmoke/PetKeyboardGuard;->ui:Landroid/os/Handler;
    const-wide/16 v0, #0
    iput-wide v0, v2, Lcom/palai/prootsmoke/PetKeyboardGuard;->seq:J
    const/4 v0, #-1
    iput v0, v2, Lcom/palai/prootsmoke/PetKeyboardGuard;->lastHeight:I
    const-string v0, ""
    iput-object v0, v2, Lcom/palai/prootsmoke/PetKeyboardGuard;->lastSource:Ljava/lang/String;
    const/4 v0, #0
    iput-boolean v0, v2, Lcom/palai/prootsmoke/PetKeyboardGuard;->reportedOnce:Z
    new-instance v0, Lcom/palai/prootsmoke/PetKeyboardGuard$1;
    invoke-direct {v0, v2}, Lcom/palai/prootsmoke/PetKeyboardGuard$1;-><init>(Lcom/palai/prootsmoke/PetKeyboardGuard;)V
    iput-object v0, v2, Lcom/palai/prootsmoke/PetKeyboardGuard;->tick:Ljava/lang/Runnable;
    invoke-virtual {v3}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;
    move-result-object v0
    iput-object v0, v2, Lcom/palai/prootsmoke/PetKeyboardGuard;->app:Landroid/content/Context;
    iput-object v4, v2, Lcom/palai/prootsmoke/PetKeyboardGuard;->root:Landroid/view/View;
    iput-object v5, v2, Lcom/palai/prootsmoke/PetKeyboardGuard;->target:Landroid/view/View;
    invoke-virtual {v3}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;
    move-result-object v3
    invoke-virtual {v3}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;
    move-result-object v3
    iget v3, v3, Landroid/util/DisplayMetrics;->heightPixels:I
    iput v3, v2, Lcom/palai/prootsmoke/PetKeyboardGuard;->screenH:I
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetKeyboardGuard;->a11yOrInsets()I
    # registers=4 ins=1 tries=1
    invoke-static {}, Lcom/palai/prootsmoke/EyesService;->imeHeight()I
    move-result v0
    if-lez v0, :L33
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "a11y="
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    iput-object v1, v3, Lcom/palai/prootsmoke/PetKeyboardGuard;->lastSource:Ljava/lang/String;
    invoke-direct {v3, v0}, Lcom/palai/prootsmoke/PetKeyboardGuard;->clampH(I)I
    move-result v0
    return v0
    move-exception v0
    :L33
    nop 
    invoke-direct {v3}, Lcom/palai/prootsmoke/PetKeyboardGuard;->imeHeight()I
    move-result v0
    return v0
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/PetKeyboardGuard;->access$000(Lcom/palai/prootsmoke/PetKeyboardGuard;)V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/PetKeyboardGuard;->evaluate()V
    return-void 
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/PetKeyboardGuard;->access$100(Lcom/palai/prootsmoke/PetKeyboardGuard;)Landroid/os/Handler;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/PetKeyboardGuard;->ui:Landroid/os/Handler;
    return-object v0
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/PetKeyboardGuard;->access$200(Lcom/palai/prootsmoke/PetKeyboardGuard;I)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/PetKeyboardGuard;->onImeFromA11y(I)V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetKeyboardGuard;->clampH(I)I
    # registers=6 ins=2 tries=0
    if-gtz v5, :L4
    const/4 v5, #0
    return v5
    :L4
    iget v0, v4, Lcom/palai/prootsmoke/PetKeyboardGuard;->screenH:I
    int-to-double v0, v0
    const-wide/high16 v2, #int 0x3fe80000
    mul-double/2addr v0, v2
    double-to-int v0, v0
    invoke-static {v5, v0}, Ljava/lang/Math;->min(II)I
    move-result v5
    return v5
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetKeyboardGuard;->evaluate()V
    # registers=7 ins=1 tries=0
    invoke-static {}, Lcom/palai/prootsmoke/EyesService;->isRunning()Z
    move-result v0
    if-eqz v0, :L11
    invoke-direct {v6}, Lcom/palai/prootsmoke/PetKeyboardGuard;->a11yOrInsets()I
    move-result v1
    goto :L15
    :L11
    invoke-direct {v6}, Lcom/palai/prootsmoke/PetKeyboardGuard;->imeHeight()I
    move-result v1
    :L15
    iget-boolean v2, v6, Lcom/palai/prootsmoke/PetKeyboardGuard;->reportedOnce:Z
    const/4 v3, #0
    const-string v4, "PetKb"
    const/4 v5, #1
    if-nez v2, :L38
    iput-boolean v5, v6, Lcom/palai/prootsmoke/PetKeyboardGuard;->reportedOnce:Z
    if-eqz v0, :L30
    const-string v0, "init a11y=on"
    goto :L32
    :L30
    const-string v0, "init a11y=off 需要开启无障碍"
    :L32
    invoke-static {v4, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    invoke-direct {v6, v3, v0}, Lcom/palai/prootsmoke/PetKeyboardGuard;->reportIme(ZLjava/lang/String;)V
    :L38
    iget v0, v6, Lcom/palai/prootsmoke/PetKeyboardGuard;->lastHeight:I
    if-eq v1, v0, :L82
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "ime height "
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v2, " ("
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    iget-object v2, v6, Lcom/palai/prootsmoke/PetKeyboardGuard;->lastSource:Ljava/lang/String;
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v2, ")"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static {v4, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :L82
    iput v1, v6, Lcom/palai/prootsmoke/PetKeyboardGuard;->lastHeight:I
    invoke-direct {v6, v1}, Lcom/palai/prootsmoke/PetKeyboardGuard;->reportKeyboard(I)V
    if-lez v1, :L90
    move v3, v5
    :L90
    iget-object v0, v6, Lcom/palai/prootsmoke/PetKeyboardGuard;->lastSource:Ljava/lang/String;
    invoke-direct {v6, v3, v0}, Lcom/palai/prootsmoke/PetKeyboardGuard;->reportIme(ZLjava/lang/String;)V
    return-void 
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/PetKeyboardGuard;->findWeb(Landroid/view/View;)Landroid/webkit/WebView;
    # registers=4 ins=1 tries=0
    const/4 v0, #0
    if-nez v3, :L4
    return-object v0
    :L4
    instance-of v1, v3, Landroid/webkit/WebView;
    if-eqz v1, :L11
    check-cast v3, Landroid/webkit/WebView;
    return-object v3
    :L11
    instance-of v1, v3, Landroid/view/ViewGroup;
    if-eqz v1, :L38
    check-cast v3, Landroid/view/ViewGroup;
    const/4 v1, #0
    :L18
    invoke-virtual {v3}, Landroid/view/ViewGroup;->getChildCount()I
    move-result v2
    if-ge v1, v2, :L38
    invoke-virtual {v3, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;
    move-result-object v2
    invoke-static {v2}, Lcom/palai/prootsmoke/PetKeyboardGuard;->findWeb(Landroid/view/View;)Landroid/webkit/WebView;
    move-result-object v2
    if-eqz v2, :L35
    return-object v2
    :L35
    add-int/lit8 v1, v1, #1
    goto :L18
    :L38
    return-object v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetKeyboardGuard;->imeHeight()I
    # registers=5 ins=1 tries=4
    const-string v0, ""
    iput-object v0, v4, Lcom/palai/prootsmoke/PetKeyboardGuard;->lastSource:Ljava/lang/String;
    nop 
    invoke-static {}, Lcom/palai/prootsmoke/EyesService;->imeHeightSmart()I
    move-result v0
    if-lez v0, :L37
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "a11y="
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    iput-object v1, v4, Lcom/palai/prootsmoke/PetKeyboardGuard;->lastSource:Ljava/lang/String;
    invoke-direct {v4, v0}, Lcom/palai/prootsmoke/PetKeyboardGuard;->clampH(I)I
    move-result v0
    return v0
    :L37
    if-gez v0, :L76
    iget v0, v4, Lcom/palai/prootsmoke/PetKeyboardGuard;->screenH:I
    int-to-double v0, v0
    const-wide v2, #4600517091351509074L
    mul-double/2addr v0, v2
    double-to-int v0, v0
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "a11y~guess="
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    iput-object v1, v4, Lcom/palai/prootsmoke/PetKeyboardGuard;->lastSource:Ljava/lang/String;
    invoke-direct {v4, v0}, Lcom/palai/prootsmoke/PetKeyboardGuard;->clampH(I)I
    move-result v0
    return v0
    move-exception v0
    :L76
    nop 
    iget-object v0, v4, Lcom/palai/prootsmoke/PetKeyboardGuard;->root:Landroid/view/View;
    invoke-virtual {v0}, Landroid/view/View;->getRootWindowInsets()Landroid/view/WindowInsets;
    move-result-object v0
    if-eqz v0, :L124
    invoke-static {}, Landroid/view/WindowInsets$Type;->ime()I
    move-result v1
    invoke-virtual {v0, v1}, Landroid/view/WindowInsets;->getInsets(I)Landroid/graphics/Insets;
    move-result-object v0
    iget v0, v0, Landroid/graphics/Insets;->bottom:I
    if-lez v0, :L124
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "root.insets="
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    iput-object v1, v4, Lcom/palai/prootsmoke/PetKeyboardGuard;->lastSource:Ljava/lang/String;
    invoke-direct {v4, v0}, Lcom/palai/prootsmoke/PetKeyboardGuard;->clampH(I)I
    move-result v0
    return v0
    move-exception v0
    :L124
    nop 
    sget-object v0, Lcom/palai/prootsmoke/PetKeyboardGuard;->touchLayer:Landroid/view/View;
    if-eqz v0, :L174
    invoke-virtual {v0}, Landroid/view/View;->getRootWindowInsets()Landroid/view/WindowInsets;
    move-result-object v0
    if-eqz v0, :L174
    invoke-static {}, Landroid/view/WindowInsets$Type;->ime()I
    move-result v1
    invoke-virtual {v0, v1}, Landroid/view/WindowInsets;->getInsets(I)Landroid/graphics/Insets;
    move-result-object v0
    iget v0, v0, Landroid/graphics/Insets;->bottom:I
    if-lez v0, :L174
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "touch.insets="
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    iput-object v1, v4, Lcom/palai/prootsmoke/PetKeyboardGuard;->lastSource:Ljava/lang/String;
    invoke-direct {v4, v0}, Lcom/palai/prootsmoke/PetKeyboardGuard;->clampH(I)I
    move-result v0
    return v0
    move-exception v0
    :L174
    nop 
    new-instance v0, Landroid/graphics/Rect;
    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V
    iget-object v1, v4, Lcom/palai/prootsmoke/PetKeyboardGuard;->root:Landroid/view/View;
    invoke-virtual {v1, v0}, Landroid/view/View;->getWindowVisibleDisplayFrame(Landroid/graphics/Rect;)V
    iget v1, v4, Lcom/palai/prootsmoke/PetKeyboardGuard;->screenH:I
    iget v0, v0, Landroid/graphics/Rect;->bottom:I
    sub-int/2addr v1, v0
    if-lez v1, :L219
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "frame="
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    iput-object v0, v4, Lcom/palai/prootsmoke/PetKeyboardGuard;->lastSource:Ljava/lang/String;
    invoke-direct {v4, v1}, Lcom/palai/prootsmoke/PetKeyboardGuard;->clampH(I)I
    move-result v0
    return v0
    move-exception v0
    :L219
    nop 
    const/4 v0, #0
    return v0
.end method

# direct access=0x9
.method public static Lcom/palai/prootsmoke/PetKeyboardGuard;->install(Landroid/content/Context;Landroid/view/View;Landroid/view/View;)V
    # registers=5 ins=3 tries=1
    const-string v0, "PetKb"
    if-eqz v2, :L107
    if-nez v3, :L7
    goto :L107
    :L7
    sget-object v1, Lcom/palai/prootsmoke/PetKeyboardGuard;->current:Lcom/palai/prootsmoke/PetKeyboardGuard;
    if-nez v1, :L29
    new-instance v1, Lcom/palai/prootsmoke/PetKeyboardGuard;
    if-nez v4, :L16
    move-object v4, v3
    :L16
    invoke-direct {v1, v2, v3, v4}, Lcom/palai/prootsmoke/PetKeyboardGuard;-><init>(Landroid/content/Context;Landroid/view/View;Landroid/view/View;)V
    iget-object v2, v1, Lcom/palai/prootsmoke/PetKeyboardGuard;->ui:Landroid/os/Handler;
    iget-object v3, v1, Lcom/palai/prootsmoke/PetKeyboardGuard;->tick:Ljava/lang/Runnable;
    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    sput-object v1, Lcom/palai/prootsmoke/PetKeyboardGuard;->current:Lcom/palai/prootsmoke/PetKeyboardGuard;
    goto :L35
    :L29
    if-nez v4, :L32
    move-object v4, v3
    :L32
    invoke-direct {v1, v3, v4}, Lcom/palai/prootsmoke/PetKeyboardGuard;->retarget(Landroid/view/View;Landroid/view/View;)V
    :L35
    nop 
    new-instance v2, Lcom/palai/prootsmoke/PetKeyboardGuard$2;
    invoke-direct {v2, v1}, Lcom/palai/prootsmoke/PetKeyboardGuard$2;-><init>(Lcom/palai/prootsmoke/PetKeyboardGuard;)V
    invoke-static {v2}, Lcom/palai/prootsmoke/EyesService;->setImeListener(Lcom/palai/prootsmoke/EyesService$ImeListener;)V
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    const-string v3, "installed screenH="
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v2
    iget v3, v1, Lcom/palai/prootsmoke/PetKeyboardGuard;->screenH:I
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v2
    const-string v3, " a11y="
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-static {}, Lcom/palai/prootsmoke/EyesService;->isRunning()Z
    move-result v3
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    invoke-static {v0, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    goto :L106
    move-exception v2
    new-instance v3, Ljava/lang/StringBuilder;
    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V
    const-string v4, "install failed: "
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    invoke-static {v0, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :L106
    return-void 
    :L107
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetKeyboardGuard;->onImeFromA11y(I)V
    # registers=3 ins=2 tries=0
    if-gez v2, :L3
    const/4 v2, #0
    :L3
    const-string v0, "a11y"
    invoke-direct {v1, v2, v0}, Lcom/palai/prootsmoke/PetKeyboardGuard;->publish(ILjava/lang/String;)V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetKeyboardGuard;->publish(ILjava/lang/String;)V
    # registers=3 ins=3 tries=0
    iput-object v2, v0, Lcom/palai/prootsmoke/PetKeyboardGuard;->lastSource:Ljava/lang/String;
    iput v1, v0, Lcom/palai/prootsmoke/PetKeyboardGuard;->lastHeight:I
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/PetKeyboardGuard;->reportKeyboard(I)V
    if-lez v1, :L11
    const/4 v1, #1
    goto :L12
    :L11
    const/4 v1, #0
    :L12
    invoke-direct {v0, v1, v2}, Lcom/palai/prootsmoke/PetKeyboardGuard;->reportIme(ZLjava/lang/String;)V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetKeyboardGuard;->reportIme(ZLjava/lang/String;)V
    # registers=6 ins=3 tries=1
    iget-object v0, v3, Lcom/palai/prootsmoke/PetKeyboardGuard;->web:Landroid/webkit/WebView;
    if-nez v0, :L12
    iget-object v0, v3, Lcom/palai/prootsmoke/PetKeyboardGuard;->root:Landroid/view/View;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetKeyboardGuard;->findWeb(Landroid/view/View;)Landroid/webkit/WebView;
    move-result-object v0
    iput-object v0, v3, Lcom/palai/prootsmoke/PetKeyboardGuard;->web:Landroid/webkit/WebView;
    :L12
    iget-object v0, v3, Lcom/palai/prootsmoke/PetKeyboardGuard;->web:Landroid/webkit/WebView;
    if-nez v0, :L24
    const-string v4, "PetKb"
    const-string v5, "no webview for ime report"
    invoke-static {v4, v5}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    return-void 
    :L24
    if-nez v5, :L29
    const-string v5, ""
    goto :L37
    :L29
    const-string v0, "'"
    const-string v1, " "
    invoke-virtual {v5, v0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;
    move-result-object v5
    :L37
    iget-object v0, v3, Lcom/palai/prootsmoke/PetKeyboardGuard;->web:Landroid/webkit/WebView;
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "window.__petIme&&window.__petIme("
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
    move-result-object v4
    const-string v1, ",'"
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v4
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v4
    const-string v5, "')"
    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v4
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    const/4 v5, #0
    invoke-virtual {v0, v4, v5}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    goto :L80
    move-exception v4
    :L80
    nop 
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetKeyboardGuard;->reportKeyboard(I)V
    # registers=8 ins=2 tries=1
    const-string v0, "PetKb"
    iget-object v1, v6, Lcom/palai/prootsmoke/PetKeyboardGuard;->web:Landroid/webkit/WebView;
    if-nez v1, :L14
    iget-object v1, v6, Lcom/palai/prootsmoke/PetKeyboardGuard;->root:Landroid/view/View;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetKeyboardGuard;->findWeb(Landroid/view/View;)Landroid/webkit/WebView;
    move-result-object v1
    iput-object v1, v6, Lcom/palai/prootsmoke/PetKeyboardGuard;->web:Landroid/webkit/WebView;
    :L14
    iget-object v1, v6, Lcom/palai/prootsmoke/PetKeyboardGuard;->web:Landroid/webkit/WebView;
    if-nez v1, :L24
    const-string v7, "no webview for keyboard report"
    invoke-static {v0, v7}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    return-void 
    :L24
    iget-wide v2, v6, Lcom/palai/prootsmoke/PetKeyboardGuard;->seq:J
    const-wide/16 v4, #1
    add-long/2addr v2, v4
    iput-wide v2, v6, Lcom/palai/prootsmoke/PetKeyboardGuard;->seq:J
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    const-string v3, "window.__petKeyboard&&window.__petKeyboard("
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v7
    const-string v2, ","
    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v7
    iget-wide v2, v6, Lcom/palai/prootsmoke/PetKeyboardGuard;->seq:J
    invoke-virtual {v7, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    move-result-object v7
    const-string v2, ")"
    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v7
    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v7
    const/4 v2, #0
    invoke-virtual {v1, v7, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    goto :L96
    move-exception v7
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "reportKeyboard failed: "
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v7
    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v7
    invoke-static {v0, v7}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :L96
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetKeyboardGuard;->retarget(Landroid/view/View;Landroid/view/View;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetKeyboardGuard;->root:Landroid/view/View;
    iput-object v2, v0, Lcom/palai/prootsmoke/PetKeyboardGuard;->target:Landroid/view/View;
    const/4 v1, #0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetKeyboardGuard;->web:Landroid/webkit/WebView;
    return-void 
.end method

# direct access=0x9
.method public static Lcom/palai/prootsmoke/PetKeyboardGuard;->setTouchLayer(Landroid/view/View;)V
    # registers=3 ins=1 tries=0
    sput-object v2, Lcom/palai/prootsmoke/PetKeyboardGuard;->touchLayer:Landroid/view/View;
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    const-string v1, "touch layer attached="
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    if-eqz v2, :L17
    const/4 v2, #1
    goto :L18
    :L17
    const/4 v2, #0
    :L18
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    const-string v0, "PetKb"
    invoke-static {v0, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindow2$1;
.super Ljava/lang/Object;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindow2$1;-><init>()V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindow2$1;->run()V
    # registers=4 ins=1 tries=1
    invoke-static {}, Lcom/palai/prootsmoke/PetWindow2;->access$000()V
    goto :L29
    move-exception v0
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "tick: "
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    const-string v1, "PetWin2"
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :L29
    invoke-static {}, Lcom/palai/prootsmoke/PetWindow2;->access$100()Landroid/os/Handler;
    move-result-object v0
    const-wide/16 v1, #120
    invoke-virtual {v0, v3, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindow2$2;
.super Landroid/webkit/WebViewClient;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindow2$2;-><init>()V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Landroid/webkit/WebViewClient;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindow2$2;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    # registers=4 ins=3 tries=1
    const-string v3, "(function(){ if (typeof petHostNative === 'undefined') return 'no-bridge'; if (window.petHost) return 'already'; window.petHost = { setInteractive:function(o){}, focus:function(){}, grabFocus:function(){}, releaseFocus:function(){}, hide:function(){}, openDress:function(){}, setAlpha:function(f){}, getAlpha:function(){return 1;}, openApp:function(n){return false;}, onCursor:function(cb){}, sampleBackdrop:function(){return null;} }; document.body.classList.remove('tab'); document.body.classList.add('desk'); return 'ok';})()"
    const/4 v0, #0
    invoke-virtual {v2, v3, v0}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    goto :L8
    move-exception v2
    :L8
    return-void 
.end method

.class Lcom/palai/prootsmoke/PetWindow2$3;
.super Landroid/view/View;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindow2$3;-><init>(Landroid/content/Context;)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Landroid/view/View;-><init>(Landroid/content/Context;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindow2$3;->onTouchEvent(Landroid/view/MotionEvent;)Z
    # registers=2 ins=2 tries=0
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindow2;->access$200(Landroid/view/MotionEvent;)Z
    move-result v1
    return v1
.end method

.class public final Lcom/palai/prootsmoke/PetWindow2$Bridge;
.super Ljava/lang/Object;

# direct access=0x10001
.method public constructor Lcom/palai/prootsmoke/PetWindow2$Bridge;-><init>()V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindow2$Bridge;->log(Ljava/lang/String;)V
    # registers=4 ins=2 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    const-string v1, "page: "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    const-string v0, "PetWin2"
    invoke-static {v0, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindow2$Bridge;->rect(FFFF)V
    # registers=5 ins=5 tries=0
    invoke-static {v1}, Ljava/lang/Math;->round(F)I
    move-result v1
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindow2;->access$302(I)I
    invoke-static {v2}, Ljava/lang/Math;->round(F)I
    move-result v1
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindow2;->access$402(I)I
    invoke-static {v3}, Ljava/lang/Math;->round(F)I
    move-result v1
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindow2;->access$502(I)I
    invoke-static {v4}, Ljava/lang/Math;->round(F)I
    move-result v1
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindow2;->access$602(I)I
    return-void 
.end method

.class public final Lcom/palai/prootsmoke/PetWindow2$HostBridge;
.super Ljava/lang/Object;

# direct access=0x10001
.method public constructor Lcom/palai/prootsmoke/PetWindow2$HostBridge;-><init>()V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindow2$HostBridge;->focus()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindow2$HostBridge;->getAlpha()F
    # registers=2 ins=1 tries=0
    const/high16 v0, #int 0x3f800000
    return v0
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindow2$HostBridge;->grabFocus()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindow2$HostBridge;->hide()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindow2$HostBridge;->openApp(Ljava/lang/String;)Z
    # registers=2 ins=2 tries=0
    const/4 v1, #0
    return v1
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindow2$HostBridge;->openDress()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindow2$HostBridge;->releaseFocus()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindow2$HostBridge;->setAlpha(F)V
    # registers=2 ins=2 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindow2$HostBridge;->setInteractive(Z)V
    # registers=2 ins=2 tries=0
    return-void 
.end method

.class public final Lcom/palai/prootsmoke/PetWindow2;
.super Ljava/lang/Object;

.field private static final BASE_TOUCH:I
.field private static final SHIM:Ljava/lang/String;
.field private static final TAG:Ljava/lang/String;
.field private static final URL:Ljava/lang/String;
.field private static volatile petB:I
.field private static volatile petL:I
.field private static volatile petR:I
.field private static volatile petT:I
.field private static started:Z
.field private static final tick:Ljava/lang/Runnable;
.field private static touch:Landroid/view/View;
.field private static touchLp:Landroid/view/WindowManager$LayoutParams;
.field private static final ui:Landroid/os/Handler;
.field private static web:Landroid/webkit/WebView;
.field private static webLp:Landroid/view/WindowManager$LayoutParams;
.field private static wm:Landroid/view/WindowManager;

# direct access=0x10008
.method static constructor Lcom/palai/prootsmoke/PetWindow2;-><clinit>()V
    # registers=2 ins=0 tries=0
    const/4 v0, #-1
    sput v0, Lcom/palai/prootsmoke/PetWindow2;->petL:I
    sput v0, Lcom/palai/prootsmoke/PetWindow2;->petT:I
    sput v0, Lcom/palai/prootsmoke/PetWindow2;->petR:I
    sput v0, Lcom/palai/prootsmoke/PetWindow2;->petB:I
    const/4 v0, #0
    sput-boolean v0, Lcom/palai/prootsmoke/PetWindow2;->started:Z
    new-instance v0, Landroid/os/Handler;
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;
    move-result-object v1
    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
    sput-object v0, Lcom/palai/prootsmoke/PetWindow2;->ui:Landroid/os/Handler;
    new-instance v0, Lcom/palai/prootsmoke/PetWindow2$1;
    invoke-direct {v0}, Lcom/palai/prootsmoke/PetWindow2$1;-><init>()V
    sput-object v0, Lcom/palai/prootsmoke/PetWindow2;->tick:Ljava/lang/Runnable;
    return-void 
.end method

# direct access=0x10002
.method private constructor Lcom/palai/prootsmoke/PetWindow2;-><init>()V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/PetWindow2;->access$000()V
    # registers=0 ins=0 tries=0
    invoke-static {}, Lcom/palai/prootsmoke/PetWindow2;->sync()V
    return-void 
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/PetWindow2;->access$100()Landroid/os/Handler;
    # registers=1 ins=0 tries=0
    sget-object v0, Lcom/palai/prootsmoke/PetWindow2;->ui:Landroid/os/Handler;
    return-object v0
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/PetWindow2;->access$200(Landroid/view/MotionEvent;)Z
    # registers=1 ins=1 tries=0
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindow2;->forward(Landroid/view/MotionEvent;)Z
    move-result v0
    return v0
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/PetWindow2;->access$302(I)I
    # registers=1 ins=1 tries=0
    sput v0, Lcom/palai/prootsmoke/PetWindow2;->petL:I
    return v0
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/PetWindow2;->access$402(I)I
    # registers=1 ins=1 tries=0
    sput v0, Lcom/palai/prootsmoke/PetWindow2;->petT:I
    return v0
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/PetWindow2;->access$502(I)I
    # registers=1 ins=1 tries=0
    sput v0, Lcom/palai/prootsmoke/PetWindow2;->petR:I
    return v0
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/PetWindow2;->access$602(I)I
    # registers=1 ins=1 tries=0
    sput v0, Lcom/palai/prootsmoke/PetWindow2;->petB:I
    return v0
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/PetWindow2;->build(Landroid/content/Context;)V
    # registers=10 ins=1 tries=0
    const-string v0, "window"
    invoke-virtual {v9, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/view/WindowManager;
    sput-object v0, Lcom/palai/prootsmoke/PetWindow2;->wm:Landroid/view/WindowManager;
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v1, #26
    if-lt v0, v1, :L19
    const/16 v0, #2038
    goto :L21
    :L19
    const/16 v0, #2002
    :L21
    new-instance v1, Landroid/webkit/WebView;
    invoke-direct {v1, v9}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V
    sput-object v1, Lcom/palai/prootsmoke/PetWindow2;->web:Landroid/webkit/WebView;
    const/4 v2, #0
    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->setBackgroundColor(I)V
    sget-object v1, Lcom/palai/prootsmoke/PetWindow2;->web:Landroid/webkit/WebView;
    const/4 v2, #2
    const/4 v3, #0
    invoke-virtual {v1, v2, v3}, Landroid/webkit/WebView;->setLayerType(ILandroid/graphics/Paint;)V
    sget-object v1, Lcom/palai/prootsmoke/PetWindow2;->web:Landroid/webkit/WebView;
    invoke-virtual {v1}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v1
    const/4 v2, #1
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V
    sget-object v1, Lcom/palai/prootsmoke/PetWindow2;->web:Landroid/webkit/WebView;
    invoke-virtual {v1}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v1
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V
    sget-object v1, Lcom/palai/prootsmoke/PetWindow2;->web:Landroid/webkit/WebView;
    new-instance v2, Lcom/palai/prootsmoke/PetWindow2$Bridge;
    invoke-direct {v2}, Lcom/palai/prootsmoke/PetWindow2$Bridge;-><init>()V
    const-string v3, "pet2Native"
    invoke-virtual {v1, v2, v3}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V
    sget-object v1, Lcom/palai/prootsmoke/PetWindow2;->web:Landroid/webkit/WebView;
    new-instance v2, Lcom/palai/prootsmoke/PetWindow2$HostBridge;
    invoke-direct {v2}, Lcom/palai/prootsmoke/PetWindow2$HostBridge;-><init>()V
    const-string v3, "petHostNative"
    invoke-virtual {v1, v2, v3}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V
    sget-object v1, Lcom/palai/prootsmoke/PetWindow2;->web:Landroid/webkit/WebView;
    new-instance v2, Lcom/palai/prootsmoke/PetWindow2$2;
    invoke-direct {v2}, Lcom/palai/prootsmoke/PetWindow2$2;-><init>()V
    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V
    sget-object v1, Lcom/palai/prootsmoke/PetWindow2;->web:Landroid/webkit/WebView;
    const-string v2, "http://127.0.0.1:7797/pet?pet=2"
    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    new-instance v7, Landroid/view/WindowManager$LayoutParams;
    const/4 v2, #-1
    const/4 v3, #-1
    const/16 v5, #792
    const/4 v6, #-3
    move-object v1, v7
    move v4, v0
    invoke-direct/range {v1..v6}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V
    sput-object v7, Lcom/palai/prootsmoke/PetWindow2;->webLp:Landroid/view/WindowManager$LayoutParams;
    const v8, #8388659
    iput v8, v7, Landroid/view/WindowManager$LayoutParams;->gravity:I
    sget-object v1, Lcom/palai/prootsmoke/PetWindow2;->wm:Landroid/view/WindowManager;
    sget-object v2, Lcom/palai/prootsmoke/PetWindow2;->web:Landroid/webkit/WebView;
    sget-object v3, Lcom/palai/prootsmoke/PetWindow2;->webLp:Landroid/view/WindowManager$LayoutParams;
    invoke-interface {v1, v2, v3}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    new-instance v1, Lcom/palai/prootsmoke/PetWindow2$3;
    invoke-direct {v1, v9}, Lcom/palai/prootsmoke/PetWindow2$3;-><init>(Landroid/content/Context;)V
    sput-object v1, Lcom/palai/prootsmoke/PetWindow2;->touch:Landroid/view/View;
    new-instance v9, Landroid/view/WindowManager$LayoutParams;
    const/16 v2, #520
    const/16 v3, #520
    const/16 v5, #776
    move-object v1, v9
    invoke-direct/range {v1..v6}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V
    sput-object v9, Lcom/palai/prootsmoke/PetWindow2;->touchLp:Landroid/view/WindowManager$LayoutParams;
    iput v8, v9, Landroid/view/WindowManager$LayoutParams;->gravity:I
    sget-object v9, Lcom/palai/prootsmoke/PetWindow2;->wm:Landroid/view/WindowManager;
    sget-object v0, Lcom/palai/prootsmoke/PetWindow2;->touch:Landroid/view/View;
    sget-object v1, Lcom/palai/prootsmoke/PetWindow2;->touchLp:Landroid/view/WindowManager$LayoutParams;
    invoke-interface {v9, v0, v1}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    sget-object v9, Lcom/palai/prootsmoke/PetWindow2;->ui:Landroid/os/Handler;
    sget-object v0, Lcom/palai/prootsmoke/PetWindow2;->tick:Ljava/lang/Runnable;
    invoke-virtual {v9, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    const-string v9, "PetWin2"
    const-string v0, "started"
    invoke-static {v9, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    return-void 
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/PetWindow2;->forward(Landroid/view/MotionEvent;)Z
    # registers=6 ins=1 tries=1
    const/4 v0, #0
    sget-object v1, Lcom/palai/prootsmoke/PetWindow2;->web:Landroid/webkit/WebView;
    if-nez v1, :L6
    return v0
    :L6
    invoke-virtual {v1}, Landroid/webkit/WebView;->getResources()Landroid/content/res/Resources;
    move-result-object v1
    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;
    move-result-object v1
    iget v1, v1, Landroid/util/DisplayMetrics;->density:F
    invoke-static {v5}, Landroid/view/MotionEvent;->obtain(Landroid/view/MotionEvent;)Landroid/view/MotionEvent;
    move-result-object v2
    invoke-virtual {v5}, Landroid/view/MotionEvent;->getX()F
    move-result v3
    sget-object v4, Lcom/palai/prootsmoke/PetWindow2;->touchLp:Landroid/view/WindowManager$LayoutParams;
    iget v4, v4, Landroid/view/WindowManager$LayoutParams;->x:I
    int-to-float v4, v4
    add-float/2addr v3, v4
    div-float/2addr v3, v1
    invoke-virtual {v5}, Landroid/view/MotionEvent;->getY()F
    move-result v5
    sget-object v4, Lcom/palai/prootsmoke/PetWindow2;->touchLp:Landroid/view/WindowManager$LayoutParams;
    iget v4, v4, Landroid/view/WindowManager$LayoutParams;->y:I
    int-to-float v4, v4
    add-float/2addr v5, v4
    div-float/2addr v5, v1
    invoke-virtual {v2, v3, v5}, Landroid/view/MotionEvent;->setLocation(FF)V
    sget-object v5, Lcom/palai/prootsmoke/PetWindow2;->web:Landroid/webkit/WebView;
    invoke-virtual {v5, v2}, Landroid/webkit/WebView;->dispatchTouchEvent(Landroid/view/MotionEvent;)Z
    invoke-virtual {v2}, Landroid/view/MotionEvent;->recycle()V
    const/4 v5, #1
    return v5
    move-exception v5
    return v0
.end method

# direct access=0x9
.method public static Lcom/palai/prootsmoke/PetWindow2;->start(Landroid/content/Context;)V
    # registers=3 ins=1 tries=1
    sget-boolean v0, Lcom/palai/prootsmoke/PetWindow2;->started:Z
    if-eqz v0, :L5
    return-void 
    :L5
    const/4 v0, #1
    sput-boolean v0, Lcom/palai/prootsmoke/PetWindow2;->started:Z
    invoke-virtual {v2}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;
    move-result-object v2
    invoke-static {v2}, Lcom/palai/prootsmoke/PetWindow2;->build(Landroid/content/Context;)V
    goto :L44
    move-exception v2
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    const-string v1, "start: "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    const-string v0, "PetWin2"
    invoke-static {v0, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    const/4 v2, #0
    sput-boolean v2, Lcom/palai/prootsmoke/PetWindow2;->started:Z
    :L44
    return-void 
.end method

# direct access=0x9
.method public static Lcom/palai/prootsmoke/PetWindow2;->stop()V
    # registers=2 ins=0 tries=3
    const/4 v0, #0
    sput-boolean v0, Lcom/palai/prootsmoke/PetWindow2;->started:Z
    sget-object v0, Lcom/palai/prootsmoke/PetWindow2;->ui:Landroid/os/Handler;
    sget-object v1, Lcom/palai/prootsmoke/PetWindow2;->tick:Ljava/lang/Runnable;
    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V
    goto :L12
    move-exception v0
    :L12
    sget-object v0, Lcom/palai/prootsmoke/PetWindow2;->web:Landroid/webkit/WebView;
    if-eqz v0, :L23
    sget-object v1, Lcom/palai/prootsmoke/PetWindow2;->wm:Landroid/view/WindowManager;
    invoke-interface {v1, v0}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    goto :L23
    move-exception v0
    :L23
    sget-object v0, Lcom/palai/prootsmoke/PetWindow2;->touch:Landroid/view/View;
    if-eqz v0, :L34
    sget-object v1, Lcom/palai/prootsmoke/PetWindow2;->wm:Landroid/view/WindowManager;
    invoke-interface {v1, v0}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    goto :L34
    move-exception v0
    :L34
    const/4 v0, #0
    sput-object v0, Lcom/palai/prootsmoke/PetWindow2;->web:Landroid/webkit/WebView;
    sput-object v0, Lcom/palai/prootsmoke/PetWindow2;->touch:Landroid/view/View;
    return-void 
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/PetWindow2;->sync()V
    # registers=5 ins=0 tries=2
    sget-object v0, Lcom/palai/prootsmoke/PetWindow2;->touch:Landroid/view/View;
    if-eqz v0, :L122
    sget v0, Lcom/palai/prootsmoke/PetWindow2;->petL:I
    if-ltz v0, :L122
    sget v0, Lcom/palai/prootsmoke/PetWindow2;->petR:I
    sget v1, Lcom/palai/prootsmoke/PetWindow2;->petL:I
    if-gt v0, v1, :L15
    goto :L122
    :L15
    nop 
    const/4 v0, #0
    const/high16 v1, #int 0x3f800000
    sget-object v2, Lcom/palai/prootsmoke/PetWindow2;->web:Landroid/webkit/WebView;
    invoke-virtual {v2}, Landroid/webkit/WebView;->getContext()Landroid/content/Context;
    move-result-object v2
    const-string v3, "coopanion"
    invoke-virtual {v2, v3, v0}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v2
    const-string v3, "pet_scale"
    invoke-interface {v2, v3, v1}, Landroid/content/SharedPreferences;->getFloat(Ljava/lang/String;F)F
    move-result v2
    const v3, #1045220557
    cmpg-float v3, v2, v3
    if-lez v3, :L54
    const/high16 v3, #int 0x40400000
    cmpl-float v3, v2, v3
    if-lez v3, :L51
    goto :L54
    :L51
    move v1, v2
    goto :L54
    move-exception v2
    :L54
    nop 
    const/high16 v2, #int 0x44020000
    mul-float/2addr v1, v2
    invoke-static {v1}, Ljava/lang/Math;->round(F)I
    move-result v1
    const/16 v2, #160
    invoke-static {v2, v1}, Ljava/lang/Math;->max(II)I
    move-result v1
    sget v2, Lcom/palai/prootsmoke/PetWindow2;->petL:I
    sget v3, Lcom/palai/prootsmoke/PetWindow2;->petR:I
    add-int/2addr v2, v3
    div-int/lit8 v2, v2, #2
    sget v3, Lcom/palai/prootsmoke/PetWindow2;->petT:I
    sget v4, Lcom/palai/prootsmoke/PetWindow2;->petB:I
    add-int/2addr v3, v4
    div-int/lit8 v3, v3, #2
    sget-object v4, Lcom/palai/prootsmoke/PetWindow2;->touchLp:Landroid/view/WindowManager$LayoutParams;
    iput v1, v4, Landroid/view/WindowManager$LayoutParams;->width:I
    sget-object v4, Lcom/palai/prootsmoke/PetWindow2;->touchLp:Landroid/view/WindowManager$LayoutParams;
    iput v1, v4, Landroid/view/WindowManager$LayoutParams;->height:I
    sget-object v4, Lcom/palai/prootsmoke/PetWindow2;->touchLp:Landroid/view/WindowManager$LayoutParams;
    div-int/lit8 v1, v1, #2
    sub-int/2addr v2, v1
    invoke-static {v0, v2}, Ljava/lang/Math;->max(II)I
    move-result v2
    iput v2, v4, Landroid/view/WindowManager$LayoutParams;->x:I
    sget-object v2, Lcom/palai/prootsmoke/PetWindow2;->touchLp:Landroid/view/WindowManager$LayoutParams;
    sub-int/2addr v3, v1
    invoke-static {v0, v3}, Ljava/lang/Math;->max(II)I
    move-result v0
    iput v0, v2, Landroid/view/WindowManager$LayoutParams;->y:I
    sget-object v0, Lcom/palai/prootsmoke/PetWindow2;->wm:Landroid/view/WindowManager;
    sget-object v1, Lcom/palai/prootsmoke/PetWindow2;->touch:Landroid/view/View;
    sget-object v2, Lcom/palai/prootsmoke/PetWindow2;->touchLp:Landroid/view/WindowManager$LayoutParams;
    invoke-interface {v0, v1, v2}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    goto :L121
    move-exception v0
    :L121
    return-void 
    :L122
    return-void 
.end method

.class Lcom/palai/prootsmoke/VoiceBridge$1;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/VoiceBridge;
.field final synthetic val$js:Ljava/lang/String;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/VoiceBridge$1;-><init>(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/VoiceBridge$1;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    iput-object v2, v0, Lcom/palai/prootsmoke/VoiceBridge$1;->val$js:Ljava/lang/String;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$1;->run()V
    # registers=4 ins=1 tries=1
    iget-object v0, v3, Lcom/palai/prootsmoke/VoiceBridge$1;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v0}, Lcom/palai/prootsmoke/VoiceBridge;->access$000(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/webkit/WebView;
    move-result-object v0
    iget-object v1, v3, Lcom/palai/prootsmoke/VoiceBridge$1;->val$js:Ljava/lang/String;
    const/4 v2, #0
    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    goto :L38
    move-exception v0
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "deliver: "
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    const-string v1, "PetVoice"
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :L38
    return-void 
.end method

.class Lcom/palai/prootsmoke/VoiceBridge$2;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/VoiceBridge;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/VoiceBridge$2;-><init>(Lcom/palai/prootsmoke/VoiceBridge;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/VoiceBridge$2;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$2;->run()V
    # registers=5 ins=1 tries=1
    const-string v0, ""
    iget-object v1, v4, Lcom/palai/prootsmoke/VoiceBridge$2;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v1}, Lcom/palai/prootsmoke/VoiceBridge;->access$100(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/speech/SpeechRecognizer;
    move-result-object v1
    if-nez v1, :L19
    iget-object v1, v4, Lcom/palai/prootsmoke/VoiceBridge$2;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v1}, Lcom/palai/prootsmoke/VoiceBridge;->access$200(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/speech/SpeechRecognizer;
    move-result-object v2
    invoke-static {v1, v2}, Lcom/palai/prootsmoke/VoiceBridge;->access$102(Lcom/palai/prootsmoke/VoiceBridge;Landroid/speech/SpeechRecognizer;)Landroid/speech/SpeechRecognizer;
    :L19
    iget-object v1, v4, Lcom/palai/prootsmoke/VoiceBridge$2;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    const/4 v2, #1
    invoke-static {v1, v2}, Lcom/palai/prootsmoke/VoiceBridge;->access$302(Lcom/palai/prootsmoke/VoiceBridge;Z)Z
    iget-object v1, v4, Lcom/palai/prootsmoke/VoiceBridge$2;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v1}, Lcom/palai/prootsmoke/VoiceBridge;->access$100(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/speech/SpeechRecognizer;
    move-result-object v1
    invoke-virtual {v1}, Landroid/speech/SpeechRecognizer;->cancel()V
    iget-object v1, v4, Lcom/palai/prootsmoke/VoiceBridge$2;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v1}, Lcom/palai/prootsmoke/VoiceBridge;->access$100(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/speech/SpeechRecognizer;
    move-result-object v1
    iget-object v2, v4, Lcom/palai/prootsmoke/VoiceBridge$2;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v2}, Lcom/palai/prootsmoke/VoiceBridge;->access$400(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/content/Intent;
    move-result-object v2
    invoke-virtual {v1, v2}, Landroid/speech/SpeechRecognizer;->startListening(Landroid/content/Intent;)V
    iget-object v1, v4, Lcom/palai/prootsmoke/VoiceBridge$2;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    const-string v2, "start"
    invoke-static {v1, v2, v0, v0}, Lcom/palai/prootsmoke/VoiceBridge;->access$500(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    goto :L97
    move-exception v1
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    const-string v3, "start: "
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    const-string v3, "PetVoice"
    invoke-static {v3, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    iget-object v2, v4, Lcom/palai/prootsmoke/VoiceBridge$2;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-virtual {v1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;
    move-result-object v1
    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v1
    const-string v3, "error"
    invoke-static {v2, v3, v0, v1}, Lcom/palai/prootsmoke/VoiceBridge;->access$500(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :L97
    return-void 
.end method

.class Lcom/palai/prootsmoke/VoiceBridge$3;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/VoiceBridge;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/VoiceBridge$3;-><init>(Lcom/palai/prootsmoke/VoiceBridge;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/VoiceBridge$3;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$3;->run()V
    # registers=4 ins=1 tries=1
    iget-object v0, v3, Lcom/palai/prootsmoke/VoiceBridge$3;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v0}, Lcom/palai/prootsmoke/VoiceBridge;->access$100(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/speech/SpeechRecognizer;
    move-result-object v0
    if-eqz v0, :L43
    iget-object v0, v3, Lcom/palai/prootsmoke/VoiceBridge$3;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v0}, Lcom/palai/prootsmoke/VoiceBridge;->access$100(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/speech/SpeechRecognizer;
    move-result-object v0
    invoke-virtual {v0}, Landroid/speech/SpeechRecognizer;->stopListening()V
    goto :L43
    move-exception v0
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "stop: "
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    const-string v1, "PetVoice"
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :L43
    return-void 
.end method

.class Lcom/palai/prootsmoke/VoiceBridge$4;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/VoiceBridge;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/VoiceBridge$4;-><init>(Lcom/palai/prootsmoke/VoiceBridge;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/VoiceBridge$4;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$4;->run()V
    # registers=4 ins=1 tries=1
    iget-object v0, v3, Lcom/palai/prootsmoke/VoiceBridge$4;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    const/4 v1, #0
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/VoiceBridge;->access$302(Lcom/palai/prootsmoke/VoiceBridge;Z)Z
    iget-object v0, v3, Lcom/palai/prootsmoke/VoiceBridge$4;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v0}, Lcom/palai/prootsmoke/VoiceBridge;->access$100(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/speech/SpeechRecognizer;
    move-result-object v0
    if-eqz v0, :L49
    iget-object v0, v3, Lcom/palai/prootsmoke/VoiceBridge$4;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v0}, Lcom/palai/prootsmoke/VoiceBridge;->access$100(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/speech/SpeechRecognizer;
    move-result-object v0
    invoke-virtual {v0}, Landroid/speech/SpeechRecognizer;->cancel()V
    goto :L49
    move-exception v0
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "cancel: "
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    const-string v1, "PetVoice"
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :L49
    return-void 
.end method

.class Lcom/palai/prootsmoke/VoiceBridge$5;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/VoiceBridge;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/VoiceBridge$5;-><init>(Lcom/palai/prootsmoke/VoiceBridge;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/VoiceBridge$5;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$5;->onBeginningOfSpeech()V
    # registers=5 ins=1 tries=0
    iget-object v0, v4, Lcom/palai/prootsmoke/VoiceBridge$5;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    const-string v1, ""
    const-string v2, "speech"
    const-string v3, "level"
    invoke-static {v0, v3, v1, v2}, Lcom/palai/prootsmoke/VoiceBridge;->access$500(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$5;->onBufferReceived([B)V
    # registers=2 ins=2 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$5;->onEndOfSpeech()V
    # registers=5 ins=1 tries=0
    iget-object v0, v4, Lcom/palai/prootsmoke/VoiceBridge$5;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    const-string v1, ""
    const-string v2, "end"
    const-string v3, "level"
    invoke-static {v0, v3, v1, v2}, Lcom/palai/prootsmoke/VoiceBridge;->access$500(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$5;->onError(I)V
    # registers=5 ins=2 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    const-string v1, "onError "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    const-string v1, "PetVoice"
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    iget-object v0, v3, Lcom/palai/prootsmoke/VoiceBridge$5;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v0}, Lcom/palai/prootsmoke/VoiceBridge;->access$300(Lcom/palai/prootsmoke/VoiceBridge;)Z
    move-result v1
    if-eqz v1, :L38
    const/4 v1, #7
    if-ne v4, v1, :L38
    const-string v1, "empty"
    goto :L40
    :L38
    const-string v1, "error"
    :L40
    const-string v2, ""
    invoke-static {v4}, Lcom/palai/prootsmoke/VoiceBridge;->access$600(I)Ljava/lang/String;
    move-result-object v4
    invoke-static {v0, v1, v2, v4}, Lcom/palai/prootsmoke/VoiceBridge;->access$500(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$5;->onEvent(ILandroid/os/Bundle;)V
    # registers=3 ins=3 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$5;->onPartialResults(Landroid/os/Bundle;)V
    # registers=5 ins=2 tries=0
    invoke-static {v4}, Lcom/palai/prootsmoke/VoiceBridge;->access$700(Landroid/os/Bundle;)Ljava/lang/String;
    move-result-object v4
    if-eqz v4, :L21
    invoke-virtual {v4}, Ljava/lang/String;->length()I
    move-result v0
    if-lez v0, :L21
    iget-object v0, v3, Lcom/palai/prootsmoke/VoiceBridge$5;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    const-string v1, "partial"
    const-string v2, ""
    invoke-static {v0, v1, v4, v2}, Lcom/palai/prootsmoke/VoiceBridge;->access$500(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :L21
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$5;->onReadyForSpeech(Landroid/os/Bundle;)V
    # registers=5 ins=2 tries=0
    iget-object v4, v3, Lcom/palai/prootsmoke/VoiceBridge$5;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    const-string v0, ""
    const-string v1, "ready"
    const-string v2, "level"
    invoke-static {v4, v2, v0, v1}, Lcom/palai/prootsmoke/VoiceBridge;->access$500(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$5;->onResults(Landroid/os/Bundle;)V
    # registers=5 ins=2 tries=0
    iget-object v0, v3, Lcom/palai/prootsmoke/VoiceBridge$5;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v4}, Lcom/palai/prootsmoke/VoiceBridge;->access$700(Landroid/os/Bundle;)Ljava/lang/String;
    move-result-object v4
    const-string v1, ""
    const-string v2, "final"
    invoke-static {v0, v2, v4, v1}, Lcom/palai/prootsmoke/VoiceBridge;->access$500(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$5;->onRmsChanged(F)V
    # registers=5 ins=2 tries=0
    iget-object v0, v3, Lcom/palai/prootsmoke/VoiceBridge$5;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    float-to-int v4, v4
    invoke-static {v4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;
    move-result-object v4
    const-string v1, "rms"
    const-string v2, ""
    invoke-static {v0, v1, v2, v4}, Lcom/palai/prootsmoke/VoiceBridge;->access$500(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    return-void 
.end method

.class public Lcom/palai/prootsmoke/VoiceBridge;
.super Ljava/lang/Object;

.field private static final TAG:Ljava/lang/String;
.field private final ctx:Landroid/content/Context;
.field private rec:Landroid/speech/SpeechRecognizer;
.field private final ui:Landroid/os/Handler;
.field private wanted:Z
.field private final web:Landroid/webkit/WebView;

# direct access=0x10001
.method public constructor Lcom/palai/prootsmoke/VoiceBridge;-><init>(Landroid/content/Context;Landroid/webkit/WebView;)V
    # registers=5 ins=3 tries=0
    invoke-direct {v2}, Ljava/lang/Object;-><init>()V
    new-instance v0, Landroid/os/Handler;
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;
    move-result-object v1
    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
    iput-object v0, v2, Lcom/palai/prootsmoke/VoiceBridge;->ui:Landroid/os/Handler;
    const/4 v0, #0
    iput-boolean v0, v2, Lcom/palai/prootsmoke/VoiceBridge;->wanted:Z
    iput-object v3, v2, Lcom/palai/prootsmoke/VoiceBridge;->ctx:Landroid/content/Context;
    iput-object v4, v2, Lcom/palai/prootsmoke/VoiceBridge;->web:Landroid/webkit/WebView;
    return-void 
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/VoiceBridge;->access$000(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/webkit/WebView;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/VoiceBridge;->web:Landroid/webkit/WebView;
    return-object v0
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/VoiceBridge;->access$100(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/speech/SpeechRecognizer;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/VoiceBridge;->rec:Landroid/speech/SpeechRecognizer;
    return-object v0
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/VoiceBridge;->access$102(Lcom/palai/prootsmoke/VoiceBridge;Landroid/speech/SpeechRecognizer;)Landroid/speech/SpeechRecognizer;
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/VoiceBridge;->rec:Landroid/speech/SpeechRecognizer;
    return-object v1
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/VoiceBridge;->access$200(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/speech/SpeechRecognizer;
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/VoiceBridge;->build()Landroid/speech/SpeechRecognizer;
    move-result-object v0
    return-object v0
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/VoiceBridge;->access$300(Lcom/palai/prootsmoke/VoiceBridge;)Z
    # registers=1 ins=1 tries=0
    iget-boolean v0, v0, Lcom/palai/prootsmoke/VoiceBridge;->wanted:Z
    return v0
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/VoiceBridge;->access$302(Lcom/palai/prootsmoke/VoiceBridge;Z)Z
    # registers=2 ins=2 tries=0
    iput-boolean v1, v0, Lcom/palai/prootsmoke/VoiceBridge;->wanted:Z
    return v1
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/VoiceBridge;->access$400(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/content/Intent;
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/VoiceBridge;->intent()Landroid/content/Intent;
    move-result-object v0
    return-object v0
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/VoiceBridge;->access$500(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    # registers=4 ins=4 tries=0
    invoke-direct {v0, v1, v2, v3}, Lcom/palai/prootsmoke/VoiceBridge;->deliver(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    return-void 
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/VoiceBridge;->access$600(I)Ljava/lang/String;
    # registers=1 ins=1 tries=0
    invoke-static {v0}, Lcom/palai/prootsmoke/VoiceBridge;->errName(I)Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/VoiceBridge;->access$700(Landroid/os/Bundle;)Ljava/lang/String;
    # registers=1 ins=1 tries=0
    invoke-static {v0}, Lcom/palai/prootsmoke/VoiceBridge;->first(Landroid/os/Bundle;)Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/VoiceBridge;->build()Landroid/speech/SpeechRecognizer;
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/VoiceBridge;->ctx:Landroid/content/Context;
    invoke-static {v0}, Landroid/speech/SpeechRecognizer;->createSpeechRecognizer(Landroid/content/Context;)Landroid/speech/SpeechRecognizer;
    move-result-object v0
    new-instance v1, Lcom/palai/prootsmoke/VoiceBridge$5;
    invoke-direct {v1, v2}, Lcom/palai/prootsmoke/VoiceBridge$5;-><init>(Lcom/palai/prootsmoke/VoiceBridge;)V
    invoke-virtual {v0, v1}, Landroid/speech/SpeechRecognizer;->setRecognitionListener(Landroid/speech/RecognitionListener;)V
    return-object v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/VoiceBridge;->deliver(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    # registers=6 ins=4 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/VoiceBridge;->web:Landroid/webkit/WebView;
    if-nez v0, :L5
    return-void 
    :L5
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    const-string v1, "(function(){try{var f=window.__petVoiceResult;if(typeof f==='function')f("
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-static {v3}, Lcom/palai/prootsmoke/VoiceBridge;->jsStr(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    const-string v0, ","
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    const-string v1, ""
    if-nez v4, :L35
    move-object v4, v1
    :L35
    invoke-static {v4}, Lcom/palai/prootsmoke/VoiceBridge;->jsStr(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v4
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    if-nez v5, :L50
    move-object v5, v1
    :L50
    invoke-static {v5}, Lcom/palai/prootsmoke/VoiceBridge;->jsStr(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v4
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    const-string v4, ");}catch(e){}})()"
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    iget-object v4, v2, Lcom/palai/prootsmoke/VoiceBridge;->ui:Landroid/os/Handler;
    new-instance v5, Lcom/palai/prootsmoke/VoiceBridge$1;
    invoke-direct {v5, v2, v3}, Lcom/palai/prootsmoke/VoiceBridge$1;-><init>(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;)V
    invoke-virtual {v4, v5}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    return-void 
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/VoiceBridge;->errName(I)Ljava/lang/String;
    # registers=3 ins=1 tries=0
    packed-switch v2, :pswitch_data_0
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    const-string v1, "错误 "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    return-object v2
    :pswitch_8
    const-string v2, "没有麦克风权限"
    return-object v2
    :pswitch_7
    const-string v2, "识别服务忙"
    return-object v2
    :pswitch_6
    const-string v2, "没听清"
    return-object v2
    :pswitch_5
    const-string v2, "没听到声音"
    return-object v2
    :pswitch_4
    const-string v2, "客户端错误"
    return-object v2
    :pswitch_3
    const-string v2, "识别服务出错"
    return-object v2
    :pswitch_2
    const-string v2, "录音出错"
    return-object v2
    :pswitch_1
    const-string v2, "网络错误"
    return-object v2
    :pswitch_0
    const-string v2, "网络超时"
    return-object v2
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_7
        :pswitch_8
    .end packed-switch
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/VoiceBridge;->first(Landroid/os/Bundle;)Ljava/lang/String;
    # registers=3 ins=1 tries=0
    const-string v0, ""
    if-nez v2, :L5
    return-object v0
    :L5
    const-string v1, "results_recognition"
    invoke-virtual {v2, v1}, Landroid/os/Bundle;->getStringArrayList(Ljava/lang/String;)Ljava/util/ArrayList;
    move-result-object v2
    if-eqz v2, :L28
    invoke-virtual {v2}, Ljava/util/ArrayList;->isEmpty()Z
    move-result v1
    if-eqz v1, :L20
    goto :L28
    :L20
    const/4 v0, #0
    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Ljava/lang/String;
    return-object v2
    :L28
    return-object v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/VoiceBridge;->intent()Landroid/content/Intent;
    # registers=4 ins=1 tries=0
    new-instance v0, Landroid/content/Intent;
    const-string v1, "android.speech.action.RECOGNIZE_SPEECH"
    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    const-string v1, "android.speech.extra.LANGUAGE_MODEL"
    const-string v2, "free_form"
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    const-string v1, "android.speech.extra.LANGUAGE"
    const-string v2, "zh-CN"
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    const-string v1, "android.speech.extra.PARTIAL_RESULTS"
    const/4 v2, #1
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;
    const-string v1, "android.speech.extra.MAX_RESULTS"
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;
    iget-object v1, v3, Lcom/palai/prootsmoke/VoiceBridge;->ctx:Landroid/content/Context;
    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v1
    const-string v2, "calling_package"
    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    return-object v0
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/VoiceBridge;->jsStr(Ljava/lang/String;)Ljava/lang/String;
    # registers=6 ins=1 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "'"
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    const/4 v1, #0
    :L8
    invoke-virtual {v5}, Ljava/lang/String;->length()I
    move-result v2
    const/16 v3, #39
    if-ge v1, v2, :L61
    invoke-virtual {v5, v1}, Ljava/lang/String;->charAt(I)C
    move-result v2
    const/16 v4, #92
    if-eq v2, v3, :L51
    if-ne v2, v4, :L27
    goto :L51
    :L27
    const/16 v3, #10
    if-ne v2, v3, :L37
    const-string v2, "\n"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :L58
    :L37
    const/16 v3, #13
    if-ne v2, v3, :L47
    const-string v2, "\r"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :L58
    :L47
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    goto :L58
    :L51
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    :L58
    add-int/lit8 v1, v1, #1
    goto :L8
    :L61
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    move-result-object v5
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v5
    return-object v5
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge;->available()Z
    # registers=2 ins=1 tries=1
    iget-object v0, v1, Lcom/palai/prootsmoke/VoiceBridge;->ctx:Landroid/content/Context;
    invoke-static {v0}, Landroid/speech/SpeechRecognizer;->isRecognitionAvailable(Landroid/content/Context;)Z
    move-result v0
    return v0
    move-exception v0
    const/4 v0, #0
    return v0
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge;->cancel()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/VoiceBridge;->ui:Landroid/os/Handler;
    new-instance v1, Lcom/palai/prootsmoke/VoiceBridge$4;
    invoke-direct {v1, v2}, Lcom/palai/prootsmoke/VoiceBridge$4;-><init>(Lcom/palai/prootsmoke/VoiceBridge;)V
    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge;->start()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/VoiceBridge;->ui:Landroid/os/Handler;
    new-instance v1, Lcom/palai/prootsmoke/VoiceBridge$2;
    invoke-direct {v1, v2}, Lcom/palai/prootsmoke/VoiceBridge$2;-><init>(Lcom/palai/prootsmoke/VoiceBridge;)V
    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge;->stop()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/VoiceBridge;->ui:Landroid/os/Handler;
    new-instance v1, Lcom/palai/prootsmoke/VoiceBridge$3;
    invoke-direct {v1, v2}, Lcom/palai/prootsmoke/VoiceBridge$3;-><init>(Lcom/palai/prootsmoke/VoiceBridge;)V
    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    return-void 
.end method

.class Lcom/palai/prootsmoke/WebRetry$1;
.super Ljava/lang/Object;

.field final synthetic val$web:Landroid/webkit/WebView;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/WebRetry$1;-><init>(Landroid/webkit/WebView;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/WebRetry$1;->val$web:Landroid/webkit/WebView;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/WebRetry$1;->run()V
    # registers=4 ins=1 tries=1
    iget-object v0, v3, Lcom/palai/prootsmoke/WebRetry$1;->val$web:Landroid/webkit/WebView;
    invoke-virtual {v0}, Landroid/webkit/WebView;->reload()V
    goto :L31
    move-exception v0
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "reload: "
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    const-string v1, "PetWebRetry"
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :L31
    return-void 
.end method

.class public final Lcom/palai/prootsmoke/WebRetry;
.super Ljava/lang/Object;

.field private static final TAG:Ljava/lang/String;
.field private static final UI:Landroid/os/Handler;
.field private static lastAt:J
.field private static tries:I

# direct access=0x10008
.method static constructor Lcom/palai/prootsmoke/WebRetry;-><clinit>()V
    # registers=2 ins=0 tries=0
    new-instance v0, Landroid/os/Handler;
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;
    move-result-object v1
    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
    sput-object v0, Lcom/palai/prootsmoke/WebRetry;->UI:Landroid/os/Handler;
    const/4 v0, #0
    sput v0, Lcom/palai/prootsmoke/WebRetry;->tries:I
    const-wide/16 v0, #0
    sput-wide v0, Lcom/palai/prootsmoke/WebRetry;->lastAt:J
    return-void 
.end method

# direct access=0x10002
.method private constructor Lcom/palai/prootsmoke/WebRetry;-><init>()V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# direct access=0x9
.method public static Lcom/palai/prootsmoke/WebRetry;->fail(Landroid/webkit/WebView;J)V
    # registers=9 ins=3 tries=0
    if-nez v6, :L3
    return-void 
    :L3
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v0
    sget-wide v2, Lcom/palai/prootsmoke/WebRetry;->lastAt:J
    sub-long v2, v0, v2
    const-wide/16 v4, #30000
    cmp-long v2, v2, v4
    if-lez v2, :L20
    const/4 v2, #0
    sput v2, Lcom/palai/prootsmoke/WebRetry;->tries:I
    :L20
    sput-wide v0, Lcom/palai/prootsmoke/WebRetry;->lastAt:J
    sget v0, Lcom/palai/prootsmoke/WebRetry;->tries:I
    const/16 v1, #40
    const-string v2, "PetWebRetry"
    if-lt v0, v1, :L55
    new-instance v6, Ljava/lang/StringBuilder;
    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V
    const-string v7, "give up after "
    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v6
    sget v7, Lcom/palai/prootsmoke/WebRetry;->tries:I
    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v6
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v6
    invoke-static {v2, v6}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    return-void 
    :L55
    add-int/lit8 v0, v0, #1
    sput v0, Lcom/palai/prootsmoke/WebRetry;->tries:I
    nop 
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v3, "load failed, retry #"
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v1, " in "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, v7, v8}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v1, "ms"
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static {v2, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    sget-object v0, Lcom/palai/prootsmoke/WebRetry;->UI:Landroid/os/Handler;
    new-instance v1, Lcom/palai/prootsmoke/WebRetry$1;
    invoke-direct {v1, v6}, Lcom/palai/prootsmoke/WebRetry$1;-><init>(Landroid/webkit/WebView;)V
    const-wide/16 v2, #300
    invoke-static {v2, v3, v7, v8}, Ljava/lang/Math;->max(JJ)J
    move-result-wide v6
    invoke-virtual {v0, v1, v6, v7}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    return-void 
.end method

# direct access=0x9
.method public static Lcom/palai/prootsmoke/WebRetry;->ok()V
    # registers=1 ins=0 tries=0
    const/4 v0, #0
    sput v0, Lcom/palai/prootsmoke/WebRetry;->tries:I
    return-void 
.end method

