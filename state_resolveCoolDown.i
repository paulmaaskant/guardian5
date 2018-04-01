; -------------------------------------------------
; game state 14: initialize cool down
; -------------------------------------------------
state_initializeCoolDown:

	LDA #$03									; clear from list3+3
	LDX #$09									; up to and including list3+9
	JSR clearList3

	JSR applyActionPointCost

	LDA #0
	STA list1+0 							; animation frame count
	STA list1+2								;
	STA activeObjectStats+9		; remove all remaining APs

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
	.db 3			; 3 items
	.db $15		; resolve cool down
	.db $35		; show modifier
	.db $16		; show result

	; built in RTS

; -------------------------------------------------
; game state 15: resolve cool down
; -------------------------------------------------
state_resolveCoolDown:
	; animation here

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
  ADC #-14
  STA currentEffects+12, X

	DEX
	BPL -loop

	INC list1+0
	RTS

state_15_radius:
	.db 0, 8, 16, 24

state_15_angle:
	.db 192, 160, 128, 96
