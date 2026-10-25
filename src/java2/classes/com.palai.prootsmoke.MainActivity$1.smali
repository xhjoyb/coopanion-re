.class Lcom/palai/prootsmoke/MainActivity$1;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;
.field final synthetic val$s:Ljava/lang/String;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$1;-><init>(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$1;->this$0:Lcom/palai/prootsmoke/MainActivity;
    iput-object v2, v0, Lcom/palai/prootsmoke/MainActivity$1;->val$s:Ljava/lang/String;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$1;->run()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$1;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetstatusTv(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/TextView;
    move-result-object v0
    if-eqz v0, :L19
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$1;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetstatusTv(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/TextView;
    move-result-object v0
    iget-object v1, v2, Lcom/palai/prootsmoke/MainActivity$1;->val$s:Ljava/lang/String;
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :L19
    return-void 
.end method

