.class Lcom/palai/prootsmoke/MainActivity$35;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;
.field final synthetic val$b:Landroid/app/AlertDialog$Builder;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$35;-><init>(Lcom/palai/prootsmoke/MainActivity;Landroid/app/AlertDialog$Builder;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$35;->this$0:Lcom/palai/prootsmoke/MainActivity;
    iput-object v2, v0, Lcom/palai/prootsmoke/MainActivity$35;->val$b:Landroid/app/AlertDialog$Builder;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$35;->run()V
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/MainActivity$35;->val$b:Landroid/app/AlertDialog$Builder;
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;
    return-void 
.end method

