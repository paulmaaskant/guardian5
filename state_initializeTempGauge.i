; -----------------------------------
; state 42
; -----------------------------------

state_initializeTempGauge:
  JSR clearActionMenu

  LDX #8                    ; copy current HEAT gauge and AP list1

-loop:
  LDA systemMenuLine1, X
  STA list1, X
  DEX
  BPL -loop

  ;LDA #space
  ;STA systemMenuLine3+0
  ;STA systemMenuLine3+1
  ;STA systemMenuLine3+2

  LDX #5                    ; copy target current gauge HP to list1

-loop:
  LDA targetMenuLine1, X
  STA list1+10, X
  DEX
  BPL -loop

  LDA #72
  STA blockInputCounter

  JSR pullAndBuildStateStack
  .db 3
  .db $31, #eRefreshStatusBar           ; raise event
  .db $43                               ; resolve temp gauge / hit points
