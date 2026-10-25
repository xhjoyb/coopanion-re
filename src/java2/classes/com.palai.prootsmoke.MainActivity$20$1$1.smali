.class Lcom/palai/prootsmoke/MainActivity$20$1$1;
.super Ljava/lang/Object;

.field final synthetic this$2:Lcom/palai/prootsmoke/MainActivity$20$1;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$20$1$1;-><init>(Lcom/palai/prootsmoke/MainActivity$20$1;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$20$1$1;->this$2:Lcom/palai/prootsmoke/MainActivity$20$1;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$20$1$1;->run()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$20$1$1;->this$2:Lcom/palai/prootsmoke/MainActivity$20$1;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$20;->this$0:Lcom/palai/prootsmoke/MainActivity;
    iget-object v1, v2, Lcom/palai/prootsmoke/MainActivity$20$1$1;->this$2:Lcom/palai/prootsmoke/MainActivity$20$1;
    iget-object v1, v1, Lcom/palai/prootsmoke/MainActivity$20$1;->this$1:Lcom/palai/prootsmoke/MainActivity$20;
    iget v1, v1, Lcom/palai/prootsmoke/MainActivity$20;->val$attempt:I
    add-int/lit8 v1, v1, #1
    invoke-static {v0, v1}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mloadPetWithRetry(Lcom/palai/prootsmoke/MainActivity;I)V
    return-void 
.end method

