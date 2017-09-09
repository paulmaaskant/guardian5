; -----------------------------------------
; write 32 tiles
; -----------------------------------------
write32Tiles:
	TSX						; switch stack pointers
	STX	stackPointer1
	LDX stackPointer2
	TXS

	LDX #$20
-	JSR getNextByte
	PHA
	DEX
	BNE -

	LDA pointer2+1
	PHA
	LDA pointer2+0
	PHA
	LDA #$40
	PHA

	LDA pointer2+1			; increment pointer to tile position by 32
	CLC
	ADC #$20
	STA pointer2+1
	LDA pointer2+0
	ADC #$00
	STA pointer2+0

	TSX						; switch stack pointers back
	STX	stackPointer2
	LDX stackPointer1
	TXS

	RTS



;------------------------------------------
; grid coordinates to screen position
;
; IN		A = hexagon = YYYYXXXX
; OUT 		currentObjectXPos = X screen position
; OUT 		currentObjectYPos = Y screen position
; OUT		carry flag, 1 set when on screen
; LOCAL 	locVar1
; LOCAL		locVar2
; LOCAL 	locVar3
; LOCAL		locVar4
;------------------------------------------
gridPosToScreenPos:
	STA locVar1																																		; store to retrieve X later
	AND	#$F0																																			; Y mask
	LSR
	STA locVar2																																		; store YYYY * 8

	SEC																																						; start by calculating
	LDA #$BF																																			; the screen position of grid 0,0
	SBC cameraY+1																																	; given the current camera position
	STA currentObjectYPos																													; w/o scrolling this would be (X=$20, Y=$BF)
	LDA #$00																																			; store it in the current coordinates
	STA locVar4																																		; reset variable 4 (has nothing to with SBC)
	SBC cameraY+0
	STA currentObjectYScreen
	SEC
	LDA #$20																																			;
	SBC cameraX+1																																	; offset to account for camera
	STA currentObjectXPos
	LDA #$00
	SBC cameraX+0
	STA currentObjectXScreen

	LDA locVar1																																		; determine X
	AND #$0F																																			; x mask
	ASL
	ASL
	ASL
	STA locVar1																																		; XXXX * 8, store for use later
	SEC																																						; calculate Y screen offset relative to grid 0,0
	SBC locVar2																																		; (XXXX - YYYY) * 8
	BPL +continue
	DEC currentObjectYScreen

+continue:
	CLC
	ADC currentObjectYPos
	STA currentObjectYPos																													; final Y screen position
	LDA currentObjectYScreen
	ADC #$00
	STA currentObjectYScreen																											; final Y screen

	LDA locVar1																																		; X screen is next
	CLC
	ADC locVar2
	STA locVar3																																		; (X+Y) * 8 (max value is 240)
	ASL 																																					; multiply locvar3 by 3
	ROL locVar4																																		; and store result in locvar3 (lo) and locVar4 (hi)
	ADC locVar3																																		; this is the X screen offset relative to grid 0,0
	STA locVar3
	LDA locVar4
	ADC #$00
	STA locVar4																																		; add the offset to current
	LDA locVar3
	ADC currentObjectXPos
	STA currentObjectXPos																													; final X screen position
	LDA currentObjectXScreen
	ADC locVar4
	STA currentObjectXScreen

	; --- check if object is within camera rectangle ---
	LDA currentObjectXScreen
	BNE +offScreen
	LDA currentObjectYScreen
	BNE +offScreen
	LDA currentObjectYPos
	CMP #$30
	BCC +offScreen
	CMP #$E0
	BCS +offScreen
	LDA currentObjectXPos
	CMP #$08
	BCC +offScreen
	CMP #$F8
	BCS +offScreen
	SEC
	RTS

+offScreen:
	CLC
	RTS

;------------------------------------------
; random 255
;
; IN OUT 	seed
; OUT A 	random byte
;------------------------------------------
random:
	LDX #$08
	LDA seed+0
--	ASL
	ROL seed+1
	BCC +
	EOR #$2D
+	DEX
	BNE --
	STA seed+0
	CMP #$00
	RTS

random100:
	JSR random
	LDX #$64		;
	JSR multiply	;
	LDA par1		; between 0 and 99
	RTS




;------------------------------------------
; multiply
; M * N = MN
;
; M (1 byte) A
; N (1 byte) X
; MN (2 Bytes) par 1 hi, par 2 lo
;-----------------------------------------
multiply:
	EOR #$FF		; flip bits of M
	STA locVar1		; M
	STX locVar2		; N
	LDA #$00
	STA par1
	STA par2
	LDY #$08
-	ASL par2
	ROL par1
	ASL locVar1
	BCS +			; leverage M flipped bits to prevent CLC
	;CLC
	LDA par2
	ADC locVar2
	STA par2
	LDA par1
	ADC #$00
	STA par1
+	DEY
	BNE -
	RTS



;------------------------------------------
; divide
; N/D = (Q,R)
;
; D cannot be greater than 127
;
; IN 	 N 	Numerator 		(2 bytes)    par1 hi, par2 lo
; IN 	 D 	Denominator 	(1 byte)	 A
; OUT    Q quotient A 		(2 bytes)    par3 hi, par4 lo
; OUT 	 R 	Rest			(1 byte)	 A
;------------------------------------------
divide:
	STA locVar1		; D
	LDA #$00
	STA locVar2		; R
	STA par3		; Q high
	STA par4		; Q low
	INC par4		; set bit b0 to 1 (end condition bit)
-divLoop:
	ASL par2		;
	ROL	par1		; move b15 from N
	ROL locVar2		; into R
	LDA locVar2		; load R into accumulator
	CMP locVar1		; compare to D
	BCC +			; if R >= D
	SBC locVar1		; carry is set for sure
	STA locVar2		; then R = R - D, carry is set for sure (because R >= D)
+	ROL par4		; move carry flag value into Q
	ROL par3
	BCC -divLoop	; wait for end condition bit to fall off
	LDA locVar2		; load R
	RTS

;------------------------------------------
; distance
; number of hex grid cells between start & dest
;
; IN A	xxxx yyyy (start)
; IN par1 	XXXX YYYY (dest)
; OUT A		distance
; LOCAL locVar1,2
; LOCAL locVar3,4
; LOCAL locVar5
;-----------------------------------------
distance:
	PHA
	LSR
	LSR
	LSR
	LSR
	STA locVar2 	; start.Y
	PLA
	AND #$0F
	STA locVar1		; start.X
	LDA par1
	LSR
	LSR
	LSR
	LSR
	STA locVar4 	; dest.Y
	LDA par1
	AND #$0F
	STA locVar3		; dest.X

	LDA locVar1
	SEC
	SBC locVar3
	JSR absolute
	STA locVar5		; absolute X distance

	LDA locVar2
	SEC
	SBC locVar4
	JSR absolute	; absolute Y distance
	CMP locVar5
	BCC +
	STA locVar5

+	CLC

	LDA locVar1
	ADC locVar2
 	SEC
	SBC locVar3
	SEC
	SBC locVar4

	JSR absolute

	CMP locVar5
	BCC +
	STA locVar5
+
	LDA locVar5
	RTS

;-----------------------------------------
; absolute
; IN OUT A
;-----------------------------------------
absolute:
	BPL +
	EOR #%11111111
	CLC
	ADC #$01
+	RTS

;------------------------------------------
; toBCD
; byte to 3 binary coded decimals
;
; IN A = binary number to convert
; OUT par1
; OUT par2
; OUT par3
;-------------------------------------------
toBCD:
	STA locVar1			; byte
	LDA #$00			; initialize
	STA par3			;
	STA par2			; 0-3 are ones, 4-7 are tens
	LDA #%00000001		; b0 is set to 1 as the stop condition
	STA par1			; 0-1 are hundreds

-shiftloop:
	LDA par2
	AND #$0F			; mask the ones
	CMP #$05			; if ones => 5
	BCC	+				; then
	LDA par2
	CLC
	ADC	#$03			; add 3
	STA par2
+	LDA par2
	CMP #$50			; if tens => 5
	BCC +
	CLC
	ADC	#$30			; add 3
+	STA par2			; store ones and tens
	LDA par1
	ADC #$00
	STA par1			; add carry to hundreds

	ASL locVar1			; shift byte
	ROL par2			; shift ones and tens
	ROL par1			; shift hundreds and stop condition
	BCC -shiftloop

	LDA par2			; finally
	AND #$0F			; separate the ones
	STA par3			; into par 3

	LDA par2
	LSR
	LSR
	LSR
	LSR
	STA par2

	RTS

;-----------------------------------------
; updateCamera
;
; IN cursorGridPos
; OUT cameraYDest, cameraXDest
;-----------------------------------------
updateCamera:
	LDA cursorGridPos
	JSR gridPosToScreenPos			; sets currentObject_Pos
	LDA currentObjectYPos			; if cursor screen pos < 70
	CMP #$46
	BCS +
	LDA #$F0						; - 16
	JSR updateCameraYPos
+	LDA currentObjectYPos			; if cursor screen pos > 200
	CMP #$A8
	BCC +downScrollDone				; then skip scroll
	LDA #$10						; +16
	JSR updateCameraYPos

+downScrollDone:
	LDA currentObjectXPos			; if screen pos > 224 = 128+64+32
	CMP #$E0
	BCC +rightScrollDone			; then skip scroll
	LDA #$18						; + 24
	JSR updateCameraXPos

+rightScrollDone:
	LDA currentObjectXPos			; if screen pos < 40
	CMP #$28
	BCS +
	LDA #$E8						; -24							; A is signed
	JMP updateCameraXPos						; tail chain
+	RTS

; -------------------------------------------
; update Camera X position
;
; IN 	A				number of pixels to be added
; OUT	cameraYDest
; -------------------------------------------
updateCameraXPos:
	BPL +
	DEC cameraXDest+0
+	CLC
	ADC cameraXDest+1
	STA cameraXDest+1
	LDA cameraXDest+0
	ADC #$00
	STA cameraXDest+0
	BPL +
	LDA #$00
	STA cameraXDest+0
	STA cameraXDest+1
+	CMP #$02
	BCC +done
	BNE +limit
	LDA cameraXDest+1
	CMP #$00
	BCC +done
+limit:
	LDA #$02
	STA cameraXDest+0
	LDA #$00
	STA cameraXDest+1
+done:
	RTS

; -------------------------------------------
; update Camera Y position
;
; IN 	A				number of pixels to be added
; OUT	cameraYDest
; -------------------------------------------
updateCameraYPos:
	BPL +
	DEC cameraYDest+0
+	CLC
	ADC cameraYDest+1
	STA cameraYDest+1
	LDA cameraYDest+0
	ADC #$00
	STA cameraYDest+0
	BPL +
	LDA #$00
	STA cameraYDest+0
	STA cameraYDest+1
+	CMP #$00
	BCC +done
	BNE +limit
	LDA cameraYDest+1
	CMP #$78
	BCC +done
+limit:
	LDA #$00
	STA cameraYDest+0
	LDA #$78
	STA cameraYDest+1
+done:
	RTS

;-----------------------------------------
; load target object
;	IN
;-----------------------------------------
updateTargetObject:
	LDA activeObjectGridPos
	STA par1
	LDA cursorGridPos
	JSR distance
	STA distanceToTarget

	LDX #$00
	STX targetObjectIndex
	STX targetObjectTypeAndNumber
-loop:
	LDA objectTypeAndNumber, X
	AND #$07
	ASL
	ASL
	TAY
	LDA object+3, Y
	CMP cursorGridPos
	BEQ +setObjectAsTarget
	INX
	CPX objectCount
	BNE -loop
	RTS
+setObjectAsTarget:
	STY targetObjectIndex
	LDA objectTypeAndNumber, X
	STA targetObjectTypeAndNumber
	RTS


;------------------------------------------
; Update Target Menu
; called when cursor has moved
; still very messy
; -----------------------------------------
updateTargetMenu:
	;---- show distance to target ---
	LDA distanceToTarget
	JSR toBCD
	LDA #$13
	STA targetMenuLine4+0
	LDA par2
	STA targetMenuLine4+1
	LDA par3
	STA targetMenuLine4+2

	;--- determine the target type (unit or empty node)
	LDA targetObjectTypeAndNumber
	BNE +displayTarget
	JMP showHexagon				; tail chain

+displayTarget:
	CMP activeObjectTypeAndNumber
	BEQ +done

	; --- target stats ---
	LDA #$10
	STA targetMenuLine1+3
	LDA #$0F
	STA targetMenuLine1+4
	LDA #$0B
	STA targetMenuLine1+5
	LDA #$1F

	BIT actionMessage					; check for invalid target
	BMI +done							; skip power & hit

	; --- armor ---
	LDA list3+12
	STA targetMenuLine1+4
	LDA list3+13
	STA targetMenuLine1+5

+done:
	JMP showTargetMech					; tail chain

; ------------------------------------------
; retrieves dail position address
; IN A (object)TypeAndNumber
; OUT pointer1, fixed stats
; OUT Y , pointer1 + Y = current stats
; OUT A, current dail pos
; ------------------------------------------
getStatsAddress:
	PHA
	AND #%00000111
	ASL
	ASL
	TAY

	PLA
	AND #%01111000
	LSR
	LSR
	LSR
	TAX
	LDA objectTypeL, X
	CLC
	ADC #$0D
	STA pointer1+0
	LDA objectTypeH, X
	ADC #$00
	STA pointer1+1

	LDA object+1, Y					; current dail pos
	LSR
	LSR								; 3x shift right
	LSR
	PHA
	TAY								; multiply by 3 (3 bytes per dail click)
	ASL								; carry is guaranteed 0
	ADC identity, Y
	TAY
	PLA								; current dail pos in A
	RTS

; --------------------------
; clear list 3
; position X through A
; --------------------------
clearList3:
	STA locVar1
	LDA #$00
-loop:
	STA list3, X
	DEX
	CPX locVar1
	BCS -loop
	RTS

; --------------------------
; A brightness (-40 +40
; --------------------------
updatePalette:
	STA locVar1								; adjustment value
	LDY #$07
-loop:
	LDX currentPalettes, Y

	LDA paletteColor1, X
	CLC
	ADC locVar1
	BPL +											; if color value becomes negative
	LDA #$0F									; make it BLACK (0F)
+	CMP #$3E
	BCC +											; if color vale becomes bigger than 60
	LDA #$30									; make it white
+	STA pal_color1, Y

	LDA paletteColor2, X
	CLC
	ADC locVar1
	BPL +
	LDA #$0F
+	CMP #$3E
	BCC +
	LDA #$30
+	STA pal_color2, Y

	LDA paletteColor3, X
	CLC
	ADC locVar1
	BPL +
	LDA #$0F
+	CMP #$3E
	BCC +
	LDA #$30
+	STA pal_color3, Y

	DEY
	BPL -loop

	LDA currentTransparant
	CLC
	ADC locVar1
	BPL +
	LDA #$0F
+	CMP #$3E
	BCC +
	LDA #$30
+	STA pal_transparant

	RTS

; --------------------------
; deleteObject A
; --------------------------
deleteObject:
	LDX #$05

	; --- first find the to-be deleted object ---
-loop:
	CMP objectTypeAndNumber, X
	BEQ +match
	DEX
	BPL -loop
	RTS

	; --- then delete it ---
+match:
	AND #$07
	ASL
	ASL
	TAY
	LDA object+3, Y
	TAY
	LDA nodeMap, Y
	AND #$3F
	STA nodeMap, Y

	DEC objectCount
-loop:
	CPX objectCount
	BEQ +done
	LDA objectTypeAndNumber+1, X
	STA objectTypeAndNumber, X
	INX
	BEQ -loop												; always branches

+done:
	LDA events
	ORA event_updateSprites
	STA events
	RTS


writeStartMenuToBuffer:
	TSX													; switch stack pointers
	STX	stackPointer1
	LDX stackPointer2
	TXS

	LDA list1+2
	JSR toBCD
	LDA par2
	STA actionMenuLine3+11
	LDA par3
	STA actionMenuLine3+12


	; --- line 1 tile 8 through 21 ---
	LDX #$0D			; 13

	LDA menuFlags
	BPL +set
	BIT menuFlag_line1
	BEQ +set
	LDA #$0F

-loop1:
	PHA
	DEX
	BPL -loop1
	JMP +done

+set:
	DEX
-loop2:
	LDA actionMenuLine1, X
	PHA
	DEX
	BPL -loop2
	LDA menuIndicator+0
	PHA

+done:
	LDA #$6A
	PHA
	LDA #$26
	PHA
	LDA #$1C			; 14 * 2 = 28
	PHA

	LDX #$0D		; 13
	LDA menuFlags
	BPL +set
	BIT menuFlag_line2
	BEQ +set
	LDA #$0F

-loop1:
	PHA
	DEX
	BPL -loop1
	JMP +done

+set:
	DEX
-loop2:
	LDA actionMenuLine2, X
	PHA
	DEX
	BPL -loop2
	LDA menuIndicator+1
	PHA

+done:
	LDA #$8A
	PHA
	LDA #$26
	PHA
	LDA #$1C			; 14 * 2 = 28
	PHA

	LDX #$0D			; 13
	LDA menuFlags
	BPL +set
	BIT menuFlag_line3
	BEQ +set
	LDA #$0F

-loop1:
	PHA
	DEX
	BPL -loop1
	JMP +done

+set:
	DEX
-loop2:
	LDA actionMenuLine3, X
	PHA
	DEX
	BPL -loop2
	LDA menuIndicator+2
	PHA
+done:

	LDA #$AA
	PHA
	LDA #$26
	PHA
	LDA #$1C			; 14 * 2 = 28
	PHA


	TSX													; switch stack pointers
	STX	stackPointer2
	LDX stackPointer1
	TXS
	RTS
