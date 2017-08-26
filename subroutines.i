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
	STA locVar1
	LDA #$00
	STA locVar4

	; determine grid origin position
	; if camera = (0,0) then node 00 is screen pos (X, Y)  = ($20, $BF)
	SEC
	LDA #$BF				;
	SBC cameraY+1			; offset to account for camera
	STA currentObjectYPos
	LDA #$00
	SBC cameraY+0
	STA currentObjectYScreen

	SEC
	LDA #$20				;
	SBC cameraX+1			; offset to account for camera
	STA currentObjectXPos
	LDA #$00
	SBC cameraX+0
	STA currentObjectXScreen

	; --- pre calculate temp variables---
	LDA locVar1
	AND	#$F0				; y mask
	LSR
	STA locVar2				; YYYY * 8

	LDA locVar1
	AND #$0F				; x mask
	ASL
	ASL
	ASL
	STA locVar1				; XXXX * 8


	; --- calculate Y position ---
	SEC
	SBC locVar2				; (XXXX - YYYY) * 8
	BPL +pos
	DEC currentObjectYScreen
+pos:
	STA locVar3					; remove
	CLC
	LDA currentObjectYPos		; remove
	ADC locVar3					; ADC currentObjectYPos
	STA currentObjectYPos
	LDA currentObjectYScreen
	ADC #$00
	STA currentObjectYScreen

	; --- calculate X position ---
	LDA locVar1
	CLC
	ADC locVar2
	STA locVar3			; (X+Y) * 8
	ASL locVar3
	ROL locVar4
	CLC
	ADC locVar3
	STA locVar3
	LDA locVar4
	ADC #$00
	STA locVar4			; (X+Y) * 24 + current X
	LDA locVar3
	ADC currentObjectXPos
	STA currentObjectXPos
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
	JSR updateCameraXPos
+	RTS

; -------------------------------------------
; update Camera X position
;
; IN 	A				number of pixels to be added
; OUT	cameraYDest
; -------------------------------------------
updateCameraXPos
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
updateCameraYPos
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

;---------------------------------------
; updateActionList
;
; Determine the actions the player can choose from based on the current target node
; IN	activeObjectTypeAndNumber
; IN	activeObjectGridPos
; OUT   actionList
;---------------------------------------

; --- action attributes ----
; byte1: game state, byte2: char string
actionTable:
	.db $10, $02				; 00 MOVE
	.db $12, $00				; 01 RANGED ATK 1
	.db $12, $01				; 02 RANGED ATK 2
	.db $14, $04				; 03 COOL DOWN
	.db $17, $07				; 04 CLOSE COMBAT
	.db $1B, $03				; 05 CHARGE
	.db $19, $13				; 06 PIVOT TURN
	.db $10, $18				; 07 RUN

	aMOVE = $00
	aRANGED1 = $01
	aRANGED2 = $02
	aCOOLDOWN = $03
	aCLOSECOMBAT = $04
	aCHARGE = $05
	aPIVOT = $06
	aRUN = $07

updateActionList:
	; --- clear message ---
	LDA #$00
	STA actionMessage

	; --- clear list of possible actions ---
	LDX #$09									; loop to clear array
-	STA actionList, X
	DEX
	BPL -											; list cleared
	LDA #$01
	STA selectedAction

	LDA cursorGridPos					; cursor on self?
	CMP activeObjectGridPos		;
	BNE +continue							; no -> continue
														; yes ->

	; ----------------------------------
	; Cursor on SELF
	; ----------------------------------
	LDA #aPIVOT								; PIVOT TURN
	JSR addPossibleAction
	LDA #aCOOLDOWN						; COOL DOWN
	JSR addPossibleAction
	JMP prepareAction					; tail chain

+continue:
	LDA targetObjectTypeAndNumber		; Cursor on other UNIT?
	BEQ +continue										; no -> continue
																	; yes ->
	; ----------------------------------
	; Cursor on OTHER UNIT
	; ----------------------------------
	LDA distanceToTarget
	CMP #$01
	PHP
	BNE	+skipCloseCombat
	LDA #aCLOSECOMBAT
	JSR addPossibleAction

+skipCloseCombat:
	LDA #aRANGED1
	JSR addPossibleAction
	LDA #aRANGED2
	JSR addPossibleAction
	PLP
	BEQ +skipCharge
	LDA #aCHARGE
	JSR addPossibleAction

+skipCharge:
	JMP checkTarget					; tail chain, check conditions for attack
													; such as line of sight

	; ----------------------------------
	; Cursor on EMPTY SPACE
	; ----------------------------------
+continue:
	; --- find path ---
	LDA cursorGridPos
	STA par1										; par1 = destination node
	LDA activeObjectStats+2			;
	ASL
	STA par2										; par2 = # moves allowed
	LDX par1
	LDA nodeMap, X
	BPL +notBlocked
	LDA #$89										; deny (b7) + impassable (b6-b0)
	STA actionMessage
	BNE +walk

+notBlocked:
	LDA activeObjectGridPos			; A = start node
	JSR findPath								; A* search path, may take more than 1 frame
	LDA actionMessage						; if move is allowed
	BMI +done																																		; move > 1 heat
	LDA activeObjectStats+2			; movement stat
	CMP list1										; compare to used number of moves (list1)
	BCS +walk
	LDA #$02
	STA list3+0
	LDA #aRUN
	JMP addPossibleAction																																	; top spread > 1 exra heat

+walk:
	LDA #$01
	STA list3+0
	LDA #aMOVE
	JMP addPossibleAction

+done:
	RTS


;---------------------------------------
; IN A, action #
;---------------------------------------
addPossibleAction:
	INC actionList
	LDX actionList			; count+1
	STA actionList, X
	RTS

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

; ------------------------------------------
; Initialize screen
; ------------------------------------------
; list1+0 , number of tile rows
; list1+1 , next game state
; list1+2 , pointer byte stream hi
; list1+3 , pointer byte stream lo
; list1+4 , b7 fade in / b6 fade out
; ------------------------------------------
initializeScreen:
	; --- set VRAM address ---
	LDA #$24						; VRAM address for status bar
	STA pointer2+0					; $[24]00
	LDA #$00
	STA pointer2+1					; $24[00]

	; --- set byte stream address ---
	LDA list1+2
	STA bytePointer+0
	LDA list1+3
	STA bytePointer+1

	LDA #$20
	STA list1+0

	; --- determine next game state ---
	LDA #$0E							; goal game state "load screen"
	BIT list1+4						; fade out first?
	BVC +

	; --- set fade out parameters ---
	STA list2+1						; next next game state
	LDA #$00							; fade out parameters
	STA list2+0						; counter for fade out
	STA list2+2						; starting brightness
	STA list2+3						; fade out
	LDA #$07
	STA list2+4						; timing mask
	LDA #$C0
	STA list2+5						; all black

	LDA #$02							; game state "fade out"
+	STA gameState					; next gamestate
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
