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
	LDA #0																																				; init temp parameters
	STA nmiVar3

	LDA cameraY+1																																	; determine meta tile row number in top of screen
	LSR																																						; by dividing camera Y by 8
	LSR
	LSR																																						; tile row
	LSR																																						; meta tile row
	ROR nmiVar3																																		; set bit 7 (upper/lower) and also clears carry flag

	TAX																																						; meta tile row #
	LDY missionMapSettings
	LDA mapMetaTilesInRow, Y																											; number of meta tiles in row
	JSR multiply																																	; meta tiles in row * numer of rows
	CLC
	LDA par2
	STA nmiVar0
	LDA par1
	STA nmiVar1

	LDY missionMapSettings
	LDA sysFlags																																	; adjust the tile map pointer for scroll direction ---
	AND #%01000000
	BNE +scrollDown
																																								; --- when scrolling UP ---
	SEC
	LDA nmiVar0																																		;
	SBC map03Rows15Cols, Y																												; subtract 3 meta tile rows (3*48) and add 15 = 144-15 = 129 = $81
	STA nmiVar0																																		; (the 15 is to start at the end of the row)
	LDA nmiVar1																																		; (remember we're loading right to left because we use the stack for buffering tiles!)
	SBC #0																																				;
	STA nmiVar1																																		;
	BCS +offsetSet																																;
																																								; --- when scrolling DOWN ---
+scrollDown:
	CLC																;
	LDA nmiVar0												; and then move down 12 rows in meta tile map
	ADC map12Rows15ColsLo, Y					; add 12 rows (12 * 48), add 15 = 576+15 = 591 = $024F
	STA nmiVar0												;	 the 15 is to start at the end of the row
	LDA nmiVar1												;
	ADC map12Rows15ColsHi, Y					;
	STA nmiVar1												;

+offsetSet:													; --- adjust for each full screen X ---
	LDA cameraX+0											; add 16 for each screen X
	ASL																;
	ASL																;
	ASL																;
	ASL																;
	ADC nmiVar0												;
	STA nmiVar0												;
	LDA nmiVar1												;
	ADC #$00													;
	STA nmiVar1												;

	LDA nmiVar0
	ADC mapShadowLo, Y
	STA nmiVar5

	LDA nmiVar1
	ADC mapShadowHi, Y
	STA nmiVar6

	LDA nmiVar0
	ADC missionMap+0
	STA nmiVar0

	LDA nmiVar1
	ADC missionMap+1
	STA nmiVar1


	; --- prepare loop ---
	LDA cameraX+1			; now determine the first meta tile
	LSR								; from the meta tile map to buffer
	LSR
	LSR
	STA nmiVar2				; # of tiles after which wrap around occurs

	LDA #$20					; initialize loop count
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

	CLC
	LDA nmiVar0				; reset meta tile map pointer 16 meta tiles to the right
	ADC #$10
	STA nmiVar0				;
	LDA nmiVar1				;
	ADC #$00
	STA nmiVar1				;

	LDA nmiVar5				; do the same for shadow pointer
	ADC #$10
	STA nmiVar5
	LDA nmiVar6
	ADC #$00
	STA nmiVar6

+skipOffset:
	DEC nmiVar2

	; --- retrieve meta tile ---
	LDY #$00
	LDA (nmiVar0), Y					; retrieve the metaTile # from meta tile map ( nmiVar is the row, Y is the col)
	TAX												; move the meta tile # to X

	; --- get the right tile ---
	LDA nmiVar4
	LSR 											; set carry flag; invert carry flag for diagonal scroll
	BIT nmiVar3								; up or down side of the meta tile
	BPL +up
	BCC +lowerRight						; left or right

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
	;JMP +done

+done:
	CMP #64
	BCC +objectTile
	PHA						; background tile: push tile to buffer
	BCS +done

+objectTile:
	CMP #6							; set carry flag
	AND #3
	STA nmiVar7
	TYA 								; set A to 0
	BCC +continue				; check carry flag
	LDA #14 						; 14 +1 carry

+continue:
	ADC (nmiVar5), Y		; determine grid pos using look up table (for speed)
	TAY
	LDA nodeMap, Y			; retrieve the meta tile for the grid pos
	ASL
	ASL
	CLC
	ADC nmiVar7					; determine which of the 4 tiles in th meta tile
	TAX
	LDA objectTiles, X	; retrieve the tile
	PHA

+done:
	; --- move to next meta tile? ---
	LDA nmiVar4
	LSR
	BCC +stayOnMetaTile		; move to new meta tile once every two iterations

	LDA nmiVar0
	BNE +noDec
	DEC nmiVar1
+noDec:
	DEC nmiVar0

	LDA nmiVar5
	BNE +noDec
	DEC nmiVar6
+noDec:
	DEC nmiVar5

+stayOnMetaTile:
	; --- loop back ---
	DEC nmiVar4
	BEQ +continue
	JMP -loop

+continue:
	; --- done ---
	LDA #$00
	STA nmiVar2

	LDA cameraY+1			; first determine the VRAM address = $2000 + MOD(($0020 * (y camera row + offset 24)), $03C0)
	AND #%11111000		; the offset 24 is to make sure the new row is drawn behind the status bar
	LSR								;
	LSR								;
	ADC #$30					; 24*2 = 48 = $30
	CMP #$3C
	BCC +skip
	SEC								; MOD (fast & simple) for map of max 2 screens wide
	SBC #$3C
+skip:
	ASL								; $2[XX]0 -> $[2X][X0]
	ROL nmiVar2
	ASL
	ROL nmiVar2
	ASL
	ROL nmiVar2
	ASL
	ROL nmiVar2
	PHA						; addres (L)

	LDA #$20			;
	CLC
	ADC nmiVar2
	PHA						; address (H)

	LDA #$40			; length
	PHA

	TSX						; switch stack pointers
	STX	stackPointer2
	LDX stackPointer1
	TXS

	RTS
