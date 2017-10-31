state_initializeEffect:

  LDA effects
  AND #$F0
  ORA #$06
  STA effects

  LDX #5
  LDA #10

-loop:
  STA currentEffects+0, X
  DEX
  BPL -loop

  LDA #64
  STA list1+2

  LDA #$2D            ; run effect
  JMP replaceState
