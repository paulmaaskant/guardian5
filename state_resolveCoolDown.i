; -------------------------------------------------
; game state 14: initialize cool down
; -------------------------------------------------
state_initializeCoolDown:

	LDA #$04						; clear from list3+4
	LDX #$09						; up to and including list3+9
	JSR clearList3

	LDA #$04
	STA list3+3						; stream 1: temp level decrease of X

	LDA #$02
	STA list3+0						; cool down value

	; -----


	LDA #$15
	STA gameState
	RTS

; -------------------------------------------------
; game state 15: resolve cool down
; -------------------------------------------------
state_resolveCoolDown:

	LDA #$16						; show results
	STA gameState
	RTS
