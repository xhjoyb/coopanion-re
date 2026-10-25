.class Lcom/palai/prootsmoke/PetWindowService$10;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$10;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$10;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$10;->onKey(Landroid/view/View;ILandroid/view/KeyEvent;)Z
    # registers=4 ins=4 tries=0
    invoke-virtual {v3}, Landroid/view/KeyEvent;->getAction()I
    move-result v1
    if-nez v1, :L19
    const/16 v1, #67
    if-ne v2, v1, :L19
    iget-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$10;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    const-string v2, "Backspace"
    invoke-static {v1, v2}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mpushKeyToPage(Lcom/palai/prootsmoke/PetWindowService;Ljava/lang/String;)V
    const/4 v1, #1
    return v1
    :L19
    const/4 v1, #0
    return v1
.end method

