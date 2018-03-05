pullParameter:
  DEC stateStack

pullState:
  LDX stateStack
  LDA stateStack, X
  DEC stateStack
  RTS
