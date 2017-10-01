; -------------------------------------------------
; game state 14: initialize cool down
; -------------------------------------------------
state_initializeCoolDown:

	LDA #$03						; clear from list3+3
	LDX #$09						; up to and including list3+9
	JSR clearList3

	JSR calculateHeat

	LDA #$00
	STA list1+0

	LDA activeObjectGridPos
	JSR gridPosToScreenPos

	JSR clearCurrentEffects

	LDA #$09
	STA currentEffects+0
	STA currentEffects+1

	LDA currentObjectXPos
	CLC
	ADC #$08
	STA currentEffects+6
	SEC
	SBC #$10
	STA currentEffects+7

	LDA currentObjectYPos
	STA currentEffects+12
	STA currentEffects+13

	LDA #%01000000
	STA currentEffects+25

	LDA #%01000010
	STA effects

	JSR pullAndBuildStateStack
	.db 2			; 2 items
	.db $15
	.db $16
	; built in RTS

; -------------------------------------------------
; game state 15: resolve cool down
; -------------------------------------------------
state_resolveCoolDown:
	; animation here
	LDA list1+0
	CMP #$80
	BNE +continue
	JMP pullState

+continue:
	INC list1+0

	RTS
