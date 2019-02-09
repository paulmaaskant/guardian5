;------------------------------------------
; Update Target Menu
; called when cursor has moved
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
	JMP setTargetIcon

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
	LDY targetObjectIndex
	JSR getStatsAddress
	LDY #4
	LDA (pointer1), Y
	LSR
	LSR
	LSR
	LSR
	JSR setTargetIcon

	LDY targetObjectIndex
	LDA object+4, Y
	AND #%01111100
	TAY
	LDA pilotTable, Y
	STA targetMenuName
	RTS

; -------

setTargetIcon:
	TAX
	LDA targetIcon0, X
	STA targetMenuImage+0
	LDA targetIcon1, X
	STA targetMenuImage+1
	LDA targetIcon2, X
	STA targetMenuImage+2
	LDA targetIcon3, X
	STA targetMenuImage+3
	RTS

; 00 empty hex
; 01 strctr
; 02 big mech
; 03 small mech
; 04 lemur
; 05 convoy
; 06 turret

targetIcon0:
	.hex 0F 36 30 3D 30 3D 3D
targetIcon1:
	.hex 0F 37 31 3E 31 3E 3E
targetIcon2:
	.hex 34 38 32 32 0F 0F 38
targetIcon3:
	.hex 35 39 33 33 0F 0F 39
