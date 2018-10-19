; -------------------------------------------------
; game state 14: initialize cool down
; -------------------------------------------------
state_initializeBrace:
	JSR applyActionPointCost

	LDA #0
	STA list1+0 							; animation frame count
	STA list1+2								;
	; STA activeObjectStats+9		; managed in applyActionPointCost

	LDY activeObjectIndex
	LDA object+4, Y
	ORA #%10000000						; set BRACE flag
	STA object+4, Y

	LDA activeObjectGridPos
	STA cursorGridPos					; ensure that the EDVADE modifier appears above the active unit

	JSR gridPosToScreenPos
	JSR clearCurrentEffects

	LDX #4
	STX effects
	DEX

-loop:
	LDA #4
	STA currentEffects+0, X

	LDA currentObjectXPos
	STA currentEffects+6, X

	LDA currentObjectYPos
	STA currentEffects+12, X

	DEX
	BPL -loop

	JSR pullAndBuildStateStack
	.db 4					; 3 items
	.db $15				; resolve cool down
	.db $58, 2		; show modifier: active unit, heat
	.db $16				; show result

	; built in RTS
