state_shutDown:
  LDA #$00
  STA selectedAction
  LDA #aCOOLDOWN
  STA actionList
  JSR calculateActionPointCost
  JSR applyActionPointCost

  JMP pullState

;  JSR pullAndBuildStateStack
;  .db 2                 ; 2 items
;  .db $45, 00           ; clear menu flags
