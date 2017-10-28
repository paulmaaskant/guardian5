; ------------------------------------------
; gameState 0B: sets the camera destination so that it centres on the cursor
; ------------------------------------------
state_centerCameraOnCursor:
	LDA cursorGridPos

	JSR centerCameraOnNode
	JMP pullState
