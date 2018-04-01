;---------------------------------------
; updateActionList
;
; Determine the actions the player can choose from based on the current target node
; IN	activeObjectTypeAndNumber
; IN	activeObjectGridPos
; OUT   actionList
;---------------------------------------
updateActionList:
	LDA #$00
	STA actionMessage																															; clear message
	LDX #$09																																			; clear list of possible actions
-	STA actionList, X					; clear action list
	DEX
	BPL -
	LDA #$01
	STA selectedAction																														; list cleared

	LDA cursorGridPos																															; cursor on self?
	CMP activeObjectGridPos																												; cursor on self?
	BNE +continue																																	; no -> continue																																							; yes ->

	; ----------------------------------
	; Cursor on SELF
	; ----------------------------------
	LDA #aPIVOT								; PIVOT TURN
	JSR addPossibleAction
	LDA #aCOOLDOWN						; COOL DOWN
	JMP addPossibleAction			; tail chain


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
	LDA #aCLOSECOMBAT
	JSR addPossibleAction

+skipCloseCombat:
	LDA #aRANGED1
	JSR addPossibleAction
	LDA #aRANGED2
	JSR addPossibleAction
	LDA #aAIM
	JSR addPossibleAction
	PLP
	BEQ +skipCharge
	LDA activeObjectStats+9
	CMP #2
	BCC +skipCharge
	LDA #aCHARGE
	JSR addPossibleAction

+skipCharge:
	JSR checkTarget					; tail chain, check conditions for attack
	LDA #aCOOLDOWN						; COOL DOWN
	JMP addPossibleAction			; tail chain

	; ----------------------------------
	; Cursor on EMPTY SPACE
	; ----------------------------------
+continue:
	; --- find path ---
	LDA cursorGridPos
	STA par1										; par1 = destination node
	LDA activeObjectStats+2			;
	LDX activeObjectStats+9
	CPX #2
	BCC +continue
	ASL

+continue:
	STA par2										; par2 = # moves allowed
	LDX par1
	LDA nodeMap, X
	BPL +notBlocked
	LDA #$89										; deny (b7) + impassable (b6-b0)
	STA actionMessage
	BNE +walk

+notBlocked:
	LDA activeObjectGridPos																												; A = start node
	JSR findPath																																	; A* search path, may take more than 1 frame
	LDA actionMessage																															; if move is allowed
	BMI +done																																			; move > 1 heat
	LDA activeObjectStats+2																												; movement stat
	CMP list1																																			; compare to used number of moves (list1)
	BCS +walk
	LDA #aRUN
	JMP addPossibleAction

+walk:
	LDA #aMOVE
	JMP addPossibleAction

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
