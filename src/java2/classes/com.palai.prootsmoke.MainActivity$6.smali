.class Lcom/palai/prootsmoke/MainActivity$6;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$6;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$6;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$6;->onClick(Landroid/view/View;)V
    # registers=5 ins=2 tries=1
    iget-object v4, v3, Lcom/palai/prootsmoke/MainActivity$6;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v0, Landroid/content/Intent;
    iget-object v1, v3, Lcom/palai/prootsmoke/MainActivity$6;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-class v2, Lcom/palai/prootsmoke/PetActivity;
    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V
    invoke-virtual {v4, v0}, Lcom/palai/prootsmoke/MainActivity;->startActivity(Landroid/content/Intent;)V
    iget-object v4, v3, Lcom/palai/prootsmoke/MainActivity$6;->this$0:Lcom/palai/prootsmoke/MainActivity;
    const-string v0, "[PET] 启动全屏桌宠 (PetActivity)"
    invoke-static {v4, v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    goto :L43
    move-exception v4
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$6;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "[PET] 启动 PetActivity 失败: "
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v4
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v4
    invoke-static {v0, v4}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    :L43
    return-void 
.end method

