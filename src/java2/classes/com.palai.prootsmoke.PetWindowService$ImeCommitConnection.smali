.class Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;
.super Ljava/lang/Object;

.field private final base:Landroid/view/inputmethod/InputConnection;
.field private final sink:Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;

# direct access=0x10000
.method constructor Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;-><init>(Landroid/view/inputmethod/InputConnection;Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;)V
    # registers=3 ins=3 tries=0
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V
    iput-object v1, v0, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    iput-object v2, v0, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->sink:Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->beginBatchEdit()Z
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0}, Landroid/view/inputmethod/InputConnection;->beginBatchEdit()Z
    move-result v0
    return v0
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->clearMetaKeyStates(I)Z
    # registers=3 ins=2 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2}, Landroid/view/inputmethod/InputConnection;->clearMetaKeyStates(I)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->closeConnection()V
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0}, Landroid/view/inputmethod/InputConnection;->closeConnection()V
    return-void 
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->commitCompletion(Landroid/view/inputmethod/CompletionInfo;)Z
    # registers=3 ins=2 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2}, Landroid/view/inputmethod/InputConnection;->commitCompletion(Landroid/view/inputmethod/CompletionInfo;)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->commitContent(Landroid/view/inputmethod/InputContentInfo;ILandroid/os/Bundle;)Z
    # registers=5 ins=4 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2, v3, v4}, Landroid/view/inputmethod/InputConnection;->commitContent(Landroid/view/inputmethod/InputContentInfo;ILandroid/os/Bundle;)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->commitCorrection(Landroid/view/inputmethod/CorrectionInfo;)Z
    # registers=3 ins=2 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2}, Landroid/view/inputmethod/InputConnection;->commitCorrection(Landroid/view/inputmethod/CorrectionInfo;)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->commitText(Ljava/lang/CharSequence;I)Z
    # registers=5 ins=3 tries=3
    if-eqz v3, :L17
    invoke-interface {v3}, Ljava/lang/CharSequence;->length()I
    move-result v0
    if-lez v0, :L17
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->sink:Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;
    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;
    move-result-object v1
    invoke-interface {v0, v1}, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;->onCommit(Ljava/lang/String;)V
    :L17
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v3, v4}, Landroid/view/inputmethod/InputConnection;->commitText(Ljava/lang/CharSequence;I)Z
    iget-object v3, v2, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->sink:Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;
    invoke-interface {v3}, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;->onClearLocal()V
    const/4 v3, #1
    return v3
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->deleteSurroundingText(II)Z
    # registers=4 ins=3 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2, v3}, Landroid/view/inputmethod/InputConnection;->deleteSurroundingText(II)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->deleteSurroundingTextInCodePoints(II)Z
    # registers=4 ins=3 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2, v3}, Landroid/view/inputmethod/InputConnection;->deleteSurroundingTextInCodePoints(II)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->endBatchEdit()Z
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0}, Landroid/view/inputmethod/InputConnection;->endBatchEdit()Z
    move-result v0
    return v0
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->finishComposingText()Z
    # registers=4 ins=1 tries=3
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    const/16 v1, #4096
    const/4 v2, #0
    invoke-interface {v0, v1, v2}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;
    move-result-object v0
    if-eqz v0, :L26
    invoke-interface {v0}, Ljava/lang/CharSequence;->length()I
    move-result v1
    if-lez v1, :L26
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;
    move-result-object v0
    iget-object v1, v3, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->sink:Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;
    invoke-interface {v1, v0}, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;->onCommit(Ljava/lang/String;)V
    :L26
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0}, Landroid/view/inputmethod/InputConnection;->finishComposingText()Z
    iget-object v0, v3, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->sink:Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;
    invoke-interface {v0}, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;->onClearLocal()V
    const/4 v0, #1
    return v0
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->getCursorCapsMode(I)I
    # registers=3 ins=2 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2}, Landroid/view/inputmethod/InputConnection;->getCursorCapsMode(I)I
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->getExtractedText(Landroid/view/inputmethod/ExtractedTextRequest;I)Landroid/view/inputmethod/ExtractedText;
    # registers=4 ins=3 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2, v3}, Landroid/view/inputmethod/InputConnection;->getExtractedText(Landroid/view/inputmethod/ExtractedTextRequest;I)Landroid/view/inputmethod/ExtractedText;
    move-result-object v2
    return-object v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->getHandler()Landroid/os/Handler;
    # registers=2 ins=1 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0}, Landroid/view/inputmethod/InputConnection;->getHandler()Landroid/os/Handler;
    move-result-object v0
    return-object v0
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->getSelectedText(I)Ljava/lang/CharSequence;
    # registers=3 ins=2 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2}, Landroid/view/inputmethod/InputConnection;->getSelectedText(I)Ljava/lang/CharSequence;
    move-result-object v2
    return-object v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->getTextAfterCursor(II)Ljava/lang/CharSequence;
    # registers=4 ins=3 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2, v3}, Landroid/view/inputmethod/InputConnection;->getTextAfterCursor(II)Ljava/lang/CharSequence;
    move-result-object v2
    return-object v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;
    # registers=4 ins=3 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2, v3}, Landroid/view/inputmethod/InputConnection;->getTextBeforeCursor(II)Ljava/lang/CharSequence;
    move-result-object v2
    return-object v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->performContextMenuAction(I)Z
    # registers=3 ins=2 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2}, Landroid/view/inputmethod/InputConnection;->performContextMenuAction(I)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->performEditorAction(I)Z
    # registers=3 ins=2 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2}, Landroid/view/inputmethod/InputConnection;->performEditorAction(I)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->performPrivateCommand(Ljava/lang/String;Landroid/os/Bundle;)Z
    # registers=4 ins=3 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2, v3}, Landroid/view/inputmethod/InputConnection;->performPrivateCommand(Ljava/lang/String;Landroid/os/Bundle;)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->reportFullscreenMode(Z)Z
    # registers=3 ins=2 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2}, Landroid/view/inputmethod/InputConnection;->reportFullscreenMode(Z)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->requestCursorUpdates(I)Z
    # registers=3 ins=2 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2}, Landroid/view/inputmethod/InputConnection;->requestCursorUpdates(I)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->sendKeyEvent(Landroid/view/KeyEvent;)Z
    # registers=4 ins=2 tries=1
    if-eqz v3, :L21
    invoke-virtual {v3}, Landroid/view/KeyEvent;->getAction()I
    move-result v0
    if-nez v0, :L21
    invoke-virtual {v3}, Landroid/view/KeyEvent;->getKeyCode()I
    move-result v0
    const/16 v1, #67
    if-ne v0, v1, :L21
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->sink:Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;
    invoke-interface {v0}, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection$Sink;->onDelete()V
    :L21
    iget-object v0, v2, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v3}, Landroid/view/inputmethod/InputConnection;->sendKeyEvent(Landroid/view/KeyEvent;)Z
    move-result v3
    return v3
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->setComposingRegion(II)Z
    # registers=4 ins=3 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2, v3}, Landroid/view/inputmethod/InputConnection;->setComposingRegion(II)Z
    const/4 v2, #1
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->setComposingText(Ljava/lang/CharSequence;I)Z
    # registers=4 ins=3 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2, v3}, Landroid/view/inputmethod/InputConnection;->setComposingText(Ljava/lang/CharSequence;I)Z
    move-result v2
    return v2
.end method

# virtual access=0x1
.method public Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->setSelection(II)Z
    # registers=4 ins=3 tries=0
    iget-object v0, v1, Lcom/palai/prootsmoke/PetWindowService$ImeCommitConnection;->base:Landroid/view/inputmethod/InputConnection;
    invoke-interface {v0, v2, v3}, Landroid/view/inputmethod/InputConnection;->setSelection(II)Z
    move-result v2
    return v2
.end method

