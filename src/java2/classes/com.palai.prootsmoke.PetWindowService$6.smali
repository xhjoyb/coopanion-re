.class Lcom/palai/prootsmoke/PetWindowService$6;
.super Landroid/webkit/WebChromeClient;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$6;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$6;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0}, Landroid/webkit/WebChromeClient;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$6;->onConsoleMessage(Landroid/webkit/ConsoleMessage;)Z
    # registers=4 ins=2 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[PET-JS] "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v3}, Landroid/webkit/ConsoleMessage;->message()Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    const-string v0, "PetWindow"
    invoke-static {v0, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    const/4 v3, #1
    return v3
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$6;->onPermissionRequest(Landroid/webkit/PermissionRequest;)V
    # registers=9 ins=2 tries=1
    const-string v0, "PetWindow"
    invoke-virtual {v8}, Landroid/webkit/PermissionRequest;->getResources()[Ljava/lang/String;
    move-result-object v1
    array-length v2, v1
    const/4 v3, #0
    move v4, v3
    :L9
    if-ge v3, v2, :L25
    aget-object v5, v1, v3
    const-string v6, "android.webkit.resource.AUDIO_CAPTURE"
    invoke-virtual {v6, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v5
    if-eqz v5, :L22
    const/4 v4, #1
    :L22
    add-int/lit8 v3, v3, #1
    goto :L9
    :L25
    if-eqz v4, :L40
    const-string v1, "[PET][MIC] WebView 请求麦克风 -> 已放行"
    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    invoke-virtual {v8}, Landroid/webkit/PermissionRequest;->getResources()[Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v8, v1}, Landroid/webkit/PermissionRequest;->grant([Ljava/lang/String;)V
    goto :L63
    :L40
    invoke-virtual {v8}, Landroid/webkit/PermissionRequest;->deny()V
    goto :L63
    move-exception v8
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "[PET][MIC] onPermissionRequest err: "
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v1, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v8
    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v8
    invoke-static {v0, v8}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :L63
    return-void 
.end method

