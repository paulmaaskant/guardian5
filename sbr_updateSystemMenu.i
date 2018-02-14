; IN pointer1 (fixed stats)
updateSystemMenu:
	LDA #$3F
	STA systemMenuLine3+2

	LDA activeObjectStats+6
	JSR toBCD
	LDA par2
	STA systemMenuLine3+0
	LDA par3
	STA systemMenuLine3+1

	LDY activeObjectIndex
	LDA object+1, Y
	AND #%00000111
	TAY
	LDA heatGauge0, Y
	STA systemMenuLine1+0
	LDA heatGauge1, Y
	STA systemMenuLine1+1
	LDA heatGauge2, Y
	STA systemMenuLine1+2

	RTS

heatGauge0:
	.hex 3C 3B 3A 3A 3A 3A 3A
heatGauge1:
	.hex 3C 3C 3C 3B 3A 3A 3A
heatGauge2:
	.hex 3C 3C 3C 3C 3C 3B 3A
