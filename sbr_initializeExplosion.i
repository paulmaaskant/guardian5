initializeExplosion:
  JSR clearCurrentEffects
  LDA #0
  STA actionCounter

  LDA #$0D
  STA currentEffects+0                ; animation
  STA currentEffects+1

  LDA #$0C
  STA currentEffects+2
  STA currentEffects+3

  LDA effects
  ORA #%00001000
  STA effects

  RTS
