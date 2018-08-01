; ------------------------------------------
; retrieves dail position address
; IN Y (b3-0) object Index
; OUT pointer1, fixed stats
; ------------------------------------------
getStatsAddress:
	LDA object+0, Y
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA objectTypeL, X
	CLC
	ADC #8						; skip animation slots
	STA pointer1+0
	LDA objectTypeH, X
	ADC #0
	STA pointer1+1
	RTS
