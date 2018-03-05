; ------------------------------------------
; gameState 02: fade out fade in
; ------------------------------------------
; list2+0 = counter
;
; ------------------------------------------
state_fadeInOut:
	LDX list2+0
	LDA list2, X
	JSR updatePalette
	DEC list2+0
	BNE +continue
	JMP pullState

+continue:
	LDA list2+5
	STA blockInputCounter
	JSR buildStateStack
	.db 1
	.db $1A
