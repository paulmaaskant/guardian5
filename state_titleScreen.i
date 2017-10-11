; ------------------------------------------
; gameState 03: Title Screen Cycle
; ------------------------------------------
state_titleScreen:
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
	LSR									; start button
	BCS +confirm
	LSR									; select button
	BCS +animation
	LSR									; B
	LSR									; A button
	BCC +setTimer

+confirm:
	LDA list1+1
	BEQ +startGame			; if "start game" game + start

	JSR soundSilence

	LDA frameCounter				; wait for next frame
-	CMP frameCounter
	BEQ -

	LDA list1+1
	CMP #$01
	BEQ +instructions		; if "instructions" + start

	LDY list1+2
	JSR soundLoad

+setTimer:
	LDA #$08
	STA blockInputCounter
	JMP writeStartMenuToBuffer

+startGame:
	JSR pullAndBuildStateStack
	.db 16							; # items
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

+instructions:
JSR pullAndBuildStateStack
	.db 16							; # items
	.db $0D, 0					; change brightness 0: fade out
	.db $00, 4					; load screen 4: instruction screen
	.db $0D, 1					; change brightness 1: fade in
	.db $01, 11					; load stream 11: instructions
	.db $0D, 0					; change brightness 0: fade out
	.db $00, 0						; load screen 00: title screen
	.db $1E								; load title menu
	.db $0D, 1						; change brightness 1: fade in
	.db $03								; title screen (wait for user)
	; built in RTS

+animation:

JSR soundSilence
JSR pullAndBuildStateStack
	.db 15							; # items
	.db $0D, 0					; change brightness 0: fade out
	.db $00, 5					; load screen 5: animation screen
	.db $0D, 1					; change brightness 1: fade in

	.db $26							; play animations

	; unclean state variables cause corrupt

	.db $0D, 0						; change brightness 0: fade out
	.db $00, 0						; load screen 00: title screen
	.db $1E								; load title menu
	.db $0D, 1						; change brightness 1: fade in
	.db $03								; title screen (wait for user)
	; built in RTS
