state_shutDown:
  LDA #$00
  STA menuFlags
  STA selectedAction

  LDA #aCOOLDOWN
  STA actionList
  JSR calculateActionPointCost
  JSR applyActionPointCost
  JMP pullState
