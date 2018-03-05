;
; game state 0D
;
; 0 fade out
; 1 fade in
; 2 flash in
; 3 flash out

state_changeBrightness:
  JSR pullParameter
  TAY
  ASL
  ASL
  CLC
  ADC identity, Y
  ADC #4
  TAY
  LDX #4
  STX list2+0

-loop:
  LDA state_0D_stream, Y
  STA list2+1, X
  DEY
  DEX
  BPL -loop

JSR buildStateStack
  .db 1
  ;.db $FF
  .db $02

state_0D_stream:
  .db -64, -48, -32, -16, 8
  .db   0, -16, -32, -48, 8
  .db  64,  48,  32,  16, 3
  .db   0,  16,  32,  48, 3
