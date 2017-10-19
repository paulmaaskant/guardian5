; ------------------------------------------
; gameState 0C: Wait for the camera to reach its destination
; ------------------------------------------
state_waitForCamera:
	LDA cameraXDest+0
	CMP cameraX+0
	BNE +wait
	LDA cameraXDest+1
	CMP cameraX+1
	BNE +wait
	LDA cameraYDest+0
	CMP cameraY+0
	BNE +wait
	LDA cameraYDest+1
	CMP cameraY+1
	BNE +wait

	LDA activeObjectTypeAndNumber
	;BMI +done

	JSR showSystemInfo
  LDA events
	ORA event_updateTarget
	STA events

+done:
  JMP pullState

+wait:
	RTS
