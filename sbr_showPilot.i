; ----------------------------
; Show pilot
; ----------------------------
; IN A (b7-b4) pilot ID
; IN Y position
showPilot:
	STY locVar2			; controls position

	PHA							; for bank
	LSR
	LSR
	PHA							; for address
	LSR
	LSR
	CLC
	ADC #$08
	STA currentPalettes+3

	PLA							; set address
	AND #%00001100
	CLC
	ADC #$40
	STA locVar1

	PLA							; set bank
	AND #%11000000
	ROL
	ROL
	ROL							; Carry clear
	ADC #$08
	STA $D001

	TSX							; switch stack pointers
	STX	stackPointer1
	LDX stackPointer2
	TXS

	LDY #$00

-outerLoop:
	LDX #$03

-innerLoop:
	TYA
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC locVar1
	ADC identity, X
	PHA
	DEX
	BPL -innerLoop
	TYA
	ROR
	ROR
	ROR
	ROR
	CLC
	ADC locVar2
	PHA
	LDA #$24
	ADC #$00
	PHA
	LDA #$08
	PHA

	INY
	CPY #$03
	BNE -outerLoop

	TSX					; switch stack pointers
	STX	stackPointer2
	LDX stackPointer1
	TXS

	LDA #$00
	JMP updatePalette
