pushState:
  INC stateStack
  LDX stateStack
  STA stateStack, X
  RTS
