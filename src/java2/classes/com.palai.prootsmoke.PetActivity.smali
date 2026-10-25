.class public Lcom/palai/prootsmoke/PetActivity;
.super Landroid/app/Activity;

.field private static final PET_URL:Ljava/lang/String;
.field private static final REQ_FILE:I
.field private filePathCallback:Landroid/webkit/ValueCallback;
.field private root:Landroid/widget/FrameLayout;
.field private web:Landroid/webkit/WebView;

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetActivity;->-$$Nest$fgetfilePathCallback(Lcom/palai/prootsmoke/PetActivity;)Landroid/webkit/ValueCallback;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/PetActivity;->filePathCallback:Landroid/webkit/ValueCallback;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/PetActivity;->-$$Nest$fputfilePathCallback(Lcom/palai/prootsmoke/PetActivity;Landroid/webkit/ValueCallback;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetActivity;->filePathCallback:Landroid/webkit/ValueCallback;
    return-void 
.end method

# direct access=0x10001
.method public constructor Lcom/palai/prootsmoke/PetActivity;-><init>()V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Landroid/app/Activity;-><init>()V
    return-void 
.end method

# virtual access=0x4
.method protected Lcom/palai/prootsmoke/PetActivity;->onActivityResult(IILandroid/content/Intent;)V
    # registers=7 ins=4 tries=0
    const/16 v0, #20819
    if-ne v4, v0, :L60
    const/4 v4, #-1
    const/4 v0, #1
    const/4 v1, #0
    const/4 v2, #0
    if-ne v5, v4, :L27
    if-eqz v6, :L27
    invoke-virtual {v6}, Landroid/content/Intent;->getData()Landroid/net/Uri;
    move-result-object v4
    if-eqz v4, :L27
    new-array v4, v0, [Landroid/net/Uri;
    invoke-virtual {v6}, Landroid/content/Intent;->getData()Landroid/net/Uri;
    move-result-object v5
    aput-object v5, v4, v1
    goto :L28
    :L27
    move-object v4, v2
    :L28
    iget-object v5, v3, Lcom/palai/prootsmoke/PetActivity;->filePathCallback:Landroid/webkit/ValueCallback;
    if-eqz v5, :L37
    invoke-interface {v5, v4}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V
    iput-object v2, v3, Lcom/palai/prootsmoke/PetActivity;->filePathCallback:Landroid/webkit/ValueCallback;
    :L37
    new-instance v5, Ljava/lang/StringBuilder;
    const-string v6, "[PETACT][FILE] onActivityResult ok="
    invoke-direct {v5, v6}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    if-eqz v4, :L47
    goto :L48
    :L47
    move v0, v1
    :L48
    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
    move-result-object v4
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-static {v4}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    goto :L63
    :L60
    invoke-super {v3, v4, v5, v6}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V
    :L63
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity;->onBackPressed()V
    # registers=1 ins=1 tries=0
    invoke-virtual {v0}, Lcom/palai/prootsmoke/PetActivity;->finish()V
    return-void 
.end method

# virtual access=0x4
.method protected Lcom/palai/prootsmoke/PetActivity;->onCreate(Landroid/os/Bundle;)V
    # registers=8 ins=2 tries=2
    const-string v0, "android.permission.RECORD_AUDIO"
    invoke-super {v6, v7}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V
    invoke-static {v6}, Lcom/palai/prootsmoke/AppLog;->init(Landroid/content/Context;)V
    const-string v7, "[PETACT] ===== PetActivity onCreate ====="
    invoke-static {v7}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    invoke-virtual {v6}, Lcom/palai/prootsmoke/PetActivity;->getIntent()Landroid/content/Intent;
    move-result-object v7
    const/4 v1, #1
    const/4 v2, #0
    if-eqz v7, :L35
    invoke-virtual {v6}, Lcom/palai/prootsmoke/PetActivity;->getIntent()Landroid/content/Intent;
    move-result-object v7
    const-string v3, "transparent"
    invoke-virtual {v7, v3, v2}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z
    move-result v7
    if-eqz v7, :L35
    move v7, v1
    goto :L36
    :L35
    move v7, v2
    :L36
    if-eqz v7, :L59
    invoke-virtual {v6}, Lcom/palai/prootsmoke/PetActivity;->getWindow()Landroid/view/Window;
    move-result-object v3
    new-instance v4, Landroid/graphics/drawable/ColorDrawable;
    invoke-direct {v4, v2}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V
    invoke-virtual {v3, v4}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V
    invoke-virtual {v6}, Lcom/palai/prootsmoke/PetActivity;->getWindow()Landroid/view/Window;
    move-result-object v3
    const/16 v4, #32
    invoke-virtual {v3, v4}, Landroid/view/Window;->addFlags(I)V
    :L59
    invoke-virtual {v6}, Lcom/palai/prootsmoke/PetActivity;->getWindow()Landroid/view/Window;
    move-result-object v3
    const/16 v4, #1024
    invoke-virtual {v3, v4, v4}, Landroid/view/Window;->setFlags(II)V
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v4, #28
    if-lt v3, v4, :L84
    invoke-virtual {v6}, Lcom/palai/prootsmoke/PetActivity;->getWindow()Landroid/view/Window;
    move-result-object v3
    invoke-virtual {v3}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;
    move-result-object v3
    iput v1, v3, Landroid/view/WindowManager$LayoutParams;->layoutInDisplayCutoutMode:I
    :L84
    new-instance v3, Landroid/widget/FrameLayout;
    invoke-direct {v3, v6}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V
    iput-object v3, v6, Lcom/palai/prootsmoke/PetActivity;->root:Landroid/widget/FrameLayout;
    const v4, #-16052460
    if-eqz v7, :L98
    move v5, v2
    goto :L99
    :L98
    move v5, v4
    :L99
    invoke-virtual {v3, v5}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V
    new-instance v3, Landroid/webkit/WebView;
    invoke-direct {v3, v6}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V
    iput-object v3, v6, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v3}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v3
    invoke-virtual {v3, v1}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V
    invoke-virtual {v3, v1}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V
    invoke-virtual {v3, v2}, Landroid/webkit/WebSettings;->setMixedContentMode(I)V
    invoke-virtual {v3, v1}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V
    invoke-virtual {v3, v2}, Landroid/webkit/WebSettings;->setMediaPlaybackRequiresUserGesture(Z)V
    invoke-virtual {v3, v2}, Landroid/webkit/WebSettings;->setUseWideViewPort(Z)V
    invoke-virtual {v3, v2}, Landroid/webkit/WebSettings;->setLoadWithOverviewMode(Z)V
    invoke-virtual {v3, v2}, Landroid/webkit/WebSettings;->setSupportZoom(Z)V
    invoke-virtual {v3, v2}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V
    invoke-virtual {v3, v2}, Landroid/webkit/WebSettings;->setDisplayZoomControls(Z)V
    iget-object v3, v6, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    if-eqz v7, :L148
    move v4, v2
    :L148
    invoke-virtual {v3, v4}, Landroid/webkit/WebView;->setBackgroundColor(I)V
    iget-object v7, v6, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    new-instance v3, Lcom/palai/prootsmoke/PetActivity$PetHostBridge;
    invoke-direct {v3}, Lcom/palai/prootsmoke/PetActivity$PetHostBridge;-><init>()V
    const-string v4, "petHostNative"
    invoke-virtual {v7, v3, v4}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V
    iget-object v7, v6, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    new-instance v3, Lcom/palai/prootsmoke/PetActivity$PetHostBridge;
    invoke-direct {v3}, Lcom/palai/prootsmoke/PetActivity$PetHostBridge;-><init>()V
    const-string v4, "petHost"
    invoke-virtual {v7, v3, v4}, Landroid/webkit/WebView;->addJavascriptInterface(Ljava/lang/Object;Ljava/lang/String;)V
    iget-object v7, v6, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    new-instance v3, Lcom/palai/prootsmoke/PetActivity$1;
    invoke-direct {v3, v6}, Lcom/palai/prootsmoke/PetActivity$1;-><init>(Lcom/palai/prootsmoke/PetActivity;)V
    invoke-virtual {v7, v3}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V
    iget-object v7, v6, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    new-instance v3, Lcom/palai/prootsmoke/PetActivity$2;
    invoke-direct {v3, v6}, Lcom/palai/prootsmoke/PetActivity$2;-><init>(Lcom/palai/prootsmoke/PetActivity;)V
    invoke-virtual {v7, v3}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V
    iget-object v7, v6, Lcom/palai/prootsmoke/PetActivity;->root:Landroid/widget/FrameLayout;
    iget-object v3, v6, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    new-instance v4, Landroid/widget/FrameLayout$LayoutParams;
    const/4 v5, #-1
    invoke-direct {v4, v5, v5}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V
    invoke-virtual {v7, v3, v4}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    new-instance v7, Landroid/widget/LinearLayout;
    invoke-direct {v7, v6}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V
    invoke-virtual {v7, v2}, Landroid/widget/LinearLayout;->setOrientation(I)V
    new-instance v3, Landroid/widget/FrameLayout$LayoutParams;
    const/4 v4, #-2
    invoke-direct {v3, v4, v4}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V
    const/16 v4, #53
    iput v4, v3, Landroid/widget/FrameLayout$LayoutParams;->gravity:I
    const/16 v4, #40
    iput v4, v3, Landroid/widget/FrameLayout$LayoutParams;->topMargin:I
    const/16 v4, #24
    iput v4, v3, Landroid/widget/FrameLayout$LayoutParams;->rightMargin:I
    new-instance v4, Landroid/widget/Button;
    invoke-direct {v4, v6}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V
    const-string v5, "✕ 退出"
    invoke-virtual {v4, v5}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V
    const v5, #1057803469
    invoke-virtual {v4, v5}, Landroid/widget/Button;->setAlpha(F)V
    new-instance v5, Lcom/palai/prootsmoke/PetActivity$3;
    invoke-direct {v5, v6}, Lcom/palai/prootsmoke/PetActivity$3;-><init>(Lcom/palai/prootsmoke/PetActivity;)V
    invoke-virtual {v4, v5}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    invoke-virtual {v7, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    iget-object v4, v6, Lcom/palai/prootsmoke/PetActivity;->root:Landroid/widget/FrameLayout;
    invoke-virtual {v4, v7, v3}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    iget-object v7, v6, Lcom/palai/prootsmoke/PetActivity;->root:Landroid/widget/FrameLayout;
    invoke-virtual {v6, v7}, Lcom/palai/prootsmoke/PetActivity;->setContentView(Landroid/view/View;)V
    invoke-virtual {v6, v0}, Lcom/palai/prootsmoke/PetActivity;->checkSelfPermission(Ljava/lang/String;)I
    move-result v7
    if-eqz v7, :L286
    new-array v7, v1, [Ljava/lang/String;
    aput-object v0, v7, v2
    const/16 v0, #10088
    invoke-virtual {v6, v7, v0}, Lcom/palai/prootsmoke/PetActivity;->requestPermissions([Ljava/lang/String;I)V
    :L286
    iget-object v7, v6, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    const-string v0, "http://127.0.0.1:7797/pet?host=app"
    invoke-virtual {v7, v0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    const-string v7, "[PETACT] loadUrl -> http://127.0.0.1:7797/pet?host=app"
    invoke-static {v7}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x4
.method protected Lcom/palai/prootsmoke/PetActivity;->onDestroy()V
    # registers=3 ins=1 tries=1
    iget-object v0, v2, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    if-eqz v0, :L17
    const-string v1, "about:blank"
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    iget-object v0, v2, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v0}, Landroid/webkit/WebView;->destroy()V
    const/4 v0, #0
    iput-object v0, v2, Lcom/palai/prootsmoke/PetActivity;->web:Landroid/webkit/WebView;
    :L17
    invoke-super {v2}, Landroid/app/Activity;->onDestroy()V
    return-void 
.end method

