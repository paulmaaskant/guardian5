; -------------------------------
; can only be called with JSR because it needs the return address
; to pull byte for the stack
; -------------------------------
pullAndBuildStateStack:
  DEC stateStack

buildStateStack:
  PLA
  STA pointer1+0
  PLA
  STA pointer1+1
  LDY #$01
  LDA (pointer1), Y
  TAY
  INY
  LDX stateStack

-loop:
  LDA (pointer1), Y
  INX
  STA stateStack, X
  DEY
  CPY #$01
  BNE -loop
  STX stateStack
  RTS
