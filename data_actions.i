; --- action attributes ----
; byte1: game state, byte2: dictionary
actionTable:
	.db $10, 2				; 00 MOVE
	.db $53, 56				; 01 JUMP
	.db $12, 1				; 02 ATTACK
	.db $14, 4				; 03 BRACE
	.db $17, 7				; 04 CLOSE COMBAT
	.db $1B, 3				; 05 CHARGE
	.db $19, 19				; 06 PIVOT TURN
	.db $10, 24				; 07 SPRINT
	.db $44, 28				; 08 MARK TARGET

; b7 show waypoints when confirming action?
; b6 check range?
; b5 check line of sight?
; b4 check charge distance?
; b3 calculate hit %?
; b2 check for reload, ammo and recycle?
; b1 piloting skill (1) OR accuracy (0)

actionPropertiesTable:
	.db %10000000			; 00 MOVE
	.db %00000000			; 01 JUMP
	.db %01101100			; 02 RANGED ATTACK
	.db %00000000			; 03 BRACE
	.db %01001010			; 04 CLOSE COMBAT
	.db %10011010			; 05 CHARGE
	.db %00000000			; 06 PIVOT TURN
	.db %10000000			; 07 SPRINT
	.db %00100000			; 08 MARK TARGET

actionPointCostTable:
	.db 1				      ; 00 MOVE
	.db 1  			      ; 01 JUMP
	.db 1+128    		  ; 02 ATTACK (uses all remaining AP)
	.db 1+128      	  ; 03 BRACE (uses all remaining AP)
	.db 1+128         ; 04 CLOSE COMBAT (uses all remaining AP)
	.db 2+128         ; 05 CHARGE
	.db 1             ; 06 PIVOT TURN
	.db 2             ; 07 SPRINT
	.db 1             ; 08 MARK TARGET

heatCostTable:
	.db 0            ; 00 MOVE
	.db 1             ; 01 JUMP
	.db 1             ; 02 ATTACK
	.db -2            ; 03 BRACE
	.db 0             ; 04 CLOSE COMBAT
	.db 0             ; 05 CHARGE
	.db 0            ; 06 PIVOT TURN
	.db 0            ; 07 RUN
	.db 0            ; 08 MARK TARGET
