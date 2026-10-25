.class Lcom/palai/prootsmoke/WebRetry$1;
.super Ljava/lang/Object;

.field final synthetic val$web:Landroid/webkit/WebView;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/WebRetry$1;-><init>(Landroid/webkit/WebView;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/WebRetry$1;->val$web:Landroid/webkit/WebView;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/WebRetry$1;->run()V
    # registers=4 ins=1 tries=1
    iget-object v0, v3, Lcom/palai/prootsmoke/WebRetry$1;->val$web:Landroid/webkit/WebView;
    invoke-virtual {v0}, Landroid/webkit/WebView;->reload()V
    goto :L31
    move-exception v0
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "reload: "
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    const-string v1, "PetWebRetry"
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :L31
    return-void 
.end method

