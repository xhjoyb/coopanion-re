.class Lcom/palai/prootsmoke/PetWindowService$17;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;
.field final synthetic val$fh:I
.field final synthetic val$fw:I
.field final synthetic val$fx:I
.field final synthetic val$fy:I

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$17;-><init>(Lcom/palai/prootsmoke/PetWindowService;IIII)V
    # registers=6 ins=6 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$17;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    iput v2, v0, Lcom/palai/prootsmoke/PetWindowService$17;->val$fx:I
    iput v3, v0, Lcom/palai/prootsmoke/PetWindowService$17;->val$fy:I
    iput v4, v0, Lcom/palai/prootsmoke/PetWindowService$17;->val$fw:I
    iput v5, v0, Lcom/palai/prootsmoke/PetWindowService$17;->val$fh:I
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$17;->run()V
    # registers=4 ins=1 tries=1
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$17;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v0
    iget v1, v3, Lcom/palai/prootsmoke/PetWindowService$17;->val$fx:I
    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->x:I
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$17;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v0
    iget v1, v3, Lcom/palai/prootsmoke/PetWindowService$17;->val$fy:I
    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->y:I
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$17;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v0
    iget v1, v3, Lcom/palai/prootsmoke/PetWindowService$17;->val$fw:I
    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->width:I
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$17;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v0
    iget v1, v3, Lcom/palai/prootsmoke/PetWindowService$17;->val$fh:I
    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->height:I
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$17;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetwm(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager;
    move-result-object v0
    iget-object v1, v3, Lcom/palai/prootsmoke/PetWindowService$17;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v1
    iget-object v2, v3, Lcom/palai/prootsmoke/PetWindowService$17;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v2}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v2
    invoke-interface {v0, v1, v2}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    return-void 
.end method

