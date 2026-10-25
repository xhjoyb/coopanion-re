.class Lcom/palai/prootsmoke/PetWindowService$11$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/PetWindowService$11;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$11$1;-><init>(Lcom/palai/prootsmoke/PetWindowService$11;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$11$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$11;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$11$1;->run()V
    # registers=3 ins=1 tries=1
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$11$1;->this$1:Lcom/palai/prootsmoke/PetWindowService$11;
    iget-object v0, v0, Lcom/palai/prootsmoke/PetWindowService$11;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetweb(Lcom/palai/prootsmoke/PetWindowService;)Landroid/webkit/WebView;
    move-result-object v0
    const-string v1, "http://127.0.0.1:7797/pet"
    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V
    const-string v0, "PetWindow"
    const-string v1, "[PET] loadUrl(布局就绪后) -> http://127.0.0.1:7797/pet"
    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    return-void 
.end method

