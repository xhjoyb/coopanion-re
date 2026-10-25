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

