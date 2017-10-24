; ------------------------------------------
; gamesState 08: end turn
;------------------------------------------
; 1) see if end-of-turn events are triggered
; 2) assign turn to next unit
; 			looks up the active object's index and tries to find the object with index+1
; 			if no such object exits it looks for index+2 etc
; 			when index+n is equal to the number of objects in memory, the index is reset to 0
; 3) see if start-of-turn events are triggered
;
;

state_endTurn:
	; ---------------------
	; end of turn event : mission accomplished if only 1 unit remains
	; ---------------------
	LDA objectCount
	CMP #$02
	BCS +continue

	; is the last unit standing hostile or friendly?
	LDA objectTypeAndNumber
	BMI +missionFailed

	JSR buildStateStack
	.db $14							; # items
	.db $20, 0
	.db $23 						; expand status bar
	.db $01, 9					; load stream 09: mission accomplished
	.db $0D, 0					; change brightness 0: fade out
	.db $00, 2					; load screen 02: mission screen
	.db $0D, 1					; change brightness 1: fade in
	.db $01, 2					; load stream 01: mission 2 brief
	.db $0D, 0					; change brightness 0: fade out
	.db $00, 3					; load screen 03: status bar
	.db $04							; load level
	.db $0D, 1					; change brightness 1: fade in
	; built in RTS

+missionFailed:
	JSR buildStateStack
	.db $14							; # items
	.db $20, 0
	.db $23 						; expand status bar
	.db $01, 12					; load stream 12: mission failed
	.db $0D, 0					; change brightness 0: fade out
	.db $00, 2					; load screen 02: mission screen
	.db $0D, 1					; change brightness 1: fade in
	.db $01, 3					; load stream 01: mission 3 brief
	.db $0D, 0					; change brightness 0: fade out
	.db $00, 3					; load screen 03: status bar
	.db $04							; load level
	.db $0D, 1					; change brightness 1: fade in
	; built in RTS

+continue:

	JMP pullState
