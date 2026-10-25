.class Lcom/palai/prootsmoke/PetWindowService$15;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$15;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$15;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1041
.method public bridge synthetic Lcom/palai/prootsmoke/PetWindowService$15;->onReceiveValue(Ljava/lang/Object;)V
    # registers=2 ins=2 tries=0
    check-cast v1, Ljava/lang/String;
    invoke-virtual {v0, v1}, Lcom/palai/prootsmoke/PetWindowService$15;->onReceiveValue(Ljava/lang/String;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$15;->onReceiveValue(Ljava/lang/String;)V
    # registers=14 ins=2 tries=1
    const-string v0, "probe box=["
    if-eqz v13, :L216
    invoke-virtual {v13}, Ljava/lang/String;->length()I
    move-result v1
    const/4 v2, #3
    if-ge v1, v2, :L13
    goto/16 :L216
    :L13
    const-string v1, """
    const-string v3, ""
    invoke-virtual {v13, v1, v3}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;
    move-result-object v13
    const/16 v1, #124
    invoke-virtual {v13, v1}, Ljava/lang/String;->lastIndexOf(I)I
    move-result v1
    if-gez v1, :L30
    return-void 
    :L30
    const/4 v3, #0
    invoke-virtual {v13, v3, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;
    move-result-object v4
    const/4 v5, #1
    add-int/2addr v1, v5
    invoke-virtual {v13, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;
    move-result-object v13
    const-string v1, "1"
    invoke-virtual {v13, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v13
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v6
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService$15;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetlastProbeLog(Lcom/palai/prootsmoke/PetWindowService;)J
    move-result-wide v8
    sub-long v8, v6, v8
    const-wide/16 v10, #1000
    cmp-long v1, v8, v10
    if-lez v1, :L98
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService$15;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v1, v6, v7}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fputlastProbeLog(Lcom/palai/prootsmoke/PetWindowService;J)V
    iget-object v1, v12, Lcom/palai/prootsmoke/PetWindowService$15;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    new-instance v6, Ljava/lang/StringBuilder;
    invoke-direct {v6, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v6, "] focused="
    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    invoke-static {v1, v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mdiag(Lcom/palai/prootsmoke/PetWindowService;Ljava/lang/String;)V
    :L98
    iget-object v0, v12, Lcom/palai/prootsmoke/PetWindowService$15;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0, v13}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$mapplyInputFocus(Lcom/palai/prootsmoke/PetWindowService;Z)V
    invoke-virtual {v4}, Ljava/lang/String;->length()I
    move-result v13
    const/4 v0, #5
    if-ge v13, v0, :L111
    return-void 
    :L111
    const-string v13, ","
    invoke-virtual {v4, v13}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    move-result-object v13
    array-length v0, v13
    const/4 v1, #4
    if-ge v0, v1, :L122
    return-void 
    :L122
    iget-object v0, v12, Lcom/palai/prootsmoke/PetWindowService$15;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-virtual {v0}, Lcom/palai/prootsmoke/PetWindowService;->getResources()Landroid/content/res/Resources;
    move-result-object v0
    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;
    move-result-object v0
    iget v0, v0, Landroid/util/DisplayMetrics;->density:F
    aget-object v1, v13, v3
    invoke-static {v1}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F
    move-result v1
    mul-float/2addr v1, v0
    float-to-int v1, v1
    aget-object v3, v13, v5
    invoke-static {v3}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F
    move-result v3
    mul-float/2addr v3, v0
    float-to-int v3, v3
    const/4 v4, #2
    aget-object v5, v13, v4
    invoke-static {v5}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F
    move-result v5
    mul-float/2addr v5, v0
    float-to-int v5, v5
    aget-object v13, v13, v2
    invoke-static {v13}, Ljava/lang/Float;->parseFloat(Ljava/lang/String;)F
    move-result v13
    mul-float/2addr v13, v0
    float-to-int v13, v13
    iget-object v0, v12, Lcom/palai/prootsmoke/PetWindowService$15;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    add-int v2, v1, v5
    int-to-float v6, v2
    const/high16 v7, #int 0x40000000
    div-float/2addr v6, v7
    invoke-static {v0, v6}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fputpetX(Lcom/palai/prootsmoke/PetWindowService;F)V
    iget-object v0, v12, Lcom/palai/prootsmoke/PetWindowService$15;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    add-int v6, v3, v13
    int-to-float v8, v6
    div-float/2addr v8, v7
    invoke-static {v0, v8}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fputpetY(Lcom/palai/prootsmoke/PetWindowService;F)V
    sub-int/2addr v5, v1
    add-int/lit8 v5, v5, #80
    const/16 v0, #520
    invoke-static {v5, v0}, Ljava/lang/Math;->max(II)I
    move-result v1
    sub-int/2addr v13, v3
    add-int/lit8 v13, v13, #80
    invoke-static {v13, v0}, Ljava/lang/Math;->max(II)I
    move-result v13
    div-int/2addr v2, v4
    div-int/lit8 v0, v1, #2
    sub-int/2addr v2, v0
    div-int/2addr v6, v4
    div-int/lit8 v0, v13, #2
    sub-int/2addr v6, v0
    iget-object v0, v12, Lcom/palai/prootsmoke/PetWindowService$15;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0, v2, v6, v1, v13}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$msizeTouchTo(Lcom/palai/prootsmoke/PetWindowService;IIII)V
    :L216
    return-void 
.end method

