.class public final Lcom/palai/prootsmoke/SenseBridge;
.super Ljava/lang/Object;

.field private static final NOTIF_CAP:I
.field public static final PORT:I
.field private static volatile instance:Lcom/palai/prootsmoke/SenseBridge;
.field private final ctx:Landroid/content/Context;
.field private notifSeq:J
.field private final notifs:Ljava/util/List;
.field private volatile running:Z
.field private server:Ljava/net/ServerSocket;
.field private thread:Ljava/lang/Thread;

# direct access=0x1009
.method public static synthetic Lcom/palai/prootsmoke/SenseBridge;->$r8$lambda$CN_0ZWdmF93s_ZMCumFomHqzwGM(Lcom/palai/prootsmoke/SenseBridge;Ljava/net/Socket;)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/SenseBridge;->lambda$loop$0(Ljava/net/Socket;)V
    return-void 
.end method

# direct access=0x1009
.method public static synthetic Lcom/palai/prootsmoke/SenseBridge;->$r8$lambda$IUo89o2fw9stkETEq7IynT6S0sk(Lcom/palai/prootsmoke/SenseBridge;)V
    # registers=1 ins=1 tries=0
    invoke-direct {v0}, Lcom/palai/prootsmoke/SenseBridge;->loop()V
    return-void 
.end method

# direct access=0x10002
.method private constructor Lcom/palai/prootsmoke/SenseBridge;-><init>(Landroid/content/Context;)V
    # registers=4 ins=2 tries=0
    invoke-direct {v2}, Ljava/lang/Object;-><init>()V
    new-instance v0, Ljava/util/ArrayList;
    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V
    iput-object v0, v2, Lcom/palai/prootsmoke/SenseBridge;->notifs:Ljava/util/List;
    const-wide/16 v0, #0
    iput-wide v0, v2, Lcom/palai/prootsmoke/SenseBridge;->notifSeq:J
    iput-object v3, v2, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->appLabel(Ljava/lang/String;)Ljava/lang/String;
    # registers=4 ins=2 tries=1
    iget-object v0, v2, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    invoke-virtual {v0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;
    move-result-object v0
    const/4 v1, #0
    invoke-virtual {v0, v3, v1}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;
    move-result-object v1
    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->getApplicationLabel(Landroid/content/pm/ApplicationInfo;)Ljava/lang/CharSequence;
    move-result-object v0
    if-nez v0, :L18
    goto :L22
    :L18
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;
    move-result-object v3
    :L22
    return-object v3
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->currentAppJson()Lorg/json/JSONObject;
    # registers=6 ins=1 tries=2
    new-instance v0, Lorg/json/JSONObject;
    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V
    invoke-direct {v5}, Lcom/palai/prootsmoke/SenseBridge;->foregroundPackage()Ljava/lang/String;
    move-result-object v1
    const-string v2, "pkg"
    const-string v3, ""
    if-nez v1, :L17
    move-object v4, v3
    goto :L18
    :L17
    move-object v4, v1
    :L18
    invoke-virtual {v0, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const-string v2, "label"
    if-nez v1, :L26
    goto :L30
    :L26
    invoke-direct {v5, v1}, Lcom/palai/prootsmoke/SenseBridge;->appLabel(Ljava/lang/String;)Ljava/lang/String;
    move-result-object v3
    :L30
    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const-string v1, "ts"
    invoke-direct {v5}, Lcom/palai/prootsmoke/SenseBridge;->nowIso()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    return-object v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->foregroundPackage()Ljava/lang/String;
    # registers=9 ins=1 tries=1
    const/4 v0, #0
    iget-object v1, v8, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    const-string v2, "usagestats"
    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v1
    move-object v2, v1
    check-cast v2, Landroid/app/usage/UsageStatsManager;
    if-eqz v2, :L69
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J
    move-result-wide v6
    const-wide/32 v3, #3600000L
    sub-long v4, v6, v3
    const/4 v3, #0
    invoke-virtual/range {v2..v7}, Landroid/app/usage/UsageStatsManager;->queryUsageStats(IJJ)Ljava/util/List;
    move-result-object v1
    if-eqz v1, :L69
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v1
    move-object v2, v0
    :L35
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z
    move-result v3
    if-eqz v3, :L63
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v3
    check-cast v3, Landroid/app/usage/UsageStats;
    if-eqz v2, :L61
    invoke-virtual {v3}, Landroid/app/usage/UsageStats;->getLastTimeUsed()J
    move-result-wide v4
    invoke-virtual {v2}, Landroid/app/usage/UsageStats;->getLastTimeUsed()J
    move-result-wide v6
    cmp-long v4, v4, v6
    if-lez v4, :L35
    :L61
    move-object v2, v3
    goto :L35
    :L63
    if-eqz v2, :L69
    invoke-virtual {v2}, Landroid/app/usage/UsageStats;->getPackageName()Ljava/lang/String;
    move-result-object v0
    :L69
    return-object v0
.end method

# direct access=0x20009
.method public static Lcom/palai/prootsmoke/SenseBridge;->get(Landroid/content/Context;)Lcom/palai/prootsmoke/SenseBridge;
    # registers=3 ins=1 tries=2
    const-class v0, Lcom/palai/prootsmoke/SenseBridge;
    monitor-enter v0
    sget-object v1, Lcom/palai/prootsmoke/SenseBridge;->instance:Lcom/palai/prootsmoke/SenseBridge;
    if-nez v1, :L18
    new-instance v1, Lcom/palai/prootsmoke/SenseBridge;
    invoke-virtual {v2}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;
    move-result-object v2
    invoke-direct {v1, v2}, Lcom/palai/prootsmoke/SenseBridge;-><init>(Landroid/content/Context;)V
    sput-object v1, Lcom/palai/prootsmoke/SenseBridge;->instance:Lcom/palai/prootsmoke/SenseBridge;
    :L18
    sget-object v2, Lcom/palai/prootsmoke/SenseBridge;->instance:Lcom/palai/prootsmoke/SenseBridge;
    monitor-exit v0
    return-object v2
    move-exception v2
    monitor-exit v0
    throw v2
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->handle(Ljava/net/Socket;)V
    # registers=9 ins=2 tries=5
    const-string v0, " "
    new-instance v1, Ljava/io/BufferedReader;
    new-instance v2, Ljava/io/InputStreamReader;
    invoke-virtual {v8}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;
    move-result-object v3
    sget-object v4, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;
    invoke-direct {v2, v3, v4}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/nio/charset/Charset;)V
    invoke-direct {v1, v2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;
    move-result-object v2
    if-nez v2, :L28
    invoke-virtual {v8}, Ljava/net/Socket;->close()V
    return-void 
    :L28
    const-string v3, "/"
    invoke-virtual {v2, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;
    move-result-object v2
    array-length v4, v2
    const/4 v5, #2
    if-lt v4, v5, :L41
    const/4 v3, #1
    aget-object v3, v2, v3
    :L41
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;
    move-result-object v2
    if-eqz v2, :L54
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z
    move-result v2
    if-nez v2, :L54
    goto :L41
    :L54
    const-string v1, "/health"
    invoke-virtual {v3, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v1
    const/16 v2, #200
    if-eqz v1, :L70
    invoke-direct {v7}, Lcom/palai/prootsmoke/SenseBridge;->healthJson()Ljava/lang/String;
    move-result-object v1
    :L68
    move v3, v2
    goto :L159
    :L70
    const-string v1, "/state"
    invoke-virtual {v3, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v1
    if-eqz v1, :L83
    invoke-direct {v7}, Lcom/palai/prootsmoke/SenseBridge;->stateJson()Ljava/lang/String;
    move-result-object v1
    goto :L68
    :L83
    const-string v1, "/notifications"
    invoke-virtual {v3, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z
    move-result v1
    if-eqz v1, :L155
    const-string v1, "since="
    invoke-virtual {v3, v1}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I
    move-result v1
    if-ltz v1, :L148
    add-int/lit8 v1, v1, #6
    new-instance v4, Ljava/lang/StringBuilder;
    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V
    :L106
    invoke-virtual {v3}, Ljava/lang/String;->length()I
    move-result v5
    if-ge v1, v5, :L133
    invoke-virtual {v3, v1}, Ljava/lang/String;->charAt(I)C
    move-result v5
    invoke-static {v5}, Ljava/lang/Character;->isDigit(C)Z
    move-result v5
    if-eqz v5, :L133
    add-int/lit8 v5, v1, #1
    invoke-virtual {v3, v1}, Ljava/lang/String;->charAt(I)C
    move-result v1
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;
    move v1, v5
    goto :L106
    :L133
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->length()I
    move-result v1
    if-lez v1, :L148
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v1
    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J
    move-result-wide v3
    goto :L150
    :L148
    const-wide/16 v3, #0
    :L150
    invoke-direct {v7, v3, v4}, Lcom/palai/prootsmoke/SenseBridge;->notificationsJson(J)Ljava/lang/String;
    move-result-object v1
    goto :L68
    :L155
    const-string v1, "{}"
    const/16 v3, #404
    :L159
    sget-object v4, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;
    invoke-virtual {v1, v4}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B
    move-result-object v1
    invoke-virtual {v8}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;
    move-result-object v4
    new-instance v5, Ljava/lang/StringBuilder;
    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V
    const-string v6, "HTTP/1.1 "
    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v5
    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v5
    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    if-ne v3, v2, :L193
    const-string v2, "OK"
    goto :L195
    :L193
    const-string v2, "Not Found"
    :L195
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v2, "
Content-Type: application/json; charset=utf-8
Content-Length: "
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    array-length v2, v1
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;
    move-result-object v0
    const-string v2, "
Connection: close

"
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    move-result-object v0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    sget-object v2, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;
    invoke-virtual {v0, v2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B
    move-result-object v0
    invoke-virtual {v4, v0}, Ljava/io/OutputStream;->write([B)V
    invoke-virtual {v4, v1}, Ljava/io/OutputStream;->write([B)V
    invoke-virtual {v4}, Ljava/io/OutputStream;->flush()V
    invoke-virtual {v8}, Ljava/net/Socket;->close()V
    goto :L244
    move-exception v0
    invoke-virtual {v8}, Ljava/net/Socket;->close()V
    throw v0
    :L244
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->hasUsageAccess()Z
    # registers=6 ins=1 tries=1
    const/4 v0, #0
    iget-object v1, v5, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    const-string v2, "appops"
    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Landroid/app/AppOpsManager;
    if-nez v1, :L14
    return v0
    :L14
    const-string v2, "android:get_usage_stats"
    invoke-static {}, Landroid/os/Process;->myUid()I
    move-result v3
    iget-object v4, v5, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    invoke-virtual {v4}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v4
    invoke-virtual {v1, v2, v3, v4}, Landroid/app/AppOpsManager;->checkOpNoThrow(Ljava/lang/String;ILjava/lang/String;)I
    move-result v1
    if-nez v1, :L33
    const/4 v0, #1
    :L33
    return v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->healthJson()Ljava/lang/String;
    # registers=5 ins=1 tries=1
    new-instance v0, Lorg/json/JSONObject;
    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V
    const-string v1, "usage"
    invoke-direct {v4}, Lcom/palai/prootsmoke/SenseBridge;->hasUsageAccess()Z
    move-result v2
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    const-string v1, "notif"
    iget-object v2, v4, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    invoke-static {v2}, Lcom/palai/prootsmoke/NotifListenerService;->isEnabled(Landroid/content/Context;)Z
    move-result v2
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    const-string v1, "accessibility"
    invoke-direct {v4}, Lcom/palai/prootsmoke/SenseBridge;->isAccessibilityOn()Z
    move-result v2
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    new-instance v1, Lorg/json/JSONObject;
    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V
    const-string v2, "ok"
    const/4 v3, #1
    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    const-string v2, "sources"
    invoke-virtual {v1, v2, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;
    move-result-object v0
    return-object v0
    const-string v0, "{"ok":true,"sources":{}}"
    return-object v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->isAccessibilityOn()Z
    # registers=4 ins=1 tries=1
    const/4 v0, #0
    iget-object v1, v3, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    invoke-virtual {v1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;
    move-result-object v1
    const-string v2, "enabled_accessibility_services"
    invoke-static {v1, v2}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;
    move-result-object v1
    if-eqz v1, :L28
    iget-object v2, v3, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;
    move-result-object v2
    invoke-virtual {v1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z
    move-result v1
    if-eqz v1, :L28
    const/4 v0, #1
    :L28
    return v0
.end method

# direct access=0x1002
.method private synthetic Lcom/palai/prootsmoke/SenseBridge;->lambda$loop$0(Ljava/net/Socket;)V
    # registers=2 ins=2 tries=0
    invoke-direct {v0, v1}, Lcom/palai/prootsmoke/SenseBridge;->handle(Ljava/net/Socket;)V
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->loop()V
    # registers=5 ins=1 tries=1
    new-instance v0, Ljava/net/ServerSocket;
    const-string v1, "127.0.0.1"
    invoke-static {v1}, Ljava/net/InetAddress;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;
    move-result-object v1
    const/16 v2, #17899
    const/16 v3, #8
    invoke-direct {v0, v2, v3, v1}, Ljava/net/ServerSocket;-><init>(IILjava/net/InetAddress;)V
    iput-object v0, v4, Lcom/palai/prootsmoke/SenseBridge;->server:Ljava/net/ServerSocket;
    :L17
    iget-boolean v0, v4, Lcom/palai/prootsmoke/SenseBridge;->running:Z
    if-eqz v0, :L46
    iget-object v0, v4, Lcom/palai/prootsmoke/SenseBridge;->server:Ljava/net/ServerSocket;
    invoke-virtual {v0}, Ljava/net/ServerSocket;->accept()Ljava/net/Socket;
    move-result-object v0
    new-instance v1, Ljava/lang/Thread;
    new-instance v2, Lcom/palai/prootsmoke/SenseBridge$$ExternalSyntheticLambda1;
    invoke-direct {v2, v4, v0}, Lcom/palai/prootsmoke/SenseBridge$$ExternalSyntheticLambda1;-><init>(Lcom/palai/prootsmoke/SenseBridge;Ljava/net/Socket;)V
    const-string v0, "sense-bridge-conn"
    invoke-direct {v1, v2, v0}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V
    goto :L17
    const/4 v0, #0
    iput-boolean v0, v4, Lcom/palai/prootsmoke/SenseBridge;->running:Z
    :L46
    return-void 
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->notificationsJson(J)Ljava/lang/String;
    # registers=10 ins=3 tries=5
    new-instance v0, Lorg/json/JSONObject;
    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V
    new-instance v1, Lorg/json/JSONArray;
    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V
    monitor-enter v7
    iget-object v2, v7, Lcom/palai/prootsmoke/SenseBridge;->notifs:Ljava/util/List;
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;
    move-result-object v2
    :L17
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z
    move-result v3
    if-eqz v3, :L45
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;
    move-result-object v3
    check-cast v3, Lorg/json/JSONObject;
    const-string v4, "seq"
    const-wide/16 v5, #0
    invoke-virtual {v3, v4, v5, v6}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J
    move-result-wide v4
    cmp-long v4, v4, v8
    if-ltz v4, :L17
    invoke-virtual {v1, v3}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;
    goto :L17
    :L45
    const-string v8, "cursor"
    iget-wide v2, v7, Lcom/palai/prootsmoke/SenseBridge;->notifSeq:J
    invoke-virtual {v0, v8, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;
    monitor-exit v7
    const-string v8, "items"
    invoke-virtual {v0, v8, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;
    move-result-object v8
    return-object v8
    move-exception v8
    monitor-exit v7
    throw v8
    const-string v8, "{"cursor":0,"items":[]}"
    return-object v8
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->nowIso()Ljava/lang/String;
    # registers=4 ins=1 tries=0
    new-instance v0, Ljava/text/SimpleDateFormat;
    const-string v1, "yyyy-MM-dd'T'HH:mm:ssXXX"
    sget-object v2, Ljava/util/Locale;->US:Ljava/util/Locale;
    invoke-direct {v0, v1, v2}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V
    new-instance v1, Ljava/util/Date;
    invoke-direct {v1}, Ljava/util/Date;-><init>()V
    invoke-virtual {v0, v1}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

# direct access=0x9
.method public static Lcom/palai/prootsmoke/SenseBridge;->peek()Lcom/palai/prootsmoke/SenseBridge;
    # registers=1 ins=0 tries=0
    sget-object v0, Lcom/palai/prootsmoke/SenseBridge;->instance:Lcom/palai/prootsmoke/SenseBridge;
    return-object v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->powerJson()Lorg/json/JSONObject;
    # registers=9 ins=1 tries=2
    new-instance v0, Lorg/json/JSONObject;
    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V
    iget-object v1, v8, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    new-instance v2, Landroid/content/IntentFilter;
    const-string v3, "android.intent.action.BATTERY_CHANGED"
    invoke-direct {v2, v3}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V
    const/4 v3, #0
    invoke-virtual {v1, v3, v2}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;
    move-result-object v1
    const-string v2, "level"
    const/4 v3, #0
    const/4 v4, #-1
    if-eqz v1, :L64
    const-string v5, "status"
    invoke-virtual {v1, v5, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v5
    const/4 v6, #2
    if-eq v5, v6, :L37
    const/4 v6, #5
    if-ne v5, v6, :L38
    :L37
    const/4 v3, #1
    :L38
    invoke-virtual {v1, v2, v4}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v5
    const-string v6, "scale"
    const/16 v7, #100
    invoke-virtual {v1, v6, v7}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I
    move-result v1
    if-ltz v5, :L64
    if-lez v1, :L64
    int-to-float v4, v5
    const/high16 v5, #int 0x42c80000
    mul-float/2addr v4, v5
    int-to-float v1, v1
    div-float/2addr v4, v1
    invoke-static {v4}, Ljava/lang/Math;->round(F)I
    move-result v4
    :L64
    const-string v1, "charging"
    invoke-virtual {v0, v1, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    invoke-virtual {v0, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    return-object v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->screenJson()Lorg/json/JSONObject;
    # registers=7 ins=1 tries=1
    new-instance v0, Lorg/json/JSONObject;
    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V
    iget-object v1, v6, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    const-string v2, "power"
    invoke-virtual {v1, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v1
    check-cast v1, Landroid/os/PowerManager;
    const/4 v2, #1
    const/4 v3, #0
    if-eqz v1, :L27
    invoke-virtual {v1}, Landroid/os/PowerManager;->isInteractive()Z
    move-result v1
    if-eqz v1, :L27
    move v1, v2
    goto :L28
    :L27
    move v1, v3
    :L28
    iget-object v4, v6, Lcom/palai/prootsmoke/SenseBridge;->ctx:Landroid/content/Context;
    const-string v5, "keyguard"
    invoke-virtual {v4, v5}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;
    move-result-object v4
    check-cast v4, Landroid/app/KeyguardManager;
    if-eqz v4, :L47
    invoke-virtual {v4}, Landroid/app/KeyguardManager;->isKeyguardLocked()Z
    move-result v4
    if-eqz v4, :L47
    goto :L48
    :L47
    move v2, v3
    :L48
    const-string v3, "on"
    invoke-virtual {v0, v3, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    const-string v1, "locked"
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;
    return-object v0
.end method

# direct access=0x2
.method private Lcom/palai/prootsmoke/SenseBridge;->stateJson()Ljava/lang/String;
    # registers=4 ins=1 tries=1
    new-instance v0, Lorg/json/JSONObject;
    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V
    const-string v1, "app"
    invoke-direct {v3}, Lcom/palai/prootsmoke/SenseBridge;->currentAppJson()Lorg/json/JSONObject;
    move-result-object v2
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const-string v1, "screen"
    invoke-direct {v3}, Lcom/palai/prootsmoke/SenseBridge;->screenJson()Lorg/json/JSONObject;
    move-result-object v2
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const-string v1, "power"
    invoke-direct {v3}, Lcom/palai/prootsmoke/SenseBridge;->powerJson()Lorg/json/JSONObject;
    move-result-object v2
    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;
    move-result-object v0
    return-object v0
    const-string v0, "{}"
    return-object v0
.end method

# virtual access=0x20001
.method public Lcom/palai/prootsmoke/SenseBridge;->addNotification(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V
    # registers=11 ins=7 tries=4
    const-string v9, "n"
    monitor-enter v4
    iget-wide v0, v4, Lcom/palai/prootsmoke/SenseBridge;->notifSeq:J
    const-wide/16 v2, #1
    add-long/2addr v0, v2
    iput-wide v0, v4, Lcom/palai/prootsmoke/SenseBridge;->notifSeq:J
    new-instance v10, Lorg/json/JSONObject;
    invoke-direct {v10}, Lorg/json/JSONObject;-><init>()V
    const-string v0, "seq"
    iget-wide v1, v4, Lcom/palai/prootsmoke/SenseBridge;->notifSeq:J
    invoke-virtual {v10, v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;
    const-string v0, "id"
    new-instance v1, Ljava/lang/StringBuilder;
    invoke-direct {v1, v9}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V
    iget-wide v2, v4, Lcom/palai/prootsmoke/SenseBridge;->notifSeq:J
    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;
    move-result-object v9
    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v9
    invoke-virtual {v10, v0, v9}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const-string v9, "pkg"
    if-nez v5, :L48
    const-string v5, ""
    :L48
    invoke-virtual {v10, v9, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const-string v5, "app"
    if-nez v6, :L57
    const-string v6, ""
    :L57
    invoke-virtual {v10, v5, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const-string v5, "title"
    if-nez v7, :L66
    const-string v7, ""
    :L66
    invoke-virtual {v10, v5, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    const-string v5, "text"
    if-nez v8, :L75
    const-string v8, ""
    :L75
    invoke-virtual {v10, v5, v8}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    iget-object v5, v4, Lcom/palai/prootsmoke/SenseBridge;->notifs:Ljava/util/List;
    invoke-interface {v5, v10}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :L83
    iget-object v5, v4, Lcom/palai/prootsmoke/SenseBridge;->notifs:Ljava/util/List;
    invoke-interface {v5}, Ljava/util/List;->size()I
    move-result v5
    const/16 v6, #64
    if-le v5, v6, :L100
    iget-object v5, v4, Lcom/palai/prootsmoke/SenseBridge;->notifs:Ljava/util/List;
    const/4 v6, #0
    invoke-interface {v5, v6}, Ljava/util/List;->remove(I)Ljava/lang/Object;
    goto :L83
    :L100
    monitor-exit v4
    return-void 
    move-exception v5
    monitor-exit v4
    throw v5
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/SenseBridge;->start()V
    # registers=5 ins=1 tries=0
    iget-boolean v0, v4, Lcom/palai/prootsmoke/SenseBridge;->running:Z
    if-eqz v0, :L5
    return-void 
    :L5
    const/4 v0, #1
    iput-boolean v0, v4, Lcom/palai/prootsmoke/SenseBridge;->running:Z
    new-instance v1, Ljava/lang/Thread;
    new-instance v2, Lcom/palai/prootsmoke/SenseBridge$$ExternalSyntheticLambda0;
    invoke-direct {v2, v4}, Lcom/palai/prootsmoke/SenseBridge$$ExternalSyntheticLambda0;-><init>(Lcom/palai/prootsmoke/SenseBridge;)V
    const-string v3, "sense-bridge"
    invoke-direct {v1, v2, v3}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;Ljava/lang/String;)V
    iput-object v1, v4, Lcom/palai/prootsmoke/SenseBridge;->thread:Ljava/lang/Thread;
    invoke-virtual {v1, v0}, Ljava/lang/Thread;->setDaemon(Z)V
    iget-object v0, v4, Lcom/palai/prootsmoke/SenseBridge;->thread:Ljava/lang/Thread;
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/SenseBridge;->stop()V
    # registers=2 ins=1 tries=1
    const/4 v0, #0
    iput-boolean v0, v1, Lcom/palai/prootsmoke/SenseBridge;->running:Z
    iget-object v0, v1, Lcom/palai/prootsmoke/SenseBridge;->server:Ljava/net/ServerSocket;
    if-eqz v0, :L10
    invoke-virtual {v0}, Ljava/net/ServerSocket;->close()V
    :L10
    const/4 v0, #0
    iput-object v0, v1, Lcom/palai/prootsmoke/SenseBridge;->server:Ljava/net/ServerSocket;
    return-void 
.end method

