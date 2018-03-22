initializeExplosion:
  JSR clearCurrentEffects
  LDA #0
  STA runningEffectCounter

  LDA #$0D
  STA currentEffects+0                ; animation
  STA currentEffects+1

  LDA #$0C
  STA currentEffects+2
  STA currentEffects+3

  LDA #1
  STA runningEffect

  RTS
