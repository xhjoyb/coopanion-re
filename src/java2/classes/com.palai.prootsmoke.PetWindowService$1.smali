.class Lcom/palai/prootsmoke/PetWindowService$1;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;
.field final synthetic val$a:F

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$1;-><init>(Lcom/palai/prootsmoke/PetWindowService;F)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$1;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    iput v2, v0, Lcom/palai/prootsmoke/PetWindowService$1;->val$a:F
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$1;->run()V
    # registers=5 ins=1 tries=1
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$1;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    iget v1, v4, Lcom/palai/prootsmoke/PetWindowService$1;->val$a:F
    const/4 v2, #0
    cmpg-float v3, v1, v2
    if-gez v3, :L11
    :L9
    move v1, v2
    goto :L18
    :L11
    const/high16 v2, #int 0x3f800000
    cmpl-float v3, v1, v2
    if-lez v3, :L18
    goto :L9
    :L18
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fputpetAlpha(Lcom/palai/prootsmoke/PetWindowService;F)V
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$1;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v0
    if-eqz v0, :L72
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$1;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v0
    if-eqz v0, :L72
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$1;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v0
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService$1;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetpetAlpha(Lcom/palai/prootsmoke/PetWindowService;)F
    move-result v1
    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->alpha:F
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$1;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetwm(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager;
    move-result-object v0
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService$1;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v1
    iget-object v2, v4, Lcom/palai/prootsmoke/PetWindowService$1;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v2}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v2
    invoke-interface {v0, v1, v2}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :L72
    return-void 
.end method

