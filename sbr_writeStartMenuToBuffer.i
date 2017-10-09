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
