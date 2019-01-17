;-------------------------------------
; initialize action resolution: MOVE
;-------------------------------------
state_initializeMoveAction:
	JSR applyActionPointCost
	JSR clearActionMenu					; clear the menu

	LDX #13											; line 2
	LDY #10											; "moving"
	JSR writeToActionMenu

	LDY activeObjectIndex
	LDA object+7, Y             ; set evade points
	AND #%11111000							; clear evade points
	ORA list3+14
	STA object+7, Y

	JSR pullAndBuildStateStack
	.db 14								; 13 items
	.db $45, %00111000		; blink action menu (all lines)
	.db $31, #eRefreshStatusBar
	.db $3A, $FF					; switch CHR bank 1 to bank with active unit move animation
	.db $3B 							; init and resolve move
	.db $3A, 0						; switch CHR bank 1 back to 0
	.db $0B								; center camera on cursor
	.db $0A								; set direction
	.db $58, 0						; active object evade point marker animation
	.db $16								; show results
	; built in RTS
