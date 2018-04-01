; A grid pos
; Y effect index
setEffectCoordinates:
  JSR gridPosToScreenPos
  LDA currentObjectXPos   ; x cursor position
  STA currentEffects+6, Y
  LDA currentObjectYPos   ; y cursor position
  STA currentEffects+12, Y
  RTS
