;------------------------------------------
; Update Target Menu
; called when cursor has moved
; still very messy
; -----------------------------------------
updateTargetMenu:
	;---- show distance to target ---
	LDA distanceToTarget
	JSR toBCD
	LDA par2
	STA targetMenuImage+4
	LDA par3
	STA targetMenuImage+5

	;--- determine the target type (unit or empty node)
	LDA targetObjectTypeAndNumber
	BNE +displayTarget
	LDA #$34												; show empty hex
	STA targetMenuImage+2
	LDA #$35
	STA targetMenuImage+3
	RTS

+displayTarget:
	; --- target stats ---
	LDA #space												; default to active unit HP
	STA targetMenuLine1+2
	LDA systemMenuLine3+0
	STA targetMenuLine1+0
	LDA systemMenuLine3+1
	STA targetMenuLine1+1

	LDA #0
	JSR setTargetHeatGauge

	LDA targetObjectTypeAndNumber 	; is target the active unit?
	CMP activeObjectIndexAndPilot
	BEQ +done							     			; skip hp

	LDY targetObjectIndex						; retrieve target's hit points and show in menu
	LDA object+1, Y
 	LSR
	LSR
	LSR
	JSR toBCD																; convert health points to BCD for display purposes
	LDA par2																; the tens
	STA targetMenuLine1+0
	LDA par3																; the ones
	STA targetMenuLine1+1

+done:
	LDA targetObjectTypeAndNumber
	AND #%00000011
	BEQ +displayObstacle

	LDA #$30
	STA targetMenuImage+0
	LDA #$31
	STA targetMenuImage+1

	LDY targetObjectIndex
	JSR getStatsAddress
	LDY #7
	LDA (pointer1), Y
	BNE +skip

	LDA #$32
	STA targetMenuImage+2
	LDA #$33
	STA targetMenuImage+3

+skip:
	LDY targetObjectIndex
	LDA object+4, Y
	AND #%01111100
	TAY
	LDA pilotTable, Y
	STA targetMenuName
	RTS

+displayObstacle:
	LDA #$36
	STA targetMenuImage+0
	LDA #$37
	STA targetMenuImage+1
	LDA #$38
	STA targetMenuImage+2
	LDA #$39
	STA targetMenuImage+3
	RTS
