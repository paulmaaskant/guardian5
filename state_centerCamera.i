; ------------------------------------------
; gameState 0B: sets the camera destination so that it centres on the active object
; ------------------------------------------
state_centerCamera:
	LDA activeObjectGridPos
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

  LDA #$0C					; wait for camera to center
	JMP replaceState
