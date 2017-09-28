; -----------------------------------------
; write 32 tiles
; -----------------------------------------
write32Tiles:
	TSX						; switch stack pointers
	STX	stackPointer1
	LDX stackPointer2
	TXS

	LDX #$20
-	JSR getNextByte
	PHA
	DEX
	BNE -

	LDA list1+2
	PHA
	LDA list1+1
	PHA
	LDA #$40
	PHA

	LDA list1+2			; increment pointer to tile position by 32
	CLC
	ADC #$20
	STA list1+2
	LDA list1+1
	ADC #$00
	STA list1+1

	TSX						; switch stack pointers back
	STX	stackPointer2
	LDX stackPointer1
	TXS

	RTS
