
; state $40
state_initializeTargetLockMarker:
  LDA cursorGridPos
  JSR gridPosToScreenPos
  JSR clearCurrentEffects

  LDA #$58
  STA list3+30
  LDA #$59
  STA list3+31
  LDA #$5A
  STA list3+32

  LDA #$60                ; frame counter
  STA list1+0

  LDA #7
  STA currentEffects+0    ; # animation

  LDA currentObjectXPos   ; x cursor position
  STA currentEffects+6

  LDA currentObjectYPos   ; y cursor position
  STA currentEffects+12

  LDA #1
  STA effects

  LDA #$41
  JMP replaceState
