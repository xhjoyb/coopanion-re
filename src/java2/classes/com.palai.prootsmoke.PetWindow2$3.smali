.class Lcom/palai/prootsmoke/PetWindow2$3;
.super Landroid/view/View;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindow2$3;-><init>(Landroid/content/Context;)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Landroid/view/View;-><init>(Landroid/content/Context;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindow2$3;->onTouchEvent(Landroid/view/MotionEvent;)Z
    # registers=2 ins=2 tries=0
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindow2;->access$200(Landroid/view/MotionEvent;)Z
    move-result v1
    return v1
.end method

