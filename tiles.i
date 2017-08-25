;------------------------------------------
; writeNextRowToBuffer
; used for scrolling, writes a row of tiles to the buffer
;
; IN		nmiVar0,1 = current level meta tile map
; IN    	cameraY+1 = used to derive which row to buffer
; IN 		cameraX+1 = used to derive row offset
; IN 		sysFlags = used to derive which row to buffer + offset
; LOCAL 	nmiVar2 = tile row # to load
; LOCAL 	nmiVar3 = upper/lower side of meta tile
; LOCAL 	nmiVar4 = used to loop
; OUT 		stack
;------------------------------------------
writeNextRowToBuffer:
	; stub
	LDA #< level1
	STA nmiVar0				;
	LDA #> level1
	STA nmiVar1				;

	; --- init ---
	LDA #$00
	STA nmiVar3				; indicates which half of the meta tile we need
	STA nmiVar4				; temp store

	; --- determine meta tile row number in top of screen
	LDA cameraY+1			;
	LSR
	LSR
	LSR						; tile row
	LSR						; meta tile row
	ROR nmiVar3				; set bit 7 and clears carry flag

	; --- calculate offset for tile map pointer ---
							; multiply meta tile row number with the number of meta tiles in row (48)
	STA nmiVar2				; works only for maps of limited size
	ASL
	ADC nmiVar2				; x 3
	ASL						; x 2
	ASL						; x 2
	ASL						; x 2
	ROL nmiVar4				; meta tile row # high byte
	ASL						; x 2
	ROL nmiVar4

	; --- set meta tile map pointer to top row on screen
	ADC nmiVar0				; and then
	STA nmiVar0				; set the pointer to the top most visible meta tile map row
	LDA nmiVar1				;
	ADC nmiVar4				;
	STA nmiVar1				;

	; --- adjust the tile map pointer for scroll direction ---
	LDA sysFlags
	AND #%01000000
	BNE +scrollDown

	; --- when scrolling UP ---
	SEC
	LDA nmiVar0				;
	SBC #$81				; subtract 3 meta tile rows (3*48) and add 15 = 144-15 = 129 = $81
	STA nmiVar0				; (the 15 is to start at the end of the row)
	LDA nmiVar1				; (remember we're loading right to left because we use the stack for buffering tiles!)
	SBC #$00				;
	STA nmiVar1				;
	JMP +offsetSet			;

	; --- when scrolling DOWN ---
+scrollDown:
	CLC						;
	LDA nmiVar0				; and then move down 12 rows in meta tile map
	ADC #$4F				; add 12 rows (12 * 48), add 15 = 576+15 = 591 = $024F
	STA nmiVar0				; the 15 is to start at the end of the row
	LDA nmiVar1				;
	ADC #$02				;
	STA nmiVar1				;
+offsetSet:

	; --- adjust for each full screen X ---
	LDA cameraX+0			; add 16 for each screen X
	ASL
	ASL
	ASL
	ASL
	ADC nmiVar0
	STA nmiVar0				;
	LDA nmiVar1				;
	ADC #$00				;
	STA nmiVar1				;

	; --- prepare loop ---
	LDA cameraX+1			; now determine the first meta tile
	LSR						; from the meta tile map to buffer
	LSR
	LSR
	STA nmiVar2				; # of tiles after which wrap around occurs

	LDA #$20				; initialize loop count
	STA nmiVar4				; to 32 tile
	SEC
	SBC nmiVar2
	STA nmiVar2				; wrap count

	TSX						; switch stack pointers
	STX	stackPointer1
	LDX stackPointer2
	TXS

	; --- loop ---
-loop:
	; --- wrap around? ---
	LDA nmiVar2				;
	BNE +skipOffset			; on name table edge
	LDA nmiVar0				; reset meta tile map pointer 16 meta tiles to the right
	CLC
	ADC #$10
	STA nmiVar0				;
	LDA nmiVar1				;
	ADC #$00
	STA nmiVar1				;
+skipOffset:
	DEC nmiVar2

	; --- retrieve meta tile ---
	LDY #$00
	LDA (nmiVar0), Y		; retrieve the metaTile # from meta tile map ( nmiVar is the row, Y is the col)
	TAX						; move the meta tile # to X

	; --- get the right tile ---
	LDA nmiVar4
	LSR 					; set carry flag; invert carry flag for diagonal scroll
	BIT nmiVar3				; up or down side of the meta tile
	BPL +up
	BCC +lowerRight			; left or right
	LDA metaTileBlock02, X
	JMP +done
+lowerRight:
	LDA metaTileBlock03, X
	JMP +done
+up:
	BCC +upperRight
	LDA metaTileBlock00, X
	JMP +done
+upperRight:
	LDA metaTileBlock01, X
	JMP +done
+done:
	PHA						; push tile to buffer

	; --- move to next meta tile? ---
	LDA nmiVar4
	LSR
	BCC +stayOnMetaTile		; move to new meta tile once every two iterations

	LDA nmiVar0
	BNE +noDec
	DEC nmiVar1
+noDec:
	DEC nmiVar0

+stayOnMetaTile:
	; --- loop back ---
	DEC nmiVar4
	BNE -loop

	; --- done ---
	LDA #$00
	STA nmiVar2

	LDA cameraY+1		; first determine the VRAM address = $2000 + MOD(($0020 * (y camera row + offset 24)), $03C0)
	AND #%11111000		; the offset 24 is to make sure the new row is drawn behind the status bar
	LSR					;
	LSR					;
	ADC #$30			;24*2 = 48 = $30
	CMP #$3C
	BCC +skip
	SEC					; MOD (fast & simple) for map of max 2 screens wide
	SBC #$3C
+skip:
	ASL					; $2[XX]0 -> $[2X][X0]
	ROL nmiVar2
	ASL
	ROL nmiVar2
	ASL
	ROL nmiVar2
	ASL
	ROL nmiVar2
	PHA					; addres (L)

	LDA #$20
	CLC
	ADC nmiVar2
	PHA					; address (H)

	LDA #$40			; length
	PHA

	TSX						; switch stack pointers
	STX	stackPointer2
	LDX stackPointer1
	TXS

	RTS

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
	LDA nmiVar2				; yes -> move to right most meta tile column
	ADC #$10				;
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
	LDA cameraY+1
	LSR
	LSR
	LSR

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

; metaTileTable
; 00 transparent
; 01 building roof 1 r
; 02 building roof 0 l
; 03 building base 1 r
; 04 building base 0 l
; 05 -
; 06 -
; 07 -
; 08 -
; 09 -
; 0A -
; 0B -
; 0C -
; 0D -
; 0E -
; 0F MARKER
; 10 plains 0
; 11 plains 1
; 12 plains 2
; 13 plains 0 blocked r+lu+ld
; 14 plains 0 blocked r
; 15 plains 0 blocked lu
; 16 plains 0 blocked ld
; 17 plains 0 blocked ld+lu
; 18 plains 0 blocked lu+r (canal)
; 19 plains 0 blocked ld+r (canal)
; 1A plains 1 blocked r+lu+ld
; 1B plains 1 blocked l
; 1C plains 1 blocked ru
; 1D plains 1 blocked rd
; 1E plains 1 blocked rd+ru
; 1F plains 1 blocked ru+l (canal)
; 20 plains 1 blocked rd+l (canal)
; 21 plains 2 blocked
; 22 plains 2 blocked u corner ^
; 23 plains 2 blocked d corner ^
; 24 plains 2 blocked d lu > rd
; 25 plains 2 blocked u lu > rd
; 26 plains 2 blocked u ru > ld
; 27 plains 2 blocked d corner v
; 28 plains 2 blocked u corner v
; 29 plains 2 blocked d ru > ld TODO
; 2A plains 1 full block chip lu
; 2B plains 0 full block chip ru
; 2C plains 1 full block chip ld
; 2D plains 0 full block chip rd
; 2E plains 1 blocked ru+l (pond)
; 2F plains 0 blocked lu+r (pond)
; 30 plains 1 blocked rd+l (pond)
; 31 plains 0 blocked ld+r (pond)


metaTileBlock00:
	.db #$8F,#$88,#$8A,#$A8,#$AA,#$BC,#$AA,#$9C,#$8A,#$AE,#$9A,#$8F,#$8F,#$8F,#$8F,#$00
	.db #$80,#$82,#$91,#$85,#$84,#$83,#$80,#$83,#$85,#$84,#$87,#$87,#$82,#$82,#$82,#$B5
	.db #$87,#$B5,#$96,#$91,#$91,#$B4,#$96,#$91,#$B4,#$91,#$B5,#$85,#$8F,#$8F,#$8F,#$8F
	.db #$87,#$84,#$8F

metaTileBlock01:
	.db #$8F,#$89,#$8B,#$A9,#$AB,#$A9,#$BD,#$89,#$9D,#$99,#$AF,#$8F,#$8F,#$8F,#$8F,#$00
	.db #$81,#$90,#$92,#$A5,#$86,#$81,#$81,#$81,#$A5,#$86,#$93,#$93,#$94,#$90,#$94,#$95
	.db #$93,#$95,#$97,#$92,#$92,#$97,#$B3,#$92,#$B3,#$92,#$95,#$A5,#$8F,#$8F,#$8F,#$8F
	.db #$93,#$86,#$B3

metaTileBlock02:
	.db #$8F,#$98,#$AA,#$B8,#$BA,#$B8,#$BA,#$AD,#$AA,#$BE,#$AA,#$8F,#$8F,#$8F,#$8F,#$00
	.db #$90,#$92,#$81,#$8F,#$94,#$90,#$93,#$93,#$94,#$95,#$97,#$B3,#$92,#$92,#$92,#$B3
	.db #$97,#$97,#$81,#$86,#$A5,#$81,#$81,#$A5,#$81,#$86,#$8F,#$8F,#$97,#$8F,#$B3,#$94
	.db #$8F,#$95,#$8F

metaTileBlock03:
	.db #$8F,#$A9,#$9B,#$B9,#$BB,#$B9,#$BB,#$A9,#$AD,#$A9,#$BF,#$8F,#$8F,#$8F,#$8F,#$00
	.db #$91,#$80,#$82,#$96,#$B4,#$91,#$91,#$91,#$B4,#$96,#$85,#$83,#$80,#$84,#$84,#$83
	.db #$85,#$8F,#$82,#$87,#$87,#$82,#$82,#$B5,#$82,#$B5,#$8F,#$8F,#$8F,#$96,#$83,#$B4
	.db #$85,#$8F,#$87

level1:
.db $00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00
.db $00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$2D	,$2E	,$22	,$2F	,$2C	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00
.db $00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$2D	,$2E	,$26	,$15	,$11	,$12	,$10	,$1C	,$25	,$2F	,$2C	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00
.db $00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$2D	,$2E	,$26	,$15	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$1C	,$25	,$2F	,$2C	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00
.db $00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$2D	,$2E	,$26	,$15	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$1C	,$25	,$2F	,$2C	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00
.db $00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$2D	,$2E	,$26	,$15	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$1C	,$25	,$2F	,$2C	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00
.db $00	,$00	,$00	,$00	,$00	,$00	,$00	,$2D	,$2E	,$26	,$15	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$1C	,$25	,$2F	,$2C	,$00	,$00	,$00	,$00	,$00	,$00
.db $00	,$00	,$00	,$00	,$2D	,$2C	,$32	,$17	,$11	,$12	,$10	,$11	,$12	,$01	,$02	,$12	,$01	,$02	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$1C	,$25	,$2F	,$2C	,$00	,$00	,$00
.db $00	,$2D	,$2E	,$26	,$15	,$1C	,$28	,$15	,$1D	,$23	,$16	,$11	,$12	,$03	,$04	,$12	,$03	,$04	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$1C	,$25	,$2F	,$2C
.db $32	,$17	,$11	,$12	,$10	,$11	,$12	,$10	,$1C	,$25	,$09	,$08	,$24	,$16	,$11	,$12	,$10	,$1D	,$23	,$16	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$1E
.db $00	,$2B	,$30	,$24	,$16	,$11	,$12	,$10	,$11	,$12	,$03	,$06	,$25	,$18	,$20	,$27	,$19	,$1F	,$22	,$18	,$30	,$24	,$16	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$1D	,$29	,$31	,$2A
.db $00	,$00	,$00	,$00	,$2B	,$30	,$24	,$16	,$11	,$12	,$10	,$11	,$12	,$10	,$1C	,$28	,$15	,$1D	,$29	,$19	,$2E	,$26	,$15	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$1D	,$29	,$31	,$2A	,$00	,$00	,$00
.db $00	,$00	,$00	,$00	,$00	,$00	,$00	,$2B	,$30	,$24	,$16	,$11	,$12	,$10	,$11	,$12	,$14	,$1F	,$26	,$15	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$1D	,$29	,$31	,$2A	,$00	,$00	,$00	,$00	,$00	,$00
.db $00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$2B	,$30	,$27	,$31	,$1B	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$1D	,$29	,$31	,$2A	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00
.db $00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$30	,$24	,$16	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$1D	,$29	,$31	,$2A	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00
.db $00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$2B	,$30	,$24	,$16	,$11	,$12	,$10	,$11	,$12	,$10	,$11	,$12	,$10	,$1D	,$29	,$31	,$2A	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00
.db $00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$2B	,$30	,$24	,$16	,$11	,$12	,$10	,$1D	,$29	,$31	,$2A	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00
.db $00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$2B	,$30	,$27	,$31	,$2A	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00
.db $00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00	,$00
