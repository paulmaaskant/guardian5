eff_locked:

  DEC runningEffectCounter
  BNE +continue

  LDA #0
  STA runningEffect

+continue:
  LDA runningEffectCounter
  AND #%00000111
  BNE +done

  LDA effects
  EOR #%00000001
  STA effects

+done:
  RTS
