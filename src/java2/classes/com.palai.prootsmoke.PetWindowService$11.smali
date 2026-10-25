.class Lcom/palai/prootsmoke/PetWindowService$11;
.super Ljava/lang/Object;

.field loaded:Z
.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$11;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$11;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    const/4 v1, #0
    iput-boolean v1, v0, Lcom/palai/prootsmoke/PetWindowService$11;->loaded:Z
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$11;->onLayoutChange(Landroid/view/View;IIIIIIII)V
    # registers=10 ins=10 tries=0
    iget-boolean v1, v0, Lcom/palai/prootsmoke/PetWindowService$11;->loaded:Z
    if-eqz v1, :L5
    return-void 
    :L5
    sub-int/2addr v4, v2
    if-lez v4, :L31
    sub-int/2addr v5, v3
    if-gtz v5, :L12
    goto :L31
    :L12
    const/4 v1, #1
    iput-boolean v1, v0, Lcom/palai/prootsmoke/PetWindowService$11;->loaded:Z
    iget-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$11;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetui(Lcom/palai/prootsmoke/PetWindowService;)Landroid/os/Handler;
    move-result-object v1
    new-instance v2, Lcom/palai/prootsmoke/PetWindowService$11$1;
    invoke-direct {v2, v0}, Lcom/palai/prootsmoke/PetWindowService$11$1;-><init>(Lcom/palai/prootsmoke/PetWindowService$11;)V
    const-wide/16 v3, #32
    invoke-virtual {v1, v2, v3, v4}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    :L31
    return-void 
.end method

