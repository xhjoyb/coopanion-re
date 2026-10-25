.class Lcom/palai/prootsmoke/MainActivity$32;
.super Ljava/lang/Object;

.field final synthetic this$0:Lcom/palai/prootsmoke/MainActivity;
.field final synthetic val$sp:Landroid/content/SharedPreferences;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/MainActivity$32;-><init>(Lcom/palai/prootsmoke/MainActivity;Landroid/content/SharedPreferences;)V
    # registers=3 ins=3 tries=0
    iput-object v1, v0, Lcom/palai/prootsmoke/MainActivity$32;->this$0:Lcom/palai/prootsmoke/MainActivity;
    iput-object v2, v0, Lcom/palai/prootsmoke/MainActivity$32;->val$sp:Landroid/content/SharedPreferences;
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/MainActivity$32;->onClick(Landroid/content/DialogInterface;I)V
    # registers=4 ins=3 tries=0
    iget-object v2, v1, Lcom/palai/prootsmoke/MainActivity$32;->val$sp:Landroid/content/SharedPreferences;
    invoke-interface {v2}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;
    move-result-object v2
    const-string v3, "pet_alpha"
    const/high16 v0, #int 0x3f800000
    invoke-interface {v2, v3, v0}, Landroid/content/SharedPreferences$Editor;->putFloat(Ljava/lang/String;F)Landroid/content/SharedPreferences$Editor;
    move-result-object v2
    invoke-interface {v2}, Landroid/content/SharedPreferences$Editor;->apply()V
    iget-object v2, v1, Lcom/palai/prootsmoke/MainActivity$32;->this$0:Lcom/palai/prootsmoke/MainActivity;
    invoke-static {v2, v0}, Lcom/palai/prootsmoke/MainActivity;->-$$Nest$mpushAlphaToService(Lcom/palai/prootsmoke/MainActivity;F)V
    return-void 
.end method

