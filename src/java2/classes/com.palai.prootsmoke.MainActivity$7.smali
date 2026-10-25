.class Lcom/palai/prootsmoke/MainActivity$7;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$7;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$7;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$7;->onClick(Landroid/view/View;)V
    # registers=3 ins=2 tries=0
    iget-object v2, v1, Lcom/palai/prootsmoke/MainActivity$7;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v2
    if-nez v2, :L9
    return-void 
    :L9
    iget-object v2, v1, Lcom/palai/prootsmoke/MainActivity$7;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v2
    const-string v0, "http://127.0.0.1:17788/"
    invoke-virtual {v2, v0}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    iget-object v2, v1, Lcom/palai/prootsmoke/MainActivity$7;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v0, "[PET] 切回控制台 -> http://127.0.0.1:17788/"
    invoke-static {v2, v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    return-void 
.end method

