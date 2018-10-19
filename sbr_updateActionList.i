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
	JMP checkTarget									; done, tail chain

	; ----------------------------------
	; Cursor on OTHER UNIT at more than 1 hex distance
	; ----------------------------------
+skipCloseCombat:
	LDA #aATTACK								; add ATTACK
	JSR addPossibleAction

	LDA #aMARKTARGET						; add MARK
	CMP activeObjectStats+8			; special action
	BNE +noMark
	JSR addPossibleAction

+noMark:
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

	LDX #1
	LDA #aJUMP
	CMP activeObjectStats+8
	BNE +continue
	JSR addPossibleAction
	LDX #2

+continue:
	CPX selectedAction
	BCS +continue
	STX selectedAction

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
