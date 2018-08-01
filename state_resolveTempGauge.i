

state_resolveTempGauge:
  LDA blockInputCounter
  BNE +wait
  JMP pullState

+wait:
  DEC blockInputCounter
  BIT bit1to0               ; once every 8 frames
  BNE +done


  AND #%00000100
  BEQ +oldGauge
  JSR updateSystemMenu
  JSR updateTargetMenu

-refresh:
  LDA event_refreshStatusBar
  STA events

+done:
  RTS

+oldGauge:
  LDX #8                    ; copy current heat gauge to list1

-loop:
  LDA list1, X
  STA systemMenuLine1, X
  DEX
  BPL -loop

  LDX #5

-loop:
  LDA list1+10, X
  STA targetMenuLine1, X
  DEX
  BPL -loop
  BMI -refresh
