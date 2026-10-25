.class public Lcom/palai/prootsmoke/NotifListenerService;
.super Landroid/service/notification/NotificationListenerService;

.field private static volatile connected:Z

# direct access=0x10008
.method static constructor Lcom/palai/prootsmoke/NotifListenerService;-><clinit>()V
    # registers=0 ins=0 tries=0
    return-void 
.end method

# direct access=0x10001
.method public constructor Lcom/palai/prootsmoke/NotifListenerService;-><init>()V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Landroid/service/notification/NotificationListenerService;-><init>()V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/NotifListenerService;->appLabel(Ljava/lang/String;)Ljava/lang/String;
    # registers=4 ins=2 tries=1
    invoke-virtual {v2}, Lcom/palai/prootsmoke/NotifListenerService;->getPackageManager()Landroid/content/pm/PackageManager;
    move-result-object v0
    const/4 v1, #0
    invoke-virtual {v0, v3, v1}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->getApplicationLabel(Landroid/content/pm/ApplicationInfo;)Ljava/lang/CharSequence;
    move-result-object v0
    if-nez v0, :L16
    goto :L20
    :L16
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;
    move-result-object v3
    :L20
    return-object v3
.end method

# direct access=0x9
.method public static Lcom/palai/prootsmoke/NotifListenerService;->isConnected()Z
    # registers=1 ins=0 tries=0
    sget-boolean v0, Lcom/palai/prootsmoke/NotifListenerService;->connected:Z
    return v0
.end method

# direct access=0x9
.method public static Lcom/palai/prootsmoke/NotifListenerService;->isEnabled(Landroid/content/Context;)Z
    # registers=3 ins=1 tries=1
    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
    move-result-object v0
    const-string v1, "enabled_notification_listeners"
    invoke-static {v0, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v0
    if-eqz v0, :L32
    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;
    move-result-object v0
    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v2
    if-eqz v2, :L32
    const/4 v2, #1
    return v2
    :L32
    const/4 v2, #0
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/NotifListenerService;->onListenerConnected()V
    # registers=2 ins=1 tries=0
    const/4 v0, #1
    sput-boolean v0, Lcom/palai/prootsmoke/NotifListenerService;->connected:Z
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/NotifListenerService;->onListenerDisconnected()V
    # registers=2 ins=1 tries=0
    const/4 v0, #0
    sput-boolean v0, Lcom/palai/prootsmoke/NotifListenerService;->connected:Z
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/NotifListenerService;->onNotificationPosted(Landroid/service/notification/StatusBarNotification;)V
    # registers=10 ins=2 tries=2
    if-eqz v9, :L101
    invoke-virtual {v9}, Landroid/service/notification/StatusBarNotification;->getNotification()Landroid/app/Notification;
    move-result-object v0
    if-nez v0, :L9
    goto :L101
    :L9
    invoke-virtual {v9}, Landroid/service/notification/StatusBarNotification;->getPackageName()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v9}, Landroid/service/notification/StatusBarNotification;->getNotification()Landroid/app/Notification;
    move-result-object v0
    iget-object v0, v0, Landroid/app/Notification;->extras:Landroid/os/Bundle;
    const/4 v1, #0
    if-nez v0, :L24
    move-object v3, v1
    goto :L30
    :L24
    const-string v3, "android.title"
    invoke-virtual {v0, v3}, Landroid/os/Bundle;->getCharSequence(Ljava/lang/String;)Ljava/lang/CharSequence;
    move-result-object v3
    :L30
    if-nez v0, :L33
    goto :L39
    :L33
    const-string v1, "android.text"
    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getCharSequence(Ljava/lang/String;)Ljava/lang/CharSequence;
    move-result-object v1
    :L39
    if-nez v1, :L52
    if-eqz v0, :L52
    const-string v4, "android.bigText"
    invoke-virtual {v0, v4}, Landroid/os/Bundle;->getCharSequence(Ljava/lang/String;)Ljava/lang/CharSequence;
    move-result-object v0
    if-eqz v0, :L52
    move-object v1, v0
    :L52
    const-string v0, ""
    if-nez v3, :L58
    move-object v4, v0
    goto :L63
    :L58
    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;
    move-result-object v3
    move-object v4, v3
    :L63
    if-nez v1, :L66
    goto :L70
    :L66
    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;
    move-result-object v0
    :L70
    move-object v5, v0
    invoke-virtual {v4}, Ljava/lang/String;->isEmpty()Z
    move-result v0
    if-eqz v0, :L84
    invoke-virtual {v5}, Ljava/lang/String;->isEmpty()Z
    move-result v0
    if-eqz v0, :L84
    return-void 
    :L84
    invoke-static {}, Lcom/palai/prootsmoke/SenseBridge;->peek()Lcom/palai/prootsmoke/SenseBridge;
    move-result-object v1
    if-eqz v1, :L101
    invoke-direct {v8, v2}, Lcom/palai/prootsmoke/NotifListenerService;->appLabel(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v3
    invoke-virtual {v9}, Landroid/service/notification/StatusBarNotification;->getPostTime()J
    move-result-wide v6
    invoke-virtual/range {v1..v7}, Lcom/palai/prootsmoke/SenseBridge;->addNotification(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V
    :L101
    return-void 
.end method

