eff_modifier:

  LDA effects
  ORA #$01
  STA effects

  DEC runningEffectCounter
  BNE +continue
  LDA #0
  STA runningEffect
  LDA effects
  AND #%11111000
  STA effects

+continue:
  LDA runningEffectCounter
  AND #$03
  BNE +done
  DEC currentEffects+12

+done:
  RTS
