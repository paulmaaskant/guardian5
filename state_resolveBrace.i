; -------------------------------------------------
; game state 15: resolve Brace
; -------------------------------------------------
state_resolveBrace:
	LDA activeObjectGridPos
	JSR gridPosToScreenPos

	LDA list1+0
	CMP #88
	BNE +continue

	JSR clearCurrentEffects				; done
	JMP pullState

+continue:
	LDX #1
	CMP #8
	BCC +one
	CMP #16
	BCC +two
	CMP #24
	BCC +three
	INX
+three:
	INX
+two:
	INX
+one:
	STX effects
	DEX
-loop:
	STX list1+1

	LDA list1+0
	AND #%11111000
	ASL
	ASL
	CLC
	ADC state_15_angle, X
	PHA
	LDA list1+0
	AND #$07
	CLC
	ADC state_15_radius, X
	TAX
	PLA
	JSR getCircleCoordinates

	TXA
	LDX list1+1
  CLC
  ADC currentObjectXPos
  STA currentEffects+6, X

	TYA
  CLC
  ADC currentObjectYPos
  STA currentEffects+12, X

	DEX
	BPL -loop

	INC list1+0
	RTS

state_15_radius:
	.db 0, 8, 16, 24

state_15_angle:
	.db 192, 160, 128, 96
