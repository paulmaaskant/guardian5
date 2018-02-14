
; state 42
state_initializeTempGauge:

  JSR clearActionMenu

  LDX #2                    ; copy current gauge to list1

-loop:
  LDA systemMenuLine1, X
  STA list1, X
  DEX
  BPL -loop

  LDA #80
  STA blockInputCounter

  JSR pullAndBuildStateStack
  .db 3
  .db $31, #eRefreshStatusBar           ; raise event
  .db $43                               ; wait
