.class Lcom/palai/prootsmoke/PetWindowService$8;
.super Landroid/widget/EditText;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$8;-><init>(Lcom/palai/prootsmoke/PetWindowService;Landroid/content/Context;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$8;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0, v2}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$8;->onCreateInputConnection(Landroid/view/inputmethod/EditorInfo;)Landroid/view/inputmethod/InputConnection;
    # registers=4 ins=2 tries=0
    invoke-super {v2, v3}, Landroid/widget/EditText;->onCreateInputConnection(Landroid/view/inputmethod/EditorInfo;)Landroid/view/inputmethod/InputConnection;
    move-result-object v3
    if-nez v3, :L8
    const/4 v3, #0
    return-object v3
    :L8
    new-instance v0, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$8$1;
    invoke-direct {v1, v2}, Lcom/palai/prootsmoke/PetWindowService$8$1;-><init>(Lcom/palai/prootsmoke/PetWindowService$8;)V
    invoke-direct {v0, v3, v1}, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;-><init>(Landroid/view/inputmethod/InputConnection;Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;)V
    return-object v0
.end method

