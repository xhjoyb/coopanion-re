.class Lcom/palai/prootsmoke/CrashApp$1;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/CrashApp;
.field final synthetic val$prev:Ljava/lang/Thread$UncaughtExceptionHandler;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/CrashApp$1;-><init>(Lcom/palai/prootsmoke/CrashApp;Ljava/lang/Thread$UncaughtExceptionHandler;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/CrashApp$1;->this$0:Lcom/palai/prootsmoke/CrashApp;
    iput-object v2, v0, Lcom/palai/prootsmoke/CrashApp$1;->val$prev:Ljava/lang/Thread$UncaughtExceptionHandler;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/CrashApp$1;->uncaughtException(Ljava/lang/Thread;Ljava/lang/Throwable;)V
    # registers=4 ins=3 tries=1
    iget-object v0, v1, Lcom/palai/prootsmoke/CrashApp$1;->this$0:Lcom/palai/prootsmoke/CrashApp;
    invoke-static {v0, v2, v3}, Lcom/palai/prootsmoke/CrashApp;->-$$Nest$mdump(Lcom/palai/prootsmoke/CrashApp;Ljava/lang/Thread;Ljava/lang/Throwable;)V
    iget-object v0, v1, Lcom/palai/prootsmoke/CrashApp$1;->val$prev:Ljava/lang/Thread$UncaughtExceptionHandler;
    if-eqz v0, :L12
    invoke-interface {v0, v2, v3}, Ljava/lang/Thread$UncaughtExceptionHandler;->uncaughtException(Ljava/lang/Thread;Ljava/lang/Throwable;)V
    :L12
    return-void 
.end method

