; ------------------------------------------
; retrieves dail position address
; IN A (object)TypeAndNumber
; OUT pointer1, fixed stats
; OUT Y , pointer1 + Y = current stats
; OUT A, current dail pos
; ------------------------------------------
getStatsAddress:
	PHA
	AND #%00000111
	ASL
	ASL
	TAY

	PLA
	AND #%01111000
	LSR
	LSR
	LSR
	TAX
	LDA objectTypeL, X
	CLC
	ADC #$08
	STA pointer1+0
	LDA objectTypeH, X
	ADC #$00
	STA pointer1+1

	LDA object+1, Y																																; current dail pos
	LSR																											
	LSR																																						; 3x shift right
	LSR																											
	PHA																											
	TAY																																						; multiply by 3 (3 bytes per dail click)
	ASL																																						; carry is guaranteed 0
	ADC identity, Y																											
	TAY																											
	PLA																																						; current dail pos in A
	RTS
