; IN pointer1 (fixed stats)
showSystemInfo:
	LDA #$3F
	STA systemMenuLine3+2

	LDA activeObjectStats+6
	JSR toBCD
	LDA par2
	STA systemMenuLine3+0
	LDA par3
	STA systemMenuLine3+1

	;LDY activeObjectIndex
	;LDA object+1, Y
	;AND #%00000111
	;JSR toBCD

	LDA #$3A
	STA systemMenuLine1+0
	STA systemMenuLine1+1
	STA systemMenuLine1+2

	RTS
