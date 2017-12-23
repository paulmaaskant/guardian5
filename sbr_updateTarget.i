;-----------------------------------------
; load target object
;	IN
;-----------------------------------------
updateTargetObject:
	LDA activeObjectGridPos
	STA par1
	LDA cursorGridPos
	JSR distance
	STA distanceToTarget

	LDX #$00
	STX targetObjectIndex
	STX targetObjectTypeAndNumber

-loop:
	LDA objectTypeAndNumber, X
	AND #$0F
	ASL
	ASL
	TAY
	LDA object+3, Y
	CMP cursorGridPos
	BEQ +setObjectAsTarget
	INX
	CPX objectCount
	BNE -loop
	RTS

+setObjectAsTarget:
	STY targetObjectIndex
	LDA objectTypeAndNumber, X
	STA targetObjectTypeAndNumber
	RTS
