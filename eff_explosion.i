eff_explosion:
  LDA currentEffects+18
  CMP #1
  BNE +done

  LDY runningEffectCounter
  DEY
  BPL +continue
  LDY #2

+continue:
  CLC
  LDA currentEffects+6
  ADC explosion_offset_X, Y
  STA currentEffects+6

  CLC
  LDA currentEffects+12
  ADC explosion_offset_Y, Y
  STA currentEffects+12

  STY runningEffectCounter


+done:
  RTS

explosion_offset_X:
  .db -3, 6, -3

explosion_offset_Y:
  .db -3, 0, 3
