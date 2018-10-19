; ------------------------------------------
; gameState 09: run dialog
; ------------------------------------------
; list1+0 address current tile hi
; list1+1 address current tile lo
; list1+2 address start tile hi
; list1+3 address start tile lo
; list1+4 # tiles margin left
; list1+5 # tiles margin right
; list1+6 stream control (b7 end, b6 wait for A, b5 speed mode)
; list1+7 line count  (used to clear dialog)
; list1+8 number of lines
; list1+9 number of buffered characters

state_runDialog:
	; --- if start button is hit ---
	LDA buttons
	AND #%00010000				; start button
	BNE +nextGameState

	LDA blockInputCounter
	BEQ +continue
	DEC blockInputCounter

+continue:
	; --- stream control ----
	LDA list1+6
	ASL
	BCS	+nextGameState
	ASL
	BCS +waitForConfirm
	ASL
	BCS +readStream
	LDA buttons
	BPL +readStream
	LDA blockInputCounter
	BNE +readStream

	LDA list1+6						; A pressed while not waiting
	ORA #$20							; speed mode (b5)
	STA list1+6

	LDA #$10
	STA blockInputCounter
	BNE +readStream

-done:
	RTS

+waitForConfirm:
	LDA blockInputCounter
	BNE -done
	JSR random
	LDA buttons
	BPL -done				; A button pressed

	LDA #$10
	STA blockInputCounter

	LDA #$00
	STA list1+6						; open stream again
	LDA #$0F							; replace blinking cursor
	JMP +pushChar

+nextGameState:
	LDA #$10
	STA blockInputCounter
	JMP pullState

+readStream:
	JSR getNextByte

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
	CMP #nextPage
	BNE +continue

	LDA list1+2				; reset write address to first position
	STA list1+0				;
	LDA list1+3				;
	STA list1+1				;

	LDA list1+8				; number of lines to clear
	STA list1+7				;

	LDA #$00
	STA list1+6				; make sure speed mode is off

	LDA #$0F				  ; game state : clear text box
	JMP pushState

+continue:
	; --- op code: wait for A button ---
	CMP #waitForA
	BNE +continue
	LDA #$40				; wait for A button (b6)
	STA list1+6
	LDA #$71				; blink cursor
	BNE +pushChar

+continue:
	; --- op code: move to next game state ---
	CMP #endOfStream
	BNE +continue
	LDA #$80				; (b7) move to next game state
	STA list1+6
	RTS

+continue:
	CMP #setPortrait
	BNE +continue

	JSR getNextByte
	BIT bit6
	BEQ +update
	AND #7
	TAX
	JSR getPilot
	JMP updatePortrait

+update:
	JMP updatePortrait2

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

	TAX
	LDA list1+6
	AND #$20
	BEQ +oneCharOnly			; if speed mod skip

	TXA
	LDX #$00
-loop
	STA list4, X
	INX
	JSR getNextByte
	CMP #$F0
	BCC -loop

	LDA bytePointer+0								; put last byte back in stream
	BNE +noDec
	DEC bytePointer+1

+noDec:
	DEC bytePointer+0

	DEX
-loop:
	LDA list4, X
	PHA
	INC list1+9
	DEX
	BPL -loop
	BMI +continue

+oneCharOnly:
	TXA
	PHA
	INC list1+9

+continue:
	LDA list1+1						; lo
	PHA
	LDA list1+0						; hi
	PHA
	LDA list1+9
	ASL
	PHA

	TSX										; switch stack pointers back
	STX	stackPointer2
	LDX stackPointer1
	TXS

	BIT list1+6				; unless the stream is paused
	BVS +continue
	LDA list1+1
	CLC
	ADC list1+9
	STA list1+1


+continue:

	LDA #$00
	STA list1+9						; reset # buffered chars
	RTS
