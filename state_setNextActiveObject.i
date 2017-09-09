; ------------------------------------------
; gamesState 08: Selects the object that is up next
;------------------------------------------
; looks up the active object's index and tries to find the object with index+1
; if no such object exits it looks for index+2 etc
; when index+n is equal to the number of objects in memory, the index is reset to 0
state_setNextActiveObject:
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
	BNE -loop:
	LDX #$00								; increase index and try again
	INC locVar1
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

	LDA #$0B									; center camera
	STA gameState

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
	JMP clearTargetMenu
	;				; tail chain
