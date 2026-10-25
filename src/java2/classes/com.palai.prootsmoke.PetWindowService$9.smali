.class Lcom/palai/prootsmoke/PetWindowService$9;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$9;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$9;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$9;->afterTextChanged(Landroid/text/Editable;)V
    # registers=3 ins=2 tries=1
    invoke-interface {v2}, Landroid/text/Editable;->length()I
    move-result v0
    if-nez v0, :L7
    return-void 
    :L7
    invoke-static {v2}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$sm_isComposing(Landroid/text/Editable;)Z
    move-result v0
    if-eqz v0, :L14
    return-void 
    :L14
    invoke-interface {v2}, Landroid/text/Editable;->clear()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$9;->beforeTextChanged(Ljava/lang/CharSequence;III)V
    # registers=5 ins=5 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$9;->onTextChanged(Ljava/lang/CharSequence;III)V
    # registers=5 ins=5 tries=0
    return-void 
.end method

