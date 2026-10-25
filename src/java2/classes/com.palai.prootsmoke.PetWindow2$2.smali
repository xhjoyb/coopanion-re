.class Lcom/palai/prootsmoke/PetWindow2$2;
.super Landroid/webkit/WebViewClient;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindow2$2;-><init>()V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Landroid/webkit/WebViewClient;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindow2$2;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    # registers=4 ins=3 tries=1
    const-string v3, "(function(){ if (typeof petHostNative === 'undefined') return 'no-bridge'; if (window.petHost) return 'already'; window.petHost = { setInteractive:function(o){}, focus:function(){}, grabFocus:function(){}, releaseFocus:function(){}, hide:function(){}, openDress:function(){}, setAlpha:function(f){}, getAlpha:function(){return 1;}, openApp:function(n){return false;}, onCursor:function(cb){}, sampleBackdrop:function(){return null;} }; document.body.classList.remove('tab'); document.body.classList.add('desk'); return 'ok';})()"
    const/4 v0, #0
    invoke-virtual {v2, v3, v0}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    goto :L8
    move-exception v2
    :L8
    return-void 
.end method

