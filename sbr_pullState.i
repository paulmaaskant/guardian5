pullParameter:
  LDX stateStack
  LDA #0
  STA stateStack, X
  DEC stateStack

pullState:
  LDX stateStack
  LDA stateStack, X
  PHA
  LDA #0
  STA stateStack, X
  DEC stateStack
  PLA
  RTS
