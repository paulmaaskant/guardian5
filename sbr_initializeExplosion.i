initializeExplosion:
  JSR clearCurrentEffects
  LDA #0
  STA actionCounter

  LDA effects
  ORA #%00001000
  STA effects

  RTS
