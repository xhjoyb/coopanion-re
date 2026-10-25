.class Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/PetWindowService;

# direct access=0x10002
.method private constructor Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# direct access=0x11000
.method synthetic constructor Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;-><init>(Lcom/palai/prootsmoke/PetWindowService;Lcom/palai/prootsmoke/PetWindowService$PetHostBridge-IA;)V
    # registers=3 ins=3 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;-><init>(Lcom/palai/prootsmoke/PetWindowService;)V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->focus()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->getAlpha()F
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetpetAlpha(Lcom/palai/prootsmoke/PetWindowService;)F
    move-result v0
    return v0
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->grabFocus()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->hide()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetui(Lcom/palai/prootsmoke/PetWindowService;)Landroid/os/Handler;
    move-result-object v0
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$2;
    invoke-direct {v1, v2}, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$2;-><init>(Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;)V
    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->openApp(Ljava/lang/String;)Z
    # registers=14 ins=2 tries=1
    const-string v0, "PetWindow"
    const/4 v1, #0
    if-nez v13, :L6
    return v1
    :L6
    invoke-virtual {v13}, Ljava/lang/String;->trim()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z
    move-result v3
    if-eqz v3, :L21
    return v1
    :L21
    iget-object v3, v12, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-virtual {v3}, Lcom/palai/prootsmoke/PetWindowService;->getPackageManager()Landroid/content/pm/PackageManager;
    move-result-object v3
    new-instance v4, Landroid/content/Intent;
    const-string v5, "android.intent.action.MAIN"
    invoke-direct {v4, v5}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V
    const-string v5, "android.intent.category.LAUNCHER"
    invoke-virtual {v4, v5}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;
    invoke-virtual {v3, v4, v1}, Landroid/content/pm/PackageManager;->queryIntentActivities(Landroid/content/Intent;I)Ljava/util/List;
    move-result-object v4
    invoke-interface {v4}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v4
    const/4 v5, #-1
    const/4 v6, #0
    move v7, v5
    :L50
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z
    move-result v8
    if-eqz v8, :L154
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v8
    check-cast v8, Landroid/content/pm/ResolveInfo;
    if-eqz v8, :L50
    iget-object v9, v8, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;
    if-nez v9, :L69
    goto :L50
    :L69
    iget-object v9, v8, Landroid/content/pm/ResolveInfo;->activityInfo:Landroid/content/pm/ActivityInfo;
    iget-object v9, v9, Landroid/content/pm/ActivityInfo;->packageName:Ljava/lang/String;
    invoke-virtual {v8, v3}, Landroid/content/pm/ResolveInfo;->loadLabel(Landroid/content/pm/PackageManager;)Ljava/lang/CharSequence;
    move-result-object v8
    if-nez v8, :L82
    const-string v8, ""
    goto :L86
    :L82
    invoke-virtual {v8}, Ljava/lang/Object;->toString()Ljava/lang/String;
    move-result-object v8
    :L86
    invoke-virtual {v8}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;
    move-result-object v8
    invoke-virtual {v9}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;
    move-result-object v10
    invoke-virtual {v10, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v11
    if-eqz v11, :L103
    const/16 v8, #1000
    goto :L149
    :L103
    invoke-virtual {v8, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    move-result v11
    if-eqz v11, :L112
    const/16 v8, #900
    goto :L149
    :L112
    invoke-virtual {v8, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v11
    if-eqz v11, :L130
    invoke-virtual {v8}, Ljava/lang/String;->length()I
    move-result v8
    invoke-virtual {v2}, Ljava/lang/String;->length()I
    move-result v10
    sub-int/2addr v8, v10
    rsub-int/lit16 v8, v8, #700
    goto :L149
    :L130
    invoke-virtual {v10, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v8
    if-eqz v8, :L148
    invoke-virtual {v10}, Ljava/lang/String;->length()I
    move-result v8
    invoke-virtual {v2}, Ljava/lang/String;->length()I
    move-result v10
    sub-int/2addr v8, v10
    rsub-int/lit16 v8, v8, #500
    goto :L149
    :L148
    move v8, v5
    :L149
    if-le v8, v7, :L50
    move v7, v8
    move-object v6, v9
    goto :L50
    :L154
    if-eqz v6, :L232
    if-gez v7, :L159
    goto :L232
    :L159
    invoke-virtual {v3, v6}, Landroid/content/pm/PackageManager;->getLaunchIntentForPackage(Ljava/lang/String;)Landroid/content/Intent;
    move-result-object v2
    if-nez v2, :L188
    new-instance v13, Ljava/lang/StringBuilder;
    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V
    const-string v2, "[PET] openApp 无启动入口: "
    invoke-virtual {v13, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v13
    invoke-virtual {v13, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v13
    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v13
    invoke-static {v0, v13}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    return v1
    :L188
    const/high16 v3, #int 0x10000000
    invoke-virtual {v2, v3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;
    iget-object v3, v12, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-virtual {v3, v2}, Lcom/palai/prootsmoke/PetWindowService;->startActivity(Landroid/content/Intent;)V
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    const-string v3, "[PET] openApp 启动 "
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v13
    const-string v2, " -> "
    invoke-virtual {v13, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v13
    invoke-virtual {v13, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v13
    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v13
    invoke-static {v0, v13}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    const/4 v13, #1
    return v13
    :L232
    new-instance v2, Ljava/lang/StringBuilder;
    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V
    const-string v3, "[PET] openApp 没找到: "
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v2
    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v13
    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v13
    invoke-static {v0, v13}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    return v1
    move-exception v13
    new-instance v2, Ljava/lang/StringBuilder;
    const-string v3, "[PET] openApp 失败: "
    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v2, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    move-result-object v13
    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v13
    invoke-static {v0, v13}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    return v1
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->openDress()V
    # registers=4 ins=1 tries=0
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetui(Lcom/palai/prootsmoke/PetWindowService;)Landroid/os/Handler;
    move-result-object v1
    new-instance v2, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$3;
    invoke-direct {v2, v3, v0}, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$3;-><init>(Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;Landroid/content/Context;)V
    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->releaseFocus()V
    # registers=1 ins=1 tries=0
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->setAlpha(F)V
    # registers=5 ins=2 tries=1
    const/4 v0, #0
    cmpg-float v1, v4, v0
    if-gez v1, :L6
    move v4, v0
    :L6
    const/high16 v0, #int 0x3f800000
    cmpl-float v1, v4, v0
    if-lez v1, :L13
    move v4, v0
    :L13
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    const-string v1, "coopanion"
    const/4 v2, #0
    invoke-virtual {v0, v1, v2}, Lcom/palai/prootsmoke/PetWindowService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
    move-result-object v0
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    const-string v1, "pet_alpha"
    invoke-interface {v0, v1, v4}, Landroid/content/SharedPreferences$Editor;->putFloat(Ljava/lang/String;F)Landroid/content/SharedPreferences$Editor;
    move-result-object v0
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->this$0:Lcom/palai/prootsmoke/PetWindowService;
    invoke-static {v0}, Lcom/palai/prootsmoke/PetWindowService;->-$$Nest$fgetui(Lcom/palai/prootsmoke/PetWindowService;)Landroid/os/Handler;
    move-result-object v0
    new-instance v1, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;
    invoke-direct {v1, v3, v4}, Lcom/palai/prootsmoke/PetWindowService$PetHostBridge$1;-><init>(Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;F)V
    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$PetHostBridge;->setInteractive(Z)V
    # registers=4 ins=2 tries=0
    new-instance v0, Ljava/lang/StringBuilder;
    const-string v1, "[PET] setInteractive="
    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;
    move-result-object v3
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v3
    const-string v0, "PetWindow"
    invoke-static {v0, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    return-void 
.end method

