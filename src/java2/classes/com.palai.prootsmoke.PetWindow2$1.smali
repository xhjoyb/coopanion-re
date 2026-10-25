.class Lcom/palai/prootsmoke/PetWindow2$1;
.super Ljava/lang/Object;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindow2$1;-><init>()V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindow2$1;->run()V
    # registers=4 ins=1 tries=1
    invoke-static {}, Lcom/palai/prootsmoke/PetWindow2;->access$000()V
    goto :L29
    move-exception v0
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "tick: "
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    const-string v1, "PetWin2"
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :L29
    invoke-static {}, Lcom/palai/prootsmoke/PetWindow2;->access$100()Landroid/os/Handler;
    move-result-object v0
    const-wide/16 v1, #120
    invoke-virtual {v0, v3, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    return-void 
.end method

