.class Lcom/palai/prootsmoke/PetWindowService$16;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;
.field final synthetic val$on:Z

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$16;-><init>(Lcom/palai/prootsmoke/PetWindowService;Z)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    iput-boolean v2, v0, Lcom/palai/prootsmoke/PetWindowService$16;->val$on:Z
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$16;->run()V
    # registers=5 ins=1 tries=3
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v0
    if-eqz v0, :L66
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v0
    if-eqz v0, :L66
    iget-boolean v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->val$on:Z
    if-eqz v0, :L33
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v0
    iget v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I
    and-int/lit8 v1, v1, #-9
    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I
    goto :L45
    :L33
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v0
    iget v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I
    or-int/lit8 v1, v1, #8
    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->flags:I
    :L45
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetwm(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager;
    move-result-object v0
    iget-object v1, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v1
    iget-object v2, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v2}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchLp(Lcom/palai/prootsmoke/PetWindowService;)Landroid/view/WindowManager$LayoutParams;
    move-result-object v2
    invoke-interface {v0, v1, v2}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :L66
    iget-boolean v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->val$on:Z
    if-eqz v0, :L103
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetui(Lcom/palai/prootsmoke/PetWindowService;)Landroid/os/Handler;
    move-result-object v0
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$16$1;
    invoke-direct {v1, v4}, Lcom/palai/prootsmoke/PetWindowService$16$1;-><init>(Lcom/palai/prootsmoke/PetWindowService$16;)V
    const-wide/16 v2, #120
    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetui(Lcom/palai/prootsmoke/PetWindowService;)Landroid/os/Handler;
    move-result-object v0
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$16$2;
    invoke-direct {v1, v4}, Lcom/palai/prootsmoke/PetWindowService$16$2;-><init>(Lcom/palai/prootsmoke/PetWindowService$16;)V
    const-wide/16 v2, #450
    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    goto :L181
    :L103
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetimeProxy(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/EditText;
    move-result-object v0
    if-eqz v0, :L164
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    const-string v1, "input_method"
    invoke-virtual {v0, v1}, Lcom/palai/prootsmoke/PetWindowService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v0
    check-cast v0, Landroid/view/inputmethod/InputMethodManager;
    const/4 v1, #0
    if-eqz v0, :L137
    iget-object v2, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v2}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetimeProxy(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/EditText;
    move-result-object v2
    invoke-virtual {v2}, Landroid/widget/EditText;->getWindowToken()Landroid/os/IBinder;
    move-result-object v2
    invoke-virtual {v0, v2, v1}, Landroid/view/inputmethod/InputMethodManager;->hideSoftInputFromWindow(Landroid/os/IBinder;I)Z
    :L137
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetimeProxy(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/EditText;
    move-result-object v0
    invoke-virtual {v0}, Landroid/widget/EditText;->clearFocus()V
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetimeProxy(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/EditText;
    move-result-object v0
    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setFocusable(Z)V
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetimeProxy(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/EditText;
    move-result-object v0
    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setFocusableInTouchMode(Z)V
    :L164
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v0
    if-eqz v0, :L181
    iget-object v0, v4, Lcom/palai/prootsmoke/PetWindowService$16;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgettouchBox(Lcom/palai/prootsmoke/PetWindowService;)Landroid/widget/FrameLayout;
    move-result-object v0
    invoke-virtual {v0}, Landroid/widget/FrameLayout;->clearFocus()V
    :L181
    return-void 
.end method

