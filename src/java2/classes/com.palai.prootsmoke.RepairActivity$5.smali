.class Lcom/palai/prootsmoke/RepairActivity$5;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/RepairActivity;
.field final synthetic val$v:Landroid/webkit/WebView;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/RepairActivity$5;-><init>(Lcom/palai/prootsmoke/RepairActivity;Landroid/webkit/WebView;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/RepairActivity$5;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    iput-object v2, v0, Lcom/palai/prootsmoke/RepairActivity$5;->val$v:Landroid/webkit/WebView;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/RepairActivity$5;->run()V
    # registers=4 ins=1 tries=1
    iget-object v0, v3, Lcom/palai/prootsmoke/RepairActivity$5;->val$v:Landroid/webkit/WebView;
    if-nez v0, :L5
    return-void 
    :L5
    const-string v1, "(window.__imeProbe?window.__imeProbe():0)"
    new-instance v2, Lcom/palai/prootsmoke/RepairActivity$5$1;
    invoke-direct {v2, v3}, Lcom/palai/prootsmoke/RepairActivity$5$1;-><init>(Lcom/palai/prootsmoke/RepairActivity$5;)V
    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    iget-object v0, v3, Lcom/palai/prootsmoke/RepairActivity$5;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fgetimeHandler(Lcom/palai/prootsmoke/RepairActivity;)Landroid/os/Handler;
    move-result-object v0
    if-eqz v0, :L34
    iget-object v0, v3, Lcom/palai/prootsmoke/RepairActivity$5;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fgetimeHandler(Lcom/palai/prootsmoke/RepairActivity;)Landroid/os/Handler;
    move-result-object v0
    const-wide/16 v1, #400
    invoke-virtual {v0, v3, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    :L34
    return-void 
.end method

