; -------------------------------------------------
; game state 14: initialize cool down
; -------------------------------------------------
state_initializeCoolDown:

	LDA #$03						; clear from list3+3
	LDX #$09						; up to and including list3+9
	JSR clearList3

	JSR applyActionPointCost

	LDA #$00
	STA list1+0
	STA list1+2

	LDA activeObjectGridPos
	JSR gridPosToScreenPos
	JSR clearCurrentEffects

	LDX #4
	STX effects
	DEX

-loop:
	LDA #10
	STA currentEffects+0, X

	LDA currentObjectXPos
	STA currentEffects+6, X

	LDA currentObjectYPos
	CLC
	ADC #-14
	STA currentEffects+12, X

	DEX
	BPL -loop



	JSR pullAndBuildStateStack
	.db 2			; 2 items
	.db $15
	.db $35

	;.db $16
	; built in RTS

; -------------------------------------------------
; game state 15: resolve cool down
; -------------------------------------------------
state_resolveCoolDown:
	; animation here

	LDA activeObjectGridPos
	JSR gridPosToScreenPos

	LDA list1+0
	CMP #$40
	BNE +continue

	JSR clearCurrentEffects
	JMP pullState

+continue:
	CMP #$10
	BCC +expand
	CMP	#$30
	BCC +rotate
	CMP #$40
	BCC +collapse
	LDA #1
	STA effects
	BNE +done


+rotate:
	AND #%00011111
	ASL
	ASL
	STA list1+2
	JMP +startLoop

+collapse:
	AND #%00011111
	EOR #%00011111

+expand:
	STA list1+3

+startLoop:
	LDX #3

-loop:
	STX list1+1
	LDA state_15_angle_table, X
	CLC
	ADC list1+2
	LDX list1+3
	JSR getCircleCoordinates

	TXA
	LDX list1+1
	CLC
	ADC currentObjectXPos
	STA currentEffects+6, X

	TYA
	CLC
	ADC currentObjectYPos
	ADC #-14
	STA currentEffects+12, X

	DEX
	BPL -loop

+done:
	INC list1+0
	RTS


state_15_angle_table:
	.db 0, 64, 128, 194
