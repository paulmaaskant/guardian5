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
	STA targetMenuLine3+3
	LDA par2
	STA targetMenuLine3+4
	LDA par3
	STA targetMenuLine3+5

	;--- determine the target type (unit or empty node)
	LDA targetObjectTypeAndNumber
	BNE +displayTarget
	JMP showHexagon				; tail chain

+displayTarget:
	CMP activeObjectTypeAndNumber
	BEQ +done

	; --- target stats ---
	LDA #$3C
	STA targetMenuLine1+3
	LDA #$0F
	STA targetMenuLine1+4
	STA targetMenuLine2+4
	LDA #$0B
	STA targetMenuLine1+5
	STA targetMenuLine2+5

	LDA #$3A
	STA targetMenuLine2+3

	BIT actionMessage					; check for invalid target
	BMI +done							     ; skip power & hit

	; --- hit points ---
	LDA list3+12
	STA targetMenuLine1+4
	LDA list3+13
	STA targetMenuLine1+5

+done:
	JMP showTargetMech					; tail chain
