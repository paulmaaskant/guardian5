; ------------------------------------------
; gameState 1E: init title screen menu
; ------------------------------------------
state_initializeTitleMenu:
	LDX #6
-loop:
	LDA state_1E_initstream, X
	STA list8, X
	DEX
	BPL -loop


	JMP pullState

	state_1E_initstream:
		.db $2F, $0F, $0F, 0 , 0, 0, 0
