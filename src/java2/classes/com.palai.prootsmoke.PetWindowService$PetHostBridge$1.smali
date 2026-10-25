.class Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
.field final synthetic val$a:F

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;-><init>(Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;F)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iput v2, v0, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->val$a:F
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->run()V
    # registers=5 ins=1 tries=1
    const-string v0, "[PET] setAlpha="
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v1, v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    iget v2, v4, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->val$a:F
    invoke-static {v1, v2}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fputpetAlpha(Lcom/palai/prootsmoke/PetWindowService;F)V
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v1, v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v1
    if-eqz v1, :L70
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v1, v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v1
    if-eqz v1, :L70
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v1, v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v1
    iget v2, v4, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->val$a:F
    iput v2, v1, Landroid/view/WindowManager$LayoutParams;->alpha:F
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v1, v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetwm(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager;
    move-result-object v1
    iget-object v2, v4, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v2, v2, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v2}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v2
    iget-object v3, v4, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v3, v3, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v3}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v3
    invoke-interface {v1, v2, v3}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :L70
    const-string v1, "PetWindow"
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget v0, v4, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;->val$a:F
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    return-void 
.end method

