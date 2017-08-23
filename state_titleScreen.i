; ------------------------------------------
; gameState 03: Title Screen Cycle
; ------------------------------------------
state_titleScreen:
	LDA frameCounter
	AND #%00000111
	BNE +skipAnimation

	; --- update animated tiles every 8 frames ---
	TSX
	STX	stackPointer1
	LDX stackPointer2
	TXS
	LDY list1+0
	CPY #$03
	BCC +increment
	LDY #$FF

+increment:
	INY
	STY list1+0
	LDA faceTiles, Y
	PHA
	LDA faceTiles+4, Y
	PHA
	LDA #$0F
	PHA						; address low byte
	LDA #$25
	PHA						; address high byte
	LDA #$04
	PHA						; lenght * 2
	TSX						; switch stack pointers
	STX	stackPointer2
	LDX stackPointer1
	TXS

+skipAnimation:
	LDA blockInputCounter
	BEQ +continue
	DEC blockInputCounter
	RTS

+continue:
	LDA buttons
	BEQ +done

	LSR										; RIGHT
	BCC +next
	LDA list1+1
	CMP #$02
	BNE +done

	LDA list1+2
	CMP #$1F
	BCS +setTimer
	INC list1+2
	BNE +setTimer

+next:
	LSR										; LEFT
	BCC +next
	LDA list1+1
	CMP #$02
	BNE +done
	DEC list1+2
	BPL +setTimer
	INC list1+2
	BEQ +setTimer

+next:
	LSR										; DOWN
	BCC +next
	LDA #$0F
	LDY list1+1
	STA menuIndicator, Y
	INY
	CPY #$03
	BNE +setIndicator
	DEY
	BNE +setIndicator

+next:
	LSR										;UP
	BCC +next
	LDA #$0F
	LDY list1+1
	STA menuIndicator, Y
	DEY
	BPL +setIndicator
	INY

+setIndicator:
	LDA #$2F
	STA menuIndicator, Y
	STY list1+1
	LDY #sSimpleBlip
	JSR soundLoad
	JMP +setTimer

+next:
	LSR
	LSR
	LSR
	LSR
	BCC +setTimer				; A button

	LDA list1+1
	BEQ +startGame

	CMP #$02
	BNE +setTimer

	JSR soundSilence

	LDA frameCounter				; wait for next frame
-	CMP frameCounter
	BEQ -

	LDY list1+2
	JSR soundLoad

+setTimer:
	LDA #$08
	STA blockInputCounter

	JSR writeStartMenuToBuffer

+done:
	RTS

	; --- start button pressed ---
+startGame:
	LDA #$04								; load level map
	STA list1+1							; is the game state we want to get to
	LDA #< statusBar				; title screen byte stream hi
	STA list1+2
	LDA #> statusBar				; title screen byte stream lo
	STA list1+3
	LDA #$40								; fade control: fade out, but no fade in
	STA list1+4

	JSR soundSilence
	JMP initializeScreen		; tail chain

faceTiles:
	.db #$4B, #$57, #$67, #$49, #$78, #$4A, #$77, #$4A
