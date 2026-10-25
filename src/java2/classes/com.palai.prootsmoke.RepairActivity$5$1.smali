.class Lcom/palai/prootsmoke/RepairActivity$5$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/RepairActivity$5;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/RepairActivity$5$1;-><init>(Lcom/palai/prootsmoke/RepairActivity$5;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/RepairActivity$5$1;->this$1:Lcom/palai/prootsmoke/RepairActivity$5;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1041
.method public bridge synthetic Lcom/palai/prootsmoke/RepairActivity$5$1;->onReceiveValue(Ljava/lang/Object;)V
    # registers=2 ins=2 tries=0
    check-cast v1, Ljava/lang/String;
    invoke-virtual {v0, v1}, Lcom/palai/prootsmoke/RepairActivity$5$1;->onReceiveValue(Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/RepairActivity$5$1;->onReceiveValue(Ljava/lang/String;)V
    # registers=5 ins=2 tries=0
    const/4 v0, #1
    const/4 v1, #0
    if-eqz v4, :L14
    const-string v2, "1"
    invoke-virtual {v4, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v4
    if-eqz v4, :L14
    move v4, v0
    goto :L15
    :L14
    move v4, v1
    :L15
    if-eqz v4, :L42
    iget-object v2, v3, Lcom/palai/prootsmoke/RepairActivity$5$1;->this$1:Lcom/palai/prootsmoke/RepairActivity$5;
    iget-object v2, v2, Lcom/palai/prootsmoke/RepairActivity$5;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-static {v2}, Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fgetimeShown(Lcom/palai/prootsmoke/RepairActivity;)Z
    move-result v2
    if-nez v2, :L42
    iget-object v4, v3, Lcom/palai/prootsmoke/RepairActivity$5$1;->this$1:Lcom/palai/prootsmoke/RepairActivity$5;
    iget-object v4, v4, Lcom/palai/prootsmoke/RepairActivity$5;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-static {v4, v0}, Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fputimeShown(Lcom/palai/prootsmoke/RepairActivity;Z)V
    iget-object v4, v3, Lcom/palai/prootsmoke/RepairActivity$5$1;->this$1:Lcom/palai/prootsmoke/RepairActivity$5;
    iget-object v4, v4, Lcom/palai/prootsmoke/RepairActivity$5;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-static {v4}, Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$mshowImeNow(Lcom/palai/prootsmoke/RepairActivity;)V
    goto :L51
    :L42
    if-nez v4, :L51
    iget-object v4, v3, Lcom/palai/prootsmoke/RepairActivity$5$1;->this$1:Lcom/palai/prootsmoke/RepairActivity$5;
    iget-object v4, v4, Lcom/palai/prootsmoke/RepairActivity$5;->this$0:Lcom/palai/prootsmoke/RepairActivity;
    invoke-static {v4, v1}, Lcom/palai/prootsmoke/RepairActivity;->-$$Nest$fputimeShown(Lcom/palai/prootsmoke/RepairActivity;Z)V
    :L51
    return-void 
.end method

