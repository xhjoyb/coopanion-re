.class Lcom/palai/prootsmoke/PetActivity$1;
.super Landroid/webkit/WebChromeClient;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetActivity$1;-><init>(Lcom/palai/prootsmoke/PetActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetActivity$1;->this$0:Lcom/palai/prootsmoke/PetActivity;
    invoke-direct {v0}, Landroid/webkit/WebChromeClient;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$1;->onPermissionRequest(Landroid/webkit/PermissionRequest;)V
    # registers=8 ins=2 tries=1
    invoke-virtual {v7}, Landroid/webkit/PermissionRequest;->getResources()[Ljava/lang/String;
    move-result-object v0
    array-length v1, v0
    const/4 v2, #0
    move v3, v2
    :L7
    if-ge v2, v1, :L23
    aget-object v4, v0, v2
    const-string v5, "android.webkit.resource.AUDIO_CAPTURE"
    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v4
    if-eqz v4, :L20
    const/4 v3, #1
    :L20
    add-int/lit8 v2, v2, #1
    goto :L7
    :L23
    if-eqz v3, :L38
    const-string v0, "[PETACT][MIC] WebView 请求麦克风 -> 已放行"
    invoke-static {v0}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    invoke-virtual {v7}, Landroid/webkit/PermissionRequest;->getResources()[Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v7, v0}, Landroid/webkit/PermissionRequest;->grant([Ljava/lang/String;)V
    goto :L61
    :L38
    invoke-virtual {v7}, Landroid/webkit/PermissionRequest;->deny()V
    goto :L61
    move-exception v7
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[PETACT][MIC] onPermissionRequest err: "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v7
    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v7
    invoke-static {v7}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    :L61
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$1;->onShowFileChooser(Landroid/webkit/WebView;Landroid/webkit/ValueCallback;Landroid/webkit/WebChromeClient$FileChooserParams;)Z
    # registers=5 ins=4 tries=2
    const-string v2, "[PETACT][FILE] onShowFileChooser"
    invoke-static {v2}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    iget-object v2, v1, Lcom/palai/prootsmoke/PetActivity$1;->this$0:Lcom/palai/prootsmoke/PetActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/PetActivity;->-$$Nest$fgetfilePathCallback(Lcom/palai/prootsmoke/PetActivity;)Landroid/webkit/ValueCallback;
    move-result-object v2
    const/4 v4, #0
    if-eqz v2, :L23
    iget-object v2, v1, Lcom/palai/prootsmoke/PetActivity$1;->this$0:Lcom/palai/prootsmoke/PetActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/PetActivity;->-$$Nest$fgetfilePathCallback(Lcom/palai/prootsmoke/PetActivity;)Landroid/webkit/ValueCallback;
    move-result-object v2
    invoke-interface {v2, v4}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V
    :L23
    iget-object v2, v1, Lcom/palai/prootsmoke/PetActivity$1;->this$0:Lcom/palai/prootsmoke/PetActivity;
    invoke-static {v2, v3}, Lcom/palai/prootsmoke/PetActivity;->-$$Nest$fputfilePathCallback(Lcom/palai/prootsmoke/PetActivity;Landroid/webkit/ValueCallback;)V
    new-instance v2, Landroid/content/Intent;
    const-string v3, "android.intent.action.GET_CONTENT"
    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    const-string v3, "android.intent.category.OPENABLE"
    invoke-virtual {v2, v3}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;
    const-string v3, "image/*"
    invoke-virtual {v2, v3}, Landroid/content/Intent;->setType(Ljava/lang/String;)Landroid/content/Intent;
    iget-object v3, v1, Lcom/palai/prootsmoke/PetActivity$1;->this$0:Lcom/palai/prootsmoke/PetActivity;
    const-string v0, "select image"
    invoke-static {v2, v0}, Landroid/content/Intent;->createChooser(Landroid/content/Intent;Ljava/lang/CharSequence;)Landroid/content/Intent;
    move-result-object v2
    const/16 v0, #20819
    invoke-virtual {v3, v2, v0}, Lcom/palai/prootsmoke/PetActivity;->startActivityForResult(Landroid/content/Intent;I)V
    const/4 v2, #1
    return v2
    move-exception v2
    new-instance v3, Ljava/lang/StringBuilder;
    const-string v0, "[PETACT][FILE] err: "
    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    invoke-static {v2}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    iget-object v2, v1, Lcom/palai/prootsmoke/PetActivity$1;->this$0:Lcom/palai/prootsmoke/PetActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/PetActivity;->-$$Nest$fgetfilePathCallback(Lcom/palai/prootsmoke/PetActivity;)Landroid/webkit/ValueCallback;
    move-result-object v2
    if-eqz v2, :L101
    iget-object v2, v1, Lcom/palai/prootsmoke/PetActivity$1;->this$0:Lcom/palai/prootsmoke/PetActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/PetActivity;->-$$Nest$fgetfilePathCallback(Lcom/palai/prootsmoke/PetActivity;)Landroid/webkit/ValueCallback;
    move-result-object v2
    invoke-interface {v2, v4}, Landroid/webkit/ValueCallback;->onReceiveValue(Ljava/lang/Object;)V
    iget-object v2, v1, Lcom/palai/prootsmoke/PetActivity$1;->this$0:Lcom/palai/prootsmoke/PetActivity;
    invoke-static {v2, v4}, Lcom/palai/prootsmoke/PetActivity;->-$$Nest$fputfilePathCallback(Lcom/palai/prootsmoke/PetActivity;Landroid/webkit/ValueCallback;)V
    :L101
    const/4 v2, #0
    return v2
.end method

