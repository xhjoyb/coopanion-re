.class Lcom/palai/prootsmoke/PetWindowService$4;
.super Landroid/webkit/WebViewClient;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;
.field final synthetic val$finish:Ljava/lang/Runnable;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$4;-><init>(Lcom/palai/prootsmoke/PetWindowService;Ljava/lang/Runnable;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$4;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    iput-object v2, v0, Lcom/palai/prootsmoke/PetWindowService$4;->val$finish:Ljava/lang/Runnable;
    invoke-direct {v0}, Landroid/webkit/WebViewClient;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$4;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    # registers=5 ins=3 tries=0
    const-string v3, "PetWindow"
    const-string v4, "[PET] 预热页加载完成，再等 400ms 让合成器落定"
    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    iget-object v3, v2, Lcom/palai/prootsmoke/PetWindowService$4;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v3}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetui(Lcom/palai/prootsmoke/PetWindowService;)Landroid/os/Handler;
    move-result-object v3
    iget-object v4, v2, Lcom/palai/prootsmoke/PetWindowService$4;->val$finish:Ljava/lang/Runnable;
    const-wide/16 v0, #400
    invoke-virtual {v3, v4, v0, v1}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    return-void 
.end method

