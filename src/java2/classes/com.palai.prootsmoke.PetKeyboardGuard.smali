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

