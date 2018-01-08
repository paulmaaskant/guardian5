; IN pointer1 (fixed stats)
showSystemInfo:
	LDA #$3C
	STA systemMenuLine1+0

	LDA activeObjectStats+6
	JSR toBCD
	LDA par2
	STA systemMenuLine1+1
	LDA par3
	STA systemMenuLine1+2

	LDY activeObjectIndex
	LDA object+1, Y
	AND #%00000111
	JSR toBCD

	LDA #$3B
	STA systemMenuLine1+3
	LDA par2
	STA systemMenuLine1+4
	LDA par3
	STA systemMenuLine1+5

	RTS
