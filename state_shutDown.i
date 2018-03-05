state_shutDown:
  LDA #0
  STA actionMessage
  STA selectedAction
  LDA #aCOOLDOWN
  STA actionList+0

  JSR calculateActionPointCost

  LDA #$14
  JMP replaceState
