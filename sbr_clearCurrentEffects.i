; ------------------------
; clear current  effects
; set all values to 0
; ------------------------
clearCurrentEffects:
  LDX #29
  LDA #0

-loop:
  STA currentEffects, X
  DEX
  BPL -loop
  RTS
