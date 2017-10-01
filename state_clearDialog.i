; ------------------------------------------
; gameState 0F: clear all tiles in text dialogue box on screen
; ------------------------------------------
; list1+0 address start tile hi
; list1+1 address start tile lo
; list1+2 address current tile hi
; list1+3 address current tile lo
; list1+4 # tiles margin left
; list1+5 # tiles new line break tile pos
; list1+6 reserved
; list1+7 number of lines to clear
state_clearDialog:

	LDA list1+5
	SEC
	SBC list1+4
	TAY
	ASL
	STA locVar1

	TSX						; switch stack pointers
	STX	stackPointer1
	LDX stackPointer2
	TXS

	LDA #$0F
-	PHA
	DEY
	BNE -

	LDA list1+1				; lo
	PHA
	LDA list1+0				; hi
	PHA
	LDA locVar1
	PHA

	TSX						; switch stack pointers back
	STX	stackPointer2
	LDX stackPointer1
	TXS

	DEC list1+7
	BNE +nextLine

	LDA list1+2				; set back current address to first char position
	STA list1+0
	LDA list1+3
	STA list1+1

	JMP pullState			; return to previous state

+nextLine:
	LDA #$20
	CLC
	ADC list1+1
	STA list1+1
	LDA list1+0
	ADC #$00
	STA list1+0

	RTS
