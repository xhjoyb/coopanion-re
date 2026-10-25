.class Lcom/palai/prootsmoke/MainActivity$5;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$5;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$5;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$5;->onClick(Landroid/view/View;)V
    # registers=3 ins=2 tries=0
    iget-object v2, v1, Lcom/palai/prootsmoke/MainActivity$5;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v2
    if-nez v2, :L9
    return-void 
    :L9
    iget-object v2, v1, Lcom/palai/prootsmoke/MainActivity$5;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const/4 v0, #0
    invoke-static {v2, v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fputpetRetry(Lcom/palai/prootsmoke/MainActivity;I)V
    iget-object v2, v1, Lcom/palai/prootsmoke/MainActivity$5;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v2, v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mloadPetWithRetry(Lcom/palai/prootsmoke/MainActivity;I)V
    return-void 
.end method

