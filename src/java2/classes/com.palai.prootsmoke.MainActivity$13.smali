.class Lcom/palai/prootsmoke/MainActivity$13;
.super Landroid/webkit/WebChromeClient;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$13;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$13;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Landroid/webkit/WebChromeClient;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$13;->onPermissionRequest(Landroid/webkit/PermissionRequest;)V
    # registers=8 ins=2 tries=0
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
    if-eqz v3, :L43
    iget-object v0, v6, Lcom/palai/prootsmoke/MainActivity$13;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v1, "[MIC] WebView 请求麦克风 -> 已放行"
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    iget-object v0, v6, Lcom/palai/prootsmoke/MainActivity$13;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v1, Lcom/palai/prootsmoke/MainActivity$13$1;
    invoke-direct {v1, v6, v7}, Lcom/palai/prootsmoke/MainActivity$13$1;-><init>(Lcom/palai/prootsmoke/MainActivity$13;Landroid/webkit/PermissionRequest;)V
    invoke-virtual {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    goto :L53
    :L43
    iget-object v0, v6, Lcom/palai/prootsmoke/MainActivity$13;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v1, Lcom/palai/prootsmoke/MainActivity$13$2;
    invoke-direct {v1, v6, v7}, Lcom/palai/prootsmoke/MainActivity$13$2;-><init>(Lcom/palai/prootsmoke/MainActivity$13;Landroid/webkit/PermissionRequest;)V
    invoke-virtual {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    :L53
    return-void 
.end method

