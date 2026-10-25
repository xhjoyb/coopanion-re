.class Lcom/palai/prootsmoke/MainActivity$31;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;
.field final synthetic val$label:Landroid/widget/TextView;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$31;-><init>(Lcom/palai/prootsmoke/MainActivity;Landroid/widget/TextView;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$31;->this$0:Lcom/palai/prootsmoke/MainActivity;
    iput-object v2, v0, Lcom/palai/prootsmoke/MainActivity$31;->val$label:Landroid/widget/TextView;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$31;->onProgressChanged(Landroid/widget/SeekBar;IZ)V
    # registers=7 ins=4 tries=0
    int-to-float v4, v5
    const/high16 v5, #int 0x42c80000
    div-float/2addr v4, v5
    const v0, #1036831949
    add-float/2addr v4, v0
    const/high16 v0, #int 0x3f800000
    cmpl-float v1, v4, v0
    if-lez v1, :L15
    move v4, v0
    :L15
    iget-object v0, v3, Lcom/palai/prootsmoke/MainActivity$31;->val$label:Landroid/widget/TextView;
    new-instance v1, Ljava/lang/StringBuilder;
    const-string v2, "桌宠透明度："
    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    mul-float/2addr v5, v4
    invoke-static {v5}, Ljava/lang/Math;->round(F)I
    move-result v5
    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v5
    const-string v1, "%"
    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v5
    invoke-virtual {v0, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    if-eqz v6, :L53
    iget-object v5, v3, Lcom/palai/prootsmoke/MainActivity$31;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v5, v4}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mpushAlphaToService(Lcom/palai/prootsmoke/MainActivity;F)V
    :L53
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$31;->onStartTrackingTouch(Landroid/widget/SeekBar;)V
    # registers=2 ins=2 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$31;->onStopTrackingTouch(Landroid/widget/SeekBar;)V
    # registers=2 ins=2 tries=0
    return-void 
.end method

