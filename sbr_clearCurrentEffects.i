; ------------------------
; clear current  effects
; set all values to 0
; ------------------------
clearCurrentEffects:
  LDX #$1D
  LDA #$00

-loop:
  STA currentEffects, X
  DEX
  BPL -loop
  RTS
