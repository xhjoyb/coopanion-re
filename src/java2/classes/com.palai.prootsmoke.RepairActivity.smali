.class public Lcom/palai/prootsmoke/RepairActivity;
.super Landroid/app/Activity;

.field private static final REPAIR_URL:Ljava/lang/String;
.field private static final REQ_FILE:I
.field private filePathCallback:Landroid/webkit/ValueCallback;
.field private imeHandler:Landroid/os/Handler;
.field private imeShown:Z
.field private web:Landroid/webkit/WebView;

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fgetfilePathCallback(Lcom/palai/prootsmoke/RepairActivity;)Landroid/webkit/ValueCallback;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/RepairActivity;->filePathCallback:Landroid/webkit/ValueCallback;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fgetimeHandler(Lcom/palai/prootsmoke/RepairActivity;)Landroid/os/Handler;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/RepairActivity;->imeHandler:Landroid/os/Handler;
    return-object v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fgetimeShown(Lcom/palai/prootsmoke/RepairActivity;)Z
    # registers=1 ins=1 tries=0
    iget-boolean v0, v0, Lcom/palai/prootsmoke/RepairActivity;->imeShown:Z
    return v0
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fputfilePathCallback(Lcom/palai/prootsmoke/RepairActivity;Landroid/webkit/ValueCallback;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/RepairActivity;->filePathCallback:Landroid/webkit/ValueCallback;
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fputimeShown(Lcom/palai/prootsmoke/RepairActivity;Z)V
    # registers=2 ins=2 tries=0
    iput-boolean v1, v0, Lcom/palai/prootsmoke/RepairActivity;->imeShown:Z
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$mshowImeNow(Lcom/palai/prootsmoke/RepairActivity;)V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/RepairActivity;->showImeNow()V
    return-void 
.end method

# direct access=0x1048
.method static bridge synthetic Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$mstartImeWatchdog(Lcom/palai/prootsmoke/RepairActivity;Landroid/webkit/WebView;)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/RepairActivity;->startImeWatchdog(Landroid/webkit/WebView;)V
    return-void 
.end method

# direct access=0x10001
.method public constructor Lcom/palai/prootsmoke/RepairActivity;-><init>()V
    # registers=2 ins=1 tries=0
    invoke-direct {v1}, Landroid/app/Activity;-><init>()V
    const/4 v0, #0
    iput-boolean v0, v1, Lcom/palai/prootsmoke/RepairActivity;->imeShown:Z
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/RepairActivity;->showImeNow()V
    # registers=4 ins=1 tries=1
    iget-object v0, v3, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    if-nez v0, :L5
    return-void 
    :L5
    invoke-virtual {v0}, Landroid/webkit/WebView;->requestFocus()Z
    const-string v0, "input_method"
    invoke-virtual {v3, v0}, Lcom/palai/prootsmoke/RepairActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/view/inputmethod/InputMethodManager;
    if-eqz v0, :L49
    iget-object v1, v3, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    const/4 v2, #1
    invoke-virtual {v0, v1, v2}, Landroid/view/inputmethod/InputMethodManager;->showSoftInput(Landroid/view/View;I)Z
    const-string v0, "[REPAIRACT][IME] showSoftInput requested"
    invoke-static {v0}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    goto :L49
    move-exception v0
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "[REPAIRACT][IME] err: "
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static {v0}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    :L49
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/RepairActivity;->startImeWatchdog(Landroid/webkit/WebView;)V
    # registers=5 ins=2 tries=0
    iget-object v0, v3, Lcom/palai/prootsmoke/RepairActivity;->imeHandler:Landroid/os/Handler;
    if-nez v0, :L15
    new-instance v0, Landroid/os/Handler;
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;
    move-result-object v1
    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
    iput-object v0, v3, Lcom/palai/prootsmoke/RepairActivity;->imeHandler:Landroid/os/Handler;
    :L15
    new-instance v0, Lcom/palai/prootsmoke/RepairActivity$5;
    invoke-direct {v0, v3, v4}, Lcom/palai/prootsmoke/RepairActivity$5;-><init>(Lcom/palai/prootsmoke/RepairActivity;Landroid/webkit/WebView;)V
    iget-object v4, v3, Lcom/palai/prootsmoke/RepairActivity;->imeHandler:Landroid/os/Handler;
    const-wide/16 v1, #600
    invoke-virtual {v4, v0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    return-void 
.end method

# virtual access=0x4
.method protected Lcom/palai/prootsmoke/RepairActivity;->onActivityResult(IILandroid/content/Intent;)V
    # registers=8 ins=4 tries=1
    const/16 v0, #20818
    if-ne v5, v0, :L97
    const/4 v0, #-1
    const/4 v1, #1
    const/4 v2, #0
    const/4 v3, #0
    if-ne v6, v0, :L27
    if-eqz v7, :L27
    invoke-virtual {v7}, Landroid/content/Intent;->getData()Landroid/net/Uri;
    move-result-object v0
    if-eqz v0, :L27
    new-array v0, v1, [Landroid/net/Uri;
    invoke-virtual {v7}, Landroid/content/Intent;->getData()Landroid/net/Uri;
    move-result-object v7
    aput-object v7, v0, v3
    goto :L28
    :L27
    move-object v0, v2
    :L28
    iget-object v7, v4, Lcom/palai/prootsmoke/RepairActivity;->filePathCallback:Landroid/webkit/ValueCallback;
    if-eqz v7, :L37
    invoke-interface {v7, v0}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V
    iput-object v2, v4, Lcom/palai/prootsmoke/RepairActivity;->filePathCallback:Landroid/webkit/ValueCallback;
    :L37
    new-instance v7, Ljava/lang/StringBuilder;
    const-string v2, "[REPAIRACT][FILE] onActivityResult req="
    invoke-direct {v7, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v7, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v5
    const-string v7, " res="
    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v5
    const-string v6, " ok="
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
    if-eqz v0, :L67
    goto :L68
    :L67
    move v1, v3
    :L68
    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
    move-result-object v5
    const-string v6, " uri="
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
    if-eqz v0, :L83
    aget-object v6, v0, v3
    goto :L85
    :L83
    const-string v6, "null"
    :L85
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v5
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v5
    invoke-static {v5}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    goto :L100
    :L97
    invoke-super {v4, v5, v6, v7}, Landroid/app/Activity;->onActivityResult(IILandroid/content/Intent;)V
    :L100
    return-void 
.end method

# virtual access=0x4
.method protected Lcom/palai/prootsmoke/RepairActivity;->onCreate(Landroid/os/Bundle;)V
    # registers=6 ins=2 tries=1
    invoke-super {v4, v5}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V
    invoke-static {v4}, Lcom/palai/prootsmoke/AppLog;->init(Landroid/content/Context;)V
    const-string v5, "[REPAIRACT] ===== RepairActivity onCreate ====="
    invoke-static {v5}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    invoke-virtual {v4}, Lcom/palai/prootsmoke/RepairActivity;->getWindow()Landroid/view/Window;
    move-result-object v5
    const/16 v0, #1024
    invoke-virtual {v5, v0, v0}, Landroid/view/Window;->setFlags(II)V
    invoke-virtual {v4}, Lcom/palai/prootsmoke/RepairActivity;->getWindow()Landroid/view/Window;
    move-result-object v5
    const/16 v0, #16
    invoke-virtual {v5, v0}, Landroid/view/Window;->setSoftInputMode(I)V
    new-instance v5, Landroid/widget/FrameLayout;
    invoke-direct {v5, v4}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V
    const v0, #-16052460
    invoke-virtual {v5, v0}, Landroid/widget/FrameLayout;->setBackgroundColor(I)V
    new-instance v1, Landroid/webkit/WebView;
    invoke-direct {v1, v4}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V
    iput-object v1, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v1}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;
    move-result-object v1
    const/4 v2, #1
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V
    const/4 v3, #0
    invoke-virtual {v1, v3}, Landroid/webkit/WebSettings;->setMixedContentMode(I)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V
    invoke-virtual {v1, v3}, Landroid/webkit/WebSettings;->setMediaPlaybackRequiresUserGesture(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setDatabaseEnabled(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setSupportZoom(Z)V
    invoke-virtual {v1, v3}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setAllowContentAccess(Z)V
    invoke-virtual {v1, v2}, Landroid/webkit/WebSettings;->setJavaScriptCanOpenWindowsAutomatically(Z)V
    iget-object v1, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->setFocusable(Z)V
    iget-object v1, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->setFocusableInTouchMode(Z)V
    iget-object v1, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->setClickable(Z)V
    iget-object v1, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v1}, Landroid/webkit/WebView;->requestFocus()Z
    iget-object v1, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v1, v0}, Landroid/webkit/WebView;->setBackgroundColor(I)V
    iget-object v0, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    new-instance v1, Lcom/palai/prootsmoke/RepairActivity$1;
    invoke-direct {v1, v4}, Lcom/palai/prootsmoke/RepairActivity$1;-><init>(Lcom/palai/prootsmoke/RepairActivity;)V
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebChromeClient(Landroid/webkit/WebChromeClient;)V
    iget-object v0, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    new-instance v1, Lcom/palai/prootsmoke/RepairActivity$2;
    invoke-direct {v1, v4}, Lcom/palai/prootsmoke/RepairActivity$2;-><init>(Lcom/palai/prootsmoke/RepairActivity;)V
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V
    iget-object v0, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    new-instance v1, Lcom/palai/prootsmoke/RepairActivity$3;
    invoke-direct {v1, v4}, Lcom/palai/prootsmoke/RepairActivity$3;-><init>(Lcom/palai/prootsmoke/RepairActivity;)V
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V
    iget-object v0, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    new-instance v1, Landroid/widget/FrameLayout$LayoutParams;
    const/4 v2, #-1
    invoke-direct {v1, v2, v2}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V
    invoke-virtual {v5, v0, v1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    new-instance v0, Landroid/widget/LinearLayout;
    invoke-direct {v0, v4}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V
    invoke-virtual {v0, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V
    new-instance v1, Landroid/widget/FrameLayout$LayoutParams;
    const/4 v2, #-2
    invoke-direct {v1, v2, v2}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V
    const/16 v2, #51
    iput v2, v1, Landroid/widget/FrameLayout$LayoutParams;->gravity:I
    const/16 v2, #40
    iput v2, v1, Landroid/widget/FrameLayout$LayoutParams;->topMargin:I
    const/16 v2, #20
    iput v2, v1, Landroid/widget/FrameLayout$LayoutParams;->leftMargin:I
    new-instance v2, Landroid/widget/Button;
    invoke-direct {v2, v4}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V
    const-string v3, "‹ 返回"
    invoke-virtual {v2, v3}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V
    const v3, #1058642330
    invoke-virtual {v2, v3}, Landroid/widget/Button;->setAlpha(F)V
    new-instance v3, Lcom/palai/prootsmoke/RepairActivity$4;
    invoke-direct {v3, v4}, Lcom/palai/prootsmoke/RepairActivity$4;-><init>(Lcom/palai/prootsmoke/RepairActivity;)V
    invoke-virtual {v2, v3}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V
    invoke-virtual {v5, v0, v1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    invoke-virtual {v4, v5}, Lcom/palai/prootsmoke/RepairActivity;->setContentView(Landroid/view/View;)V
    iget-object v5, v4, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    const-string v0, "http://127.0.0.1:7797/repair"
    invoke-virtual {v5, v0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    const-string v5, "[REPAIRACT] loadUrl -> http://127.0.0.1:7797/repair"
    invoke-static {v5}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x4
.method protected Lcom/palai/prootsmoke/RepairActivity;->onDestroy()V
    # registers=4 ins=1 tries=2
    const/4 v0, #0
    iget-object v1, v3, Lcom/palai/prootsmoke/RepairActivity;->imeHandler:Landroid/os/Handler;
    if-eqz v1, :L8
    invoke-virtual {v1, v0}, Landroid/os/Handler;->removeCallbacksAndMessages(Ljava/lang/Object;)V
    :L8
    iget-object v1, v3, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    if-eqz v1, :L24
    const-string v2, "about:blank"
    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    iget-object v1, v3, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    invoke-virtual {v1}, Landroid/webkit/WebView;->destroy()V
    iput-object v0, v3, Lcom/palai/prootsmoke/RepairActivity;->web:Landroid/webkit/WebView;
    :L24
    invoke-super {v3}, Landroid/app/Activity;->onDestroy()V
    return-void 
.end method

