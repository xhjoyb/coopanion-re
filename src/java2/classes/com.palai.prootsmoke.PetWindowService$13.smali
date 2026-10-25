.class Lcom/palai/prootsmoke/PetWindowService$13;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;
.field final synthetic val$wv:Landroid/webkit/WebView;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$13;-><init>(Lcom/palai/prootsmoke/PetWindowService;Landroid/webkit/WebView;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$13;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    iput-object v2, v0, Lcom/palai/prootsmoke/PetWindowService$13;->val$wv:Landroid/webkit/WebView;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$13;->run()V
    # registers=4 ins=1 tries=1
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$13;->val$wv:Landroid/webkit/WebView;
    invoke-virtual {v0}, Landroid/webkit/WebView;->invalidate()V
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$13;->val$wv:Landroid/webkit/WebView;
    const-string v1, "(function(){try{if(window.__repaintHack)return 0;window.__repaintHack=1;var els=document.querySelectorAll('#pet,#bubble,#menu,.pet,.whale,svg,canvas');for(var i=0;i<els.length;i++){var e=els[i];var t=e.style.transform;e.style.transform=(t||'')+' translateZ(0)';void e.offsetHeight;e.style.transform=t||'';}window.dispatchEvent(new Event('resize'));window.__repaintHack=0;return 1;}catch(e){return 0;}})()"
    const/4 v2, #0
    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V
    return-void 
.end method

