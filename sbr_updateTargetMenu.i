;------------------------------------------
; Update Target Menu
; called when cursor has moved
; still very messy
; -----------------------------------------
updateTargetMenu:
	;---- show distance to target ---
	LDA distanceToTarget
	JSR toBCD
	LDA #$3E
	STA targetMenuLine2+5
	LDA par2
	STA targetMenuLine2+3
	LDA par3
	STA targetMenuLine2+4

	;--- determine the target type (unit or empty node)
	LDA targetObjectTypeAndNumber
	BNE +displayTarget
	LDA #$34												; show empty hex
	STA targetMenuLine2+0
	LDA #$35
	STA targetMenuLine2+1
	RTS

+displayTarget:
	AND #%10000111
	BEQ +displayObstacle

	; --- target stats ---
	LDA #$3F												; default to active unit HP
	STA targetMenuLine1+5
	LDA systemMenuLine3+0
	STA targetMenuLine1+3
	LDA systemMenuLine3+1
	STA targetMenuLine1+4

	LDA cursorGridPos 							; is target the active unit?
	CMP activeObjectGridPos
	BEQ +done							     			; skip hp

	LDY targetObjectIndex						; retrieve target's hit points and show in menu
	LDA object+1, Y
 	LSR
	LSR
	LSR
	JSR toBCD																; convert health points to BCD for display purposes
	LDA par2																; the tens
	STA targetMenuLine1+3
	LDA par3																; the ones
	STA targetMenuLine1+4

+done:
	LDA #$30
	STA targetMenuLine1+0
	LDA #$31
	STA targetMenuLine1+1

	LDY targetObjectIndex
	JSR getStatsAddress
	LDY #4
	LDA (pointer1), Y
	BNE +skip

	LDA #$32
	STA targetMenuLine2+0
	LDA #$33
	STA targetMenuLine2+1

+skip:
	LDY #41												; "ENEMY"
	LDA targetObjectTypeAndNumber
	BMI +enemy
	AND #$07
	ASL
	ASL
	TAX
	LDY pilotTable-4, X           ; "<pilot name>""

+enemy:
	LDX #53
	JMP writeToActionMenu

+displayObstacle:
	LDA #$36
	STA targetMenuLine1+0
	LDA #$37
	STA targetMenuLine1+1
	LDA #$38
	STA targetMenuLine2+0
	LDA #$39
	STA targetMenuLine2+1
	RTS
