;
; A in increment
;
setSystemHeatGauge:
  PHA
  LDY activeObjectIndex				; HEAT POINT GAUGE
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
  STA systemMenuLine1+0
  LDA heatGauge1, Y
  STA systemMenuLine1+1
  RTS

heatGauge0:
	.hex 3C 3B 3A 3A 3A 3A 3A
heatGauge1:
	.hex 3C 3C 3C 3B 3A 3A 3A
;heatGauge2:
	;.hex 3C 3C 3C 3C 3C 3B 3A
