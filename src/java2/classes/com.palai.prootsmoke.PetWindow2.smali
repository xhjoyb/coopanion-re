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

