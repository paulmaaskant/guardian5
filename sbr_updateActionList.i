;---------------------------------------
; updateActionList
;
; Determine the actions the player can choose from based on the current target node
; IN	activeObjectTypeAndNumber
; IN	activeObjectGridPos
; OUT   actionList
;---------------------------------------

; --- action attributes ----
; byte1: game state, byte2: dictionary
actionTable:
	.db $10, 2				; 00 MOVE
	.db $12, 0				; 01 RANGED ATK 1
	.db $12, 1				; 02 RANGED ATK 2
	.db $14, 4				; 03 COOL DOWN
	.db $17, 7				; 04 CLOSE COMBAT
	.db $1B, 3				; 05 CHARGE
	.db $19, 19				; 06 PIVOT TURN
	.db $10, 24				; 07 RUN
	.db $3E, 28				; 08 AIM


; b7 show waypoints when confirming action?
; b6 check range?
; b5 check line of sight?
; b4 check charge distance?
; b3 calculate hit %?
; b2 check for reload, ammo and recycle?

actionPropertiesTable:
	.db %10000000			; 00 MOVE
	.db %01101100			; 01 RANGED ATK 1
	.db %01101100			; 02 RANGED ATK 2
	.db %00000000			; 03 COOL DOWN
	.db %01001000			; 04 CLOSE COMBAT
	.db %10011000			; 05 CHARGE
	.db %00000000			; 06 PIVOT TURN
	.db %10000000			; 07 RUN
	.db %00100000			; 08 AIM

actionPointCostTable:
	.db 1				                                                                ; 00 MOVE
	.db 1  			                                                                ; 01 RANGED ATK 1
	.db 1    		                                                                ; 02 RANGED ATK 2
	.db 0      	                                                                ; 03 COOL DOWN
	.db 1                                                                       ; 04 CLOSE COMBAT
	.db 3                                                                       ; 05 CHARGE
	.db 1                                                                       ; 06 PIVOT TURN
	.db 2
	.db 1

	aMOVE = $00
	aRANGED1 = $01
	aRANGED2 = $02
	aCOOLDOWN = $03
	aCLOSECOMBAT = $04
	aCHARGE = $05
	aPIVOT = $06
	aRUN = $07
	aAIM = $08

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
	BIT actionMessage
	BMI +done

	LDA #7
	JSR setTargetToolTip

+done:
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
