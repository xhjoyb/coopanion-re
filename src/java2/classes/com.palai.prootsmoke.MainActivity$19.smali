.class Lcom/palai/prootsmoke/MainActivity$19;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;
.field final synthetic val$attempt:I

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$19;-><init>(Lcom/palai/prootsmoke/MainActivity;I)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$19;->this$0:Lcom/palai/prootsmoke/MainActivity;
    iput v2, v0, Lcom/palai/prootsmoke/MainActivity$19;->val$attempt:I
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$19;->run()V
    # registers=8 ins=1 tries=0
    iget-object v0, v7, Lcom/palai/prootsmoke/MainActivity$19;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v0
    if-nez v0, :L9
    return-void 
    :L9
    iget-object v0, v7, Lcom/palai/prootsmoke/MainActivity$19;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v1
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v2, "<html><body style='background:#0b0f14;color:#8aa;font-family:sans-serif;display:flex;align-items:center;justify-content:center;height:100%'><div style='text-align:center'>&#27491;&#22312;&#36830;&#25509;&#26700;&#23456;&#26381;&#21153;<br><small style='color:#567'>&#31532; "
    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget v2, v7, Lcom/palai/prootsmoke/MainActivity$19;->val$attempt:I
    add-int/lit8 v2, v2, #1
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v2, " / 20 &#27425;&#23581;&#35797;&#65292;&#35831;&#31245;&#31561;&#8230;</small></div></body></html>"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    const-string v5, "UTF-8"
    const/4 v6, #0
    const/4 v2, #0
    const-string v4, "text/html"
    invoke-virtual/range {v1..v6}, Landroid/webkit/WebView;->loadDataWithBaseURL(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    iget-object v0, v7, Lcom/palai/prootsmoke/MainActivity$19;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v0
    const-string v1, "http://127.0.0.1:7797/pet?host=app"
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    return-void 
.end method

