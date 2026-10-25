.class Lcom/palai/prootsmoke/MainActivity$23;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$23;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$23;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$23;->onClick(Landroid/content/DialogInterface;I)V
    # registers=3 ins=3 tries=0
    new-instance v1, Ljava/lang/Thread;
    new-instance v2, Lcom/palai/prootsmoke/MainActivity$23$1;
    invoke-direct {v2, v0}, Lcom/palai/prootsmoke/MainActivity$23$1;-><init>(Lcom/palai/prootsmoke/MainActivity$23;)V
    invoke-direct {v1, v2}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V
    return-void 
.end method

