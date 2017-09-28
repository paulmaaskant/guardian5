pullState:
  LDX stateStack
  LDA stateStack, X
  DEC stateStack
  RTS
