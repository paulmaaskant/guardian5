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
	BNE +continue
	RTS

+continue:
	LSR										; RIGHT
	BCC +next
	LDA list1+1
	CMP #$02
	BEQ +continue
	RTS

+continue:
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
	BEQ +continue
	RTS

+continue:
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
	LSR									; startGame
	BCS +confirm
	LSR
	LSR									; B
	LSR
	BCC +setTimer				; A button

+confirm:
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
	JMP writeStartMenuToBuffer

+startGame:

	; FIX pass along paramter for which brief
	; FIX pass along a paramte for which level

	JSR pullAndBuildStateStack
	.db $10							; # items
	.db $0D, 0					; change brightness 0: fade out
	.db $00, 2					; load screen 2: mission brief screen
	.db $0D, 1					; change brightness 1: fade in
	.db $01, 1					; load stream 01: mission 1 brief
	.db $0D, 0					; change brightness 0: fade out
	.db $00, 3					; load screen 3: status bar
	.db $04							; load level
	.db $0D, 1					; change brightness 1: fade in
	.db $08							; end / next turn
	; built in RTS

+done:
	RTS

faceTiles:
	.db $4B, $4C, $49, $5C, $4A, $78, $4A, $77
