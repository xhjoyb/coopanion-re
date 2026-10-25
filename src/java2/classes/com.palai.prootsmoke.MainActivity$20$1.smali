.class Lcom/palai/prootsmoke/MainActivity$20$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/MainActivity$20;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$20$1;-><init>(Lcom/palai/prootsmoke/MainActivity$20;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1041
.method public bridge synthetic Lcom/palai/prootsmoke/MainActivity$20$1;->onReceiveValue(Ljava/lang/Object;)V
    # registers=2 ins=2 tries=0
    check-cast v1, Ljava/lang/String;
    invoke-virtual {v0, v1}, Lcom/palai/prootsmoke/MainActivity$20$1;->onReceiveValue(Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$20$1;->onReceiveValue(Ljava/lang/String;)V
    # registers=6 ins=2 tries=0
    const-string v0, ""
    if-nez v5, :L5
    goto :L15
    :L5
    const-string v1, """
    invoke-virtual {v5, v1, v0}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;
    move-result-object v5
    invoke-virtual {v5}, Ljava/lang/String;->trim()Ljava/lang/String;
    move-result-object v0
    :L15
    const-string v5, "ok"
    invoke-virtual {v5, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v5
    const-string v1, ")"
    if-eqz v5, :L58
    iget-object v5, v4, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget-object v5, v5, Lcom/palai/prootsmoke/MainActivity$20;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v2, "[PET] OK rendered (attempt "
    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget-object v2, v4, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget v2, v2, Lcom/palai/prootsmoke/MainActivity$20;->val$attempt:I
    add-int/lit8 v2, v2, #1
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static {v5, v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    return-void 
    :L58
    iget-object v5, v4, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget-object v5, v5, Lcom/palai/prootsmoke/MainActivity$20;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v2, Ljava/lang/StringBuilder;
    const-string v3, "[PET] FAIL attempt "
    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget-object v3, v4, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget v3, v3, Lcom/palai/prootsmoke/MainActivity$20;->val$attempt:I
    add-int/lit8 v3, v3, #1
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v2
    const-string v3, " ("
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static {v5, v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    iget-object v5, v4, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget v5, v5, Lcom/palai/prootsmoke/MainActivity$20;->val$attempt:I
    add-int/lit8 v5, v5, #1
    const/16 v0, #20
    if-ge v5, v0, :L130
    new-instance v5, Landroid/os/Handler;
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;
    move-result-object v0
    invoke-direct {v5, v0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
    new-instance v0, Lcom/palai/prootsmoke/MainActivity$20$1$1;
    invoke-direct {v0, v4}, Lcom/palai/prootsmoke/MainActivity$20$1$1;-><init>(Lcom/palai/prootsmoke/MainActivity$20$1;)V
    const-wide/16 v1, #1500
    invoke-virtual {v5, v0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    goto :L151
    :L130
    iget-object v5, v4, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget-object v5, v5, Lcom/palai/prootsmoke/MainActivity$20;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v0, "[PET] retry limit reached, stop"
    invoke-static {v5, v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    iget-object v5, v4, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget-object v5, v5, Lcom/palai/prootsmoke/MainActivity$20;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v0, Lcom/palai/prootsmoke/MainActivity$20$1$2;
    invoke-direct {v0, v4}, Lcom/palai/prootsmoke/MainActivity$20$1$2;-><init>(Lcom/palai/prootsmoke/MainActivity$20$1;)V
    invoke-virtual {v5, v0}, Lcom/palai/prootsmoke/MainActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    :L151
    return-void 
.end method

