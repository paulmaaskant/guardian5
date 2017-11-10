; ------------------------------------------
; gamesState 08: end turn
;------------------------------------------
; see if end-of-turn events are triggered
;

state_endTurn:
	; ---------------------
	; end of turn event : mission accomplished if only friendly units remain
	; ---------------------
	LDX objectCount
	LDA #00

-loop:
	ORA objectTypeAndNumber-1, X
	DEX
	BNE -loop
	ASL
	BCC +missionAccomplished

	; ---------------------
	; end of turn event : mission failed if only hostile units remain
	; ---------------------
	LDX objectCount
	LDA #$80

-loop:
	AND objectTypeAndNumber-1, X
	DEX
	BNE -loop
	ASL
	BCS +missionFailed

	JMP pullState

+missionAccomplished:
	JSR buildStateStack
	.db $15							; # items
	.db $20, 0
	.db $23 						; expand status bar
	.db $01, 9					; load stream 09: mission accomplished
	.db $0D, 0					; change brightness 0: fade out
	.db $00, 6					; load screen 02: mission screen
	.db $0D, 1					; change brightness 1: fade in
	.db $01, 2					; load stream 01: mission 2 brief
	.db $0D, 0					; change brightness 0: fade out
	.db $00, 0						; load screen 00: title screen
	.db $1E								; load title menu
	.db $0D, 1						; change brightness 1: fade in
	.db $03								; title screen (wait for user)
	; built in RTS

+missionFailed:
	JSR buildStateStack
	.db $15							; # items
	.db $20, 0
	.db $23 						; expand status bar
	.db $01, 12					; load stream 12: mission failed
	.db $0D, 0					; change brightness 0: fade out
	.db $00, 2					; load screen 02: mission screen
	.db $0D, 1					; change brightness 1: fade in
	.db $01, 3					; load stream 01: mission 3 brief
	.db $0D, 0					; change brightness 0: fade out
	.db $00, 0						; load screen 00: title screen
	.db $1E								; load title menu
	.db $0D, 1						; change brightness 1: fade in
	.db $03								; title screen (wait for user)
	; built in RTS
