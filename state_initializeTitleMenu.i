; ------------------------------------------
; gameState 1E: init title screen menu
; ------------------------------------------
state_initializeTitleMenu:

	;LDA #$2F
	;STA list8+0

	;LDA #$0F
	;STA list8+1
	;STA list8+2

	;LDA #0
	;STA list8+3						; selected option
	;STA list8+4						; selected sound
	;STA list8+5						; sound number ones
	;STA list8+6						; sound number tens


	;STA list1+0						; title screen animation counter

	LDX #6
-loop:
	LDA state_1E_initstream, X
	STA list8, X
	DEX
	BPL -loop


	JMP pullState

	state_1E_initstream:
		.db $2F, $0F, $0F, 0 , 0, 0, 0
