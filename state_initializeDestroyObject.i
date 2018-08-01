state_initializeDestroyObject:

  LDA #6
  STA effects
  JSR clearCurrentEffects
  LDX #5
  LDA #4

-loop:
  STA currentEffects+0, X
  DEX
  BPL -loop

  LDA #64
  STA list1+2

  LDA #$2D            ; run effect
  JMP replaceState
