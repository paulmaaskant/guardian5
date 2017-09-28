
; list3+0			heat increase / decrease
; list3+1			Hit Probability
; list3+2			Damage value
; list3+3..9	Result messages / streams


;
; list3+10		hit probability BCD digit 10
; list3+11		hit probability BCD digit 01
; list3+12		target dial BCD digit 10
; list3+13		target dial BCD digit 01

; list3+20		target dial
; list3+21		damage sustained by attacker
; list3+22		attacker dail
; list3+22		close combat animation
; list3+23		close combat sound



; -----------------------------------------
; the following subroutines are used to determine the visibility of a target

; - is the target within the firing arc (ranged, close combat)
; - is the target within range (ranged)
; - is the line of sight unblocked (ranged)
; - is the grid pos in contact with only one hostile (charge)
; -----------------------------------------
checkTarget:
	LDA #$00																																			; set charge damage to 0
	STA list3+21

;	LDA #$01																																			; default heat increase
;	STA list3+0

	; --- retrieve action ---
	LDY selectedAction
	LDX actionList, Y
	CPX #aCHARGE																																	; if action is CHARGE
	BEQ +chargeChecks																															; continue to charge checks

	; --- check arc ---																														; otherwise, check field of vision
	JSR checkFiringArc																														; note: leaves X intact
	BCS +nextCheck
	LDA #$8A																																			; deny (b7) + outside of arc (b6-b0)
	STA actionMessage
	RTS

+nextCheck:
	CPX #aCLOSECOMBAT						; if action is 04
	BEQ +checksDone							; all checks are done

	; --- check min max distance for ranged attacks ---
	JSR checkRange							; destroys X
	LDA actionMessage
	BEQ +nextCheck
	RTS

+nextCheck:
	; --- check line of sight ---
	JSR checkLineOfSight
	BCC +checksDone

	LDA effects
	ORA #%00100000							; active block marker
	STA effects

	LDA #$85										; deny (b7) + no line of sight (b6-b0)
	STA actionMessage
	RTS

+chargeChecks:
	LDX cursorGridPos						; unblock target node first: to make sure findPath works
	LDA nodeMap, X							;
	AND #$7F										; unset blocked flag
	STA nodeMap, X

	; --------------------------
	; Call find path
	; --------------------------
	LDA cursorGridPos
	STA par1										; par1 = destination node
	LDA activeObjectStats+2			; movement stat
	ASL													; x 2
	STA par2										; par2 = # moves allowed
	INC par2										; one extra (specific to charge)
	LDA activeObjectGridPos			; A =  start node
	JSR findPath								; CALL: A* search path, may take more than 1 frame

	LDX cursorGridPos						; re-block target node
	LDA nodeMap, X							;
	ORA #$80										; reset blocked flag
	STA nodeMap, X

	BIT actionMessage
	BMI +return

	; TODO
	; condition for charge: adjacent to exactly 1 hostile
	; JSR isChargePossible

	LDA #$01
	STA list3+21																																	; 1 charge damage sustained

+checksDone:
	LDA activeObjectStats+5																												; calculate hit chance
	AND #%00111000																																; first get attacker accuracy
	LSR
	LSR
	LSR
	ADC #$05																																			; CLC guaranteed
	PHA 																																					; ACCURACY on stack
	LDA targetObjectTypeAndNumber																									; then get targets health & defence value
	JSR getStatsAddress
	STA list3+20																																	; target health points
	JSR toBCD																																			; convert health points to BCD for display purposes
	LDA par2																																			; the tens
	STA list3+12
	LDA par3																																			; the ones
	STA list3+13
	PLA
	TAX														; move ACCURACY to X
	LDA (pointer1), Y							; retrieve target's defence
	AND #$07
	CLC
	ADC #$0F											; target's DEFENSE
	SEC
	SBC identity, X								; minus active unit's ACCURACY
	TAY
	LDA hitProbability, Y					; look up the hit probability
	STA list3+1										; store hit probability
	JSR toBCD											; convert to BCD for display purposes
	LDA par2
	STA list3+10
	LDA par3
	CLC
	ADC #$10
	STA list3+11
	LDY selectedAction
	LDX actionList, Y							; 1 for weapon 1, 2 for weapon 2
	LDA activeObjectStats+3				; default weapon 1 (primary) damage
	CPX #aRANGED2									; unless the secondary weapon is selected
	BNE +continue
	LDA activeObjectStats+4				; weapon 2

+continue
	CPX #aCHARGE
	BNE +continue
	CLC
	ADC #$01											; add one damage if CHARGing

+continue:
	STA list3+2										; damage
	LDA #$14											; STR4 RNG 2-8
	STA actionMessage

+return
	RTS

; -----------------------------------------
;
; -----------------------------------------
checkRange:
	; -- determine which weapon is selected ---
	LDY selectedAction
	LDX actionList, Y					; 1 for weapon 1, 2 for weapon 2
	LDA activeObjectStats-1, X			; max range (b7-4) min range (b3-2)
	LSR
	LSR
	STA locVar2
	INC locVar2							; minimum range
	LSR
	LSR
	CMP distanceToTarget
	BCS +checkMinRange
	LDA #$88							; deny (b7) + out of range (b6-b0)
	STA actionMessage
	RTS
+checkMinRange:
	LDA locVar2							; minimum distance
	AND #$03							; distance
	CMP distanceToTarget
	BEQ +done
	BCC +done
	LDA #$8C							; deny (b7) + target too close (b6-b0)
	STA actionMessage
+done:
	RTS
; -----------------------------------------
; is target in firing arc?
;
; - firing arc always spans 120 degrees
; - facing directions always are aligned with the X, Y & Z axis
;
; algorithm
; using the firing node as the origin, the target is within the
; firing arc if it is within the sextant left or right of the axis
; that aligns with the facing direction
;
; to determine this locVar5 is created first:
;
; bbbbbbbb
; ||||||||
; |||||||+ 1: Z target <= Z source
; ||||||+- 1: Z target >= Z source
; |||||+-- 1: Y target <= Y source
; ||||+--- 1: Y target >= Y source
; |||+---- 1: X target <= X source
; ||+----- 1: X target >= X source
; ++------ not used
;
; -----------------------------------------
checkFiringArc:
	LDA cursorGridPos
	LSR
	LSR
	LSR
	LSR
	STA locVar2									; target grid Y
	LDA cursorGridPos
	AND #$0F										; x mask
	STA locVar1									; target grid X

	LDA activeObjectGridPos
	LSR
	LSR
	LSR
	LSR
	STA locVar4									; firing unit grid Y
	LDA activeObjectGridPos
	AND #$0F										; x mask
	STA locVar3									; firing unit grid X

	LDA locVar1
	CMP locVar3
	ROL locVar5

	LDA locVar3
	CMP locVar1
	ROL locVar5

	LDA locVar2
	CMP locVar4
	ROL locVar5

	LDA locVar4
	CMP locVar2
	ROL locVar5

	LDA locVar1
	CLC
	ADC locVar2
	STA locVar1

	LDA locVar3
	CLC
	ADC locVar4
	STA locVar3

	LDA locVar1
	CMP locVar3
	ROL locVar5

	LDA locVar3
	CMP locVar1
	ROL locVar5

	LDY activeObjectIndex
	LDA object, Y
	AND #$07
	TAY
	LDA fireArc-1, Y	;
	AND locVar5			;
	CMP fireArc-1, Y
	BEQ +
	CLC								; clear if not in firing arc
+	RTS

fireArc:
	.db #%00011000		;1 Xt<, Yt>
	.db #%00001010		;2 Yt>, Zt>
	.db #%00100010		;3 Xt>, Zt>
	.db #%00100100		;4 Yt<, Xt>
	.db #%00000101		;5 Yt<, Zt<
	.db #%00010001		;6 Xt<, Zt<

; -----------------------------------------
; to determine if line of sight is blocked, first step is to
; specify the line if sight (LOS) as a function f(X) = aX + b = Y
;
; then, for each node in that blocks visibility,
; 2 line segments are determined:
; one horizontal, one vertical, both through the node's center
;
; if any of the line segments intersect with the LOS, the LOS is blocked
; intersection is checked by entering the end points of a
; line segment into the LOS function. If the signs of the result of
; both entries is different, then the line segment intersects the LOS
;
; so, first calculate the LOS function: aX+b
; unfortunately a & b would be fractions
; so in order to prevent rounding issues
; the following equivalent is calculated
;
; list1+0 Y orig coordinate
; list1+1 X orig coordinate (list1+1)
; list1+4 delta Y (list+4)
; list1+5 delta X (list+5)
; list1+6 sign of deltas (list+6)
;
;       (X1 - Xorig) * deltaY
;    _________________________  + Yorig - Y1 = RESULT (SIGN)
;			    deltaX
;
; LOC list1+2 	Y center of check node
; LOC list1+3	X center of check node
; LOC list1+7 	temp var used in line function
; LOC list1+8 	result var used in line function
; LOC list1+9   node that is checked
; LOC list2+0	Y1 of line segment that is checked
; LOC list2+1	X1 of line segment that is checked
; LOC list2+2	Y2 of line segment that is checked
; LOC list2+3	X2 of line segment that is checked
; LOC list2+4	targetNode grid position
; LOC list2+5   targetNode grid position X coordinate only

; helper subroutines
; 	gridPosToTilePos
; 	lineFunction
; 	getNextBlockedNode

; OUT carry flag 	1: line of sight blocked, 0: line of sight clear
; -----------------------------------------
checkLineOfSight:
	; 1) Determine the line function for the line of sight
	; 2) Iterate over all nodes in the bounding box between source and target node
	; 3) Per blocked node, determine the 3 line segments that define the node's hexagon and check any of them intersect with the line of sight

	; --- determine tile coordinates for active object
	LDX #$00
	LDA activeObjectGridPos
	STA list1+9					; used for node iteration later
	JSR gridPosToTilePos

	; --- determine tile coordinates for target object
	LDA cursorGridPos			; gridPos
	STA list2+4					; used for node iteration later
	LDX #$02
	JSR gridPosToTilePos

	; --- init variables ---
	LDA #$00
	STA list1+6		; b0
	STA list1+8		; b0

	; --- determine Y delta ---
	LDA list1+0
	SEC
	SBC list1+2
	BCS +
	INC list1+6
	EOR #$FF
	ADC #$01
+	STA list1+4

	; --- determine X delta ---
	LDA list1+1
	SEC
	SBC list1+3
	BCS +
	INC list1+6
	EOR #$FF
	ADC #$01
+	STA list1+5

	; --- prepare node iteration ---
	LDA list2+4		; target node
	AND #$0F		; mask
	STA list2+5		; target node X coor


	; --- check each blocked node in bounding box ---
-nextNode:
	JSR getNextBlockedNode
	BCC +				; carry set means that
	CLC					; iteration is complete, no blocked nodes found
	RTS
+
	; --- determine the line segments that make up the blocked node ---
	LDA list1+9
	LDX #$02	; store Y in list1+2 and X in list1+3
	JSR gridPosToTilePos

	; --- line segment 1 (horizontal through center)
	LDA list1+2
	STA list2+0			; line 1, p1, Y
	STA list2+2			; line 1, p2, Y
	LDA list1+3
	SEC
	SBC #$02
	STA list2+1			; line 1, p1, X
	CLC
	ADC #$04			; line 1, p2, X
	STA list2+3

	; --- check if the node's line segment intersects the line of sight ---
	JSR checkIntersect
	BCS +lineBlocked

	; --- line segment 2 (vertical through center)
	LDA list1+3
	STA list2+1			; line 1, p1, X
	STA list2+3			; line 1, p2, X
	LDA list1+2
	SEC
	SBC #$01
	STA list2+0			; line 1, p1, Y
	CLC
	ADC #$02			; line 1, p2, Y
	STA list2+2

	; --- check if the node's line segment intersects the line of sight ---
	JSR checkIntersect
	BCC -nextNode
+lineBlocked:
	RTS


; --------------------------------------------------------
; getNodeBlockedNode
;
; traverses the bounding box and returns the next blocked node
; sets carry flag if all nodes have been checked
;
; OUT A				the next blocked node in the bounding box between the active unit and the target unit
; OUT carry flag	1=iteration complete, 0=more nodes left in bounding box
; --------------------------------------------------------
getNextBlockedNode:
	LDA list1+9					; current node
	AND #$0F					; current node X coor
	CMP list2+5					; target node X coor
	BEQ +nextY
	BCC +incX
	DEC list1+9
	JMP +check
+incX:
	INC list1+9
	JMP +check
+nextY:
	LDA list1+9					; current node
	AND #$F0					; reset X coordinate
	STA list1+9					; on current node
	LDA activeObjectGridPos		; back to X coordinate
	AND #$0F					; of active node
	CLC
	ADC list1+9
	STA list1+9					; done

	CMP list2+4
	BCC +incY
	SBC #$10
	STA list1+9
	JMP +check
+incY:
	ADC #$10
	STA list1+9
	JMP +check
+check:
	LDA list1+9
	CMP list2+4					; target node
	BEQ +lastNode

	TAY
	LDA nodeMap, Y
	AND #%01000000				; does node block visibility?
	BEQ getNextBlockedNode		; no -> try next node
	LDA list1+9					; yes -> return node & clear carry (this is not the last node)
	CLC
	RTS
+lastNode:
	SEC							; set carry (this is the last node)
	RTS

; --------------------------------------------------------
; checkIntersect
;
; check if line segment intersects with the sight-line
; OUT carry flag (1 intersect, 0 no intersect)
; --------------------------------------------------------
checkIntersect:
	LDA list2+1			; X1
	LDX list2+0			; Y1
	JSR lineFunction
	BEQ +onLine
	BCC +
	INC list1+8			; add 1 if sign of result is negative
+	LDA list2+3			; X2
	LDX list2+2			; Y2
	JSR lineFunction
	BEQ +onLine
	BCC +
	INC list1+8			; add 1 if sign of result is negative
+	LDA list1+8
	LSR					; carry = 1 (neg+pos or pos+neg), 0 (neg+neg or pos+pos)
	RTS
+onLine:				; if point is on the LOS, then LOS is blocked
	SEC
	RTS

; --------------------------------------------------------
; line function
; checks if point (X,Y) lies either on, left or right the line of sight

; IN A			Xin
; IN X			Yin

; OUT carry flag	1: negative result, 0: positive result
; OUT zero flag 	1: point not on line, 0: point on line)

; LOC list1, locVar1,2,3,4, X, Y, par1-4
; --------------------------------------------------------
lineFunction:
	STX locVar3		; Yin
	LDX list1+6
	STX	list1+7		; copy of sign variable

	; --- step 1: Xin - Xorig ---
	SEC				; A holds X in
	SBC list1+1		; - X orig
	BCS +			; if result is negative
	INC list1+7		; flip sign variable
	EOR #$FF		; and negate result
	ADC #$01

	; --- step 2: multiply with deltaY
+	STA locVar4
	LDX list1+4		; deltaY
	JSR multiply	; X * A -> par1(hi)par2(lo)

	; --- side step: if deltaX is 0
	LDA list1+5		; is delta X = 0?
	BNE +			; no -> continue with line function
	ASL	locVar4		; yes -> set zero and carry flag
	RTS				; done

	; --- step 3b: divide by deltaX ---
+	JSR divide		; (par1(hi)par2(lo) / A) -> par3(hi)par4(lo)
	STA locVar1		; rest value

	LSR list1+7		; load sign (b0) sign bit into carry (1=neg, 0=pos)
	BCC +
	LDA par3		; negate both bytes
	EOR #$FF		;
	STA par3
	LDA par4
	EOR #$FF
	STA par4
	SEC				; + 1 to complete of negation

	LDA locVar1		; if there is a rest value, -1
	BEQ +			; the 'divide' result is rounded down when sign is positive, and up when sign is negative
	CLC				; reason: 3,5 becomes 3, so -3+20=17. What we want is round down the END result -3,5 + 20 = 16,5 ->16. So we calculate -4+20=16

	; --- step 4: add Yorig ---
+	LDA par4
	ADC list1+0
	STA par4		; Yline (lo) rounded down
	LDA par3
	ADC #$00
	STA par3		; Yline (hi) rounded down

	; --- step 5: subtract Yin ---
	LDA par4
	SEC
	SBC locVar3
	STA par4
	LDA par3
	SBC #$00
	ROL				; set carry flag

	; --- A: 0 if the point is on the line of sight
	LDA par4
	ORA locVar1;	; set zero flag

	RTS

; --------------------------------------------------------
; gridPosToTilePos
;
; IN A
; LOC locVar1, locVar2
; OUT list1
; --------------------------------------------------------
gridPosToTilePos:
	; --- separate grid X & Y ---
	PHA
	LSR 					; y mask
	LSR
	LSR
	LSR
	STA locVar2				; YYYY
	PLA
	AND #$0F				; x mask
	STA locVar1				; XXXX

	; --- calculate Y position ---
	SEC
	SBC locVar2				; (XXXX - YYYY)
	CLC
	ADC #$10
	STA list1+0, X

	; --- calculate X position ---
	LDA locVar1
	CLC
	ADC locVar2
	STA list1+1, X			; (X+Y) (max 30)
	ASL A
	ADC list1+1, X
	STA list1+1, X			; (X+Y) * 3

	RTS
