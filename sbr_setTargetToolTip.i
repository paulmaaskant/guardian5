setTargetToolTip:
  STA targetEffectAnimation
  BIT activeObjectIndexAndPilot
  BMI +done
  LDA effects
  ORA #%00010000
  STA effects
+done:
  RTS
