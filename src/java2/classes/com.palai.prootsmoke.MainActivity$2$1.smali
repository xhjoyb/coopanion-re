.class Lcom/palai/prootsmoke/MainActivity$2$1;
.super Ljava/lang/Object;

.field final synthetic this$1:Lcom/palai/prootsmoke/MainActivity$2;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$2$1;-><init>(Lcom/palai/prootsmoke/MainActivity$2;)V
    # registers=2 ins=2 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$2$1;->this$1:Lcom/palai/prootsmoke/MainActivity$2;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$2$1;->run()V
    # registers=3 ins=1 tries=0
    iget-object v0, v2, Lcom/palai/prootsmoke/MainActivity$2$1;->this$1:Lcom/palai/prootsmoke/MainActivity$2;
    iget-object v0, v0, Lcom/palai/prootsmoke/MainActivity$2;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$fgetlogScroll(Lcom/palai/prootsmoke/MainActivity;)Landroid/widget/ScrollView;
    move-result-object v0
    const/16 v1, #130
    invoke-virtual {v0, v1}, Landroid/widget/ScrollView;->fullScroll(I)Z
    return-void 
.end method

