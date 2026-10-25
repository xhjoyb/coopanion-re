.class Lcom/palai/prootsmoke/MainActivity$4;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$4;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$4;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$4;->onClick(Landroid/view/View;)V
    # registers=3 ins=2 tries=0
    new-instance v2, Ljava/lang/Thread;
    new-instance v0, Lcom/palai/prootsmoke/MainActivity$4$1;
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/MainActivity$4$1;-><init>(Lcom/palai/prootsmoke/MainActivity$4;)V
    invoke-direct {v2, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V
    invoke-virtual {v2}, Ljava/lang/Thread;->start()V
    return-void 
.end method

