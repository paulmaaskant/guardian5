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
; IN list1+0, number of nodes
; IN list1+1-18, node list
; IN list8, directions corresponding to the nodes in path
;
; LOCAL list1+19, 				current direction
; LOCAL selectedAction
; LOCAL actionList+0, 		index for list1
; LOCAL list3+63, 				X position
; LOCAL list3+64, 				Y position

; LOCAL list4temp store for sprite priority score
;
; UPDATES object				grid position on active object
;
;-------------------

; ----------------------------------------
; loop to resolve move
; ----------------------------------------
state_resolveMove:
	LDA blockInputCounter
	BEQ +continue							; frame 0?
	JMP +calculateOffset			; frame 32-1? -> calculate

+continue:									; frame 0 -> new node
	;-------------------------------------
	; New node
	;-------------------------------------
	DEC list1+0								; next node
	BPL +continue							; new nodes left?

	;-------------------------------
	; Move complete
	;-------------------------------
	LDY activeObjectIndex
	LDX activeObjectGridPos			; get node map BG tile
	LDA nodeMap, X
	STA object+5, Y							; and store on the obscuring object

	LDA object+0, Y
	EOR #%00001000							; object move bit (b3) OFF
	STA object+0, Y

	JSR getStatsAddress					; sets pointer1
	LDY activeObjectIndex
	LDA object+0, Y
	AND #%00000111							; get direction
	CLC
	LDY #7
	ADC (pointer1), Y						; add tile map offset

	ORA #%11000000							; blocked for movement and los
	LDY activeObjectGridPos
	JSR setTile
	JMP pullState

	; ---------------
	; New node
	; ---------------
+continue:
	LDA #32											; 32 frames
	STA blockInputCounter

	INC actionList

	LDX actionList							; X = index for 'list 1'
	LDY list1, X
	LDA list8, Y								; list8 still holds directions from findPath sbr
	AND #%00000111
	TAY
	LDA oppositeDirection-1, Y
	STA list1+19								; set the current direction

	TAY
	LDA directionLookupMoving, Y
	STA list3+61								; set for object sprite cycle in main loop

	LDY activeObjectIndex				; Y = index	for 'objectTypeAndNumber'
	LDA object, Y								; set new direction bits (b2-0) on active object
	AND #%11111000
	ORA list1+19
	STA object, Y


	LDA list1, X								; update active object's grid position
	STA activeObjectGridPos			;
	STA object+3, Y							;


	;-------------------------------
	; manage object sequence
	; objects closest to the bottom screen edge have highest sprite priority
	;-------------------------------
	JSR updateSpritePriority

	;JSR calculateObjectSequence		; determines horizontal row of each object (between 0 and 31)

	;LDY list1+19
	;LDA state_resolveMoveUpDownTable, Y
	;BNE +movingUp

	;JSR objectListSweepUp				; then object is moving down
	;JMP +calculateOffset

;+movingUp:										; otherwise, object is moving up
	;JSR objectListSweepDown			;

	;-------------------------------
	; Frame 32 to 1: calculate the offset
	;-------------------------------
+calculateOffset:
	LDA activeObjectGridPos
	JSR gridPosToScreenPos

	LDY list1+19
	LDX state_resolveMoveRadiusTable-1, Y
	LDA blockInputCounter
	JSR multiply									; set par1

	LDY list1+19
	LDA state_resolveMoveAngleTable-1, Y
	LDX par1

	JSR getCircleCoordinates

	CLC														;
  TYA														;
  ADC currentObjectYPos					;
	STA list3+63

	CLC
  TXA
  ADC currentObjectXPos
	STA list3+62

;	LDA currentObjectXScreen
;	ADC #0
;	BNE +offscreen

;	BEQ +continue

;+offscreen:
;	LDA #$FF
;	STA list3+63



;	CMP #$20												; the following code ensures
;	BCS +rightEdge									; that sprites are not wrapped
;	LDA actionList+1								; to other side of screen due to displacement
;	BPL +continue
;	BMI +done												; off screen -> done

;+rightEdge:
;	CMP #$E0
;	BCC +continue
;	LDA actionList+1
;	BPL +done												  ; off screen

+continue:
	LDY activeObjectIndex					; this bit of code
	JSR getStatsAddress						; is not very elegant
	LDY #4
	LDA (pointer1), Y
	BNE +continue									; if mech animation

	LDY activeObjectIndex					; then offset by 1 pixel
	LDA object+2, Y								; every couple of frames
	AND #%00111111								; (part of the animation)
	LSR
	LSR
	LSR
	BEQ +down
	CMP #4
	BNE +continue

+down:
	INC list3+64

+continue:
	LDA blockInputCounter
	BIT rightNyble
	BNE +continue

	LDY #sMechStep
	JSR soundLoad

+continue:
	DEC blockInputCounter
	RTS


;------------------------------------
; objectListSweepDown
; rearranges the order of the objects, making sure that object sprites that are closer to the bottom are rendered first
; assumption: list is sorted, except for 1 item which needs to move down in the list
;
; IN objectListSize
; IN OUT list4 +0 ... +15
; IN OUT objectList +0 ... +15
; LOCAL X
;------------------------------------
;objectListSweepDown:
;	LDA objectListSize
;	CMP #$02
;	BCC +done2
;
;	TAX
;	DEX				; object count - 1
;-loop2:
;	LDA list4+0, X
;	CMP list4-1, X
;	BCS +next2

;	PHA								; swap
;	LDA list4-1, X
;	STA list4+0, X
;	PLA
;	STA list4-1, X

;	LDA objectList+0, X
;	PHA
;	LDA objectList-1, X
;	STA objectList+0, X
;	PLA
;	STA objectList-1, X
;+next2
;	DEX
;	BNE -loop2
;+done2:
;	RTS

;------------------------------------
; objectListSweepUp
; rearranges the order of the objects, making sure that object sprites that are closer to the bottom are rendered first
; assumption: list is sorted, except for 1 item which needs to move up in the list
;
; IN objectListSize
; IN OUT list4 +0 ... +15
; IN OUT objectList +0 ... +15
; LOCAL X
;------------------------------------
;objectListSweepUp:
;	LDA objectListSize
;	CMP #$02
;	BCC +done
;
;	LDX #$01
;-loop:
;	LDA list4+0, X
;	CMP list4-1, X
;	BCS +next
;
;	PHA								; swap
;	LDA list4-1, X
;	STA list4+0, X
;	PLA
;	STA list4-1, X

;	LDA objectList+0, X
;	PHA
;	LDA objectList-1, X
;	STA objectList+0, X
;	PLA
;	STA objectList-1, X

;+next:
;	INX
;	CPX objectListSize
;	BCC -loop
;+done
;	RTS

;------------------------------
; calculate sprite priority
;
;
; IN 	objects  +0 ... +15
; OUT	list4 +0 ... +15
; LOCAL locVar1
;------------------------------
;calculateObjectSequence:
;	LDX objectListSize
;	DEX
;-	LDA objectList, X
;	AND #%01111000
;	TAY
;	LDA object+3, Y
;	AND #$0F				; X
;	EOR #$FF				; - (X+1)
;	SEC
;	ADC #$0F
;	STA locVar1				; 15-X
;	LDA object+3, Y
;	LSR
;	LSR
;	LSR
;	LSR
;	CLC
;	ADC locVar1
;	STA list4, X
;	DEX
;	BPL -
;	RTS

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

;state_resolveMoveUpDownTable:
;	.db 1
;	.db 1
;	.db 0
;	.db 0
;	.db 0
;	.db 1
