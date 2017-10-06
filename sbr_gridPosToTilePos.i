; --------------------------------------------------------
; gridPosToTilePos
;
; IN A
; LOC locVar1, locVar2
; OUT list1
; --------------------------------------------------------
gridPosToTilePos:
	; --- separate grid X & Y ---
	PHA
	LSR 					; y mask
	LSR
	LSR
	LSR
	STA locVar2				; YYYY
	PLA
	AND #$0F				; x mask
	STA locVar1				; XXXX

	; --- calculate Y position ---
	SEC
	SBC locVar2				; (XXXX - YYYY)
	CLC
	ADC #$10
	STA list1+0, X

	; --- calculate X position ---
	LDA locVar1
	CLC
	ADC locVar2
	STA list1+1, X			; (X+Y) (max 30)
	ASL A
	ADC list1+1, X
	STA list1+1, X			; (X+Y) * 3

	RTS
