.class Lcom/palai/prootsmoke/PetActivity$2;
.super Landroid/webkit/WebViewClient;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetActivity$2;-><init>(Lcom/palai/prootsmoke/PetActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetActivity$2;->this$0:Lcom/palai/prootsmoke/PetActivity;
    invoke-direct {v0}, Landroid/webkit/WebViewClient;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetActivity$2;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    # registers=5 ins=3 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[PETACT] onPageFinished: "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v4
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-static {v4}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    new-instance v4, Lcom/palai/prootsmoke/PetActivity$2$1;
    invoke-direct {v4, v2}, Lcom/palai/prootsmoke/PetActivity$2$1;-><init>(Lcom/palai/prootsmoke/PetActivity$2;)V
    const-string v0, "(function(){try{var e=document.getElementById('pet');var g=(function tick(){window.__rc=(window.__rc||0)+1;requestAnimationFrame(tick);})();return 'petEl='+(e?'yes':'NO')+' raf='+(typeof requestAnimationFrame)+' vp='+innerWidth+'x'+innerHeight;}catch(err){return 'err '+err;}})()"
    invoke-virtual {v3, v0, v4}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    return-void 
.end method

