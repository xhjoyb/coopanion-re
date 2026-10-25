.class Lcom/palai/prootsmoke/MainActivity$20$1$2;
.super Ljava/lang/Object;

.field final synthetic this$2:Lcom/palai/prootsmoke/MainActivity$20$1;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$20$1$2;-><init>(Lcom/palai/prootsmoke/MainActivity$20$1;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$20$1$2;->this$2:Lcom/palai/prootsmoke/MainActivity$20$1;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$20$1$2;->run()V
    # registers=8 ins=1 tries=0
    iget-object v0, v7, Lcom/palai/prootsmoke/MainActivity$20$1$2;->this$2:Lcom/palai/prootsmoke/MainActivity$20$1;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$20;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v0
    if-nez v0, :L13
    return-void 
    :L13
    iget-object v0, v7, Lcom/palai/prootsmoke/MainActivity$20$1$2;->this$2:Lcom/palai/prootsmoke/MainActivity$20$1;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$20;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/MainActivity;)Landroid/webkit/WebView;
    move-result-object v1
    const-string v5, "UTF-8"
    const/4 v6, #0
    const/4 v2, #0
    const-string v3, "<html><body style='background:#0b0f14;color:#c88;font-family:sans-serif;display:flex;align-items:center;justify-content:center;height:100%'><div style='text-align:center'>&#26700;&#23456;&#26381;&#21153;&#36830;&#25509;&#22833;&#36133;<br><small style='color:#567'>&#35831;&#30830;&#35748;&#20869;&#26680;&#24050;&#21551;&#21160;&#65292;&#28982;&#21518;&#28857;&#39;&#37325;&#35797;&#21551;&#21160;&#39;</small></div></body></html>"
    const-string v4, "text/html"
    invoke-virtual/range {v1..v6}, Landroid/webkit/WebView;->loadDataWithBaseURL(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    return-void 
.end method

