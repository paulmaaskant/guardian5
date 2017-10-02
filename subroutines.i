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
	JSR gridPosToScreenPos																												; sets currentObject_Pos
	LDA currentObjectYPos																													; if cursor screen pos < 70
	CMP #$46
	BCS +
	LDA #$F0																																			; move camera Y up by 16 px
	JSR updateCameraYPos
+	LDA currentObjectYPos																													; if cursor screen pos > 200
	CMP #$A8
	BCC +downScrollDone																														; then skip scroll
	LDA #$10																																			;
	JSR updateCameraYPos																													; move camera Y down by 16 px

+downScrollDone:
	LDA currentObjectXPos			; if screen pos > 224 = 128+64+32
	CMP #$E0
	BCC +rightScrollDone			; then skip scroll


	LDA blockInputCounter
	CLC
	ADC #$04
	STA blockInputCounter

	LDA #$18									; + 24
	JSR updateCameraXPos

+rightScrollDone:
	LDA currentObjectXPos			; if screen pos < 40
	CMP #$28
	BCS +

	LDA blockInputCounter
	CLC
	ADC #$04
	STA blockInputCounter

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
	CMP #$70
	BCC +done
+limit:
	LDA #$00
	STA cameraYDest+0
	LDA #$70
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
	LDA #$3E
	STA targetMenuLine3+3
	LDA par2
	STA targetMenuLine3+4
	LDA par3
	STA targetMenuLine3+5

	;--- determine the target type (unit or empty node)
	LDA targetObjectTypeAndNumber
	BNE +displayTarget
	JMP showHexagon				; tail chain

+displayTarget:
	CMP activeObjectTypeAndNumber
	BEQ +done

	; --- target stats ---
	LDA #$3C
	STA targetMenuLine1+3
	LDA #$0F
	STA targetMenuLine1+4
	STA targetMenuLine2+4
	LDA #$0B
	STA targetMenuLine1+5
	STA targetMenuLine2+5

	LDA #$3D
	STA targetMenuLine2+3


	;LDA #$1F

	BIT actionMessage					; check for invalid target
	BMI +done							; skip power & hit

	; --- hit points ---
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
	LDA #$69
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
	LDA #$89
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

	LDA #$A9
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
