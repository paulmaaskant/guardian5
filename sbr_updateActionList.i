;---------------------------------------
; updateActionList
;
; Determine the actions the player can choose from based on the current target node
; IN	activeObjectTypeAndNumber
; IN	activeObjectGridPos
; OUT   actionList
;---------------------------------------
updateActionList:
	LDA #emptyString
	STA actionMessage					; clear message

	LDA #0
	STA infoMessage						; clear message
	STA menuFlags
	LDX #9										; clear list of possible actions

-loop:
	STA actionList, X					; clear action list
	DEX
	BPL -loop

	LDA cursorGridPos					; cursor on self?
	CMP activeObjectGridPos		; cursor on self?
	BNE +continue							; no -> continue																																							; yes ->

	; ----------------------------------
	; Cursor on SELF
	; ----------------------------------
	LDA #1													; reset
	STA selectedAction							;

	LDA activeObjectStats+2
	BMI +hoveringUnit								; hovering units can't BRACE
	LDA #aBRACE											; add BRACE
	JSR addPossibleAction						;

+hoveringUnit:
	LDA #aPIVOT											; add PIVOT TURN
	JMP addPossibleAction

	; ----------------------------------
	; Cursor not on SELF
	; ----------------------------------
+continue:
	LDA targetObjectTypeAndNumber		; Cursor on other UNIT?
	BEQ +continue										; no -> continue
																	; yes ->

	; ----------------------------------
	; Cursor on OTHER UNIT
	; ----------------------------------
	LDA #1													; reset
	STA selectedAction

	LDA distanceToTarget
	CMP #1
;	PHP
	BNE	+skipCloseCombat						; no close combat if target is at more than 1 hex distance
	BIT activeObjectStats+2
	BMI +skipCloseCombat						; no close combat of unit is hovering
	LDA #aCLOSECOMBAT								; add CLOSE COMBAT
	JSR addPossibleAction
	;PLP														; clean up stack
	JMP checkTarget									; done, tail chain

	; ----------------------------------
	; Cursor on OTHER UNIT at more than 1 hex distance
	; ----------------------------------
+skipCloseCombat:
	LDA #aATTACK								; add ATTACK
	JSR addPossibleAction

	BIT activeObjectStats+8			; check if unit can MARK (b6)
	BVC +noMark
	LDA #aMARKTARGET						; add MARK
	JSR addPossibleAction

+noMark:
	;PLP
	;BEQ +skipCharge
	LDA activeObjectStats+9
	CMP #2
	BCC +skipCharge							; no CHARGE if the unit has only 1 AP left
	BIT activeObjectStats+2			; no CHARGE for hovering units
	BMI +skipChargeAndBrace
	LDA #aCHARGE
	JSR addPossibleAction

+skipCharge:
	;LDA #aBRACE								; BRACE
	;JSR addPossibleAction			; removed because unclear what target menu shows

+skipChargeAndBrace:
	JMP checkTarget						;


	; ----------------------------------
	; Cursor on EMPTY SPACE
	; ----------------------------------
+continue:
	LDA #aMOVE
	JSR addPossibleAction

	LDA #1
	BIT activeObjectStats+8			; check if unit can JUMP (b7)
	BPL +continue
	LDA activeObjectStats+9
	CMP #2
	BCC +continue								; no JUMP if unit has only 1 AP left

	LDA #aJUMP
	JSR addPossibleAction
	LDA #2

+continue:
	CMP selectedAction
	BCS +continue
	STA selectedAction

+continue:
	JMP checkMovement

;---------------------------------------
; IN A, action #
;---------------------------------------
addPossibleAction:
	INC actionList
	LDX actionList			; count+1
	STA actionList, X
	RTS
