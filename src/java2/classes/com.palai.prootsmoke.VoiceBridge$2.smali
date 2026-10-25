.class Lcom/palai/prootsmoke/VoiceBridge$2;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/VoiceBridge;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/VoiceBridge$2;-><init>(Lcom/palai/prootsmoke/VoiceBridge;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/VoiceBridge$2;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$2;->run()V
    # registers=5 ins=1 tries=1
    const-string v0, ""
    iget-object v1, v4, Lcom/palai/prootsmoke/VoiceBridge$2;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v1}, Lcom/palai/prootsmoke/VoiceBridge;->access$100(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/speech/SpeechRecognizer;
    move-result-object v1
    if-nez v1, :L19
    iget-object v1, v4, Lcom/palai/prootsmoke/VoiceBridge$2;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v1}, Lcom/palai/prootsmoke/VoiceBridge;->access$200(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/speech/SpeechRecognizer;
    move-result-object v2
    invoke-static {v1, v2}, Lcom/palai/prootsmoke/VoiceBridge;->access$102(Lcom/palai/prootsmoke/VoiceBridge;Landroid/speech/SpeechRecognizer;)Landroid/speech/SpeechRecognizer;
    :L19
    iget-object v1, v4, Lcom/palai/prootsmoke/VoiceBridge$2;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    const/4 v2, #1
    invoke-static {v1, v2}, Lcom/palai/prootsmoke/VoiceBridge;->access$302(Lcom/palai/prootsmoke/VoiceBridge;Z)Z
    iget-object v1, v4, Lcom/palai/prootsmoke/VoiceBridge$2;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v1}, Lcom/palai/prootsmoke/VoiceBridge;->access$100(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/speech/SpeechRecognizer;
    move-result-object v1
    invoke-virtual {v1}, Landroid/speech/SpeechRecognizer;->cancel()V
    iget-object v1, v4, Lcom/palai/prootsmoke/VoiceBridge$2;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v1}, Lcom/palai/prootsmoke/VoiceBridge;->access$100(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/speech/SpeechRecognizer;
    move-result-object v1
    iget-object v2, v4, Lcom/palai/prootsmoke/VoiceBridge$2;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v2}, Lcom/palai/prootsmoke/VoiceBridge;->access$400(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/content/Intent;
    move-result-object v2
    invoke-virtual {v1, v2}, Landroid/speech/SpeechRecognizer;->startListening(Landroid/content/Intent;)V
    iget-object v1, v4, Lcom/palai/prootsmoke/VoiceBridge$2;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    const-string v2, "start"
    invoke-static {v1, v2, v0, v0}, Lcom/palai/prootsmoke/VoiceBridge;->access$500(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    goto :L97
    move-exception v1
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    const-string v3, "start: "
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    const-string v3, "PetVoice"
    invoke-static {v3, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    iget-object v2, v4, Lcom/palai/prootsmoke/VoiceBridge$2;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-virtual {v1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;
    move-result-object v1
    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;
    move-result-object v1
    const-string v3, "error"
    invoke-static {v2, v3, v0, v1}, Lcom/palai/prootsmoke/VoiceBridge;->access$500(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :L97
    return-void 
.end method

