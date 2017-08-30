; ---------------------------------------------------
; game state 19: Initialize the order to spin without moving
; ---------------------------------------------------
state_initializePivotTurn:

; ---------------------------------------------------
; game state 1A: Initialize free order to spin are reaction to an enemy charge
; ---------------------------------------------------
state_initializeFreeSpin:
	LDA #$03						; clear from list3+4
	LDX #$09						; up to and including list3+9
	JSR clearList3

	JSR calculateHeat

	JSR clearActionMenu

	LDA #$0A							; state := init set direction
	STA gameState					;
	RTS
