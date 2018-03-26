; -------------------------------------
; Y is string #
; X is position
; -------------------------------------
writeToActionMenu:
	STX locVar1

	LDA stringListL, Y
	STA pointer1+0
	LDA stringListH, Y
	STA pointer1+1

	LDY #$00
	LDA (pointer1), Y			; length
	TAY

	CLC
	ADC locVar1
	TAX
-loop:
	LDA (pointer1), Y

	BPL +
	STY locVar1
	AND #$7F
	TAY
	LDA list3, Y
	LDY locVar1

+	STA actionMenuLine1-1, X

	DEX
	DEY

	BNE -loop
	RTS
