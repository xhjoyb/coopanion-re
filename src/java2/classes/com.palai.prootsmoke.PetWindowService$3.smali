.class Lcom/palai/prootsmoke/PetWindowService$3;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;
.field final synthetic val$done:Ljava/lang/Runnable;
.field final synthetic val$finished:[Z
.field final synthetic val$holder:Landroid/widget/FrameLayout;
.field final synthetic val$warm:Landroid/webkit/WebView;
.field final synthetic val$wm0:Landroid/view/WindowManager;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$3;-><init>(Lcom/palai/prootsmoke/PetWindowService;[ZLandroid/view/WindowManager;Landroid/widget/FrameLayout;Landroid/webkit/WebView;Ljava/lang/Runnable;)V
    # registers=7 ins=7 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$3;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    iput-object v2, v0, Lcom/palai/prootsmoke/PetWindowService$3;->val$finished:[Z
    iput-object v3, v0, Lcom/palai/prootsmoke/PetWindowService$3;->val$wm0:Landroid/view/WindowManager;
    iput-object v4, v0, Lcom/palai/prootsmoke/PetWindowService$3;->val$holder:Landroid/widget/FrameLayout;
    iput-object v5, v0, Lcom/palai/prootsmoke/PetWindowService$3;->val$warm:Landroid/webkit/WebView;
    iput-object v6, v0, Lcom/palai/prootsmoke/PetWindowService$3;->val$done:Ljava/lang/Runnable;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$3;->run()V
    # registers=4 ins=1 tries=2
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$3;->val$finished:[Z
    const/4 v1, #0
    aget-boolean v2, v0, v1
    if-eqz v2, :L8
    return-void 
    :L8
    const/4 v2, #1
    aput-boolean v2, v0, v1
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$3;->val$wm0:Landroid/view/WindowManager;
    iget-object v1, v3, Lcom/palai/prootsmoke/PetWindowService$3;->val$holder:Landroid/widget/FrameLayout;
    invoke-interface {v0, v1}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$3;->val$warm:Landroid/webkit/WebView;
    invoke-virtual {v0}, Landroid/webkit/WebView;->stopLoading()V
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$3;->val$warm:Landroid/webkit/WebView;
    invoke-virtual {v0}, Landroid/webkit/WebView;->destroy()V
    const-string v0, "PetWindow"
    const-string v1, "[PET] 渲染器预热完成 → 开始正式挂载"
    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$3;->val$done:Ljava/lang/Runnable;
    invoke-interface {v0}, Ljava/lang/Runnable;->run()V
    return-void 
.end method

