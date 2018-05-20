;---------------------------------------
; updateActionList
;
; Determine the actions the player can choose from based on the current target node
; IN	activeObjectTypeAndNumber
; IN	activeObjectGridPos
; OUT   actionList
;---------------------------------------
updateActionList:
	LDA #0
	STA actionMessage					; clear message
	STA infoMessage						; clear message
	STA menuFlags
	LDX #9										; clear list of possible actions

-loop:
	STA actionList, X					; clear action list
	DEX
	BPL -loop
	LDA #1
	STA selectedAction				; init selected action

	LDA cursorGridPos					; cursor on self?
	CMP activeObjectGridPos		; cursor on self?
	BNE +continue							; no -> continue																																							; yes ->

	; ----------------------------------
	; Cursor on SELF
	; ----------------------------------

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
	LDA distanceToTarget
	CMP #$01
	PHP
	BNE	+skipCloseCombat
	BIT activeObjectStats+2			; hovering units can't initiate close combat
	BMI +skipCloseCombat
	LDA #aCLOSECOMBAT
	JSR addPossibleAction

+skipCloseCombat:
	LDA #aRANGED1
	JSR addPossibleAction
	LDA #aRANGED2
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
	; --- find path ---
	LDA cursorGridPos
	STA par1										; par1 = destination node

	LDA activeObjectStats+2			; move type | movepoints
	STA par3
	AND #$0F										; 0000 | movement points

	LDX activeObjectStats+9
	CPX #2
	BCC +continue
	ASL													; double movement (RUN)

+continue:
	STA par2										; par2 = # moves allowed
	LDX par1
	LDA nodeMap, X
	BPL +notBlocked							; not blocked
	BIT activeObjectStats+2
	BPL +blocked								; if ground unit -> blocked
	LSR													; for hovering unit
	BPL +notBlocked							; if L-O-S is possible, then not blocked

+blocked:
	LDA #$89										; deny (b7) + impassable (b6-b0)
	STA actionMessage
	BNE +walk

+notBlocked:
	LDA activeObjectGridPos																												; A = start node
	JSR findPath																																	; A* search path, may take more than 1 frame
	LDA actionMessage																															; if move is allowed
	BMI +done																																			; move > 1 heat
	LDA activeObjectStats+2																												; movement stat
	AND #$0F
	CMP list1																																			; compare to used number of moves (list1)
	BCS +walk
	LDA #aRUN
	JSR addPossibleAction
	JMP +checkEvade

+walk:
	LDA #aMOVE
	JSR addPossibleAction

+checkEvade:
	JMP setEvadePoints

+done:
	RTS

;---------------------------------------
; IN A, action #
;---------------------------------------
addPossibleAction:
	INC actionList
	LDX actionList			; count+1
	STA actionList, X
	RTS
