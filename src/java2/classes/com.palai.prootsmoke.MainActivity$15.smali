.class Lcom/palai/prootsmoke/MainActivity$15;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$15;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$15;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$15;->run()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$15;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mcanDrawOverlays(Lcom/palai/prootsmoke/MainActivity;)Z
    move-result v0
    if-eqz v0, :L31
    invoke-static {}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$sfgetpetWinOn()Ljava/util/concurrent/atomic/AtomicBoolean;
    move-result-object v0
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z
    move-result v0
    if-nez v0, :L31
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$15;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v1, "[PET] 上次桌宠开着，自动恢复悬浮窗（v10.3：先等 7797 就绪）"
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$15;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mstartPetWindowWhenReady(Lcom/palai/prootsmoke/MainActivity;)V
    goto :L46
    :L31
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$15;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mcanDrawOverlays(Lcom/palai/prootsmoke/MainActivity;)Z
    move-result v0
    if-nez v0, :L46
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$15;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v1, "[PET] 上次桌宠开着，但悬浮窗权限没了"
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    :L46
    return-void 
.end method

