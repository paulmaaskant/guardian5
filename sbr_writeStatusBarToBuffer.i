; -------------------------------------
; Write action menu to buffer
; -------------------------------------
writeStatusBarToBuffer:
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

	; --- line 1 tile 6 and 7 ---
	LDA #$0F			; separator blank space
	PHA
	LDA menuIndicator+1
	PHA

	; --- line 1 tile 8 through 21 ---
	LDX #$0C			; 11
	LDA menuFlags
	BPL +notBlank
	BIT menuFlag_line1
	BEQ +notBlank
	LDA #$0F

-loop1:									; if the line is blinking and is blank
	PHA										; just push 12 blank tiles
	DEX
	BPL -loop1
	BMI +done

+notBlank:

-loop2:
	LDA actionMenuLine1, X
	PHA
	DEX
	BPL -loop2

+done:
	; --- line 1 tile 22 ---
	LDA menuIndicator+0
	PHA
	LDA #$0F
	PHA

	LDA systemMenuLine1+0
	PHA

	LDA #$47
	PHA
	LDA #$24
	PHA
	LDA #48							; 24 * 2 = 50
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
	PHA
	PHA

	LDA systemMenuLine1+1
	PHA


	LDA #$67
	PHA
	LDA #$24
	PHA
	LDA #48								; 24 * 2 = 50
	PHA

	; --- line 3 ---
	LDX #$05
-loop:
	LDA targetMenuLine3, X
	PHA
	DEX
	BPL -loop

	LDA #$2C
	PHA


	LDX #$0C
	LDA #$0F			; separator blank space
	PHA					;
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
	PHA
	LDA systemMenuLine1+2
	PHA


	LDA #$87
	PHA
	LDA #$24
	PHA
	LDA #48							; 24 * 2
	PHA



	LDA systemMenuLine3+2
	PHA
	LDA systemMenuLine3+1
	PHA
	LDA systemMenuLine3+0
	PHA
	LDA #$A2
	PHA
	LDA #$24
	PHA
	LDA #$06								;
	PHA

	TSX											; switch stack pointers
	STX	stackPointer2
	LDX stackPointer1
	TXS

	RTS
