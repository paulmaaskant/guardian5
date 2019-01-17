;-------------------------------------
; findPath (A* alghorithm)
;
; IN				A = start node
; IN				par1 = destination node
; IN				par2 = moves available
; IN 				par3 b7 = movement type
;
; LOCAL     par3 = current node
; LOCAL			par4 = cost: start node -> current node (b7-b4)
; LOCAL			locVar1, locVar2, locVar3, locVar4, locVar5
; LOCAL			X, Y
; LOCAL 		list3 "open nodes" stack
; LOCAL 		list4 "open node scores" (b7-b4) actual cost: start->node, (b3-b0) estimate cost: start->node->destination
; LOCAL			nodeMap (b3-0 only)
; LOCAL 		list 8 (node map copy) b7 blocked, b3 closed flag, b2-0 direction
; LOCAL     list1 = directions from current node's neighbours back to current node
; LOCAL     list2 = current node's neighbours
; OUT				list1 = path nodes
; OUT   		list2 = directions to connect nodes

; OUT				actionMessage = reason failed
;------------------------------------

directionBits:
	.db #$07	; 00000111
directionTable:
	.db #$0F	; + 16 - 1
	.db #$10	; + 16
	.db #$01	; + 1
	.db #$F1	; - 16 + 1
	.db #$F0	; - 16
	.db #$FF	; - 1
oppositeDirection:
	.db #$04
	.db #$05
	.db #$06
	.db #$01
	.db #$02
	.db #$03
	;---------------------------------
	; path is found: time to reconstruct path out of the stored directions
	;---------------------------------
-pathFound:
	LDA list4, Y								; this subr uses only 4 bits to denote the distance
	LSR
	LSR
	LSR
	LSR														; ISSUE this can never be more than 15
	TAX
	STX list1											; number of nodes in path
	LDA par1											; destination node

-loop:
	STA list1, X
	TAY
	LDA list8, Y
	AND #$07											; direction to get to preceding node
	DEX
	BEQ +done										; Y holds node
	TAY
	LDA directionTable-1, Y
	CLC
	ADC list1+1, X							;
	JMP -loop

+done:
	LDA #10
	CMP list1
	BCS +continue
	STA list1

+continue:
	RTS
	;---------------------------------
	; path does not exist or not enough moves available: done
	;---------------------------------
-noMoreNodes:
-outOfRange:									; no path found
	LDA #$88										; deny (b7) + out of range (b6-b0)
	STA actionMessage
	RTS

findPath:
	;--------------------------------
	; initialize
	;--------------------------------
	STA list3+1									; start node is the first open node
	LDA distanceToTarget				; 0000dddd,
	STA list4+1									; cost to get from start node to this node (b7-b4) and estimate cost to get from this node to destination node (b3-b0)

	LDA par2										; if moves available
	CMP distanceToTarget				; is less than Manhattan distance
	BCC -outOfRange							; we are done
	LDX #0											;

-loop:
	LDA nodeMap, x							; init temp node map (list8)
	BIT par3										; b7 - 1 hovering unit, 0 ground unit
	BPL +groundUnit
	AND #%01000000							; copy bit (b6) blocks line of sight
	ASL 												; and make it (b7) blocks movement
	BCC +continue								; JMP

+groundUnit:
	AND #%10000000							; copy (b7) blocks movement
															;
+continue:
	STA list8, x								;
	INX													;
	BNE -loop										; temp node map initialized

	LDA #1											; 1 open node
	STA list3										; open node stack size
	TAY													;

	;---------------------------------
	; process (next) open node with lowest score
	;---------------------------------
-tryNexOpenNode:
	BEQ -noMoreNodes						; open node stack size == 0? no more nodes to try! Done
	LDX list3, Y								; otherwise, take next most promising open node from top of open node stack
	STX par3										; and make it the current node
	CPX par1										; is destination node?
	BEQ -pathFound							; then wrap up!
	LDA list4, Y								; otherwise, take the score
	AND leftNyble								; mask to get the...
	STA par4										; actual cost: start node -> current node

	DEC list3										; and remove current node from open node stack, by dec stack size

	LDA list8, X								; make current node a closed node
	ORA #$08										; set closed flag (b3)
	STA list8, X

	; --------------------------------
	; list neighbouring nodes of the current node
	; --------------------------------
	LDY #$00										; add adjacent nodes to current option list
	TXA													; current node to A
	CLC
	ADC #$01
	BIT rightNyble
	BEQ +xUpperBound						; over edge of the map
	INY
	STA list2, Y		    				; add current + X

	LDX #$06										;
	STX list1, Y								; direction: neighbour->current

	BIT leftNyble
	BEQ +yLowerBound
	SEC
	SBC #$10
	INY
	STA list2, Y				; add current - Y + X

	LDX #$01					;
	STX list1, Y				; direction: neighbour->current

+xUpperBound:
	LDA par3
	BIT leftNyble
	BEQ +yLowerBound
	SEC
	SBC #$10
	INY
	STA list2, Y				; add current - Y

	LDX #$02					;
	STX list1, Y				; direction: neighbour->current

+yLowerBound:
	LDA par3
	CLC
	ADC #$10
	BIT leftNyble
	BEQ +yUpperBound
	INY
	STA list2, Y				; add current + Y

	LDX #$05					;
	STX list1, Y				; direction: neighbour->current

	BIT rightNyble
	BEQ +xLowerBound
	SEC
	SBC #$01
	INY
	STA list2, Y				; add current + Y - X

	LDX #$04					;
	STX list1, Y				; direction: neighbour->current

+yUpperBound
	LDA par3
	BIT rightNyble
	BEQ +xLowerBound
	SEC
	SBC #$01
	INY
	STA list2, Y				; add current - X

	LDX #$03					;
	STX list1, Y				; direction: neighbour->current

+xLowerBound:

	; ------------------------------
	; neighbours list complete !
	; now loop over neighbours
	; ------------------------------
-neighbourLoop:
	LDX list2, Y
	LDA list8, X					; first, check of node is relevant
	AND #$88							; blocked flag, closed flag
	BEQ +continue					; this neighbour has already been processed, try the next neighbour
	JMP +next

+continue:
	;---------------------------------
	; calculate scores for neighbour node
	;---------------------------------
	CLC
	LDA par4					;
	ADC #$10					; start to current + 1
	STA locVar1					; actual cost to get from start node to neighbour node (left nyble)
	LSR
	LSR
	LSR
	LSR
	ADC locVar1
	PHA
	LDA list2, Y
	JSR distance
	STA locVar1					; estimated cost: neighbour node -> destination node
	PLA							; actual cost: start node -> neighbour node
	CLC
	ADC locVar1 				; sum is
	STA locVar1					; estimated cost to get from start node to destination node via this neighbour (right nyble)

	;---------------------------------
	; make sure score is within range
	;---------------------------------
	AND rightNyble
	CMP par2
	BCC	+continue
	BEQ +continue
	JMP +next							; estimated cost is higher than moves available, try the next neighbour

	;---------------------------------
	; de-duplicate / add neighbour as open node
	;---------------------------------
+continue:
	LDX list2, Y
	LDA list8, X
	BIT directionBits					; if the direction is set, its not a new node
	BEQ +openNewNode					; open a new node
	LDA list2, Y							; or update existing node
	JSR getOpenNode						; returns X
	LDA list4, X							; compare existing score
	CMP locVar1								; to new score
	BCS +continue							; existing score is better
	JMP +next

+continue
	; ----------------------------
	; update existing open node
	; ----------------------------
	LDA locVar1						; overwrite score
	STA list4, X

	; ----------------------------
	; push node up the open node stack based on its new (and better) score
	; ----------------------------
-loop:
	LDA list4+1, X
	AND rightNyble
	STA locVar1
	LDA list4+0, X
	AND rightNyble
	CMP locVar1
	BCS +noSwap
	LDA list4+1, X			; swap
	PHA
	LDA list4+0, X
	STA list4+1, X
	PLA
	STA list4+0, X
	LDA list3+1, X
	PHA
	LDA list3+0, X
	STA list3+1, X
	PLA
	STA list3+0, X

+noSwap:
	INX
	CPX list3
	BCC -loop
	LDX list2, Y						; update direction neighbour->current
	LDA list8, X
	AND #$F8								; clear direction
	ORA list1, Y
	STA list8, X

	JMP +next
	; ----------------------------
	; create new open node
	; ----------------------------
+openNewNode:
	ORA list1, Y					; direction neighbour->current
	STA list8, X					; save direction in node map
	LDA list2, Y					; store neighbour node
	INC list3							; at new spot at the end of the list
	LDX list3							; X = end of the list
	STA list3, X					; add neighbour node to end of list
	LDA locVar1						; G (b7-4)+ F (b3-0) scores
	STA list4, X					; add neighbour node scores to end of the list

	; ----------------------------
	; push new node down the stack
	; to make sure most promising node remains on top
	; ----------------------------
	LDX list3							; number of items in list
	LDA list4, X					; the 'sweep' item score
	STA locVar3						; GGGGFFFF
	AND rightNyble				; ____FFFF
	STA locVar1						; f score
	LDA list3, X					; the 'sweep' item node
	STA locVar2						;
-loop:
	DEX
	BEQ +done							; front of the list reached, sweep complete
	LDA list4, X
	AND rightNyble 				;
	CMP locVar1						;
	BCS +done							; F score match, sweep complete

	LDA list3, X
	STA list3+1, X
	LDA list4, X
	STA list4+1, X

	JMP -loop
+done
	LDA locVar2
	STA list3+1, X
	LDA locVar3
	STA list4+1, X

+next:
	;---------------------------------
	; loop to next neighbour
	;---------------------------------
	DEY
	BEQ +continue
	JMP -neighbourLoop

+continue:
	;---------------------------------
	; loop to next best open node
	;---------------------------------
	LDY list3					; try next most promising open node
	JMP -tryNexOpenNode

;---------------------------------
; helper subroutine, used to find an existing open node
; Returns the position (X) in the 'open node' (list3) list of a given node (A)
; IN A = grid position
;---------------------------------
getOpenNode:
	STA locVar2
	LDX list3					; number of open nodes
	BEQ +done					; no open nodes
-	LDA list3, X
	CMP locVar2
	BEQ +done					; X
	DEX
	BNE -
+done:
	RTS



; -----------
; take item at position X in list and bubble it to the start of the list, based on F score (stored in b3-b0)
; -----------
;sweepUp:
;-loop:
;	LDA list4+1, X
;	AND rightNyble
;	STA locVar1
;	LDA list4+0, X
;	AND rightNyble
;	CMP locVar1
;	BCS +noSwap

;	LDA list4+1, X			; swap
;	PHA
;	LDA list4+0, X
;	STA list4+1, X
;	PLA
;	STA list4+0, X
;	LDA list3+1, X
;	PHA
;	LDA list3+0, X
;	STA list3+1, X
;	PLA
;	STA list3+0, X

;+noSwap:
;	INX
;	CPX list3
;	BCC -loop
;	RTS

; -------------------------------------------------
; checkCharge

;
; check all adjacent grid positions for hostile units
; if there is exactly one, then that unit can be charged
; -------------------------------------------------
;isChargePossible:
;	LDA cursorGridPos
;	STA par1							; parameter for 'distance' sr
;
;	LDX #$00
;	STX par2
;
; nextObject:
;	; --- set current object attributes --
;	LDA objectList, X
;	AND #%00000111
;	ASL
;	ASL
;	TAY												; FIX exclude current object (or implement hostile!)
;	LDA object+3, Y						; object position
;	JSR distance
;	CMP #$01
;	BNE +continue
;	CPY activeObjectIndex
;	BEQ +continue
;	INC par2
;+;continue
;	INX									; next object
;	CPX objectListSize				; number of objects presently in memory
;	BNE -nextObject
;
;	LDA par2
;
;	CMP #$01
;	BCC +done					; return with carry clear
;	SEC
;	BEQ +done					; return with carry flag set
;
;	LDA #$92					; deny (b7) + not possible (b6-b0)
;	STA actionMessage
;+;done:
;	RTS
