state_setActiveObjectPortrait:
  LDY activeObjectIndex
  LDA object+4, Y
  AND #%01111100
  JSR updatePortrait
  JMP pullState
