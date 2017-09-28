;--------------------
; resolve MOVE action
;
; Reads the set path stored in list 1 and list 2 to calculate the position of the moving object every frame until the move is complete
; This'moves' the active object from one node to another in 32 frames (starting at frame 32 and counting down)
;
; Frame 32 : updates the object's grid position to the node it is moving towards
; Frame 32 : updates the object's position in list 'objectTypeAndNumber' (this determines sprite priority when rendering sprites)
; Frame 32-1: calculate the X and Y screen offset with regards to the grid position that the object is moving towards
; 		this offset is applied during sprite rendering whenever the object being rendered is the active object and sys flag active object moving is up
; Frame 1: restart loop or move complete
;
; IN list1, nodes in path
; IN list2, directions corresponding to the nodes in path
;
;
; OUT selectedAction
; OUT actionList+0, 		index for list1 and list2
; OUT actionList+1, 		X offset in pixels
; OUT actionList+2, 		Y offset in pixels
; OUT actionList+3, 		sign X offset (b7), sign Y offset (b6), interpolation toggle (b5) (diagonal or vertical)
;
; LOCAL actionList+4..+9	temp store for sprite priority score
;
; UPDATES object				grid position on active object
;
;--------------------

state_initializeCharge:
	DEC list1										; remove the final node from the path (defending unit position)

	JSR calculateAttack

	JSR initializeMove					; tail chain

	JSR pullAndBuildStateStack
	.db $03							; 3 states
	.db $11 						; initialize move animation
	.db $1C							; turn to face target
	.db $1D							; close combat animation
	.db $16							; show results
	; built in RTS


;-------------------------------------
; initialize action resolution: MOVE
;-------------------------------------
state_initializeMove:
	LDA #$03										; clear from list3+4
	LDX #$09										; up to and including list3+9
	JSR clearList3

	JSR calculateHeat

	JSR initializeMove

	JSR pullAndBuildStateStack
	.db $03							; 3 states
	.db $11 						; resolve move
	.db $0A							; set direction
	.db $16							; show results
	; built in RTS

initializeMove:
	LDA effects
	AND #%10111111							; switch off active marker
	STA effects

	LDY activeObjectIndex				; set object's move animation bit (b3)
	LDA object, Y
	ORA #%00001000
	STA object, Y

	LDY activeObjectGridPos			; unblock position in nodeMap
	LDA nodeMap, Y
	AND #%00111111
	STA nodeMap, Y

	LDA #$00
	STA actionCounter
	STA actionList+0						; node number on path in list1

	RTS

; ----------------------------------------
; loop to resolve move
; ----------------------------------------
state_resolveMove:
	LDA events
	ORA event_updateSprites
	STA events

	LDA actionCounter
	BEQ +continue
	JMP +calculateOffset			; frame 32-1? -> calculate

+continue:							; frame 0 -> new node
	;-------------------------------------
	; New node
	;-------------------------------------
	DEC list1
	BPL +continue
	;-------------------------------
	; Move complete
	;-------------------------------
	LDA effects
	AND #%11101111							; switch off obscure mask
	STA effects

	LDY activeObjectIndex

	LDA object, Y
	EOR #%00001000							; object move bit (b3) OFF
	STA object, Y

	LDY activeObjectGridPos			; block final position, move (b7) and sight (b6)
	LDA nodeMap, Y
	ORA #$C0
	STA nodeMap, Y
	JMP pullState								; tail chain

	; ---------------
	; New node
	; ---------------
+continue:
	LDA #$20										; 32 frames
	STA actionCounter

	INC actionList
	LDX actionList							; X = index for 'list 1' and 'list2'
	LDY activeObjectIndex				; Y = index	for 'objectTypeAndNumber'

	LDA object, Y								; reset direction bits (b2-0) on active object
	AND #%11111000
	ORA list2, X
	STA object, Y

	AND #%00000110																																; mirror sprite if direction is 2 or 3
	CMP	#%00000010
	BNE +next
	LDA #%01100000
	;LDA #%01000000
	BNE +store

+next:
	LDA #%00100000																																; used in embedded effect 4
	;LDA #%00000000

+store:
	STA currentEffects

	LDA effects
	AND #%11101111
	STA effects

	STX locVar1

	LDX activeObjectGridPos
	LDA nodeMap, X
	AND #%00100000
	BEQ +continue

	LDA effects
	ORA #%00010000
	STA effects

	LDA currentEffects
	EOR #%01000000
	STA currentEffects

	STX currentEffects+1

+continue:

	LDX locVar1

	LDA list1, X							; update active object's grid position
	STA activeObjectGridPos		;
	STA object+3, Y						;

	TAY
	LDA nodeMap, Y
	AND #%00100000
	BEQ +continue
	LDA effects
	ORA #%00010000
	STA effects

	STY currentEffects+1

+continue:

	LDA #$00
	STA actionList+1					; reset X offset (Y offset is always overwritten)

	;-----------------------------------
	; update action+3
	;-----------------------------------
	LDA list2, X					; determine interpolation toggle
	CMP #$01						; 1 = vertical interpolation only (16 pixels)
	BEQ +							; 0 = vertical & horizontal interpolation (8 pixels and 24 pixels)
	CMP #$04
	BEQ +
	CLC
+	ROR actionList+3				; set (b5)

	CMP #$05						; Y neg if direction is 5, 3 or 4
	BEQ +							; 1 = Y is negative
	CMP #$03						; 0 = Y is positive
	BEQ +
	CMP #$04
	BEQ +
	CLC
+	ROR actionList+3				; set (b6)

	CMP #$03						; X neg if direction is 3 or 2
	BEQ +							; 1 = Y is negative
	CMP #$02						; 0 = Y is positive
	BEQ +
	CLC
+	ROR actionList+3				; set (b7)

	;-------------------------------
	; manage object sequence
	; objects closest to the bottom screen edge have highest sprite priority
	;-------------------------------
	JSR calculateObjectSequence		; determines horizontal row of each object (between 0 and 31)
	BIT actionList+3
	BVS +movingUp					; if Y is positive
	JSR objectListSweepUp			; then object is moving down
	JMP +calculateOffset
+movingUp:							; otherwise, object is moving up
	JSR objectListSweepDown			;

	;-------------------------------
	; Frame 32 to 1: calculate the offset
	;-------------------------------
+calculateOffset:
	LDA actionCounter
	BIT rightNyble
	BNE +continue
	LDY #sMechStep
	JSR soundLoad
	LDA actionCounter

+continue:
	STA actionList+2
	LSR actionList+2				; Y = frame # / 2, X = 0

	LDA actionList+3
	AND #%00100000					; diagonal move?
	BNE +checkSigns					; no -> offset calculation is complete
									; yes -> continue calculation

	LSR actionList+2				; Y = frame # / 4

	LDA actionCounter
	STA actionList+1
	ASL
	ADC actionList+1
	STA actionList+1
	LSR actionList+1
	LSR actionList+1				; X = (3 * frame #)/4

+checkSigns:
	BIT actionList+3				; X negative?
	BPL +										; no -> keep X as is
	LDA actionList+1				; yes -> negate X
	EOR #$FF
	STA actionList+1
	INC actionList+1
+	BIT actionList+3				; Y negative?
	BVC +							; no -> keep Y as is
	LDA actionList+2				; yes -> negate Y
	EOR #$FF
	STA actionList+2
	INC actionList+2

+	DEC actionCounter
	RTS


;------------------------------------
; objectListSweepDown
; rearranges the order of the objects, making sure that object sprites that are closer to the bottom are rendered first
; assumption: list is sorted, except for 1 item which needs to move down in the list
;
; IN objectCount
; IN OUT actionList +4 ... +9
; IN OUT objectTypeAndNumber +0 ... +5
; LOCAL X
;------------------------------------
objectListSweepDown:
	LDA objectCount
	CMP #$02
	BCC +done2

	TAX
	DEX				; object count - 1
-loop2:
	LDA actionList+4, X
	CMP actionList+3, X
	BCS +next2

	PHA								; swap
	LDA actionList+3, X
	STA actionList+4, X
	PLA
	STA actionList+3, X

	LDA objectTypeAndNumber+0, X
	PHA
	LDA objectTypeAndNumber-1, X
	STA objectTypeAndNumber+0, X
	PLA
	STA objectTypeAndNumber-1, X
+next2
	DEX
	BNE -loop2
+done2:
	RTS

;------------------------------------
; objectListSweepUp
; rearranges the order of the objects, making sure that object sprites that are closer to the bottom are rendered first
; assumption: list is sorted, except for 1 item which needs to move up in the list
;
; IN objectCount
; IN OUT actionList +4 ... +9
; IN OUT objectTypeAndNumber +0 ... +5
; LOCAL X
;------------------------------------
objectListSweepUp:
	LDA objectCount
	CMP #$02
	BCC +done

	LDX #$01
-loop:
	LDA actionList+4, X
	CMP actionList+3, X
	BCS +next

	PHA								; swap
	LDA actionList+3, X
	STA actionList+4, X
	PLA
	STA actionList+3, X

	LDA objectTypeAndNumber+0, X
	PHA
	LDA objectTypeAndNumber-1, X
	STA objectTypeAndNumber+0, X
	PLA
	STA objectTypeAndNumber-1, X

+next:
	INX
	CPX objectCount
	BCC -loop
+done
	RTS

;------------------------------
; calculate sprite priority
;
;
; IN 	objects  +0 ... +5
; OUT	actionList +4 ... +9
; LOCAL locVar1
;------------------------------
calculateObjectSequence:
	LDX objectCount
	DEX
-	LDA objectTypeAndNumber, X
	AND #$07
	ASL
	ASL
	TAY
	LDA object+3, Y
	AND #$0F				; X
	EOR #$FF				; - (X+1)
	SEC
	ADC #$0F
	STA locVar1				; 15-X
	LDA object+3, Y
	LSR
	LSR
	LSR
	LSR
	CLC
	ADC locVar1
	STA actionList+4, X
	DEX
	BPL -
	RTS
