.class public final Lcom/palai/prootsmoke/PetWindow2$Bridge;
.super Ljava/lang/Object;

# direct access=0x10001
.method public constructor Lcom/palai/prootsmoke/PetWindow2$Bridge;-><init>()V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindow2$Bridge;->log(Ljava/lang/String;)V
    # registers=4 ins=2 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    const-string v1, "page: "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    const-string v0, "PetWin2"
    invoke-static {v0, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindow2$Bridge;->rect(FFFF)V
    # registers=5 ins=5 tries=0
    invoke-static {v1}, Ljava/lang/Math;->round(F)I
    move-result v1
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindow2;->access$302(I)I
    invoke-static {v2}, Ljava/lang/Math;->round(F)I
    move-result v1
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindow2;->access$402(I)I
    invoke-static {v3}, Ljava/lang/Math;->round(F)I
    move-result v1
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindow2;->access$502(I)I
    invoke-static {v4}, Ljava/lang/Math;->round(F)I
    move-result v1
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindow2;->access$602(I)I
    return-void 
.end method

