.class Lcom/palai/prootsmoke/RepairActivity$3;
.super Landroid/webkit/WebViewClient;

.field final synthetic this$0:Lcom/palai/prootsmoke/RepairActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/RepairActivity$3;-><init>(Lcom/palai/prootsmoke/RepairActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/RepairActivity$3;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-direct {v0}, Landroid/webkit/WebViewClient;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/RepairActivity$3;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    # registers=5 ins=3 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[REPAIRACT] onPageFinished: "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v4
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-static {v4}, Lcom/palai/prootsmoke/AppLog;->i(Ljava/lang/String;)V
    const-string v4, "(function(){ if(window.__imeHack) return; window.__imeHack=1;document.addEventListener('focusin',function(ev){  var t=ev.target; if(!t) return;  var tag=(t.tagName||'').toUpperCase();  if(tag==='INPUT'||tag==='TEXTAREA'||t.isContentEditable){    try{ window.__wantIme=1; }catch(e){}  }},true);window.__imeProbe=function(){var a=document.activeElement;  return (a&&(a.tagName==='INPUT'||a.tagName==='TEXTAREA'||a.isContentEditable))?1:0;};})()"
    const/4 v0, #0
    invoke-virtual {v3, v4, v0}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    iget-object v4, v2, Lcom/palai/prootsmoke/RepairActivity$3;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-static {v4, v3}, Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$mstartImeWatchdog(Lcom/palai/prootsmoke/RepairActivity;Landroid/webkit/WebView;)V
    return-void 
.end method

