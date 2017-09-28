; -------------------------------------------------
; game state 14: initialize cool down
; -------------------------------------------------
state_initializeCoolDown:

	LDA #$03						; clear from list3+3
	LDX #$09						; up to and including list3+9
	JSR clearList3

	JSR calculateHeat

	LDA #$00
	STA list1+0

	JSR pullAndBuildStateStack
	.db 2			; 2 items
	.db $15
	.db $16
	; built in RTS

; -------------------------------------------------
; game state 15: resolve cool down
; -------------------------------------------------
state_resolveCoolDown:
	; animation here
	LDA list1+0
	CMP #$E0
	BNE +continue
	JMP pullState

+continue:
	INC list1+0

	RTS
