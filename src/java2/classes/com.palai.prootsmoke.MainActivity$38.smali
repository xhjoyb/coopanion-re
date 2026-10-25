.class Lcom/palai/prootsmoke/MainActivity$38;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$38;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$38;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$38;->run()V
    # registers=4 ins=1 tries=0
    const/16 v0, #7797
    const v1, #90000
    const-string v2, "127.0.0.1"
    invoke-static {v2, v0, v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$smwaitPortOpen(Ljava/lang/String;II)Z
    move-result v0
    if-nez v0, :L21
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$38;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v1, "[PET] 7797 端口超时未就绪，仍尝试启动桌宠（可能显示空白）"
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    goto :L28
    :L21
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$38;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v1, "[PET] 7797 端口已就绪，启动桌宠悬浮窗"
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    :L28
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$38;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetroot(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/LinearLayout;
    move-result-object v0
    new-instance v1, Lcom/palai/prootsmoke/MainActivity$38$1;
    invoke-direct {v1, v3}, Lcom/palai/prootsmoke/MainActivity$38$1;-><init>(Lcom/palai/prootsmoke/MainActivity$38;)V
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->post(Ljava/lang/Runnable;)Z
    return-void 
.end method

