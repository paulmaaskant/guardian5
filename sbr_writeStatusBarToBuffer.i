; -------------------------------------
; Write action menu to buffer
; -------------------------------------
writeStatusBarToBuffer:
	TSX							; switch stack pointers
	STX	stackPointer1
	LDX stackPointer2
	TXS

	; --- line 1 tile 0 to 5 ---
	LDX #$02

-loop:
	LDA targetMenuLine1, X
	PHA
	DEX
	BPL -loop

	LDA #space
	PHA
	LDA targetMenuImage+1
	PHA
	LDA targetMenuImage+0
	PHA

	; --- line 1 tile 6 and 7 ---
	LDA #$0F			; separator blank space
	PHA
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
	LDA #space
	PHA

	LDX #2

-loop:
	LDA systemMenuLine3, X
	PHA
	DEX
	BPL -loop

	LDA #$45
	PHA
	LDA #$24
	PHA
	LDA #54							; 27 * 2
	PHA

	; --- line 2 ---
	LDX #$02

-loop:
	LDA targetMenuLine2, X
	PHA
	DEX
	BPL -loop

	LDA #space
	PHA
	LDA targetMenuImage+3
	PHA
	LDA targetMenuImage+2
	PHA




	LDX #$0C
	LDA #$0F			; separator blank space
	PHA					; twice
	PHA
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

	LDA #space			; separator blank space
	PHA
	PHA


	LDX #2

-loop:
	LDA systemMenuLine1, X
	PHA
	DEX
	BPL -loop

	LDA #$65
	PHA
	LDA #$24
	PHA
	LDA #54								; 27 * 2
	PHA

	; --- line 3 ---

	LDA targetMenuImage+5
	PHA
	LDA targetMenuImage+4
	PHA
	LDA #$2C
	PHA


	LDX #12
	LDA #space			; separator blank space
	PHA							;
	PHA
  LDA menuFlags
	BPL +set
	BIT menuFlag_line3
	BEQ +set
	LDA #space

-loop1:
	PHA
	DEX
	BPL -loop1
	BMI +done

+set:
	LDX #13
	LDA actionMessage
	AND #%01111111
	TAY
	JSR writeStringToBuffer

	; -loop2
	;LDA actionMenuLine3, X
	;PHA
	;DEX
	;BPL -loop2

+done:

	LDA #space			; separator blank space
	PHA					; twice
	PHA

	LDX #2

-loop:
	LDA systemMenuLine2, X
	PHA
	DEX
	BPL -loop

	LDA #$85
	PHA
	LDA #$24
	PHA
	LDA #46							; 23 * 2
	PHA

;	LDX #$05

;-loop:
;	LDA targetMenuLine3, X									; target name
;	PHA
;	DEX
;	BPL -loop


	LDX #6
	LDY targetMenuName
	JSR writeStringToBuffer

	LDA #$B9
	PHA
	LDA #$24
	PHA
	LDA #12								;
	PHA


;	LDX #5
;
;-loop:
;	LDA systemMenuLine4, X
;	PHA
;	DEX
;	BPL -loop
;

	LDX #6
	LDY systemMenuName
	JSR writeStringToBuffer

	LDA #$A1
	PHA
	LDA #$24
	PHA
	LDA #12									;
	PHA

	TSX											; switch stack pointers
	STX	stackPointer2
	LDX stackPointer1
	TXS

	RTS
