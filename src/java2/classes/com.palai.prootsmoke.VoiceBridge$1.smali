.class Lcom/palai/prootsmoke/VoiceBridge$1;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/VoiceBridge;
.field final synthetic val$js:Ljava/lang/String;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/VoiceBridge$1;-><init>(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/VoiceBridge$1;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    iput-object v2, v0, Lcom/palai/prootsmoke/VoiceBridge$1;->val$js:Ljava/lang/String;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge$1;->run()V
    # registers=4 ins=1 tries=1
    iget-object v0, v3, Lcom/palai/prootsmoke/VoiceBridge$1;->this$0:Lcom/palai/prootsmoke/VoiceBridge;
    invoke-static {v0}, Lcom/palai/prootsmoke/VoiceBridge;->access$000(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/webkit/WebView;
    move-result-object v0
    iget-object v1, v3, Lcom/palai/prootsmoke/VoiceBridge$1;->val$js:Ljava/lang/String;
    const/4 v2, #0
    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    goto :L38
    move-exception v0
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "deliver: "
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v1
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    const-string v1, "PetVoice"
    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :L38
    return-void 
.end method

