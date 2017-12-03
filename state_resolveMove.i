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

	JSR applyActionPointCost
	JSR initializeMove

	JSR pullAndBuildStateStack
	.db $03							; 3 states
	.db $11 						; resolve move
	.db $0A							; set direction
	.db $16							; show results
	; built in RTS

initializeMove:
	LDA effects
	AND #%10000000						; switch off active marker
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

	LDA #1
	STA softCHRBank1

	JMP clearCurrentEffects

; ----------------------------------------
; loop to resolve move
; ----------------------------------------
state_resolveMove:
	;LDA events
	;ORA event_updateSprites
	;STA events

	LDA #1
	STA softCHRBank1

	LDA actionCounter
	BEQ +continue
	JMP +calculateOffset			; frame 32-1? -> calculate

+continue:									; frame 0 -> new node
	;-------------------------------------
	; New node
	;-------------------------------------
	DEC list1
	BPL +continue
	;-------------------------------
	; Move complete
	;-------------------------------
	LDA effects
	AND #%11111000							; switch off obscure mask effects
	STA effects

	LDY activeObjectIndex

	LDA object, Y
	EOR #%00001000							; object move bit (b3) OFF
	STA object, Y

	LDY activeObjectGridPos			; block final position, move (b7) and sight (b6)
	LDA nodeMap, Y
	ORA #$C0
	STA nodeMap, Y

	LDA #0
	STA softCHRBank1

	JMP pullState

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
																														; used in embedded effect 4
	STX list5+0										; temp store X

	AND #%00000111
	TAX
	LDA state_resolveMoveMirrorTable-1, X
	STA list5+1										; temp mirror settings for mask

	LDA effects
	AND #%11111000
	STA effects

	LDX activeObjectGridPos
	LDA nodeMap, X
	AND #%00100000
	BEQ +continue

	TXA
	JSR gridPosToScreenPos
	BCC +continue													; not on screen!

	INC effects

	LDA #$04
	STA currentEffects+0
	LDA currentObjectXPos
	STA currentEffects+6
	LDA currentObjectYPos
	STA currentEffects+12
	LDA list5+1
	EOR #%01000000
	STA currentEffects+24									; mirror

+continue:
	LDX list5+0
	LDA list1, X							; update active object's grid position
	STA activeObjectGridPos		;
	STA object+3, Y						;
	TAY
	LDA nodeMap, Y
	AND #%00100000
	BEQ +continue

	TYA												; obscured!
	JSR gridPosToScreenPos
	BCC +continue							; not on screen!
	LDA effects
	AND #%00000001
	TAX
	INC effects

	LDA #$04
	STA currentEffects+0, X
	LDA currentObjectXPos
	STA currentEffects+6, X
	LDA currentObjectYPos
	STA currentEffects+12, X
	LDA list5+1
	STA currentEffects+24, X								; mirror

+continue:


	;-------------------------------
	; manage object sequence
	; objects closest to the bottom screen edge have highest sprite priority
	;-------------------------------
	JSR calculateObjectSequence		; determines horizontal row of each object (between 0 and 31)

	LDX actionList							; X = index for 'list 1' and 'list2'
	LDY list2, X
	LDA state_resolveMoveUpDownTable, Y
	BNE +movingUp

	JSR objectListSweepUp			; then object is moving down
	JMP +calculateOffset
+movingUp:							; otherwise, object is moving up
	JSR objectListSweepDown			;

	;-------------------------------
	; Frame 32 to 1: calculate the offset
	;-------------------------------
+calculateOffset:

	LDX actionList							; X = index for 'list 1' and 'list2'
	LDY list2, X
	LDX state_resolveMoveRadiusTable-1, Y
	LDA actionCounter
	JSR multiply

	LDX actionList							; X = index for 'list 1' and 'list2'
	LDY list2, X
	LDA state_resolveMoveAngleTable-1, Y
	LDX par1

	JSR getCircleCoordinates
	STX actionList+1
	STY actionList+2

	LDA actionCounter
	BIT rightNyble
	BNE +continue
	LDY #sMechStep
	JSR soundLoad


+continue:

	DEC actionCounter
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

state_resolveMoveMirrorTable:
	.db %00100000
	.db %01100000
	.db %01100000
	.db %00100000
	.db %00100000
	.db %00100000

state_resolveMoveAngleTable:
	.db 128
	.db 128+51
	.db -51
	.db 0
	.db 51
	.db 128-51


state_resolveMoveRadiusTable:
	.db 128
	.db 192
	.db 192
	.db 128
	.db 192
	.db 192

state_resolveMoveUpDownTable:
	.db 1
	.db 1
	.db 0
	.db 0
	.db 0
	.db 1
