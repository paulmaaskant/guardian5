state_initializePlayAnimation:

  LDA #$80
  STA currentObjectYPos
  STA currentObjectXPos

  LDA #$00
  STA currentObjectFrameCount

  LDA #$03
  STA list1+0

  LDA #$03
  STA list1+2

  LDA #$21
  JMP replaceState
