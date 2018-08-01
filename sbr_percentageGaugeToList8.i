; X in = position
; A in = percentage

gaugeToList8:
  STA locVar1         ; percentage or score value

  TXA
  CLC
  ADC #3
  TAX

  LDY #3

-loop:
  LDA scoreToGaugeTable, Y
  CMP locVar1
  BCC +setTile3A
  BEQ +setTile3B
  LDA #$3C
  BPL +store

+setTile3A:
  LDA #$3A
  BPL +store

+setTile3B
  LDA #$3B

+store:
  STA list8, X
  DEX
  DEY
  BPL -loop

  RTS

;percentageToGaugeTable:
;  db 50, 60, 70, 80, 90
scoreToGaugeTable:
  db 1, 3, 5, 7
