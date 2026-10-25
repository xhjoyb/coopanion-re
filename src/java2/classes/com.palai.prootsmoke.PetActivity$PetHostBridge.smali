.class public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;
.super Ljava/lang/Object;

# direct access=0x10001
.method public constructor Lcom/palai/prootsmoke/PetActivity$PetHostBridge;-><init>()V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;->focus()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;->grabFocus()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;->hide()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;->jsw(Ljava/lang/String;)V
    # registers=4 ins=2 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[JS] "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-static {v3}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;->onCursor()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;->openDress()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;->releaseFocus()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;->reportPetRect(IIII)V
    # registers=5 ins=5 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;->sampleBackdrop()Ljava/lang/String;
    # registers=2 ins=1 tries=0
    const/4 v0, #0
    return-object v0
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$PetHostBridge;->setInteractive(Z)V
    # registers=2 ins=2 tries=0
    return-void 
.end method

