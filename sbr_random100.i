random100:
	JSR random
	LDX #$64		;
	JSR multiply	;
	LDA par1		; between 0 and 99
	RTS
