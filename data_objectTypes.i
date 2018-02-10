
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

objectType0:
	.hex 26 26 26 26	; obstacle sprite
	.hex 26 26 26 26	; obstacle sprite
	.db 0							; 00 object name
	.db %11111110			; 01 max hit points / max heat points
	.db 0, 0, 0, 0, 0, 0	; dummy values for defense, acc & movement

objectType1:
	.db $1A 				; D1
	.db $18 				; D2 / D6
	.db $1B 				; D3 / D5
	.db $19 				; D4
	.db $1F 				; D1 (moving)
	.db $1D 				; D2 / D6 (moving)
	.db $1C 				; D3 / D5 (moving)
	.db $1E 				; D4 (moving)

	.db 26					; 00 mech name
	.db %10100110	; 01 max hit points / max heat points
	.db 2					; 02 action points per turn PILOT??
	.db 3					; 03 movement points
	.db 80				; 04 base accuracy PILOT??
	.db 5					; 05 defense (front)
	.db 5					; 06 defense (side)
	.db 0					; 07 defense (rear)
	.db 0					; 08 weapon 1 name
	.db 3 				; 09 weapon 1 damage
	.db $82				; 10 weapon 1 range (max|min)
	.db 0					; 11 weapon 2 name
	.db 5 				; 12 weapon 2 damage
	.db $83				; 13 weapon 2 range (max|min)

objectType2:
	.db $1A 				; D1
	.db $18 				; D2 / D6
	.db $1B 				; D3 / D5
	.db $19 				; D4
	.db $1F 				; D1 (moving)
	.db $1D 				; D2 / D6 (moving)
	.db $1C 				; D3 / D5 (moving)
	.db $1E 				; D4 (moving)

	.db #27					; 00 mech name
	.db #%01000110	; 01 max hit points / max heat points
	.db #1					; 02 (temp) action points per turn
	.db #3					; 03 movement points
	.db #70					; 04 accuracy
	.db #10					; 05 defense (front)
	.db #5					; 06 defense (side)
	.db #0					; 07 defense (rear)
	.db #0					; 08 weapon 1 name
	.db #3 					; 09 weapon 1 damage
	.db $82					; 10 weapon 1 range (max|min)
	.db #0					; 11 weapon 2 name
	.db #5 					; 12 weapon 2 damage
	.db $83					; 13 weapon 2 range (max|min)

objectType3:
	; animations (8 bytes)
	.db #$16 ; 1 animation: facing U, still
	.db #$12 ; 2 animation: facing RU/LU, still
	.db #$10 ; 3 animation: facing RD/LD, still
	.db #$14 ; 4 animation: facing D, still
	.db #$17 ; 1 animation: facing U, walking
	.db #$13 ; 2 animation: facing RU/LU, walking
	.db #$11 ; 3 animation: facing RD/LD, walking
	.db #$15 ; 4 animation: facing D, walking
