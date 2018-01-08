; ------------------------------------------
; gameState 2B: sets the camera destination so that it centres between the active unit and the cursor
; ------------------------------------------
state_centerCameraOnAttack:
  LDY targetObjectIndex
  LDA object+3, Y
  AND #$F0
  STA locVar1


  LDA activeObjectGridPos
  AND #$F0
  CLC
  ADC locVar1
  ROR
  AND #$F0
  STA locVar1

  LDA object+3, Y
  AND #$0F
  STA locVar2

  LDA activeObjectGridPos
  AND #$0F
  CLC
  ADC locVar2
  ROR
  CLC
  ADC locVar1

	JSR centerCameraOnNode
	JMP pullState
