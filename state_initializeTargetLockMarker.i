
; state $40
state_initializeTargetLockMarker:
  JSR clearCurrentEffects

  LDA cursorGridPos
  LDY #0
  JSR setEffectCoordinates

  LDA #90                ; frame counter
  STA runningEffectCounter

  LDA #3
  STA currentEffects+0    ; # animation

  LDA #3
  STA runningEffect

  LDA effects
  AND #%11111000
  STA effects

  JMP pullState
