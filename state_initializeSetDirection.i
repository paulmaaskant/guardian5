; ------------------------------------------
; gameState 0A: Initialize spin direction state
; ------------------------------------------
state_initializeSetDirection:
	LDA #$0F  										; clear menu indicators
	STA menuIndicator+0
	STA menuIndicator+1

	JSR clearActionMenu						; clear menu and write ...
	LDX #$00											; line 1, pos 0
	LDY #$0B											; "CHOOSE FACING DIRECTION"
	JSR writeToActionMenu					;

	JSR pullAndBuildStateStack
	.db 5													; 5 items
	.db $31, #eRefreshStatusBar		;
	.db $45, %00111000						; blink action menu (switch on)
	.db $07												; resolve
