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
	; --- stub ---
	LDA #< level1
	STA nmiVar0
	LDA #> level1
	STA nmiVar1

	; --- initialize
	LDA #$00				; initialize
	STA nmiVar3				; loc variables

	; --- determine left most meta tile column & which side
	LDA cameraX+1			; determine VRAM column
	LSR						;
	LSR						;
	LSR						;
	LSR 					;
	ROR nmiVar3				; set bit 7 to Carry flag, which represents (1=Right, 0=Left) tile
	STA nmiVar2				; left most meta tile column


	; --- determine the scrolling direction ---
	LDA sysFlags			;
	AND #%10000000			; scrolling to the right?
	BEQ +noOffset:			; no -> stay on left most meta tile column
	LDA nmiVar2					; yes -> move to right most meta tile column
	ADC #$10						;
	STA nmiVar2

+noOffset:

	; --- adjust for camera position ---
	LDA cameraX+0			; add 16 meta tile columns for each full screen
	ASL						; 2
	ASL						; 4
	ASL						; 8
	ASL						; 16
	CLC
	ADC nmiVar2
	STA nmiVar2

	; --- set the meta tile pointer ---
	CLC						; clear carry flag
	LDA nmiVar0				; set pointer to top cell in meta tile map
	ADC nmiVar2				; of the meta tile column we want
	STA nmiVar0
	LDA nmiVar1
	ADC #$00
	STA nmiVar1				; also clears carry flag

	; --- move pointer down to bottom cell of column ---
	LDA nmiVar0				; add 14 * 48 = 672 = 512+128+32= 02A0
	ADC #$A0				; move down one full screen (15 meta tiles)
	STA nmiVar0
	LDA nmiVar1
	ADC #$02				;
	STA nmiVar1

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
	BPL +
	LDA #$00
+
	STA nmiVar2				; number of tiles after which wrap has to occur

	; --- get ready to loop ---
	LDA #$1E				; 30
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

	LDA nmiVar0				; wrap around -> move down 15 meta tile map rows
	CLC
	ADC #$D0
	STA nmiVar0				;
	LDA nmiVar1				;
	ADC #$02
	STA nmiVar1				; nmi 1 = CD nmi 0 = 4F

+noWrapAround:
	DEC nmiVar2				; dec wrap count

	; --- retrieve meta tile ---
	LDY #$00				; because we need it for some indirect addressing
	LDA (nmiVar0), Y		; retrieve the metaTile # from meta tile map ( nmiTemp is the row, Y is the col)
	TAX						; move the meta tile # to X

	; --- determine the appropriate tile within the meta tile ---
	LDA nmiVar4
	LSR A					; set carry: upper or lower
	BIT nmiVar3				; left or right side of the meta tile
	BPL +left
	BCC +lowerRight			; changed BCS->BCC
	LDA metaTileBlock01, X	; upper right
	JMP +done
+lowerRight:
	LDA metaTileBlock03, X	; lower right
	JMP +done
+left:
	BCC +lowerLeft			; changed BCS->BCC
	LDA metaTileBlock00, X	; upper left
	JMP +done
+lowerLeft:
	LDA metaTileBlock02, X	; lower left
	JMP +done
+done:
	PHA

	; --- update pointer to meta tile map ---
	LDA nmiVar4				;
	LSR	A					;
	BCC +stayOnMetaTile		; move to new meta tile once every two iterations
	SEC
	LDA nmiVar0				; move one meta tile up by adding the no. of meta tiles in a row (48)
	SBC #$30
	STA nmiVar0
	LDA nmiVar1
	SBC #$00
	STA nmiVar1
+stayOnMetaTile:

	; --- loop back ---
	INY
	DEC nmiVar4
	BNE -loop1

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