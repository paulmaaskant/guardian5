checkLineOfSight:
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
  ; LOC list1+0 	Y orig coordinate
  ; LOC list1+1 	X orig coordinate
  ; LOC list1+2 	Y center of check node
  ; LOC list1+3	  X center of check node
  ; LOC list1+4 	delta Y (list+4)
  ; LOC list1+5 	delta X (list+5)
  ; LOC list1+6 	sign of deltas (list+6)
  ;
  ;       (X1 - Xorig) * deltaY
  ;    _________________________  + Yorig - Y1 = RESULT (SIGN)
  ;			    deltaX
  ;
  ; LOC list1+7 	temp var used in line function
  ; LOC list1+8 	result var used in line function
  ; LOC list1+9   used to iterate over grid nodes
  ; LOC list2+0		Y1 of line segment that is checked
  ; LOC list2+1		X1 of line segment that is checked
  ; LOC list2+2		Y2 of line segment that is checked
  ; LOC list2+3		X2 of line segment that is checked
  ; LOC list2+4		target grid position
  ; LOC list2+5   targetNode grid position X coordinate only
	; LOC list2+6   attackNode grid position X only

  ; helper subroutines
  ; 	gridPosToTilePos
  ; 	lineFunction
  ; 	getNextBlockedNode

  ; OUT carry flag 	1: line of sight blocked, 0: line of sight clear
  ; -----------------------------------------

	; 1) Determine the line function for the line of sight
	; 2) Iterate over all nodes in the bounding box between source and target node
	; 3) Per blocked node, determine the 3 line segments that define the node's hexagon and check any of them intersect with the line of sight

	; --- determine tile coordinates for active object
  STA list1+9					; used for node iteration later
  LDY cursorGridPos
	JSR setLineFunction

	LDA list1+9
	AND #$0F		; mask
	STA list2+6

	; --- prepare node iteration ---
	LDA cursorGridPos
	AND #$0F		; mask
	STA list2+5		; target node X coor


	; --- check each blocked node in bounding box ---
-nextNode:
	JSR getNextBlockedNode
	BCC +continue			; carry set means that
	CLC					; iteration is complete, no blocked nodes found
	RTS

+continue
	; --- determine the line segments that make up the blocked node ---
	LDA list1+9							; grid pos of the check node
	LDX #$02								; store Y in list1+2 and X in list1+3
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
	ADC #$04				; line 1, p2, X
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
	AND #$0F						; current node X coor
	CMP list2+5					; target node X coor
	BEQ +nextY
	BCC +incX
	DEC list1+9
	JMP +check

+incX:
	INC list1+9
	JMP +check

+nextY:
	LDA list1+9									; current node
	AND #$F0										; clear X coordinate
	STA list1+9									; on current node
	LDA list2+6									; back to X coordinate
	AND #$0F										; of active node
	CLC
	ADC list1+9
	STA list1+9									; done

	;CMP list2+4					; target node
	CMP cursorGridPos
	BCC +incY
	SBC #$10
	STA list1+9
	JMP +check

+incY:
	ADC #$10
	STA list1+9
	;JMP +check

+check:
	LDA list1+9
	;CMP list2+4					; target node
	CMP cursorGridPos
	BEQ +lastNode

	TAY
	LDA nodeMap, Y
	AND #%01000000						; does node block visibility?
	BEQ getNextBlockedNode		; no -> try next node
	LDA list1+9								; yes -> return node & clear carry (this is not the last node)
	CLC
	RTS

+lastNode:
	SEC							; set carry (this is the last node)
	RTS

; --------------------------------------------------------
; checkIntersect
;
; uses the line function in list1
;
;	can only be used if the setLineFunction sbr has been called
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
