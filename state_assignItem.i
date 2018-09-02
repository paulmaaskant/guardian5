state_assignItem:
  LDA runningEffectCounter
  ASL
  ASL
  ASL
  ASL                 ; x16
  TAX
  PHA

  LDY list1+18
  SEC
  LDA #167
  SBC cursorScreenPosY, Y

  JSR multiply

  LDY list1+18
  LDA cursorScreenPosY, Y
  CLC
  ADC par1
  STA currentEffects+15

  PLA
  TAX
  LDY list1+18
  SEC
  LDA cursorScreenPosX, Y
  SBC #36

  JSR multiply

  LDY list1+18
  LDA cursorScreenPosX, Y
  SEC
  SBC par1
  STA currentEffects+9

  DEC runningEffectCounter
  BPL +done

  LDX list1+13
  STX list1+18
  LDA list1+12
  
  JSR updateSelectedItem

  LDA #$00
  JSR updatePalette

  SEC
  ROR list1+16
  JMP pullState

+done:
  LDA runningEffectCounter
  CMP #8
  BNE +skip
  LDA #$10
  JMP updatePalette

+skip:
  RTS
