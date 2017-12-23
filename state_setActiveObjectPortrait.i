state_setActiveObjectPortrait:
  LDA activeObjectTypeAndNumber
  JSR updatePortrait

  JMP pullState
