.class Lcom/palai/prootsmoke/PetWindowService$12;
.super Ljava/lang/Object;

.field fired:Z
.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$12;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$12;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    const/4 v1, #0
    iput-boolean v1, v0, Lcom/palai/prootsmoke/PetWindowService$12;->fired:Z
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$12;->run()V
    # registers=3 ins=1 tries=1
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$12;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/PetWindowService;)Landroid/webkit/WebView;
    move-result-object v0
    invoke-virtual {v0}, Landroid/webkit/WebView;->getUrl()Ljava/lang/String;
    move-result-object v0
    if-nez v0, :L30
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$12;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/PetWindowService;)Landroid/webkit/WebView;
    move-result-object v0
    const-string v1, "http://127.0.0.1:7797/pet"
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    const-string v0, "PetWindow"
    const-string v1, "[PET] loadUrl(兜底超时) -> http://127.0.0.1:7797/pet"
    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :L30
    return-void 
.end method

