.class Lcom/palai/prootsmoke/MainActivity$33;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$33;-><init>(Lcom/palai/prootsmoke/MainActivity;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$33;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$33;->onClick(Landroid/content/DialogInterface;I)V
    # registers=5 ins=3 tries=1
    iget-object v3, v2, Lcom/palai/prootsmoke/MainActivity$33;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v4, Landroid/content/Intent;
    const-string v0, "android.settings.USAGE_ACCESS_SETTINGS"
    invoke-direct {v4, v0}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    invoke-virtual {v3, v4}, Lcom/palai/prootsmoke/MainActivity;->startActivity(Landroid/content/Intent;)V
    goto :L34
    move-exception v3
    iget-object v4, v2, Lcom/palai/prootsmoke/MainActivity$33;->this$0:Lcom/palai/prootsmoke/MainActivity;
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[SENSE] 打不开 usage 设置: "
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    invoke-static {v4, v3}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mlog(Lcom/palai/prootsmoke/MainActivity;Ljava/lang/String;)V
    :L34
    return-void 
.end method

