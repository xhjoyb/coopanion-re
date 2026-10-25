.class Lcom/palai/prootsmoke/MainActivity$38$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/MainActivity$38;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$38$1;-><init>(Lcom/palai/prootsmoke/MainActivity$38;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$38$1;->this$1:Lcom/palai/prootsmoke/MainActivity$38;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$38$1;->run()V
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/MainActivity$38$1;->this$1:Lcom/palai/prootsmoke/MainActivity$38;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$38;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mcanDrawOverlays(Lcom/palai/prootsmoke/MainActivity;)Z
    move-result v0
    if-eqz v0, :L27
    invoke-static {}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$sfgetpetWinOn()Ljava/util/concurrent/atomic/AtomicBoolean;
    move-result-object v0
    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z
    move-result v0
    if-nez v0, :L27
    iget-object v0, v1, Lcom/palai/prootsmoke/MainActivity$38$1;->this$1:Lcom/palai/prootsmoke/MainActivity$38;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$38;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mstartPetWindow(Lcom/palai/prootsmoke/MainActivity;)V
    :L27
    return-void 
.end method

