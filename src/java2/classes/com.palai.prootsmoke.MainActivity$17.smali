.class Lcom/palai/prootsmoke/MainActivity$17;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$17;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$17;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$17;->run()V
    # registers=4 ins=1 tries=0
    const/16 v0, #17788
    const v1, #60000
    const-string v2, "127.0.0.1"
    invoke-static {v2, v0, v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$smwaitPortOpen(Ljava/lang/String;II)Z
    move-result v0
    if-nez v0, :L21
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$17;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v1, "[3] Web UI 端口超时未就绪"
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    return-void 
    :L21
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$17;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v1, Lcom/palai/prootsmoke/MainActivity$17$1;
    invoke-direct {v1, v3}, Lcom/palai/prootsmoke/MainActivity$17$1;-><init>(Lcom/palai/prootsmoke/MainActivity$17;)V
    invoke-virtual {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    return-void 
.end method

