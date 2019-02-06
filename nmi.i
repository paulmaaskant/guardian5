NMI:
	PHA	; push accumulator on to the stack (stack: A)
	TXA	; transfer X into A
	PHA	; push X onto the stack (stack: XA)
	TYA ; transfer Y into A
	PHA ; push Y onto the stack (stack: YXA)

	; load sprites
	LDA #$00 	; load value 00 into A = address of first sprite
	STA $2003	; sets the low byte of the sprite ram address
	LDA	#$02	; load value 02 into A = page where we keep sprites
	STA	$4014	; sets the high byte of the sprite ram address, and starts transfer

	; ----------------------------------------------------------
	; process tile buffer
	; ----------------------------------------------------------
	TSX
	STX	stackPointer1
	LDX stackPointer2
	TXS

	JMP nextTileString

	; --- unrolled loop for speed ---
	PLA									; 32
	STA #$2007					;
	PLA									; 31
	STA #$2007					;
  PLA									; 30
	STA #$2007					;
  PLA									; 29
	STA #$2007					;
  PLA									; 28
	STA #$2007					;
  PLA									; 27
	STA #$2007					;
  PLA									; 26
	STA #$2007					;
  PLA									; 25
	STA #$2007					;
  PLA									; 24
	STA #$2007					;
	PLA									; 23
	STA #$2007					;
	PLA									; 22
	STA #$2007					;
	PLA									; 21
	STA #$2007					;
  PLA									; 20
	STA #$2007					;
  PLA							; 19
	STA #$2007					;
  PLA							; 18
	STA #$2007					;
  PLA							; 17
	STA #$2007					;
  PLA							; 16
	STA #$2007					;
  PLA							; 15
	STA #$2007					;
  PLA							; 14
	STA #$2007					;
	PLA							; 13
	STA #$2007					;
	PLA							; 12
	STA #$2007					;
	PLA							; 11
	STA #$2007					;
  PLA							; 10
	STA #$2007					;
  PLA							; 09
	STA #$2007					;
  PLA							; 08
	STA #$2007					;
  PLA							; 07
	STA #$2007					;
  PLA							; 06
	STA #$2007					;
  PLA							; 05
	STA #$2007					;
  PLA							; 04
	STA #$2007					;
	PLA							; 03
	STA #$2007					;
	PLA							; 02
	STA #$2007					;
	PLA							; 01 4cycles
	STA #$2007					; 4cycles

	nextTileString:		; +/- 90 cycles to per string and 8 cycles per tile in string
	; --- start of loop ---
	PLA								; contains cols/rows (b0) and length (b7-b1) (4 cycles)
	BEQ +done					; if length == 0 then the buffer is empty, tile loading is done (2 cycles on fail)
	LSR								; b0 into carry: 1-> tile column, 0-> tile row (2 cycles)
	STA nmiVar2				; store the length of the buffer string (3 cycles)
										; subtotal 11 cycles

															; --- tile rows or columns? ---
	LDA #%10010000 							; (2 cycles) $2000 value that writes rows (b2 is 0)
	BCC +rows										; (3 cycles for rows) if carry is set then
	ADC #$03										; set b2 to 1

+rows:
	STA $2000										; (4 cycles)

															; --- select name table ---
	PLA													; (4 cycles)
	CMP #$24										; (2 cycles) tiles with address $2400 or higher
	STA nmiVar0									; (3 cycles) are written to NT 1
	LDA #%00000001							; (2 cycles) tiles with address lower than $2400
	ROL													; (2 cycles) are written to NT 0
	STA $9000										; (4cycles)

															; --- read tile address from buffer and write to VRAM ---
	LDA $2002										; prepare to set PPU address (4 cycles)
	LDA nmiVar0									; (3 cycles)
	STA	$2006										; (4 cycles) set PPU address H byte
	PLA													; (4 cycles)
	STA $2006										; (4 cycles) set PPU address L byte

															; subtotal 54 cycles

	; --- prep unrolled loop jump address ---
	ASL nmiVar2									; each unrolled loop consists of 4 bytes of code (5 cycles)
	ASL nmiVar2									; bytes of code to jump back from the jump point (5 cycles)
	LDA #< nextTileString				; (4 cycles)
	SEC													; (2 cycles)
	SBC nmiVar2									; (3 cycles)
	STA nmiVar0									; (3 cycles)
	LDA #> nextTileString				; (4 cycles)
	SBC #$00										; (2 cycles)
	STA nmiVar1																																		; nmiVar0, nmiVar1 contain the jump point (3 cycles)

	; --- and jump ---
	JMP (nmiVar0)																																	; 5 cycles / 90 cycles total

	; --- nothing left in buffer ---
+done:
	PHA										; reset stack pointer (to account for the 'empty' read)
	LDA #%10010000 				; back to +1 tile increments for the pallettes
	STA $2000

	; --- switch stack pointers back ---
	TSX
	STX	stackPointer2
	LDX stackPointer1
	TXS

	; -------------------------------------------
	; write palettes to VRAM
	; -------------------------------------------
	LDA $2002					; set latch to 1
	LDA #$3F					; pointer to start of palette at 3F00
	STA $2006
	LDA #$00
	STA $2006


	LDX #$00
-loop:
	LDA pal_transparant
	STA $2007
	LDA pal_color1, X
	STA $2007
	LDA pal_color2, X
	STA $2007
	LDA pal_color3, X
	STA $2007
	INX
	CPX #$08
	BNE -loop

	LDA #$00					; make sure the VRAM I/O address is reset to prevent weird effects
	STA $2006
	STA $2006


	; -------------------------------------------
	; read controller 1
	; -------------------------------------------
+continue:
	LDA #$01 						; set A to 00000001
	STA buttons					; set buttons to 0000 0001
	STA	$4016						; strobe 1
	LSR A								; set A to 00000000 by moving all bits to the right, while at the same time setting the carry flag to 1
	STA $4016						; strobe 0
-loop:
	LDA $4016 					; read A, which is either 0 or 1
	LSR A								; move A into the carry flag
	ROL buttons					; push on carry flag on right
											; bit that falls on left goes into the carry flag
	BCC -loop						; stop looping if carry flag is 1

	LDA softCHRBank1		; assign CHR bank
	STA $B001
	LSR
	LSR
	LSR
	LSR
	STA $B009


	; -------------------------------------------
	; prepare for scrolling
	; -------------------------------------------
	LDA #%10010000 		; turn on NMI
	STA $2000					;
	LDA #%00011110 		; turn on rendering
	STA $2001					;

	LDA $2002					; Set scroll for the status bar
	LDA #$00					; X
	STA $2005					; 0,0
	LDA cameraYStatus	; Y
	STA $2005					;

	LDA #$03					; switch mapper to name table 1 (status bar)
	STA $9000

	LDA cameraY+1			; detect if vertical scrolling is needed
	AND #%00000111
	CMP #$04
	BNE +continue

	LDA sysFlags
	ORA #$01
	STA sysFlags

+continue:
	; --- wait for vBlank to end (and rendering to start) ---
-	BIT $2002				; need to make sure v-blank has ended, otherwise code to wait for h-blank won't work
	BVS -						; sprite 0 is reset?

	;-------------------------------------------
	; !!! unused processor time, waiting for sprite 0
	;-------------------------------------------

	; sound
	LDA #2				; bank 2: sound & sound subroutines
	STA $8000			; in bank slot 1

	LDA soundFlags
	BIT bit5								; if raised, load in soundHeader
	BEQ +continue
	EOR bit5
	STA soundFlags					; unflag b5
	JSR seLoadSound

+continue:
	JSR soundNextFrame

	; tile animation
	LDA sysFlags
	AND sysFlag_tileAnimation
	BEQ +continue
	LDA frameCounter
	BIT bit2to0
	BNE +continue
	LSR
	LSR
	LSR
	AND #$03
	ADC #12
	STA $D001


	; tile blinking
	;---------------------------
	; event: update blinking tiles
	;---------------------------
+continue:
	LDA menuFlags
	BNE +blink
	STA menuCounter										; reset to 0
	BEQ +done													; JMP

+blink:
	LDA menuCounter
	AND #$0F													; every 8 frames
	BNE +increment
	LDA menuFlags
	EOR menuFlag_blink								; toggle the blink flag
	STA menuFlags

	LDA events
	ORA event_refreshStatusBar				; raise event to trigger buffer to screen
	STA events

+increment:
	INC menuCounter

+done:

	;-------------------------------------------
	; END !!! unused processor time, waiting for sprite 0
	;-------------------------------------------

	LDA sysFlags
	BIT sysFlag_splitScreen
	BEQ +skip

	; add statys bar Y scroll?
	LDA cameraYStatus
	BEQ +storeOffset
	CLC
	ADC #$10
	EOR #$FF
	ADC #$01

+storeOffset:
	STA nmiVar0

	; --- prepare scroll register values and store in X & Y ---
	LDA cameraY+1			; prepare the final write to $2006 and store in X
	STA nmiVar1				; save camera Y in Y register
	CLC
	ADC nmiVar0
	TAY								; save camera Y + offset in Y register
	AND #%00111000			; mask coarse Y scroll
	ASL						; and move to
	ASL						; the most significant bits
	STA cameraY+1			; store the result in camera Y
	LDA cameraX+1			; load camera X
	LSR						; remove the fine scroll bits
	LSR						; so that coarse X scroll
	LSR						; is stored in b4-b0
	CLC
	ADC cameraY+1			; add coarse Y scroll (b7-b5)
	TAX						; and store our shadow $2006 value for later
	STY cameraY+1			; restore camera Y from Y register

-	BIT $2002						; wait for the status bar to render (sprite 0 hit)
	BVC -

	; --- start of h-blank code ---
	LDA $2002						; set scroll and name table for the play field
	LDA #%00000000			; ----.NN--
	STA $2006
	LDA cameraY+1				; YY--.-yyy (YY= most significant, -'s are ignored)
	STA $2005
	LDA cameraX+1				; ----.-xxx
	STA $2005
	TXA									; YYYX.XXXX (YYY= least significant)
	STA $2006

	LDA #$02
	STA $9000						; switch the name table to NT 0 (level map)

	; --- end of h-blank code ---
	LDA nmiVar1					; restore Camera Y
	STA cameraY+1

+skip:

	LDA #0				; bank 0: mission map tiles & subroutines
	STA $8000			; in bank slot 1

	LDA cameraX+1			; detect if horizontal scrolling is needed
	AND #%00000111
	CMP #$04
	BNE +continue
	JSR writeNextColumnToBuffer

+continue:
	LDA sysFlags
	LSR
	BCC +continue
	JSR writeNextRowToBuffer

+continue:


; --- update camera position ---
	LDA sysFlags
	AND #%00111110				; reset scroll direction  and adjustment flags
	STA sysFlags
	LDA cameraX+0
	CMP cameraXDest+0
	BCC +addX					; camera < dest
	BNE +decX					; camera > dest
	LDA cameraX+1
	CMP cameraXDest+1
	BCC +addX
	BNE +decX
	JMP +doneX					; camera == dest

+addX:
	LDA cameraX+1				; CLC guarantee
	ADC #$02
	STA cameraX+1
	LDA cameraX+0
	ADC #$00
	STA cameraX+0

	LDA sysFlags			; store the direction (right)
	ORA #%10000000
	STA sysFlags

	JMP +setFlag
+decX:
	SEC						; 2 cycles
	LDA cameraX+1			; 3
	SBC #$02				; 3
	STA cameraX+1			; 3
	LDA cameraX+0			; 3
	SBC #$00				; 3
	STA cameraX+0			; 3

+setFlag:
	;LDA events				; set flag
	;ORA event_updateSprites
	;STA events

+doneX:
	LDA cameraY+0
	CMP cameraYDest+0
	BCC +addY					; camera < dest
	BNE +decY					; camera > dest
	LDA cameraY+1
	CMP cameraYDest+1
	BCC +addY
	BNE +decY
	JMP +doneY

+addY:
	LDA cameraY+1
	ADC #$02
	STA cameraY+1
	LDA cameraY+0
	ADC #$00
	STA cameraY+0

	LDA sysFlags			; store the direction (down)
	ORA #%01000000
	STA sysFlags

	JMP +setFlag
+decY:
	SEC
	LDA cameraY+1
	SBC #$02
	STA cameraY+1
	LDA cameraY+0
	SBC #$00
	STA cameraY+0

+setFlag:
	;LDA events					; set flag
	;ORA event_updateSprites
	;STA events

+doneY:

	LDA #4				; bank 4: bytestreams
	STA $8000			; in bank slot 1


								; restore A, X & Y to values before NMI
	PLA 					; pull 1st value of the stack
	TAY						; transfer value back into Y
	PLA						; pull 2nd value of the stack
	TAX						; transfer value back into X
	PLA 					; pull 3rd value of the stack

	INC frameCounter
	RTI
