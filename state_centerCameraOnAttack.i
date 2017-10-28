; ------------------------------------------
; gameState 2B: sets the camera destination so that it centres between the active unit and the cursor
; ------------------------------------------
state_centerCameraOnAttack:
  LDA cursorGridPos
  AND #$F0
  STA locVar1

  LDA activeObjectGridPos
  AND #$F0
  SEC
  SBC locVar1

  CMP #$80
  ROR
  CLC
  ADC locVar1
  AND #$F0
  STA locVar1

  LDA cursorGridPos
  AND #$0F
  STA locVar2

  LDA activeObjectGridPos
  AND #$0F
  SEC
  SBC locVar2

  CMP #$80
  ROR
  CLC
  ADC locVar2
  AND #$0F
  CLC
  ADC locVar1

	JSR centerCameraOnNode
	JMP pullState
