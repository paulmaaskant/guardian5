setTargetHeatGauge:
  PHA
  LDY targetObjectIndex				; HEAT POINT GAUGE
  LDA object+1, Y
  AND #%00000111
  TAY
  PLA                         ; increment
  CLC
  ADC identity, Y             ; plus current heat
  BPL +next
  LDA #0                      ; bottom at 0

+next:
  CMP #6
  BCC +next
  LDA #6                      ; cap at 6

+next:
  TAY                         ; result
  LDA heatGauge0, Y
  STA targetMenuLine2+0
  LDA heatGauge1, Y
  STA targetMenuLine2+1
  RTS
