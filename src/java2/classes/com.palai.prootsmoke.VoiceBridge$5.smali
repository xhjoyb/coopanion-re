.class Lcom/palai/prootsmoke/VoiceBridge$5;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/VoiceBridge;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/VoiceBridge$5;-><init>(Lcom/palai/prootsmoke/VoiceBridge;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/VoiceBridge$5;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$5;->onBeginningOfSpeech()V
    # registers=5 ins=1 tries=0
    iget-object v0, v4, Lcom/palai/prootsmoke/VoiceBridge$5;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    const-string v1, ""
    const-string v2, "speech"
    const-string v3, "level"
    invoke-static {v0, v3, v1, v2}, Lcom/palai/prootsmoke/VoiceBridge;->access$500(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$5;->onBufferReceived([B)V
    # registers=2 ins=2 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$5;->onEndOfSpeech()V
    # registers=5 ins=1 tries=0
    iget-object v0, v4, Lcom/palai/prootsmoke/VoiceBridge$5;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    const-string v1, ""
    const-string v2, "end"
    const-string v3, "level"
    invoke-static {v0, v3, v1, v2}, Lcom/palai/prootsmoke/VoiceBridge;->access$500(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$5;->onError(I)V
    # registers=5 ins=2 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    const-string v1, "onError "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    const-string v1, "PetVoice"
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    iget-object v0, v3, Lcom/palai/prootsmoke/VoiceBridge$5;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v0}, Lcom/palai/prootsmoke/VoiceBridge;->access$300(Lcom/palai/prootsmoke/VoiceBridge;)Z
    move-result v1
    if-eqz v1, :L38
    const/4 v1, #7
    if-ne v4, v1, :L38
    const-string v1, "empty"
    goto :L40
    :L38
    const-string v1, "error"
    :L40
    const-string v2, ""
    invoke-static {v4}, Lcom/palai/prootsmoke/VoiceBridge;->access$600(I)Ljava/lang/String;
    move-result-object v4
    invoke-static {v0, v1, v2, v4}, Lcom/palai/prootsmoke/VoiceBridge;->access$500(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$5;->onEvent(ILandroid/os/Bundle;)V
    # registers=3 ins=3 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$5;->onPartialResults(Landroid/os/Bundle;)V
    # registers=5 ins=2 tries=0
    invoke-static {v4}, Lcom/palai/prootsmoke/VoiceBridge;->access$700(Landroid/os/Bundle;)Ljava/lang/String;
    move-result-object v4
    if-eqz v4, :L21
    invoke-virtual {v4}, Ljava/lang/String;->length()I
    move-result v0
    if-lez v0, :L21
    iget-object v0, v3, Lcom/palai/prootsmoke/VoiceBridge$5;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    const-string v1, "partial"
    const-string v2, ""
    invoke-static {v0, v1, v4, v2}, Lcom/palai/prootsmoke/VoiceBridge;->access$500(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :L21
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$5;->onReadyForSpeech(Landroid/os/Bundle;)V
    # registers=5 ins=2 tries=0
    iget-object v4, v3, Lcom/palai/prootsmoke/VoiceBridge$5;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    const-string v0, ""
    const-string v1, "ready"
    const-string v2, "level"
    invoke-static {v4, v2, v0, v1}, Lcom/palai/prootsmoke/VoiceBridge;->access$500(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$5;->onResults(Landroid/os/Bundle;)V
    # registers=5 ins=2 tries=0
    iget-object v0, v3, Lcom/palai/prootsmoke/VoiceBridge$5;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v4}, Lcom/palai/prootsmoke/VoiceBridge;->access$700(Landroid/os/Bundle;)Ljava/lang/String;
    move-result-object v4
    const-string v1, ""
    const-string v2, "final"
    invoke-static {v0, v2, v4, v1}, Lcom/palai/prootsmoke/VoiceBridge;->access$500(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$5;->onRmsChanged(F)V
    # registers=5 ins=2 tries=0
    iget-object v0, v3, Lcom/palai/prootsmoke/VoiceBridge$5;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    float-to-int v4, v4
    invoke-static {v4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;
    move-result-object v4
    const-string v1, "rms"
    const-string v2, ""
    invoke-static {v0, v1, v2, v4}, Lcom/palai/prootsmoke/VoiceBridge;->access$500(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    return-void 
.end method

