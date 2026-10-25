.class Lcom/palai/prootsmoke/MainActivity$17$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/MainActivity$17;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$17$1;-><init>(Lcom/palai/prootsmoke/MainActivity$17;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$17$1;->this$1:Lcom/palai/prootsmoke/MainActivity$17;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$17$1;->run()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$17$1;->this$1:Lcom/palai/prootsmoke/MainActivity$17;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$17;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v1, "[3] Web UI load (once) -> http://127.0.0.1:17788/"
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$17$1;->this$1:Lcom/palai/prootsmoke/MainActivity$17;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$17;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v0
    const-string v1, "http://127.0.0.1:17788/"
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    return-void 
.end method

