; --- unit type attribute tables ---
objectTypeL:
	.db #< objectType0
	.db #< objectType1
	.db #< objectType2
	.db #< objectType3

objectTypeH:
	.db #> objectType0
	.db #> objectType1
	.db #> objectType2
	.db #> objectType3

objectType0:				; OBSTACLE
	.hex 26 26 26 26	; obstacle sprite
	.hex 26 26 26 26	; obstacle sprite
	.db 0							; 00 object name
	.db %11111110			; 01 max hit points / max heat points
	.db 0, 0, 0, 0, 0, 0	; dummy values for defense, acc & movement

objectType1:			; DEMON
	.db $1A 				; D1
	.db $18 				; D2 / D6
	.db $1B 				; D3 / D5
	.db $19 				; D4
	.db $1F 				; D1 (moving)
	.db $1D 				; D2 / D6 (moving)
	.db $1C 				; D3 / D5 (moving)
	.db $1E 				; D4 (moving)
									; ------
	.db 26					; 00 mech name : demon
	.db 16					; 01 max hit points
	.db 2						; 02 melee
	.db 3						; 03 movement points
	.db 4						; 04 initiative
	.db 5						; 05 defense (front)
	.db 5						; 06 defense (side)
	.db 0						; 07 defense (rear)

objectType2:			; UNKNOWN
	.db $1A 				; D1
	.db $18 				; D2 / D6
	.db $1B 				; D3 / D5
	.db $19 				; D4
	.db $1F 				; D1 (moving)
	.db $1D 				; D2 / D6 (moving)
	.db $1C 				; D3 / D5 (moving)
	.db $1E 				; D4 (moving)
									; -------
	.db 27					; 00 mech name
	.db 18					; 01 max hit points
	.db 1						; 02 melee
	.db 3						; 03 movement points
	.db 4						; 04 initiative
	.db 10					; 05 defense (front)
	.db 5						; 06 defense (side)
	.db 0						; 07 defense (rear)

objectType3:			; UNKNOWN
	.db $16 				;
	.db $12 				;
	.db $10 				;
	.db $14 				;
	.db $17 				;
	.db $13 				;
	.db $11 				;
	.db $15 				;
