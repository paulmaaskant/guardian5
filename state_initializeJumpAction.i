;-------------------------------------
; initialize action resolution: JUMP
;-------------------------------------
state_initializeJumpAction:

	JSR applyActionPointCost
	JSR clearActionMenu					; clear the menu

	LDX #13											; line 2
	LDY #12											; "jumping"
	JSR writeToActionMenu

	JSR pullAndBuildStateStack
	.db 14								; 13 items
	.db $45, %00111000		; blink action menu (all lines)
	.db $31, #eRefreshStatusBar
	.db $3A, 16				  	; switch CHR bank 1 to bank with mech jump animation
	.db $54 							; init and resolve JUMP
	.db $3A, 0						; switch CHR bank 1 back to 0
	.db $0B								; center camera on cursor
	.db $0A								; set direction
	.db $58, 0						; active object evade point marker animation
	.db $16								; show results
	; built in RTS

  -
