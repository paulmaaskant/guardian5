clearActionMenu:
	LDA #$0F
	LDX #$26
-	STA actionMenuLine1, X
	DEX
	BPL -
	RTS

clearTargetMenu:
	LDA #$0F					; clear tile
	LDX #$11
-	STA targetMenuLine1, X
	DEX
	BPL -
	RTS

clearSystemMenu:
	LDA #$0F					; clear tile
	LDX #$0E
-	STA systemMenuLine1, X
	DEX
	BPL -
	RTS


showTargetMech:
	LDA #$30
	STA targetMenuLine1+0
	STA targetMenuLine1+2
	LDA #$3B
	STA targetMenuLine1+1
	LDA #$31
	STA targetMenuLine2+0
	LDA #$32
	STA targetMenuLine2+1
	LDA #$33
	STA targetMenuLine2+2
	LDA #$34
	STA targetMenuLine3+0
	LDA #$35
	STA targetMenuLine3+2
	RTS

showHexagon:
	LDA #$36
	STA targetMenuLine2+0
	LDA #$37
	STA targetMenuLine2+1
	LDA #$38
	STA targetMenuLine2+2
	RTS


; IN pointer1 (fixed stats)
showSystemInfo:
	LDA #$10
	STA systemMenuLine1+0
	LDA #$23
	STA systemMenuLine1+5

	LDA activeObjectStats+6
	JSR toBCD
	LDA par2
	STA systemMenuLine1+1
	LDA par3
	STA systemMenuLine1+2

	LDY activeObjectIndex
	LDA object+1, Y
	AND #%00000111
	JSR toBCD

	LDA par2
	STA systemMenuLine1+6
	LDA par3
	STA systemMenuLine1+7
	RTS

; ----------------------------
; Show pilot
; ----------------------------
; IN A (b7-b4) pilot ID
showPilot:
	PHA							; for bank
	LSR
	LSR
	PHA							; for address
	LSR
	LSR
	CLC
	ADC #$08
	STA currentPalettes+3
	STA currentPalettes+6
	LDA #$00
	JSR updatePalette

	PLA							; set address
	AND #%00001100
	CLC
	ADC #$C0
	STA locVar1

	PLA							; set bank
	AND #%11000000
	ROL
	ROL
	ROL							; Carry clear
	ADC #$08
	STA $E002

	TSX							; switch stack pointers
	STX	stackPointer1
	LDX stackPointer2
	TXS

	LDY #$00
-outerLoop:
	LDX #$03
-innerLoop:
	LDA identity, Y
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC locVar1
	ADC identity, X
	PHA
	DEX
	BPL -innerLoop
	LDA identity, Y
	ROR
	ROR
	ROR
	ROR
	CLC
	ADC #$40
	PHA
	LDA #$24
	PHA
	LDA #$08
	PHA

	INY
	CPY #$03
	BNE -outerLoop

	TSX					; switch stack pointers
	STX	stackPointer2
	LDX stackPointer1
	TXS


	RTS


; -------------------------------------
; Y is string #
; X is position
; -------------------------------------
writeToActionMenu:
	LDA stringListL, Y
	STA pointer1+0
	LDA stringListH, Y
	STA pointer1+1

	LDY #$00
	LDA (pointer1), Y			; length
	TAY

	CLC
	ADC identity, X
	TAX
-loop:
	LDA (pointer1), Y

	BPL +
	STY locVar1
	AND #$7F
	TAY
	LDA list3, Y
	LDY locVar1

+	STA actionMenuLine1-1, X

	DEX
	DEY

	BNE -loop
	RTS

; -------------------------------------
; Write action menu to buffer
; -------------------------------------
writeMenuToBuffer:
	TSX							; switch stack pointers
	STX	stackPointer1
	LDX stackPointer2
	TXS

	; --- line 1 tile 0 to 5 ---
	LDX #$05
-loop:
	LDA targetMenuLine1, X
	PHA
	DEX
	BPL -loop

	; --- line 1 tile 6 ---
	LDA #$0F			; separator blank space
	PHA

	; --- line 1 tile 7 ---
	LDA menuFlags
	BPL +set
	BIT menuFlag_indicator
	BEQ +set
	LDA #$0F
	JMP +push
+set:
	LDA menuIndicator+1
+push:
	PHA

	; --- line 1 tile 8 through 21 ---
	LDX #$0C			; 11

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

-loop2:
	LDA actionMenuLine1, X
	PHA
	DEX
	BPL -loop2
+done:

	; --- line 1 tile 21 ---
	LDA menuFlags
	BPL +set
	BIT menuFlag_indicator
	BEQ +set
	LDA #$0F
	JMP +push
+set:
	LDA menuIndicator+0
+push:
	PHA

	; --- line 1 tile 23 to 26 ---
	LDX #$04			;
-loop:
	LDA systemMenuLine1, X
	PHA
	DEX
	BPL -loop

	LDA #$44
	PHA
	LDA #$24
	PHA
	LDA #$36			; 27 * 2 = 54
	PHA

	; --- line 2 ---
	LDX #$05
-loop:
	LDA targetMenuLine2, X
	PHA
	DEX
	BPL -loop
	LDX #$0C

	LDA #$0F			; separator blank space
	PHA					; twice
	PHA

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
-loop2:
	LDA actionMenuLine2, X
	PHA
	DEX
	BPL -loop2
+done:

	LDA #$0F			; separator blank space
	PHA					;
	;PHA

	LDX #$04			; 03
-loop:
	LDA systemMenuLine2, X
	PHA
	DEX
	BPL -loop

	LDA #$64
	PHA
	LDA #$24
	PHA
	LDA #$36
	PHA

	; --- line 3 ---
	LDX #$05
-loop:
	LDA targetMenuLine3, X
	PHA
	DEX
	BPL -loop
	LDX #$0C
	LDA #$0F			; separator blank space
	PHA					;
	PHA
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
-loop2:
	LDA actionMenuLine3, X
	PHA
	DEX
	BPL -loop2
+done:

	LDA #$0F			; separator blank space
	PHA					; twice

	LDX #$04			; 03
-loop:
	LDA systemMenuLine3, X
	PHA
	DEX
	BPL -loop

	LDA #$84
	PHA
	LDA #$24
	PHA
	LDA #$36			;
	PHA



	LDA targetMenuLine4+2
	PHA
	LDA targetMenuLine4+1
	PHA
	LDA targetMenuLine4+0
	PHA
	LDA #$B9
	PHA
	LDA #$24
	PHA
	LDA #$06			;
	PHA





	TSX					; switch stack pointers
	STX	stackPointer2
	LDX stackPointer1
	TXS

	RTS
