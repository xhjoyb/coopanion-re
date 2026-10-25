.class Lcom/palai/prootsmoke/MainActivity$20;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;
.field final synthetic val$attempt:I

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$20;-><init>(Lcom/palai/prootsmoke/MainActivity;I)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$20;->this$0:Lcom/palai/prootsmoke/MainActivity;
    iput v2, v0, Lcom/palai/prootsmoke/MainActivity$20;->val$attempt:I
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$20;->run()V
    # registers=4 ins=1 tries=0
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$20;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v0
    if-nez v0, :L9
    return-void 
    :L9
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$20;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v0
    new-instance v1, Lcom/palai/prootsmoke/MainActivity$20$1;
    invoke-direct {v1, v3}, Lcom/palai/prootsmoke/MainActivity$20$1;-><init>(Lcom/palai/prootsmoke/MainActivity$20;)V
    const-string v2, "(function(){try{if(!document||!document.body)return 'empty';var b=document.body;var t=b.innerText||'';if(t.indexOf('ERR_CONNECTION')>=0||t.indexOf('无法')>=0)return 'err';if(b.querySelector('canvas')||b.children.length>0)return 'ok';return 'empty';}catch(e){return 'err';}})()"
    invoke-virtual {v0, v2, v1}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    return-void 
.end method

