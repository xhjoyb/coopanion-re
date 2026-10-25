.class Lcom/palai/prootsmoke/PetWindowService$2;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;
.field final synthetic val$type:I

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$2;-><init>(Lcom/palai/prootsmoke/PetWindowService;I)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$2;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    iput v2, v0, Lcom/palai/prootsmoke/PetWindowService$2;->val$type:I
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$2;->run()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$2;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    iget v1, v2, Lcom/palai/prootsmoke/PetWindowService$2;->val$type:I
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mbuildAndAttachLayers(Lcom/palai/prootsmoke/PetWindowService;I)V
    return-void 
.end method

