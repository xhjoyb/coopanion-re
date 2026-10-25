.class Lcom/palai/prootsmoke/MainActivity$10;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$10;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$10;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$10;->onClick(Landroid/view/View;)V
    # registers=5 ins=2 tries=0
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$10;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetlogScroll(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/ScrollView;
    move-result-object v0
    if-nez v0, :L9
    return-void 
    :L9
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$10;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetlogScroll(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/ScrollView;
    move-result-object v0
    invoke-virtual {v0}, Landroid/widget/ScrollView;->getVisibility()I
    move-result v0
    const/4 v1, #0
    if-eqz v0, :L24
    const/4 v0, #1
    goto :L25
    :L24
    move v0, v1
    :L25
    iget-object v2, v3, Lcom/palai/prootsmoke/MainActivity$10;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetlogScroll(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/ScrollView;
    move-result-object v2
    if-eqz v0, :L34
    goto :L36
    :L34
    const/16 v1, #8
    :L36
    invoke-virtual {v2, v1}, Landroid/widget/ScrollView;->setVisibility(I)V
    check-cast v4, Landroid/widget/Button;
    if-eqz v0, :L46
    const-string v0, "收起日志"
    goto :L48
    :L46
    const-string v0, "日志"
    :L48
    invoke-virtual {v4, v0}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V
    return-void 
.end method

