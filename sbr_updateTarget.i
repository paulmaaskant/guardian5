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
	LDA objectList, X
	AND #%01111000
	TAY
	LDA object+3, Y
	CMP cursorGridPos
	BEQ +setObjectAsTarget
	INX
	CPX objectListSize
	BNE -loop
	RTS

+setObjectAsTarget:
	STY targetObjectIndex
	LDA objectList, X
	STA targetObjectTypeAndNumber
	RTS
