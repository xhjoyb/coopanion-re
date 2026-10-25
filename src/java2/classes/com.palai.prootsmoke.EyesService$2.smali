.class Lcom/palai/prootsmoke/EyesService$2;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/EyesService;
.field final synthetic val$socket:Ljava/net/Socket;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/EyesService$2;-><init>(Lcom/palai/prootsmoke/EyesService;Ljava/net/Socket;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/EyesService$2;->this$0:Lcom/palai/prootsmoke/EyesService;
    iput-object v2, v0, Lcom/palai/prootsmoke/EyesService$2;->val$socket:Ljava/net/Socket;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/EyesService$2;->run()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/EyesService$2;->this$0:Lcom/palai/prootsmoke/EyesService;
    iget-object v1, v2, Lcom/palai/prootsmoke/EyesService$2;->val$socket:Ljava/net/Socket;
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/EyesService;->access$100(Lcom/palai/prootsmoke/EyesService;Ljava/net/Socket;)V
    return-void 
.end method

