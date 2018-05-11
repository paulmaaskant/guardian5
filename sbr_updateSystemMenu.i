; IN pointer1 (fixed stats)
updateSystemMenu:


	LDA activeObjectStats+6			; HIT POINTS
	JSR toBCD
	LDA par2
	STA systemMenuLine3+0
	LDA par3
	STA systemMenuLine3+1
	;LDA #$3F
	LDA #space
	STA systemMenuLine3+2

	LDA #$0F										; REMAINING AP
	LDX #3
-loop:
	CPX activeObjectStats+9
	BNE +continue
	LDA #$0C
+continue:
	STA systemMenuLine2-1, X
	DEX
	BNE -loop

	LDA #0											;
	JMP setSystemHeatGauge
