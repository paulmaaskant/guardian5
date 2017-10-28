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

	JSR gridPosToScreenPos

	; --- camera X += current X ---
	LDA currentObjectXPos
	CLC
	ADC cameraX+1
	STA cameraXDest+1
	LDA currentObjectXScreen
	ADC cameraX+0
	STA cameraXDest+0

	; --- camera Y += current Y
	LDA currentObjectYPos
	CLC
	ADC cameraY+1
	STA cameraYDest+1
	LDA currentObjectYScreen
	ADC cameraY+0
	STA cameraYDest+0

	LDA #$88					; offset
	JSR updateCameraXPos		;
	LDA #$81					; offset
	JSR updateCameraYPos

	JMP pullState
