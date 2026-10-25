.class Lcom/palai/prootsmoke/MainActivity$2;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;
.field final synthetic val$s:Ljava/lang/String;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$2;-><init>(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$2;->this$0:Lcom/palai/prootsmoke/MainActivity;
    iput-object v2, v0, Lcom/palai/prootsmoke/MainActivity$2;->val$s:Ljava/lang/String;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$2;->run()V
    # registers=4 ins=1 tries=0
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$2;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgettv(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/TextView;
    move-result-object v0
    if-eqz v0, :L60
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$2;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgettv(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/TextView;
    move-result-object v0
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    iget-object v2, v3, Lcom/palai/prootsmoke/MainActivity$2;->val$s:Ljava/lang/String;
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    const-string v2, "
"
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->append(Ljava/lang/CharSequence;)V
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$2;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetlogScroll(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/ScrollView;
    move-result-object v0
    if-eqz v0, :L60
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$2;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetlogScroll(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/ScrollView;
    move-result-object v0
    new-instance v1, Lcom/palai/prootsmoke/MainActivity$2$1;
    invoke-direct {v1, v3}, Lcom/palai/prootsmoke/MainActivity$2$1;-><init>(Lcom/palai/prootsmoke/MainActivity$2;)V
    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->post(Ljava/lang/Runnable;)Z
    :L60
    return-void 
.end method

