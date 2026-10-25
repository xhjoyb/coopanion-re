.class Lcom/palai/prootsmoke/MainActivity$13$2;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/MainActivity$13;
.field final synthetic val$request:Landroid/webkit/PermissionRequest;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$13$2;-><init>(Lcom/palai/prootsmoke/MainActivity$13;Landroid/webkit/PermissionRequest;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$13$2;->this$1:Lcom/palai/prootsmoke/MainActivity$13;
    iput-object v2, v0, Lcom/palai/prootsmoke/MainActivity$13$2;->val$request:Landroid/webkit/PermissionRequest;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$13$2;->run()V
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/MainActivity$13$2;->val$request:Landroid/webkit/PermissionRequest;
    invoke-virtual {v0}, Landroid/webkit/PermissionRequest;->deny()V
    return-void 
.end method

