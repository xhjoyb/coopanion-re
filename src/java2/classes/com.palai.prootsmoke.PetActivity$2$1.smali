.class Lcom/palai/prootsmoke/PetActivity$2$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/PetActivity$2;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetActivity$2$1;-><init>(Lcom/palai/prootsmoke/PetActivity$2;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetActivity$2$1;->this$1:Lcom/palai/prootsmoke/PetActivity$2;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1041
.method public bridge synthetic Lcom/palai/prootsmoke/PetActivity$2$1;->onReceiveValue(Ljava/lang/Object;)V
    # registers=2 ins=2 tries=0
    check-cast v1, Ljava/lang/String;
    invoke-virtual {v0, v1}, Lcom/palai/prootsmoke/PetActivity$2$1;->onReceiveValue(Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$2$1;->onReceiveValue(Ljava/lang/String;)V
    # registers=4 ins=2 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[PETACT] probe -> "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-static {v3}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    return-void 
.end method

