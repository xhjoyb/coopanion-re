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

