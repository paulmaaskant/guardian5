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
	LDA #1
	STA selectedAction

	LDA activeObjectStats+2
	BMI +hoveringUnit
	LDA #aBRACE								; BRACE
	JSR addPossibleAction			; tail chain

+hoveringUnit:
	LDA #aPIVOT								; PIVOT TURN
	JMP addPossibleAction

+continue:
	LDA targetObjectTypeAndNumber																									; Cursor on other UNIT?
	BEQ +continue																																	; no -> continue
																																								; yes ->
	; ----------------------------------
	; Cursor on OTHER UNIT
	; ----------------------------------
	LDA #1
	STA selectedAction

	LDA distanceToTarget
	CMP #$01
	PHP
	BNE	+skipCloseCombat
	BIT activeObjectStats+2			; hovering units can't initiate close combat
	BMI +skipCloseCombat
	LDA #aCLOSECOMBAT
	JSR addPossibleAction
	PLP
	JMP checkTarget						;

+skipCloseCombat:
	LDA #aATTACK
	JSR addPossibleAction
	LDA #aMARKTARGET
	JSR addPossibleAction
	PLP
	BEQ +skipCharge
	LDA activeObjectStats+9
	CMP #2
	BCC +skipCharge
	BIT activeObjectStats+2			; hovering units can't charge
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
	BIT activeObjectStats+2			; check if unit can JUMP (b6)
	BVC +continue

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
