; ---------------------------------------------------
; game state 19: Initialize the order to spin without moving
; ---------------------------------------------------
state_initializePivotTurn:
	JSR applyActionPointCost
	JSR clearActionMenu

	JSR pullAndBuildStateStack
	.db 2			; 2 items
	.db $0A		; wait for direction
	.db $16		; show results
	; built in RTS
