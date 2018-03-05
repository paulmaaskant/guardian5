state_expandStatusBar:
  LDA cameraYStatus
  BNE +continue
  LDA #$01													; start with sprite 1 (sprite 0 is permanently reserved)
	STA par3													; parameter to "loadAnimationFrame"
	LDA #$3F													; clear up to (including) sprite 15
	JSR clearSprites
  LDA #$00
  STA effects

  LDA #19
  STA portraitYPos

  LDA cameraYStatus
  SEC
  SBC #$10

+continue:
  CMP #$B0                          ; controls how far the menu expands downwards
  BNE +continue
  JMP pullState

+continue:
  SEC
  SBC #$02
  STA cameraYStatus
  INC $0200
  INC $0200
  RTS
