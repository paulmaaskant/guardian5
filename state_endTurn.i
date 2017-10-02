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

	LDA activeObjectTypeAndNumber
	AND #$07
	STA locVar1
	INC locVar1
	LDX #$00

-loop:
	LDA objectTypeAndNumber, X
	AND #$07
	CMP locVar1
	BEQ +setNext

	INX
	CPX objectCount
	BNE -loop

	LDX #$00								; increase index and try again
	INC locVar1
	LDA locVar1
	CMP #$06								; cycle between 0 and 5
	BNE -loop
	STX locVar1							; reset index to 0
	BEQ -loop								; JMP

+setNext:
	LDA objectTypeAndNumber, X
	STA	activeObjectTypeAndNumber
	CMP #$80
	PHP

	; --- retrieve object data ---
	AND #$07
	ASL
	ASL
	STA activeObjectIndex
	TAY
	LDA object+3, Y
	STA activeObjectGridPos

	LDA object+0, Y
	ASL
	PLP
	ROR
	LDY #$40
	JSR showPilot

	; --- retrieve type data ---
	LDA activeObjectTypeAndNumber
	JSR getStatsAddress
	STA activeObjectStats+6
	LDA (pointer1), Y				; attack & defence
	STA activeObjectStats+5
	INY								; damage & movement
	LDA (pointer1), Y
	PHA
	AND #$07
	STA activeObjectStats+3			; weapon damage 1
	PLA						; 3c, 1b
	LSR						; 6c, 3b
	LSR
	LSR
	PHA						; 3c, 1b
	AND #$07
	STA activeObjectStats+4			; weapon damage 2
	PLA
	LSR
	LSR
	LSR
	CLC
	ADC #$02
	STA activeObjectStats+2			; movement

	LDY #$01
	LDA (pointer1), Y				; wpn range 1
	STA activeObjectStats+0
	INY
	LDA (pointer1), Y
	STA activeObjectStats+1			; wpn range 2

	LDA #$C0									; switch on cursor and active marker
	STA effects

	LDA activeObjectGridPos
	STA cursorGridPos

	LDA #$00
	STA targetObjectTypeAndNumber

	LDA #$0F ;
	STA menuIndicator+0
	STA menuIndicator+1

	LDA events
	ORA event_refreshStatusBar
	STA events

	JSR clearSystemMenu
	JSR clearActionMenu
	JSR clearTargetMenu

	LDY activeObjectIndex
	LDA object+0, Y
	BMI +shutDown

	JSR buildStateStack
	.db $02							; 2 states
	.db $0B 						; center camera
	.db $06							; wait for user action
	; built in RTS

+shutDown:
	JSR buildStateStack
	.db $03							; 3 states
	.db $0B 						; center camera
	.db $1F							; handle shut down
	.db $16							; show results
	; built in RTS
