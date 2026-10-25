.class Lcom/palai/prootsmoke/VoiceBridge$3;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/VoiceBridge;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/VoiceBridge$3;-><init>(Lcom/palai/prootsmoke/VoiceBridge;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/VoiceBridge$3;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$3;->run()V
    # registers=4 ins=1 tries=1
    iget-object v0, v3, Lcom/palai/prootsmoke/VoiceBridge$3;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v0}, Lcom/palai/prootsmoke/VoiceBridge;->access$100(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/speech/SpeechRecognizer;
    move-result-object v0
    if-eqz v0, :L43
    iget-object v0, v3, Lcom/palai/prootsmoke/VoiceBridge$3;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v0}, Lcom/palai/prootsmoke/VoiceBridge;->access$100(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/speech/SpeechRecognizer;
    move-result-object v0
    invoke-virtual {v0}, Landroid/speech/SpeechRecognizer;->stopListening()V
    goto :L43
    move-exception v0
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "stop: "
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    const-string v1, "PetVoice"
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :L43
    return-void 
.end method

