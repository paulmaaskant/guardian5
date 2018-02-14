bit2to0
  .db %00000111

state_resolveTempGauge:
  LDA blockInputCounter
  BNE +wait

  JSR pullState
  BNE +finalFrame

+wait:
  DEC blockInputCounter
  BIT bit2to0               ; once every 8 frames
  BNE +done
  AND #%00001000
  BNE +oldGauge

+finalFrame
  JSR updateSystemMenu

-refresh:
  LDA event_refreshStatusBar
  STA events

+done:
  RTS

+oldGauge:
  LDX #2                    ; copy current gauge to list1

-loop:
  LDA list1, X
  STA systemMenuLine1, X
  DEX
  BPL -loop
  BMI -refresh
