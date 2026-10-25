.class Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$3;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
.field final synthetic val$ctx:Landroid/content/Context;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$3;-><init>(Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;Landroid/content/Context;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$3;->this$1:Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
    iput-object v2, v0, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$3;->val$ctx:Landroid/content/Context;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$3;->run()V
    # registers=4 ins=1 tries=1
    new-instance v0, Landroid/content/Intent;
    const-string v1, "android.intent.action.VIEW"
    const-string v2, "http://127.0.0.1:7797/dress"
    invoke-static {v2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;
    move-result-object v2
    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V
    const/high16 v1, #int 0x10000000
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;
    iget-object v1, v3, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$3;->val$ctx:Landroid/content/Context;
    invoke-virtual {v1, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    return-void 
.end method

