.class public Lcom/palai/prootsmoke/VoiceBridge;
.super Ljava/lang/Object;

.field private static final TAG:Ljava/lang/String;
.field private final ctx:Landroid/content/Context;
.field private rec:Landroid/speech/SpeechRecognizer;
.field private final ui:Landroid/os/Handler;
.field private wanted:Z
.field private final web:Landroid/webkit/WebView;

# direct access=0x10001
.method public constructor Lcom/palai/prootsmoke/VoiceBridge;-><init>(Landroid/content/Context;Landroid/webkit/WebView;)V
    # registers=5 ins=3 tries=0
    invoke-direct {v2}, Ljava/lang/Object;-><init>()V
    new-instance v0, Landroid/os/Handler;
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;
    move-result-object v1
    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V
    iput-object v0, v2, Lcom/palai/prootsmoke/VoiceBridge;->ui:Landroid/os/Handler;
    const/4 v0, #0
    iput-boolean v0, v2, Lcom/palai/prootsmoke/VoiceBridge;->wanted:Z
    iput-object v3, v2, Lcom/palai/prootsmoke/VoiceBridge;->ctx:Landroid/content/Context;
    iput-object v4, v2, Lcom/palai/prootsmoke/VoiceBridge;->web:Landroid/webkit/WebView;
    return-void 
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/VoiceBridge;->access$000(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/webkit/WebView;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/VoiceBridge;->web:Landroid/webkit/WebView;
    return-object v0
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/VoiceBridge;->access$100(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/speech/SpeechRecognizer;
    # registers=1 ins=1 tries=0
    iget-object v0, v0, Lcom/palai/prootsmoke/VoiceBridge;->rec:Landroid/speech/SpeechRecognizer;
    return-object v0
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/VoiceBridge;->access$102(Lcom/palai/prootsmoke/VoiceBridge;Landroid/speech/SpeechRecognizer;)Landroid/speech/SpeechRecognizer;
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/VoiceBridge;->rec:Landroid/speech/SpeechRecognizer;
    return-object v1
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/VoiceBridge;->access$200(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/speech/SpeechRecognizer;
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/VoiceBridge;->build()Landroid/speech/SpeechRecognizer;
    move-result-object v0
    return-object v0
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/VoiceBridge;->access$300(Lcom/palai/prootsmoke/VoiceBridge;)Z
    # registers=1 ins=1 tries=0
    iget-boolean v0, v0, Lcom/palai/prootsmoke/VoiceBridge;->wanted:Z
    return v0
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/VoiceBridge;->access$302(Lcom/palai/prootsmoke/VoiceBridge;Z)Z
    # registers=2 ins=2 tries=0
    iput-boolean v1, v0, Lcom/palai/prootsmoke/VoiceBridge;->wanted:Z
    return v1
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/VoiceBridge;->access$400(Lcom/palai/prootsmoke/VoiceBridge;)Landroid/content/Intent;
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/VoiceBridge;->intent()Landroid/content/Intent;
    move-result-object v0
    return-object v0
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/VoiceBridge;->access$500(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    # registers=4 ins=4 tries=0
    invoke-direct {v0, v1, v2, v3}, Lcom/palai/prootsmoke/VoiceBridge;->deliver(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    return-void 
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/VoiceBridge;->access$600(I)Ljava/lang/String;
    # registers=1 ins=1 tries=0
    invoke-static {v0}, Lcom/palai/prootsmoke/VoiceBridge;->errName(I)Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

# direct access=0x1008
.method static synthetic Lcom/palai/prootsmoke/VoiceBridge;->access$700(Landroid/os/Bundle;)Ljava/lang/String;
    # registers=1 ins=1 tries=0
    invoke-static {v0}, Lcom/palai/prootsmoke/VoiceBridge;->first(Landroid/os/Bundle;)Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/VoiceBridge;->build()Landroid/speech/SpeechRecognizer;
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/VoiceBridge;->ctx:Landroid/content/Context;
    invoke-static {v0}, Landroid/speech/SpeechRecognizer;->createSpeechRecognizer(Landroid/content/Context;)Landroid/speech/SpeechRecognizer;
    move-result-object v0
    new-instance v1, Lcom/palai/prootsmoke/VoiceBridge$5;
    invoke-direct {v1, v2}, Lcom/palai/prootsmoke/VoiceBridge$5;-><init>(Lcom/palai/prootsmoke/VoiceBridge;)V
    invoke-virtual {v0, v1}, Landroid/speech/SpeechRecognizer;->setRecognitionListener(Landroid/speech/RecognitionListener;)V
    return-object v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/VoiceBridge;->deliver(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    # registers=6 ins=4 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/VoiceBridge;->web:Landroid/webkit/WebView;
    if-nez v0, :L5
    return-void 
    :L5
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    const-string v1, "(function(){try{var f=window.__petVoiceResult;if(typeof f==='function')f("
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-static {v3}, Lcom/palai/prootsmoke/VoiceBridge;->jsStr(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    const-string v0, ","
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    const-string v1, ""
    if-nez v4, :L35
    move-object v4, v1
    :L35
    invoke-static {v4}, Lcom/palai/prootsmoke/VoiceBridge;->jsStr(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v4
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    if-nez v5, :L50
    move-object v5, v1
    :L50
    invoke-static {v5}, Lcom/palai/prootsmoke/VoiceBridge;->jsStr(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v4
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    const-string v4, ");}catch(e){}})()"
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    iget-object v4, v2, Lcom/palai/prootsmoke/VoiceBridge;->ui:Landroid/os/Handler;
    new-instance v5, Lcom/palai/prootsmoke/VoiceBridge$1;
    invoke-direct {v5, v2, v3}, Lcom/palai/prootsmoke/VoiceBridge$1;-><init>(Lcom/palai/prootsmoke/VoiceBridge;Ljava/lang/String;)V
    invoke-virtual {v4, v5}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    return-void 
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/VoiceBridge;->errName(I)Ljava/lang/String;
    # registers=3 ins=1 tries=0
    packed-switch v2, :pswitch_data_0
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    const-string v1, "错误 "
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v2
    return-object v2
    :pswitch_8
    const-string v2, "没有麦克风权限"
    return-object v2
    :pswitch_7
    const-string v2, "识别服务忙"
    return-object v2
    :pswitch_6
    const-string v2, "没听清"
    return-object v2
    :pswitch_5
    const-string v2, "没听到声音"
    return-object v2
    :pswitch_4
    const-string v2, "客户端错误"
    return-object v2
    :pswitch_3
    const-string v2, "识别服务出错"
    return-object v2
    :pswitch_2
    const-string v2, "录音出错"
    return-object v2
    :pswitch_1
    const-string v2, "网络错误"
    return-object v2
    :pswitch_0
    const-string v2, "网络超时"
    return-object v2
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_7
        :pswitch_8
    .end packed-switch
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/VoiceBridge;->first(Landroid/os/Bundle;)Ljava/lang/String;
    # registers=3 ins=1 tries=0
    const-string v0, ""
    if-nez v2, :L5
    return-object v0
    :L5
    const-string v1, "results_recognition"
    invoke-virtual {v2, v1}, Landroid/os/Bundle;->getStringArrayList(Ljava/lang/String;)Ljava/util/ArrayList;
    move-result-object v2
    if-eqz v2, :L28
    invoke-virtual {v2}, Ljava/util/ArrayList;->isEmpty()Z
    move-result v1
    if-eqz v1, :L20
    goto :L28
    :L20
    const/4 v0, #0
    invoke-virtual {v2, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;
    move-result-object v2
    check-cast v2, Ljava/lang/String;
    return-object v2
    :L28
    return-object v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/VoiceBridge;->intent()Landroid/content/Intent;
    # registers=4 ins=1 tries=0
    new-instance v0, Landroid/content/Intent;
    const-string v1, "android.speech.action.RECOGNIZE_SPEECH"
    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    const-string v1, "android.speech.extra.LANGUAGE_MODEL"
    const-string v2, "free_form"
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    const-string v1, "android.speech.extra.LANGUAGE"
    const-string v2, "zh-CN"
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    const-string v1, "android.speech.extra.PARTIAL_RESULTS"
    const/4 v2, #1
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;
    const-string v1, "android.speech.extra.MAX_RESULTS"
    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;
    iget-object v1, v3, Lcom/palai/prootsmoke/VoiceBridge;->ctx:Landroid/content/Context;
    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v1
    const-string v2, "calling_package"
    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;
    return-object v0
.end method

# direct access=0xa
.method private static Lcom/palai/prootsmoke/VoiceBridge;->jsStr(Ljava/lang/String;)Ljava/lang/String;
    # registers=6 ins=1 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "'"
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    const/4 v1, #0
    :L8
    invoke-virtual {v5}, Ljava/lang/String;->length()I
    move-result v2
    const/16 v3, #39
    if-ge v1, v2, :L61
    invoke-virtual {v5, v1}, Ljava/lang/String;->charAt(I)C
    move-result v2
    const/16 v4, #92
    if-eq v2, v3, :L51
    if-ne v2, v4, :L27
    goto :L51
    :L27
    const/16 v3, #10
    if-ne v2, v3, :L37
    const-string v2, "\n"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :L58
    :L37
    const/16 v3, #13
    if-ne v2, v3, :L47
    const-string v2, "\r"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    goto :L58
    :L47
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    goto :L58
    :L51
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    :L58
    add-int/lit8 v1, v1, #1
    goto :L8
    :L61
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    move-result-object v5
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v5
    return-object v5
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge;->available()Z
    # registers=2 ins=1 tries=1
    iget-object v0, v1, Lcom/palai/prootsmoke/VoiceBridge;->ctx:Landroid/content/Context;
    invoke-static {v0}, Landroid/speech/SpeechRecognizer;->isRecognitionAvailable(Landroid/content/Context;)Z
    move-result v0
    return v0
    move-exception v0
    const/4 v0, #0
    return v0
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge;->cancel()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/VoiceBridge;->ui:Landroid/os/Handler;
    new-instance v1, Lcom/palai/prootsmoke/VoiceBridge$4;
    invoke-direct {v1, v2}, Lcom/palai/prootsmoke/VoiceBridge$4;-><init>(Lcom/palai/prootsmoke/VoiceBridge;)V
    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge;->start()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/VoiceBridge;->ui:Landroid/os/Handler;
    new-instance v1, Lcom/palai/prootsmoke/VoiceBridge$2;
    invoke-direct {v1, v2}, Lcom/palai/prootsmoke/VoiceBridge$2;-><init>(Lcom/palai/prootsmoke/VoiceBridge;)V
    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/VoiceBridge;->stop()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/VoiceBridge;->ui:Landroid/os/Handler;
    new-instance v1, Lcom/palai/prootsmoke/VoiceBridge$3;
    invoke-direct {v1, v2}, Lcom/palai/prootsmoke/VoiceBridge$3;-><init>(Lcom/palai/prootsmoke/VoiceBridge;)V
    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    return-void 
.end method

