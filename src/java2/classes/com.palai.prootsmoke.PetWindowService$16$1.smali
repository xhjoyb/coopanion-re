.class Lcom/palai/prootsmoke/PetWindowService$16$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/PetWindowService$16;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$16$1;-><init>(Lcom/palai/prootsmoke/PetWindowService$16;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$16$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$16;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$16$1;->run()V
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$16$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$16;
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mfocusImeAndShow(Lcom/palai/prootsmoke/PetWindowService;)V
    return-void 
.end method

