;------------------------------------------
; writeNextColumnToBuffer
; used for scrolling,
; buffers a single column of tiles based on the current camera position and scrolling direction
; assumes single table mirror
;
; optimized based on assumption that map is maximum of 30 meta tiles high
;
; IN    	cameraX+1 = used to derive which column to buffer
; LOCAL		nmiVar0,1 = current level meta tile map
; LOCAL 	nmiVar2 = tile column # to load
; LOCAL 	nmiVar3 = left/right side of meta tile
; LOCAL 	nmiVar4 = used to loop
; OUT		stack
;------------------------------------------
writeNextColumnToBuffer:
	LDA #$00					; initialize
	STA nmiVar3				; loc variables

										; --- determine left most meta tile column & which side
	LDA cameraX+1			; determine VRAM column
	LSR								;
	LSR								;
	LSR								;
	LSR 							;
	ROR nmiVar3				; set bit 7 to Carry flag, which represents (1=Right, 0=Left) tile
	STA nmiVar2				; left most meta tile column

	LDA sysFlags			; --- determine the scrolling direction ---
	AND #%10000000		; scrolling to the right?
	BEQ +noOffset:		; no -> stay on left most meta tile column
	LDA nmiVar2				; yes -> move to right most meta tile column
	ADC #$10					;
	STA nmiVar2

+noOffset:					; --- adjust for camera position ---
	LDA cameraX+0			; add 16 meta tile columns for each full screen
	ASL								; 2
	ASL								; 4
	ASL								; 8
	ASL								; 16
	CLC
	ADC nmiVar2
	STA nmiVar2



	LDY missionMapSettings	; use to retrieve map dimensions
	CLC											; clear carry flag

	LDA missionMap+0					; set pointer to top cell of target col in meta tile map
	ADC nmiVar2							; of the meta tile column we want
	STA nmiVar0
	LDA missionMap+1
	ADC #0
	STA nmiVar1							; also clears carry flag

	LDA nmiVar0							; move pointer down to bottom cell of column ---
	ADC map14RowsLo, Y			; by moving down 14 meta tiles
	STA nmiVar0
	LDA nmiVar1
	ADC map14RowsHi, Y
	STA nmiVar1							;

	LDA mapShadowLo, Y			; same for shadow pointer
	ADC nmiVar2
	STA nmiVar5
	LDA mapShadowHi, Y
	ADC #0
	STA nmiVar6

	LDA nmiVar5
	ADC map14RowsLo, Y
	STA nmiVar5
	LDA nmiVar6
	ADC map14RowsHi, Y
	STA nmiVar6							;

	; ---- move pointer down by 15 meta tile rows for each Y screen
	; not implemented, as map is never more than 2 screens high

	; --- this subroutine always starts writing at the top of the name table ---
	; --- note that the camera might be half way through the name table ---
	; --- so we need to calculate when to wrap around ---

	LDX #$00												; set X to 0
	LDA sysFlags										; or 1
	AND #%01000001									; to adjust for diagonal scrolling
	CMP #%01000001
	BNE +continue
	LDX #$01

+continue:
	LDA cameraY+1
	LSR
	LSR
	LSR
	CLC
	ADC identity, X									; add 1 (row) to Y in the event that this frame will also scroll down
	SEC
	SBC #$06
	BPL +continue
	LDA #$00

+continue:
	STA nmiVar2				; number of tiles after which wrap has to occur

	; --- get ready to loop ---
	LDA #30						; 30
	STA nmiVar4				; loops
	SEC
	SBC nmiVar2				;
	STA nmiVar2				; var2 := 30 - var2 (because we fill buffer backwards)

	TSX						; switch stack pointers
	STX	stackPointer1
	LDX stackPointer2
	TXS

	; --- loop start ---
-loop1:
	LDA nmiVar2				; check for wrap around
	BNE +noWrapAround

	LDY missionMapSettings

	CLC
	LDA nmiVar0							; wrap around -> move down 15 meta tile map rows
	ADC map15RowsLo, Y
	STA nmiVar0							;
	LDA nmiVar1							;
	ADC map15RowsHi, Y
	STA nmiVar1							; nmi 1 = CD nmi 0 = 4F

	LDA nmiVar5							; shadow pointer
	ADC map15RowsLo, Y			;
	STA nmiVar5							;
	LDA nmiVar6							;
	ADC map15RowsHi, Y
	STA nmiVar6							;

+noWrapAround:
	DEC nmiVar2							; dec wrap count

	; --- retrieve meta tile ---
	LDY #$00								; because we need it for some indirect addressing
	LDA (nmiVar0), Y				; retrieve the metaTile # from meta tile map ( nmiTemp is the row, Y is the col)
	TAX											; move the meta tile # to X

	; --- determine the appropriate tile within the meta tile ---
	LDA nmiVar4
	LSR A										; set carry: upper or lower
	BIT nmiVar3							; left or right side of the meta tile
	BPL +left
	BCC +lowerRight					; changed BCS->BCC
	LDA metaTileBlock01, X	; upper right
	JMP +done

+lowerRight:
	LDA metaTileBlock03, X	; lower right
	JMP +done

+left:
	BCC +lowerLeft					; changed BCS->BCC
	LDA metaTileBlock00, X	; upper left
	JMP +done

+lowerLeft:
	LDA metaTileBlock02, X	; lower left
	;JMP +done

+done:
	CMP #64
	BCC +objectTile
	PHA											; background tile: push tile to buffer
	BCS +done

+objectTile:
	CMP #6							; set carry flag
	AND #3
	STA nmiVar7
	TYA 								; set A to 0
	BCC +continue				; check carry flag
	LDA #14 						; 14+1carry

+continue:
	ADC (nmiVar5), Y
	TAY
	LDA nodeMap, Y
	ASL
	ASL
	CLC
	ADC nmiVar7
	TAX
	LDA objectTiles, X
	PHA

+done:

	; --- update pointer to meta tile map ---
	LDA nmiVar4									;
	LSR	A												;
	BCC +stayOnMetaTile					; move to new meta tile once every two iterations
	SEC
	LDY missionMapSettings
	LDA nmiVar0									; move one meta tile up by adding the no. of meta tiles in a row (48)
	SBC mapMetaTilesInRow, Y
	STA nmiVar0
	LDA nmiVar1
	SBC #$00
	STA nmiVar1

	SEC
	LDA nmiVar5									; move one meta tile up by adding the no. of meta tiles in a row (48)
	SBC mapMetaTilesInRow, Y
	STA nmiVar5
	LDA nmiVar6
	SBC #$00
	STA nmiVar6

+stayOnMetaTile:

	; --- loop back ---
;	INY
	DEC nmiVar4
	BEQ +continue
	JMP -loop1

+continue:
	; --- done, finish up ---
	LDA cameraX+1			; determine VRAM column
	LSR						;
	LSR
	LSR
	PHA						; address (L)
	LDA #$20
	PHA						; address (H)
	LDA #$3D
	PHA

	TSX						; switch stack pointers
	STX	stackPointer2
	LDX stackPointer1
	TXS

	RTS
