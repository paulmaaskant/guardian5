eff_evadePoints
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
  AND #$07
  BNE +done

  LDA runningEffectCounter
  AND #%00001000
  BEQ +continue
  LDA list3+14

+continue
  TAX
  LDA evadeSpriteMap1, X
  STA list3+33
  LDA evadeSpriteMap2, X
  STA list3+34
  LDA #$4D
  STA list3+35

+done:
  RTS
