; --- action attributes ----
; byte1: game state, byte2: dictionary
actionTable:
	.db $10, 2				; 00 MOVE
	.db $12, 0				; 01 RANGED ATK 1
	.db $12, 1				; 02 RANGED ATK 2
	.db $14, 4				; 03 BRACE
	.db $17, 7				; 04 CLOSE COMBAT
	.db $1B, 3				; 05 CHARGE
	.db $19, 19				; 06 PIVOT TURN
	.db $10, 24				; 07 RUN
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
	.db %01101100			; 01 RANGED ATK 1
	.db %01101100			; 02 RANGED ATK 2
	.db %00000000			; 03 BRACE
	.db %01001010			; 04 CLOSE COMBAT
	.db %10011010			; 05 CHARGE
	.db %00000000			; 06 PIVOT TURN
	.db %10000000			; 07 RUN
	.db %00100000			; 08 MARK TARGET

actionPointCostTable:
	.db 1				      ; 00 MOVE
	.db 1  			      ; 01 RANGED ATK 1
	.db 1    		      ; 02 RANGED ATK 2
	.db 0      	      ; 03 BRACE
	.db 1             ; 04 CLOSE COMBAT                                                          ; 04 CLOSE COMBAT
	.db 2             ; 05 CHARGE                                                          ; 05 CHARGE
	.db 1             ; 06 PIVOT TURN                                                          ; 06 PIVOT TURN
	.db 2             ; 07 RUN
	.db 1             ; 08 MARK TARGET

heatCostTable:
	.db -1            ; 00 MOVE				                                                                ; 00 MOVE
	.db 0             ; 01 RANGED ATK 1  			                                                                ; 01 RANGED ATK 1
	.db 0             ; 02 RANGED ATK 2    		                                                                ; 02 RANGED ATK 2
	.db -1            ; 03 BRACE      	                                                                ; 03 COOL DOWN
	.db 0             ; 04 CLOSE COMBAT                                                                       ; 04 CLOSE COMBAT
	.db 0             ; 05 CHARGE                                                                       ; 05 CHARGE
	.db -1            ; 06 PIVOT TURN                                                                       ; 06 PIVOT TURN
	.db -2            ; 07 RUN
	.db -1            ; 08 MARK TARGET
