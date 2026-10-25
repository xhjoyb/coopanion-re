.class Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$2;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$2;-><init>(Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$2;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$2;->run()V
    # registers=3 ins=1 tries=2
    const/16 v0, #8
    iget-object v1, v2, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$2;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v1, v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v1
    if-eqz v1, :L23
    iget-object v1, v2, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$2;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v1, v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetshowBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v1
    invoke-virtual {v1, v0}, Landroid/widget/FrameLayout;->setVisibility(I)V
    :L23
    iget-object v1, v2, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$2;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v1, v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v1
    if-eqz v1, :L44
    iget-object v1, v2, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$2;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iget-object v1, v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v1
    invoke-virtual {v1, v0}, Landroid/widget/FrameLayout;->setVisibility(I)V
    :L44
    return-void 
.end method

