state_waitFrame:
  LDA blockInputCounter
  BNE +wait
  JMP pullState


+wait:
  DEC blockInputCounter
  RTS
