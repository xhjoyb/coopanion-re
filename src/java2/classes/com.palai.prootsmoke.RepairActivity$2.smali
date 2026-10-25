.class Lcom/palai/prootsmoke/RepairActivity$2;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/RepairActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/RepairActivity$2;-><init>(Lcom/palai/prootsmoke/RepairActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/RepairActivity$2;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/RepairActivity$2;->onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    # registers=3 ins=3 tries=1
    invoke-virtual {v2}, Landroid/view/MotionEvent;->getAction()I
    move-result v2
    if-nez v2, :L9
    invoke-virtual {v1}, Landroid/view/View;->requestFocus()Z
    :L9
    const/4 v1, #0
    return v1
.end method

