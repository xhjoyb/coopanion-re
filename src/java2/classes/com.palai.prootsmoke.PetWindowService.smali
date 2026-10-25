.class public Lcom/palai/prootsmoke/PetWindowService;
.super Landroid/app/Service;

.field private static final CHANNEL:Ljava/lang/String;
.field private static final KEY_ALPHA:Ljava/lang/String;
.field private static final NOTI_ID:I
.field private static final PET_HOST_SHIM:Ljava/lang/String;
.field private static final PET_URL:Ljava/lang/String;
.field private static final PREF:Ljava/lang/String;
.field private static final TAG:Ljava/lang/String;
.field private static final TOUCH_SIZE:I
.field private volatile firstLoadReloaded:Z
.field private final followTick:Ljava/lang/Runnable;
.field private imeProxy:Landroid/widget/EditText;
.field private volatile inputFocusOn:Z
.field private lastFocusLog:J
.field private lastProbeLog:J
.field private lastTouchH:I
.field private lastTouchW:I
.field private lastTouchX:I
.field private lastTouchY:I
.field private petAlpha:F
.field private volatile petX:F
.field private volatile petY:F
.field private screenH:I
.field private screenW:I
.field private showBox:Landroid/widget/FrameLayout;
.field private showLp:Landroid/view/WindowManager$LayoutParams;
.field private touchBox:Landroid/widget/FrameLayout;
.field private touchLp:Landroid/view/WindowManager$LayoutParams;
.field private ui:Landroid/os/Handler;
.field private web:Landroid/webkit/WebView;
.field private wm:Landroid/view/WindowManager;

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetimeProxy(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/EditText;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetlastProbeLog(Lcom/palai/prootsmoke/PetWindowService;)J
    # registers=3 ins=1 tries=0
    iget-wide v0, v2, Lcom/palai/prootsmoke/PetWindowService;->lastProbeLog:J
    return-wide v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetpetAlpha(Lcom/palai/prootsmoke/PetWindowService;)F
    # registers=1 ins=1 tries=0
    iget v0, v0, Lcom/palai/prootsmoke/PetWindowService;->petAlpha:F
    return v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService;->showBox:Landroid/widget/FrameLayout;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService;->showLp:Landroid/view/WindowManager$LayoutParams;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService;->touchBox:Landroid/widget/FrameLayout;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService;->touchLp:Landroid/view/WindowManager$LayoutParams;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetui(Lcom/palai/prootsmoke/PetWindowService;)Landroid/os/Handler;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService;->ui:Landroid/os/Handler;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/PetWindowService;)Landroid/webkit/WebView;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetwm(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService;->wm:Landroid/view/WindowManager;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fputlastProbeLog(Lcom/palai/prootsmoke/PetWindowService;J)V
    # registers=3 ins=3 tries=0
    iput-wide v1, v0, Lcom/palai/prootsmoke/PetWindowService;->lastProbeLog:J
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fputpetAlpha(Lcom/palai/prootsmoke/PetWindowService;F)V
    # registers=2 ins=2 tries=0
    iput v1, v0, Lcom/palai/prootsmoke/PetWindowService;->petAlpha:F
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fputpetX(Lcom/palai/prootsmoke/PetWindowService;F)V
    # registers=2 ins=2 tries=0
    iput v1, v0, Lcom/palai/prootsmoke/PetWindowService;->petX:F
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fputpetY(Lcom/palai/prootsmoke/PetWindowService;F)V
    # registers=2 ins=2 tries=0
    iput v1, v0, Lcom/palai/prootsmoke/PetWindowService;->petY:F
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mapplyInputFocus(Lcom/palai/prootsmoke/PetWindowService;Z)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->applyInputFocus(Z)V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mbuildAndAttachLayers(Lcom/palai/prootsmoke/PetWindowService;I)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->buildAndAttachLayers(I)V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mdiag(Lcom/palai/prootsmoke/PetWindowService;Ljava/lang/String;)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->diag(Ljava/lang/String;)V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mfocusImeAndShow(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/PetWindowService;->focusImeAndShow()V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mforwardToWeb(Lcom/palai/prootsmoke/PetWindowService;Landroid/view/MotionEvent;)Z
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->forwardToWeb(Landroid/view/MotionEvent;)Z
    move-result v0
    return v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mpushKeyToPage(Lcom/palai/prootsmoke/PetWindowService;Ljava/lang/String;)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->pushKeyToPage(Ljava/lang/String;)V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mpushTextToPage(Lcom/palai/prootsmoke/PetWindowService;Ljava/lang/String;)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->pushTextToPage(Ljava/lang/String;)V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mqueryPetRect(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/PetWindowService;->queryPetRect()V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$msizeTouchTo(Lcom/palai/prootsmoke/PetWindowService;IIII)V
    # registers=5 ins=5 tries=0
    invoke-direct {v0, v1, v2, v3, v4}, Lcom/palai/prootsmoke/PetWindowService;->sizeTouchTo(IIII)V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mstartRepaintWatchdog(Lcom/palai/prootsmoke/PetWindowService;Landroid/webkit/WebView;)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->startRepaintWatchdog(Landroid/webkit/WebView;)V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$sm_isComposing(Landroid/text/Editable;)Z
    # registers=1 ins=1 tries=0
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->_isComposing(Landroid/text/Editable;)Z
    move-result v0
    return v0
.end method

# direct access=0x10001
.method public constructor Lcom/palai/prootsmoke/PetWindowService;-><init>()V
    # registers=4 ins=1 tries=0
    invoke-direct {v3}, Landroid/app/Service;-><init>()V
    const/high16 v0, #int 0x3f800000
    iput v0, v3, Lcom/palai/prootsmoke/PetWindowService;->petAlpha:F
    const/4 v0, #0
    iput-boolean v0, v3, Lcom/palai/prootsmoke/PetWindowService;->firstLoadReloaded:Z
    const/high16 v1, #int 0xbf800000
    iput v1, v3, Lcom/palai/prootsmoke/PetWindowService;->petX:F
    iput v1, v3, Lcom/palai/prootsmoke/PetWindowService;->petY:F
    const/high16 v1, #int 0x80000000
    iput v1, v3, Lcom/palai/prootsmoke/PetWindowService;->lastTouchX:I
    iput v1, v3, Lcom/palai/prootsmoke/PetWindowService;->lastTouchY:I
    iput v1, v3, Lcom/palai/prootsmoke/PetWindowService;->lastTouchW:I
    iput v1, v3, Lcom/palai/prootsmoke/PetWindowService;->lastTouchH:I
    new-instance v1, Landroid/os/Handler;
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;
    move-result-object v2
    invoke-direct {v1, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
    iput-object v1, v3, Lcom/palai/prootsmoke/PetWindowService;->ui:Landroid/os/Handler;
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$14;
    invoke-direct {v1, v3}, Lcom/palai/prootsmoke/PetWindowService$14;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    iput-object v1, v3, Lcom/palai/prootsmoke/PetWindowService;->followTick:Ljava/lang/Runnable;
    iput-boolean v0, v3, Lcom/palai/prootsmoke/PetWindowService;->inputFocusOn:Z
    const-wide/16 v0, #0
    iput-wide v0, v3, Lcom/palai/prootsmoke/PetWindowService;->lastFocusLog:J
    iput-wide v0, v3, Lcom/palai/prootsmoke/PetWindowService;->lastProbeLog:J
    return-void 
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/PetWindowService;->_isComposing(Landroid/text/Editable;)Z
    # registers=6 ins=1 tries=1
    const/4 v0, #0
    invoke-interface {v5}, Landroid/text/Editable;->length()I
    move-result v1
    const-class v2, Ljava/lang/Object;
    invoke-interface {v5, v0, v1, v2}, Landroid/text/Editable;->getSpans(IILjava/lang/Class;)[Ljava/lang/Object;
    move-result-object v1
    array-length v2, v1
    move v3, v0
    :L13
    if-ge v3, v2, :L30
    aget-object v4, v1, v3
    invoke-interface {v5, v4}, Landroid/text/Editable;->getSpanFlags(Ljava/lang/Object;)I
    move-result v4
    and-int/lit16 v4, v4, #256
    if-eqz v4, :L27
    const/4 v5, #1
    return v5
    :L27
    add-int/lit8 v3, v3, #1
    goto :L13
    :L30
    return v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->applyInputFocus(Z)V
    # registers=8 ins=2 tries=0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v0
    iget-boolean v2, v6, Lcom/palai/prootsmoke/PetWindowService;->inputFocusOn:Z
    if-eq v7, v2, :L55
    iget-wide v2, v6, Lcom/palai/prootsmoke/PetWindowService;->lastFocusLog:J
    sub-long v2, v0, v2
    const-wide/16 v4, #300
    cmp-long v2, v2, v4
    if-lez v2, :L55
    iput-wide v0, v6, Lcom/palai/prootsmoke/PetWindowService;->lastFocusLog:J
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "inputFocus="
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v1, " -> NOT_FOCUSABLE "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    if-eqz v7, :L42
    const-string v1, "OFF"
    goto :L44
    :L42
    const-string v1, "ON"
    :L44
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-direct {v6, v0}, Lcom/palai/prootsmoke/PetWindowService;->diag(Ljava/lang/String;)V
    :L55
    iget-boolean v0, v6, Lcom/palai/prootsmoke/PetWindowService;->inputFocusOn:Z
    if-ne v7, v0, :L60
    return-void 
    :L60
    iput-boolean v7, v6, Lcom/palai/prootsmoke/PetWindowService;->inputFocusOn:Z
    iget-object v0, v6, Lcom/palai/prootsmoke/PetWindowService;->ui:Landroid/os/Handler;
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$16;
    invoke-direct {v1, v6, v7}, Lcom/palai/prootsmoke/PetWindowService$16;-><init>(Lcom/palai/prootsmoke/PetWindowService;Z)V
    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->buildAndAttachLayers(I)V
    # registers=14 ins=2 tries=4
    const-string v0, "PetWindow"
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    const/4 v2, #0
    invoke-direct {v1, v12, v2}, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;-><init>(Lcom/palai/prootsmoke/PetWindowService;Lcom/palai/prootsmoke/PetWindowService$PetHostBridge-IA;)V
    iget-object v2, v12, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    const-string v3, "petHostNative"
    invoke-virtual {v2, v1, v3}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V
    new-instance v1, Lcom/palai/prootsmoke/VoiceBridge;
    invoke-direct {v1, v12, v2}, Lcom/palai/prootsmoke/VoiceBridge;-><init>(Landroid/content/Context;Landroid/webkit/WebView;)V
    const-string v3, "petVoiceNative"
    invoke-virtual {v2, v1, v3}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    new-instance v2, Lcom/palai/prootsmoke/PetWindowService$5;
    invoke-direct {v2, v12}, Lcom/palai/prootsmoke/PetWindowService$5;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    new-instance v2, Lcom/palai/prootsmoke/PetWindowService$6;
    invoke-direct {v2, v12}, Lcom/palai/prootsmoke/PetWindowService$6;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V
    new-instance v1, Landroid/widget/FrameLayout;
    invoke-direct {v1, v12}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V
    iput-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->showBox:Landroid/widget/FrameLayout;
    const/4 v2, #0
    invoke-virtual {v1, v2}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->showBox:Landroid/widget/FrameLayout;
    iget-object v3, v12, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    new-instance v4, Landroid/widget/FrameLayout$LayoutParams;
    const/4 v5, #-1
    invoke-direct {v4, v5, v5}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V
    invoke-virtual {v1, v3, v4}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    new-instance v1, Landroid/view/WindowManager$LayoutParams;
    const v10, #66328
    const/4 v11, #-3
    const/4 v7, #-1
    const/4 v8, #-1
    move-object v6, v1
    move v9, v13
    invoke-direct/range {v6..v11}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V
    iput-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->showLp:Landroid/view/WindowManager$LayoutParams;
    const/high16 v1, #int 0x3f800000
    const-string v3, "coopanion"
    invoke-virtual {v12, v3, v2}, Lcom/palai/prootsmoke/PetWindowService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v3
    const-string v4, "pet_alpha"
    invoke-interface {v3, v4, v1}, Landroid/content/SharedPreferences;->getFloat(Ljava/lang/String;F)F
    move-result v3
    iput v3, v12, Lcom/palai/prootsmoke/PetWindowService;->petAlpha:F
    iget v3, v12, Lcom/palai/prootsmoke/PetWindowService;->petAlpha:F
    const/4 v4, #0
    cmpg-float v3, v3, v4
    if-gez v3, :L109
    iput v4, v12, Lcom/palai/prootsmoke/PetWindowService;->petAlpha:F
    :L109
    iget v3, v12, Lcom/palai/prootsmoke/PetWindowService;->petAlpha:F
    cmpl-float v3, v3, v1
    if-lez v3, :L117
    iput v1, v12, Lcom/palai/prootsmoke/PetWindowService;->petAlpha:F
    :L117
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->showLp:Landroid/view/WindowManager$LayoutParams;
    iget v3, v12, Lcom/palai/prootsmoke/PetWindowService;->petAlpha:F
    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->alpha:F
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->showLp:Landroid/view/WindowManager$LayoutParams;
    const v3, #8388659
    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->gravity:I
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->showLp:Landroid/view/WindowManager$LayoutParams;
    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->x:I
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->showLp:Landroid/view/WindowManager$LayoutParams;
    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->y:I
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->wm:Landroid/view/WindowManager;
    iget-object v4, v12, Lcom/palai/prootsmoke/PetWindowService;->showBox:Landroid/widget/FrameLayout;
    iget-object v5, v12, Lcom/palai/prootsmoke/PetWindowService;->showLp:Landroid/view/WindowManager$LayoutParams;
    invoke-interface {v1, v4, v5}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    iget-object v4, v12, Lcom/palai/prootsmoke/PetWindowService;->showBox:Landroid/widget/FrameLayout;
    invoke-static {v12, v4, v4}, Lcom/palai/prootsmoke/PetKeyboardGuard;->install(Landroid/content/Context;Landroid/view/View;Landroid/view/View;)V
    const-string v1, "[PET] 显示层已挂载（全屏穿透）"
    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    goto :L177
    move-exception v1
    new-instance v4, Ljava/lang/StringBuilder;
    const-string v5, "[PET] 显示层 addView 失败: "
    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :L177
    new-instance v1, Landroid/widget/FrameLayout;
    invoke-direct {v1, v12}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V
    iput-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->touchBox:Landroid/widget/FrameLayout;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetKeyboardGuard;->setTouchLayer(Landroid/view/View;)V
    invoke-virtual {v1, v2}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->touchBox:Landroid/widget/FrameLayout;
    new-instance v4, Lcom/palai/prootsmoke/PetWindowService$7;
    invoke-direct {v4, v12}, Lcom/palai/prootsmoke/PetWindowService$7;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    invoke-virtual {v1, v4}, Landroid/widget/FrameLayout;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V
    new-instance v1, Landroid/view/WindowManager$LayoutParams;
    const/16 v9, #808
    const/4 v10, #-3
    const/16 v6, #520
    const/16 v7, #520
    move-object v5, v1
    move v8, v13
    invoke-direct/range {v5..v10}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V
    iput-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->touchLp:Landroid/view/WindowManager$LayoutParams;
    iput v3, v1, Landroid/view/WindowManager$LayoutParams;->gravity:I
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->touchLp:Landroid/view/WindowManager$LayoutParams;
    iput v2, v13, Landroid/view/WindowManager$LayoutParams;->x:I
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->touchLp:Landroid/view/WindowManager$LayoutParams;
    iput v2, v13, Landroid/view/WindowManager$LayoutParams;->y:I
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->touchLp:Landroid/view/WindowManager$LayoutParams;
    const/16 v1, #16
    iput v1, v13, Landroid/view/WindowManager$LayoutParams;->softInputMode:I
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->touchBox:Landroid/widget/FrameLayout;
    invoke-virtual {v13, v2}, Landroid/widget/FrameLayout;->setFocusable(Z)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->touchBox:Landroid/widget/FrameLayout;
    invoke-virtual {v13, v2}, Landroid/widget/FrameLayout;->setFocusableInTouchMode(Z)V
    new-instance v13, Lcom/palai/prootsmoke/PetWindowService$8;
    invoke-direct {v13, v12, v12}, Lcom/palai/prootsmoke/PetWindowService$8;-><init>(Lcom/palai/prootsmoke/PetWindowService;Landroid/content/Context;)V
    iput-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v13, v2}, Landroid/widget/EditText;->setBackgroundColor(I)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v13, v2}, Landroid/widget/EditText;->setTextColor(I)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v13, v2}, Landroid/widget/EditText;->setCursorVisible(Z)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    const v1, #33554438
    invoke-virtual {v13, v1}, Landroid/widget/EditText;->setImeOptions(I)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    const/4 v1, #1
    invoke-virtual {v13, v1}, Landroid/widget/EditText;->setInputType(I)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v13, v1}, Landroid/widget/EditText;->setSingleLine(Z)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v13, v2}, Landroid/widget/EditText;->setFocusable(Z)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v13, v2}, Landroid/widget/EditText;->setFocusableInTouchMode(Z)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    new-instance v2, Lcom/palai/prootsmoke/PetWindowService$9;
    invoke-direct {v2, v12}, Lcom/palai/prootsmoke/PetWindowService$9;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    invoke-virtual {v13, v2}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    new-instance v2, Lcom/palai/prootsmoke/PetWindowService$10;
    invoke-direct {v2, v12}, Lcom/palai/prootsmoke/PetWindowService$10;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    invoke-virtual {v13, v2}, Landroid/widget/EditText;->setOnKeyListener(Landroid/view/View$OnKeyListener;)V
    new-instance v13, Landroid/widget/FrameLayout$LayoutParams;
    invoke-direct {v13, v1, v1}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->touchBox:Landroid/widget/FrameLayout;
    iget-object v2, v12, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v1, v2, v13}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->wm:Landroid/view/WindowManager;
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService;->touchBox:Landroid/widget/FrameLayout;
    iget-object v2, v12, Lcom/palai/prootsmoke/PetWindowService;->touchLp:Landroid/view/WindowManager$LayoutParams;
    invoke-interface {v13, v1, v2}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    const-string v13, "[PET] 触摸层已挂载 520x520"
    invoke-static {v0, v13}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    goto :L357
    move-exception v13
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "[PET] 触摸层 addView 失败: "
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v13
    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v13
    invoke-static {v0, v13}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :L357
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->showBox:Landroid/widget/FrameLayout;
    new-instance v0, Lcom/palai/prootsmoke/PetWindowService$11;
    invoke-direct {v0, v12}, Lcom/palai/prootsmoke/PetWindowService$11;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    invoke-virtual {v13, v0}, Landroid/widget/FrameLayout;->addOnLayoutChangeListener(Landroid/view/View$OnLayoutChangeListener;)V
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->ui:Landroid/os/Handler;
    new-instance v0, Lcom/palai/prootsmoke/PetWindowService$12;
    invoke-direct {v0, v12}, Lcom/palai/prootsmoke/PetWindowService$12;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    const-wide/16 v1, #1000
    invoke-virtual {v13, v0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    iget-object v13, v12, Lcom/palai/prootsmoke/PetWindowService;->ui:Landroid/os/Handler;
    iget-object v0, v12, Lcom/palai/prootsmoke/PetWindowService;->followTick:Ljava/lang/Runnable;
    const-wide/16 v1, #300
    invoke-virtual {v13, v0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->diag(Ljava/lang/String;)V
    # registers=7 ins=2 tries=1
    const-string v0, "["
    const-string v1, "[DIAG] "
    const-string v2, "PetWindow"
    new-instance v3, Ljava/lang/StringBuilder;
    invoke-direct {v3, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    invoke-static {v2, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    new-instance v1, Ljava/io/FileOutputStream;
    const-string v2, "/sdcard/Download/coop-diag.txt"
    const/4 v3, #1
    invoke-direct {v1, v2, v3}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;Z)V
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v3
    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v2, "] "
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v6
    const-string v0, "
"
    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v6
    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v6
    const-string v0, "UTF-8"
    invoke-virtual {v6, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B
    move-result-object v6
    invoke-virtual {v1, v6}, Ljava/io/FileOutputStream;->write([B)V
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->flush()V
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->focusImeAndShow()V
    # registers=5 ins=1 tries=1
    const-string v0, "[PET] 已请求 IME（hasFocus="
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    if-nez v1, :L7
    return-void 
    :L7
    const/4 v2, #1
    invoke-virtual {v1, v2}, Landroid/widget/EditText;->setFocusable(Z)V
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v1, v2}, Landroid/widget/EditText;->setFocusableInTouchMode(Z)V
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v1}, Landroid/widget/EditText;->requestFocus()Z
    const-string v1, "input_method"
    invoke-virtual {v4, v1}, Lcom/palai/prootsmoke/PetWindowService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Landroid/view/inputmethod/InputMethodManager;
    if-eqz v1, :L36
    iget-object v3, v4, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v1, v3, v2}, Landroid/view/inputmethod/InputMethodManager;->showSoftInput(Landroid/view/View;I)Z
    :L36
    const-string v1, "PetWindow"
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v0}, Landroid/widget/EditText;->hasFocus()Z
    move-result v0
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v2, "）"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->forwardToWeb(Landroid/view/MotionEvent;)Z
    # registers=22 ins=2 tries=1
    move-object/from16 v0, v20
    move-object/from16 v1, v21
    iget-object v2, v0, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    const/4 v3, #0
    if-nez v2, :L10
    return v3
    :L10
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getPointerCount()I
    move-result v9
    new-array v10, v9, [Landroid/view/MotionEvent$PointerProperties;
    new-array v11, v9, [Landroid/view/MotionEvent$PointerCoords;
    move v2, v3
    :L19
    if-ge v2, v9, :L88
    new-instance v4, Landroid/view/MotionEvent$PointerProperties;
    invoke-direct {v4}, Landroid/view/MotionEvent$PointerProperties;-><init>()V
    invoke-virtual {v1, v2}, Landroid/view/MotionEvent;->getPointerId(I)I
    move-result v5
    iput v5, v4, Landroid/view/MotionEvent$PointerProperties;->id:I
    invoke-virtual {v1, v2}, Landroid/view/MotionEvent;->getToolType(I)I
    move-result v5
    iput v5, v4, Landroid/view/MotionEvent$PointerProperties;->toolType:I
    aput-object v4, v10, v2
    new-instance v4, Landroid/view/MotionEvent$PointerCoords;
    invoke-direct {v4}, Landroid/view/MotionEvent$PointerCoords;-><init>()V
    if-nez v2, :L52
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getRawX()F
    move-result v5
    goto :L56
    :L52
    invoke-virtual {v1, v2}, Landroid/view/MotionEvent;->getX(I)F
    move-result v5
    :L56
    iput v5, v4, Landroid/view/MotionEvent$PointerCoords;->x:F
    if-nez v2, :L65
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getRawY()F
    move-result v5
    goto :L69
    :L65
    invoke-virtual {v1, v2}, Landroid/view/MotionEvent;->getY(I)F
    move-result v5
    :L69
    iput v5, v4, Landroid/view/MotionEvent$PointerCoords;->y:F
    invoke-virtual {v1, v2}, Landroid/view/MotionEvent;->getPressure(I)F
    move-result v5
    iput v5, v4, Landroid/view/MotionEvent$PointerCoords;->pressure:F
    invoke-virtual {v1, v2}, Landroid/view/MotionEvent;->getSize(I)F
    move-result v5
    iput v5, v4, Landroid/view/MotionEvent$PointerCoords;->size:F
    aput-object v4, v11, v2
    add-int/lit8 v2, v2, #1
    goto :L19
    :L88
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getDownTime()J
    move-result-wide v4
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getEventTime()J
    move-result-wide v6
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getAction()I
    move-result v8
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getMetaState()I
    move-result v12
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getButtonState()I
    move-result v13
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getXPrecision()F
    move-result v14
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getYPrecision()F
    move-result v15
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getDeviceId()I
    move-result v16
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getEdgeFlags()I
    move-result v17
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getSource()I
    move-result v18
    invoke-virtual/range {v21..v21}, Landroid/view/MotionEvent;->getFlags()I
    move-result v19
    invoke-static/range {v4..v19}, Landroid/view/MotionEvent;->obtain(JJII[Landroid/view/MotionEvent$PointerProperties;[Landroid/view/MotionEvent$PointerCoords;IIFFIIII)Landroid/view/MotionEvent;
    move-result-object v1
    iget-object v2, v0, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    invoke-virtual {v2, v1}, Landroid/webkit/WebView;->dispatchTouchEvent(Landroid/view/MotionEvent;)Z
    move-result v2
    invoke-virtual {v1}, Landroid/view/MotionEvent;->recycle()V
    return v2
    return v3
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/PetWindowService;->jsStr(Ljava/lang/String;)Ljava/lang/String;
    # registers=6 ins=1 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, """
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    const/4 v1, #0
    :L8
    invoke-virtual {v5}, Ljava/lang/String;->length()I
    move-result v2
    const/16 v3, #34
    if-ge v1, v2, :L83
    invoke-virtual {v5, v1}, Ljava/lang/String;->charAt(I)C
    move-result v2
    const/16 v4, #92
    if-eq v2, v3, :L73
    if-ne v2, v4, :L27
    goto :L73
    :L27
    const/16 v3, #10
    if-ne v2, v3, :L37
    const-string v2, "\n"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :L80
    :L37
    const/16 v3, #13
    if-ne v2, v3, :L47
    const-string v2, "\r"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :L80
    :L47
    const/16 v3, #32
    if-ge v2, v3, :L69
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;
    move-result-object v2
    filled-new-array {v2}, Landroid/widget/TextView;->setTextSize(F)V
    move-result-object v2
    const-string v3, "\u%04x"
    invoke-static {v3, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :L80
    :L69
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    goto :L80
    :L73
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    :L80
    add-int/lit8 v1, v1, #1
    goto :L8
    :L83
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    move-result-object v5
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v5
    return-object v5
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->pushKeyToPage(Ljava/lang/String;)V
    # registers=4 ins=2 tries=0
    iget-object v3, v2, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    if-nez v3, :L5
    return-void 
    :L5
    const-string v0, "(function(){try{var ae=document.activeElement;var el=null;if(ae && (ae.tagName==='INPUT'||ae.tagName==='TEXTAREA')) el=ae;if(!el) el=document.querySelector('#bubble input,#bubble textarea,.d-body input,.d-body textarea');if(!el) return 'no-target';el.value=(el.value||'').slice(0,-1);el.dispatchEvent(new Event('input',{bubbles:true}));return 'ok';}catch(e){return 'err';}})()"
    const/4 v1, #0
    invoke-virtual {v3, v0, v1}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->pushTextToPage(Ljava/lang/String;)V
    # registers=4 ins=2 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    if-nez v0, :L5
    return-void 
    :L5
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "(function(){try{var ae=document.activeElement;var el=null;if(ae && (ae.tagName==='INPUT'||ae.tagName==='TEXTAREA')) el=ae;if(!el) el=document.querySelector('#bubble input,#bubble textarea,.d-body input,.d-body textarea,input:focus,textarea:focus');if(!el) return 'no-target';el.value=(el.value||'')+"
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-static {v3}, Lcom/palai/prootsmoke/PetWindowService;->jsStr(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    const-string v0, ";el.dispatchEvent(new Event('input',{bubbles:true}));return 'ok';}catch(e){return 'err';}})()"
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    const/4 v1, #0
    invoke-virtual {v0, v3, v1}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->queryPetRect()V
    # registers=4 ins=1 tries=0
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    if-nez v0, :L5
    return-void 
    :L5
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$15;
    invoke-direct {v1, v3}, Lcom/palai/prootsmoke/PetWindowService$15;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    const-string v2, "(function(){try{var box='';try{if(window.__petUnionRect)box=window.__petUnionRect()||'';}catch(e0){}if(!box){function r(id){var e=document.getElementById(id);  if(!e) return null; var st=window.getComputedStyle(e);  if(st.display==='none'||st.visibility==='hidden'||e.hidden) return null;  var b=e.getBoundingClientRect(); if(b.width<1&&b.height<1) return null; return b; }var ids=['pet','pet2','pet3','pet4','bubble','bubble2','bubble3','bubble4','menu','tools'];var arr=[];for(var i=0;i<ids.length;i++){var q=r(ids[i]); if(q) arr.push(q);}if(arr.length){var l=1e9,t=1e9,rr=-1e9,b=-1e9;  for(var k=0;k<arr.length;k++){var q=arr[k];    if(q.left<l)l=q.left; if(q.top<t)t=q.top;    if(q.right>rr)rr=q.right; if(q.bottom>b)b=q.bottom; }  box=l+','+t+','+rr+','+b; }}var ae=document.activeElement;var focused = !!(ae && (ae.tagName==='INPUT'||ae.tagName==='TEXTAREA'||ae.isContentEditable));return box+'|'+(focused?'1':'0');}catch(err){return '';}})()"
    invoke-virtual {v0, v2, v1}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->showPetWindow()V
    # registers=5 ins=1 tries=0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v1, #26
    if-lt v0, v1, :L9
    const/16 v0, #2038
    goto :L11
    :L9
    const/16 v0, #2002
    :L11
    new-instance v1, Landroid/webkit/WebView;
    invoke-direct {v1, v4}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V
    iput-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    invoke-virtual {v1}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v1
    const/4 v2, #1
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V
    const/4 v3, #0
    invoke-virtual {v1, v3}, Landroid/webkit/WebSettings;->setMixedContentMode(I)V
    invoke-virtual {v1, v3}, Landroid/webkit/WebSettings;->setMediaPlaybackRequiresUserGesture(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setUseWideViewPort(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setLoadWithOverviewMode(Z)V
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    invoke-virtual {v1, v3}, Landroid/webkit/WebView;->setBackgroundColor(I)V
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    const/4 v2, #0
    invoke-virtual {v1, v3, v2}, Landroid/webkit/WebView;->setLayerType(ILandroid/graphics/Paint;)V
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    invoke-virtual {v1, v3}, Landroid/webkit/WebView;->setVerticalScrollBarEnabled(Z)V
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    invoke-virtual {v1, v3}, Landroid/webkit/WebView;->setHorizontalScrollBarEnabled(Z)V
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    const/4 v2, #2
    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->setOverScrollMode(I)V
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$2;
    invoke-direct {v1, v4, v0}, Lcom/palai/prootsmoke/PetWindowService$2;-><init>(Lcom/palai/prootsmoke/PetWindowService;I)V
    invoke-direct {v4, v1}, Lcom/palai/prootsmoke/PetWindowService;->warmUpRenderer(Ljava/lang/Runnable;)V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->sizeTouchTo(IIII)V
    # registers=13 ins=5 tries=0
    iget v0, v8, Lcom/palai/prootsmoke/PetWindowService;->lastTouchX:I
    if-ne v9, v0, :L17
    iget v0, v8, Lcom/palai/prootsmoke/PetWindowService;->lastTouchY:I
    if-ne v10, v0, :L17
    iget v0, v8, Lcom/palai/prootsmoke/PetWindowService;->lastTouchW:I
    if-ne v11, v0, :L17
    iget v0, v8, Lcom/palai/prootsmoke/PetWindowService;->lastTouchH:I
    if-ne v12, v0, :L17
    return-void 
    :L17
    iput v9, v8, Lcom/palai/prootsmoke/PetWindowService;->lastTouchX:I
    iput v10, v8, Lcom/palai/prootsmoke/PetWindowService;->lastTouchY:I
    iput v11, v8, Lcom/palai/prootsmoke/PetWindowService;->lastTouchW:I
    iput v12, v8, Lcom/palai/prootsmoke/PetWindowService;->lastTouchH:I
    iget-object v0, v8, Lcom/palai/prootsmoke/PetWindowService;->ui:Landroid/os/Handler;
    new-instance v7, Lcom/palai/prootsmoke/PetWindowService$17;
    move-object v1, v7
    move-object v2, v8
    move v3, v9
    move v4, v10
    move v5, v11
    move v6, v12
    invoke-direct/range {v1..v6}, Lcom/palai/prootsmoke/PetWindowService$17;-><init>(Lcom/palai/prootsmoke/PetWindowService;IIII)V
    invoke-virtual {v0, v7}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->startForegroundCompat()V
    # registers=8 ins=1 tries=0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/4 v1, #0
    const/4 v2, #1
    const-string v3, "coopanion_pet"
    const/16 v4, #26
    if-lt v0, v4, :L31
    const-string v0, "notification"
    invoke-virtual {v7, v0}, Lcom/palai/prootsmoke/PetWindowService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/app/NotificationManager;
    new-instance v5, Landroid/app/NotificationChannel;
    const-string v6, "桌宠运行中"
    invoke-direct {v5, v3, v6, v2}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V
    invoke-virtual {v5, v1}, Landroid/app/NotificationChannel;->setShowBadge(Z)V
    invoke-virtual {v0, v5}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V
    :L31
    new-instance v0, Landroid/content/Intent;
    const-class v5, Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0, v7, v5}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    const/high16 v5, #int 0xc000000
    invoke-static {v7, v1, v0, v5}, Landroid/app/PendingIntent;->getActivity(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;
    move-result-object v0
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I
    if-lt v1, v4, :L54
    new-instance v1, Landroid/app/Notification$Builder;
    invoke-direct {v1, v7, v3}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V
    goto :L59
    :L54
    new-instance v1, Landroid/app/Notification$Builder;
    invoke-direct {v1, v7}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;)V
    :L59
    const-string v3, "Coopanion"
    invoke-virtual {v1, v3}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;
    move-result-object v3
    const-string v4, "桌宠正在运行"
    invoke-virtual {v3, v4}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;
    move-result-object v3
    const v4, #17301561
    invoke-virtual {v3, v4}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;
    move-result-object v3
    invoke-virtual {v3, v0}, Landroid/app/Notification$Builder;->setContentIntent(Landroid/app/PendingIntent;)Landroid/app/Notification$Builder;
    move-result-object v0
    invoke-virtual {v0, v2}, Landroid/app/Notification$Builder;->setOngoing(Z)Landroid/app/Notification$Builder;
    const/16 v0, #8801
    invoke-virtual {v1}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;
    move-result-object v1
    invoke-virtual {v7, v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->startForeground(ILandroid/app/Notification;)V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->startRepaintWatchdog(Landroid/webkit/WebView;)V
    # registers=9 ins=2 tries=0
    const/4 v0, #0
    :L1
    const/16 v1, #40
    if-ge v0, v1, :L22
    iget-object v1, v7, Lcom/palai/prootsmoke/PetWindowService;->ui:Landroid/os/Handler;
    new-instance v2, Lcom/palai/prootsmoke/PetWindowService$13;
    invoke-direct {v2, v7, v8}, Lcom/palai/prootsmoke/PetWindowService$13;-><init>(Lcom/palai/prootsmoke/PetWindowService;Landroid/webkit/WebView;)V
    add-int/lit8 v0, v0, #1
    int-to-long v3, v0
    const-wide/16 v5, #200
    mul-long/2addr v3, v5
    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    goto :L1
    :L22
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/PetWindowService;->warmUpRenderer(Ljava/lang/Runnable;)V
    # registers=21 ins=2 tries=3
    move-object/from16 v8, v19
    const-string v9, "PetWindow"
    const-string v10, "[PET] 预热窗口挂载失败，跳过预热: "
    new-instance v0, Landroid/webkit/WebView;
    invoke-direct {v0, v8}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V
    invoke-virtual {v0}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v1
    const/4 v2, #1
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V
    const/4 v3, #0
    invoke-virtual {v1, v3}, Landroid/webkit/WebSettings;->setMixedContentMode(I)V
    invoke-virtual {v0, v3}, Landroid/webkit/WebView;->setBackgroundColor(I)V
    const/4 v1, #0
    invoke-virtual {v0, v3, v1}, Landroid/webkit/WebView;->setLayerType(ILandroid/graphics/Paint;)V
    const-string v1, "window"
    invoke-virtual {v8, v1}, Lcom/palai/prootsmoke/PetWindowService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v1
    move-object v11, v1
    check-cast v11, Landroid/view/WindowManager;
    new-instance v12, Landroid/widget/FrameLayout;
    invoke-direct {v12, v8}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V
    invoke-virtual {v12, v3}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V
    new-instance v1, Landroid/widget/FrameLayout$LayoutParams;
    invoke-direct {v1, v2, v2}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V
    invoke-virtual {v12, v0, v1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    new-instance v7, Landroid/view/WindowManager$LayoutParams;
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v4, #26
    if-lt v1, v4, :L72
    const/16 v1, #2038
    goto :L74
    :L72
    const/16 v1, #2002
    :L74
    move/from16 v16, v1
    const/16 v17, #24
    const/16 v18, #-3
    const/4 v14, #1
    const/4 v15, #1
    move-object v13, v7
    invoke-direct/range {v13..v18}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V
    const v1, #8388659
    iput v1, v7, Landroid/view/WindowManager$LayoutParams;->gravity:I
    new-array v4, v2, [Z
    aput-boolean v3, v4, v3
    new-instance v13, Lcom/palai/prootsmoke/PetWindowService$3;
    move-object v1, v13
    move-object/from16 v2, v19
    move-object v3, v4
    move-object v4, v11
    move-object v5, v12
    move-object v6, v0
    move-object v14, v7
    move-object/from16 v7, v20
    invoke-direct/range {v1..v7}, Lcom/palai/prootsmoke/PetWindowService$3;-><init>(Lcom/palai/prootsmoke/PetWindowService;[ZLandroid/view/WindowManager;Landroid/widget/FrameLayout;Landroid/webkit/WebView;Ljava/lang/Runnable;)V
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$4;
    invoke-direct {v1, v8, v13}, Lcom/palai/prootsmoke/PetWindowService$4;-><init>(Lcom/palai/prootsmoke/PetWindowService;Ljava/lang/Runnable;)V
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V
    invoke-interface {v11, v12, v14}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    const-string v1, "http://127.0.0.1:7797/pet"
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    iget-object v0, v8, Lcom/palai/prootsmoke/PetWindowService;->ui:Landroid/os/Handler;
    const-wide/16 v1, #2500
    invoke-virtual {v0, v13, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    goto :L178
    move-exception v0
    move-object v1, v0
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0, v10}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static {v9, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    invoke-interface {v13}, Ljava/lang/Runnable;->run()V
    return-void 
    move-exception v0
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "[PET] 预热异常，跳过预热: "
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static {v9, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    invoke-interface/range {v20..v20}, Ljava/lang/Runnable;->run()V
    :L178
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService;->onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    # registers=2 ins=2 tries=0
    const/4 v1, #0
    return-object v1
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService;->onCreate()V
    # registers=3 ins=1 tries=0
    invoke-super {v2}, Landroid/app/Service;->onCreate()V
    invoke-direct {v2}, Lcom/palai/prootsmoke/PetWindowService;->startForegroundCompat()V
    const-string v0, "window"
    invoke-virtual {v2, v0}, Lcom/palai/prootsmoke/PetWindowService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/view/WindowManager;
    iput-object v0, v2, Lcom/palai/prootsmoke/PetWindowService;->wm:Landroid/view/WindowManager;
    new-instance v0, Landroid/util/DisplayMetrics;
    invoke-direct {v0}, Landroid/util/DisplayMetrics;-><init>()V
    iget-object v1, v2, Lcom/palai/prootsmoke/PetWindowService;->wm:Landroid/view/WindowManager;
    invoke-interface {v1}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;
    move-result-object v1
    invoke-virtual {v1, v0}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V
    iget v1, v0, Landroid/util/DisplayMetrics;->widthPixels:I
    iput v1, v2, Lcom/palai/prootsmoke/PetWindowService;->screenW:I
    iget v0, v0, Landroid/util/DisplayMetrics;->heightPixels:I
    iput v0, v2, Lcom/palai/prootsmoke/PetWindowService;->screenH:I
    invoke-direct {v2}, Lcom/palai/prootsmoke/PetWindowService;->showPetWindow()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService;->onDestroy()V
    # registers=5 ins=1 tries=4
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService;->ui:Landroid/os/Handler;
    const/4 v1, #0
    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacksAndMessages(Ljava/lang/Object;)V
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    if-eqz v0, :L35
    const-string v0, "input_method"
    invoke-virtual {v4, v0}, Lcom/palai/prootsmoke/PetWindowService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/view/inputmethod/InputMethodManager;
    if-eqz v0, :L30
    iget-object v2, v4, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v2}, Landroid/widget/EditText;->getWindowToken()Landroid/os/IBinder;
    move-result-object v2
    const/4 v3, #0
    invoke-virtual {v0, v2, v3}, Landroid/view/inputmethod/InputMethodManager;->hideSoftInputFromWindow(Landroid/os/IBinder;I)Z
    :L30
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService;->imeProxy:Landroid/widget/EditText;
    invoke-virtual {v0}, Landroid/widget/EditText;->clearFocus()V
    :L35
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    if-eqz v0, :L51
    const-string v2, "about:blank"
    invoke-virtual {v0, v2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    invoke-virtual {v0}, Landroid/webkit/WebView;->destroy()V
    iput-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->web:Landroid/webkit/WebView;
    :L51
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService;->touchBox:Landroid/widget/FrameLayout;
    if-eqz v0, :L60
    iget-object v2, v4, Lcom/palai/prootsmoke/PetWindowService;->wm:Landroid/view/WindowManager;
    invoke-interface {v2, v0}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    :L60
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService;->showBox:Landroid/widget/FrameLayout;
    if-eqz v0, :L69
    iget-object v2, v4, Lcom/palai/prootsmoke/PetWindowService;->wm:Landroid/view/WindowManager;
    invoke-interface {v2, v0}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    :L69
    iput-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->touchBox:Landroid/widget/FrameLayout;
    iput-object v1, v4, Lcom/palai/prootsmoke/PetWindowService;->showBox:Landroid/widget/FrameLayout;
    invoke-super {v4}, Landroid/app/Service;->onDestroy()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService;->onStartCommand(Landroid/content/Intent;II)I
    # registers=4 ins=4 tries=1
    if-eqz v1, :L32
    const-string v2, "com.palai.prootsmoke.SET_ALPHA"
    invoke-virtual {v1}, Landroid/content/Intent;->getAction()Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v2
    if-eqz v2, :L32
    const-string v2, "alpha"
    iget v3, v0, Lcom/palai/prootsmoke/PetWindowService;->petAlpha:F
    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->getFloatExtra(Ljava/lang/String;F)F
    move-result v1
    iget-object v2, v0, Lcom/palai/prootsmoke/PetWindowService;->ui:Landroid/os/Handler;
    new-instance v3, Lcom/palai/prootsmoke/PetWindowService$1;
    invoke-direct {v3, v0, v1}, Lcom/palai/prootsmoke/PetWindowService$1;-><init>(Lcom/palai/prootsmoke/PetWindowService;F)V
    invoke-virtual {v2, v3}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :L32
    const/4 v1, #1
    return v1
.end method

