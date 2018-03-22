
; state $40
state_initializeTargetLockMarker:
  LDA cursorGridPos
  JSR gridPosToScreenPos
  JSR clearCurrentEffects

  LDA #90                ; frame counter
  STA runningEffectCounter

  LDA #3
  STA currentEffects+0    ; # animation

  LDA currentObjectXPos   ; x cursor position
  STA currentEffects+6

  LDA currentObjectYPos   ; y cursor position
  STA currentEffects+12

  LDA #3
  STA runningEffect

  LDA effects
  AND #%11111000
  STA effects

  JMP pullState
