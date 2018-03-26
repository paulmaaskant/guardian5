; ------------------------------------------
; gameState 03: Title Screen Cycle
; ------------------------------------------
state_titleScreen:
	LDA buttons
	BNE +continue
	RTS

+continue:
	LSR										; RIGHT
	BCC +next
	LDA list8+3
	CMP #1
	BEQ +continue
	RTS

+continue:
	LDA list8+4
	CMP #31
	BCS +setTimer
	INC list8+4
	BNE +setTimer

+next:
	LSR										; LEFT
	BCC +next
	LDA list8+3
	CMP #1
	BEQ +continue
	RTS

+continue:
	DEC list8+4
	BPL +setTimer
	INC list8+4
	BEQ +setTimer

+next:
	LSR										; DOWN
	BCC +next
	LDA #$0F
	LDY list8+3
	STA list8, Y
	INY
	CPY #2
	BNE +setIndicator
	DEY
	BNE +setIndicator

+next:
	LSR										;UP
	BCC +next

	LDA #$0F
	LDY list8+3
	STA list8, Y
	DEY
	BPL +setIndicator
	INY

+setIndicator:
	LDA #$2F
	STA list8, Y
	STY list8+3

	LDY #sSimpleBlip
	JSR soundLoad
	JMP +setTimer

+next:
	LSR									; start button
	BCS +confirm
	LSR									; select button
	;BCS +animation
	LSR									; B
	LSR									; A button
	BCC +setTimer

+confirm:
	LDA list8+3
	BEQ +startGame			; if "start game" game + start

	JSR soundSilence

;	LDA list8+3
;	CMP #1
;	BEQ +instructions		; if "instructions" + start

	LDY list8+4
	JSR soundLoad

+setTimer:
	LDA #6
	STA blockInputCounter

	LDA list8+4
	JSR toBCD
	LDA par2
	STA list8+5
	LDA par3
	STA list8+6

	JSR buildStateStack
	.db 3
	.db $46, 9
	.db $1A

	;JMP writeStartMenuToBuffer

+startGame:
	JSR pullAndBuildStateStack
	.db 3									; # items
	.db $0D, 0						; change brightness 0: fade out
	.db $33								; initialize level
	; built in RTS



+instructions:
	JSR pullAndBuildStateStack
	.db 16								; # items
	.db $0D, 0						; change brightness 0: fade out
	.db $00, 4						; load screen 4: instruction screen
	.db $0D, 1						; change brightness 1: fade in
	.db $01, 11						; load stream 11: instructions
	.db $0D, 0						; change brightness 0: fade out
	.db $00, 0						; load screen 00: title screen
	.db $1E								; load title menu
	.db $0D, 1						; change brightness 1: fade in
	.db $03								; title screen (wait for user)
	; built in RTS

+animation:
	JSR pullAndBuildStateStack
	.db 17								; # items
	.db $0D, 0						; change brightness 0: fade out
	.db $00, 5						; load screen 5: animation screen
	.db $3A, 1					; switch CHR bank 1 to 1
	.db $0D, 1						; change brightness 1: fade in
	.db $21								; play animations
	.db $0D, 0						; change brightness 0: fade out
	.db $00, 0						; load screen 00: title screen
	.db $1E								; load title menu
	.db $0D, 1						; change brightness 1: fade in
	.db $03								; title screen (wait for user)
	; built in RTS
