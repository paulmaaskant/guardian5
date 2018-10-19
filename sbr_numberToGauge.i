; X value
; Y list8 position
; A difference

numberToGauge:
  STA locVar1

-nextPosition:
  DEX
  BMI +excess
  DEX
  BMI +single
  LDA #$3A
  BNE +set

+single:
  DEC locVar1
  BMI +skip
  LDA #$CC
  BNE +set

+skip:
  LDA #$3B
  BNE +set

+excess:
  DEC locVar1
  BMI +done
  LDA #$CB
  DEC locVar1
  BMI +set
  LDA #$CA

+set
  STA list8, Y
  INY
  BNE -nextPosition

+done:
  RTS
