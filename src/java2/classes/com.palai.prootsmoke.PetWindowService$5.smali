.class Lcom/palai/prootsmoke/PetWindowService$5;
.super Landroid/webkit/WebViewClient;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$5;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$5;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0}, Landroid/webkit/WebViewClient;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$5;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    # registers=5 ins=3 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[PET] onPageFinished "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v4
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    const-string v0, "PetWindow"
    invoke-static {v0, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    const-string v4, "(function(){ if (window.petHost) return 'already'; if (typeof petHostNative === 'undefined') return 'no-bridge'; window.petHost = {   setInteractive: function(on){ try{ petHostNative.setInteractive(!!on); }catch(e){} },   focus: function(){ try{ petHostNative.focus(); }catch(e){} },   grabFocus: function(){ try{ petHostNative.grabFocus(); }catch(e){} },   releaseFocus: function(){ try{ petHostNative.releaseFocus(); }catch(e){} },   hide: function(){ try{ petHostNative.hide(); }catch(e){} },   openDress: function(){ try{ petHostNative.openDress(); }catch(e){} },   setAlpha: function(f){ try{ petHostNative.setAlpha(f); }catch(e){} },   getAlpha: function(){ try{ return petHostNative.getAlpha(); }catch(e){ return 1; } },   openApp: function(n){ try{ return !!petHostNative.openApp(String(n)); }catch(e){ return false; } },   onCursor: function(cb){ (window.__petCursorSubs=window.__petCursorSubs||[]).push(cb); },   sampleBackdrop: function(){ return null; } }; document.body.classList.remove('tab'); document.body.classList.add('desk'); return 'ok';})()"
    const/4 v0, #0
    invoke-virtual {v3, v4, v0}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    iget-object v4, v2, Lcom/palai/prootsmoke/PetWindowService$5;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v4, v3}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mstartRepaintWatchdog(Lcom/palai/prootsmoke/PetWindowService;Landroid/webkit/WebView;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$5;->onPageStarted(Landroid/webkit/WebView;Ljava/lang/String;Landroid/graphics/Bitmap;)V
    # registers=4 ins=4 tries=0
    const-string v2, "(function(){ if (window.petHost) return 'already'; if (typeof petHostNative === 'undefined') return 'no-bridge'; window.petHost = {   setInteractive: function(on){ try{ petHostNative.setInteractive(!!on); }catch(e){} },   focus: function(){ try{ petHostNative.focus(); }catch(e){} },   grabFocus: function(){ try{ petHostNative.grabFocus(); }catch(e){} },   releaseFocus: function(){ try{ petHostNative.releaseFocus(); }catch(e){} },   hide: function(){ try{ petHostNative.hide(); }catch(e){} },   openDress: function(){ try{ petHostNative.openDress(); }catch(e){} },   setAlpha: function(f){ try{ petHostNative.setAlpha(f); }catch(e){} },   getAlpha: function(){ try{ return petHostNative.getAlpha(); }catch(e){ return 1; } },   openApp: function(n){ try{ return !!petHostNative.openApp(String(n)); }catch(e){ return false; } },   onCursor: function(cb){ (window.__petCursorSubs=window.__petCursorSubs||[]).push(cb); },   sampleBackdrop: function(){ return null; } }; document.body.classList.remove('tab'); document.body.classList.add('desk'); return 'ok';})()"
    const/4 v3, #0
    invoke-virtual {v1, v2, v3}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    return-void 
.end method

