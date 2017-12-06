state_setActiveObjectPortrait:
  LDA activeObjectTypeAndNumber
  ASL

  LDY activeObjectIndex
  LDA object+0, Y
  ASL

  LDY activeObjectTypeAndNumber
  CPY #$80
  ROR
  JSR updatePortrait

  JMP pullState
