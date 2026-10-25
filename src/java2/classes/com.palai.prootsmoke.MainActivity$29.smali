.class Lcom/palai/prootsmoke/MainActivity$29;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$29;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$29;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$29;->onClick(Landroid/content/DialogInterface;I)V
    # registers=3 ins=3 tries=0
    iget-object v1, v0, Lcom/palai/prootsmoke/MainActivity$29;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v1
    if-eqz v1, :L26
    iget-object v1, v0, Lcom/palai/prootsmoke/MainActivity$29;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v1
    const-string v2, "http://127.0.0.1:17788/"
    invoke-virtual {v1, v2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    iget-object v1, v0, Lcom/palai/prootsmoke/MainActivity$29;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v2, "[GUIDE] 切到控制台"
    invoke-static {v1, v2}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    :L26
    return-void 
.end method

