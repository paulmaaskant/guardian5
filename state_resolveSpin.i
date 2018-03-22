; ---------------------------------------------------
; game state 19: Initialize the order to spin without moving
; ---------------------------------------------------
state_initializePivotTurn:
	LDA #$03						; clear from list3+4
	LDX #$09						; up to and including list3+9
	JSR clearList3

	JSR applyActionPointCost
	JSR clearActionMenu

	JSR pullAndBuildStateStack
	.db 2			; 2 items
	.db $0A		; wait for direction
	.db $16		; show results
	; built in RTS
