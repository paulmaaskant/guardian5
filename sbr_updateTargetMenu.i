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

	LDA #$2D
	STA targetMenuLine3+2

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
	LDA #$3F
	STA targetMenuLine1+5
	LDA systemMenuLine3+0
	STA targetMenuLine1+3
	LDA systemMenuLine3+1
	STA targetMenuLine1+4

	LDA cursorGridPos 							; check for target
	CMP activeObjectGridPos
	BEQ +done							     			; skip hp

	; --- hit points ---
	LDA list3+12
	STA targetMenuLine1+3
	LDA list3+13
	STA targetMenuLine1+4

+done:
	LDA #$30
	STA targetMenuLine1+0
	LDA #$31
	STA targetMenuLine1+1
	LDA #$32
	STA targetMenuLine2+0
	LDA #$33
	STA targetMenuLine2+1
	RTS

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
