;
; game state 0D
;
; 0 fade out
; 1 fade in
; 2 flash in
; 3 flash out

state_changeBrightness:
  JSR pullState
  JSR pullState
  TAY

  LDA #$00
  STA list2+0						; counter for fade out

  LDA state0D_startBrightness, Y
  STA list2+2

  LDA state0D_endBrightness, Y
  STA list2+5

  LDA state0D_timing, Y
  STA list2+4

  LDA state0D_toggle, Y
  STA list2+3

  LDA #$02
  JMP pushState

state0D_startBrightness:
  .db $00, $C0, $00, $40

state0D_endBrightness:
  .db $C0, $00, $40, $00

state0D_toggle:
  .db $00, $80, $80, $00

state0D_timing:
  .db $07, $07, $03, $03
