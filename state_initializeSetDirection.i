; ------------------------------------------
; gameState 0A: Initialize spin direction state
; ------------------------------------------
state_initializeSetDirection:
	JSR clearActionMenu						; clear menu and write ...

	LDX #0											; line 1, pos 0
	LDY #11											; "CHOOSE FACING DIRECTION"
	JSR writeToActionMenu					;

	LDA #6
	STA blockInputCounter

	JSR pullAndBuildStateStack
	.db 6													; 5 items
	.db $31, #eRefreshStatusBar		;
	.db $45, %00111000						; blink action menu (switch on)
	.db $1A												; wait
	.db $07												; resolve
