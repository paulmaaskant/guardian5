prepareAction:
  LDA #$01
  LDY selectedAction
  LDX actionList, Y
  CPX #aCOOLDOWN
  BNE +store
  LDA #$FD                                                                      ; -3

+store:
  STA list3+0
  RTS
