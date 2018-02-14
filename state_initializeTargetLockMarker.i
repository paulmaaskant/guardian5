
; state $40
state_initializeTargetLockMarker:
  LDA cursorGridPos
  JSR gridPosToScreenPos
  JSR clearCurrentEffects

  LDA #$60                ; frame counter
  STA list1+0

  LDA #3
  STA currentEffects+0    ; # animation

  LDA currentObjectXPos   ; x cursor position
  STA currentEffects+6

  LDA currentObjectYPos   ; y cursor position
  STA currentEffects+12

  LDA #1
  STA effects

  LDA #$41
  JMP replaceState
