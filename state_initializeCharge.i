state_initializeCharge:
	DEC list1										; remove the final node from the path (= defending unit position)

	JSR calculateAttack					; includes a call to applyActionPointCost

  LDA #0
  STA effects

	JSR pullAndBuildStateStack
	.db 8								; 9 items
	.db $3A, 1					; switch CHR bank 1 to 1
	.db $3B 						; move animation loop
	.db $1C							; turn to face target
	.db $1D							; close combat animation
	.db $3A, 0					; switch CHR bank 1 back to 0
	.db $16							; show results
	; built in RTS
