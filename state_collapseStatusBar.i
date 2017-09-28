state_collapseStatusBar:
  LDA cameraYStatus
  CMP #$EE
  BNE +continue
  LDA #$00
  STA cameraYStatus
  LDA #%11000000
  STA effects
  LDA events
  ORA event_updateSprites
  ORA event_updateTarget
  STA events
  LDA #$2E			; y pos
  STA $0200			; y pos
  JMP pullState

+continue:
  CLC
  ADC #$02
  STA cameraYStatus
  DEC $0200
  DEC $0200
  RTS
