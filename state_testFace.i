state_testFace
  LDA buttons
  BEQ +continue
  JMP pullState

+continue:

  LDA list1
  BNE +continue

  LDA #$80
  JSR updatePortrait
  INC list1

+continue:

  RTS
