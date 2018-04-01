

state_resolveTempGauge:
  LDA blockInputCounter
  BNE +wait
  JMP pullState

+wait:
  DEC blockInputCounter
  BIT bit2to0               ; once every 8 frames
  BNE +done


  AND #%00001000
  BEQ +oldGauge
  JSR updateSystemMenu

-refresh:
  LDA event_refreshStatusBar
  STA events

+done:
  RTS

+oldGauge:

  LDX #8                    ; copy current gauge to list1

-loop:
  LDA list1, X
  STA systemMenuLine1, X
  DEX
  BPL -loop
  BMI -refresh
