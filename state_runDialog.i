; ------------------------------------------
; gameState 09: run dialog
; ------------------------------------------
; list1+0 address current tile hi
; list1+1 address current tile lo
; list1+2 address start tile hi
; list1+3 address start tile lo

; list1+5 # tiles margin right
; list1+6 stream control (b7 stop, b6 wait for A)
; list1+7 reserved
; list1+8 game state

state_runDialog:
	; --- if start button is hit ---
	LDA buttons
	AND #%00010000				; start button
	BEQ +continue

	LDA #$80
	STA list1+6

+continue:
	; --- stream control ----
	LDA list1+6
	ASL
	BCS	+nextGameState			;
	ASL
	BCC +continue
	ASL
	BCS +waitForConfirm
	RTS

+waitForConfirm:
	LDA buttons
	BMI +confirmed				; A button pressed

	LDA frameCounter
	AND #%00000111
	BEQ +cursor
	RTS

+cursor:
	LDA frameCounter
	AND #%00001000
	BEQ +off
	LDA #$2F
	JMP +pushChar

+confirmed:
	LDA #$00
	STA list1+6					; open stream again

+off:
	LDA #$0F
	JMP +pushChar

+nextGameState:
	JMP pullState

+continue:
	JSR getNextByte

	; --- op code: end of stream ---
	CMP #$F0
	BNE +continue
	LDA #$40				; set b6
	STA list1+6
	RTS						; and done

+continue:
	; --- op code: new line ---
	CMP #lineBreak
	BNE +continue



	LDA list1+3
	AND #%00011111
	STA list1+4

	LDA list1+1				; lo
	AND #%11100000		; round down (31)
	ORA list1+4
	ADC #$1F					; tiles: new line
	STA list1+1
	LDA list1+0
	ADC #$00
	STA list1+0
	RTS						; and done

+continue:
	; --- op code: clear all ---
	CMP #$F2
	BNE +continue

	LDA list1+2				; reset write address to first position
	STA list1+0				;
	LDA list1+3				;
	STA list1+1				;

	LDA #$06				; number of lines to clear
	STA list1+7				;

	LDA #$0F				; game state : clear text box
	JMP pushState

+continue:
	; --- op code: wait for A button ---
	CMP #$F3
	BNE +continue
	LDA #$60				; stop stream (b6) and wait for A button (b5)
	STA list1+6
	RTS

+continue:
	; --- op code: move to next game state ---
	CMP #$F4
	BNE +continue
	LDA #$80				; (b7) move to next game state
	STA list1+6
	RTS

+continue:

	PHA
	LDA soundStreamChannel+4
	BMI +
	LDY #sSimpleBlip
	JSR soundLoad
+	PLA

+pushChar:
	; --- no op code: output char in A ---
	TSX						; switch stack pointers
	STX	stackPointer1
	LDX stackPointer2
	TXS

	PHA
	LDA list1+1				; lo
	PHA
	LDA list1+0				; hi
	PHA
	LDA #$02
	PHA

	TSX						; switch stack pointers back
	STX	stackPointer2
	LDX stackPointer1
	TXS

	BIT list1+6
	BVS +continue

	INC list1+1				; set pointer to next tile position if stream is open
	BNE +continue
	INC list1+0

+continue:
	RTS
