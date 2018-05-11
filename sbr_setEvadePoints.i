setEvadePoints:
  LDA #0
  STA list3+14

  LDA actionMessage
  BMI +done
  LDA list1                   ; set evade points
  CLC
  ADC activeObjectStats+3			; moves from previous action
  SEC
  SBC #4											; 1 point for each move above 4
  BMI +done
  BEQ +done
  STA list3+14
  LDA #13
  STA actionMessage

+done:
  RTS
