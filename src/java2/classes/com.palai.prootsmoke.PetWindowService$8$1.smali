.class Lcom/palai/prootsmoke/PetWindowService$8$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/PetWindowService$8;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$8$1;-><init>(Lcom/palai/prootsmoke/PetWindowService$8;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$8$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$8;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$8$1;->onClearLocal()V
    # registers=3 ins=1 tries=1
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$8$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$8;
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService$8;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetimeProxy(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/EditText;
    move-result-object v0
    const-string v1, ""
    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$8$1;->onCommit(Ljava/lang/String;)V
    # registers=3 ins=2 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$8$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$8;
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService$8;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0, v2}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mpushTextToPage(Lcom/palai/prootsmoke/PetWindowService;Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$8$1;->onDelete()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$8$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$8;
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService$8;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    const-string v1, "Backspace"
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mpushKeyToPage(Lcom/palai/prootsmoke/PetWindowService;Ljava/lang/String;)V
    return-void 
.end method

