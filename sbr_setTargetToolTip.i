setTargetToolTip:
  STA targetEffectAnimation
  LDA effects
  ORA #%00010000
  STA effects
  RTS
