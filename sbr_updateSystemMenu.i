; IN pointer1 (fixed stats)
updateSystemMenu:


	LDA activeObjectStats+6			; HIT POINTS
	JSR toBCD
	LDA par2
	STA systemMenuLine3+0
	LDA par3
	STA systemMenuLine3+1

	LDA #space									; warning marker?
	BIT activeObjectStats+0
	BPL +continue:
	LDA #$50

+continue:
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


	LDY #41												; "ENEMY"
	LDA activeObjectIndexAndPilot
	BMI +enemy
	AND #$07
	ASL
	ASL
	TAX
	LDY pilotTable-4, X           ; "<pilot name>""

+enemy:
	STY systemMenuName

	LDY activeObjectIndex
	LDA object+1, Y
	AND #$07
	CMP #3
	BCC +skip
	LDA #$50
	STA systemMenuLine1+2

+skip
	LDA #0											;
	JMP setSystemHeatGauge
