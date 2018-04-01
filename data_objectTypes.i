; --- unit type attribute tables ---
objectTypeL:
	.db #< objectType0 ; mech: SLINGSHOT
	.db #< objectType1 ; mech: unnamed
	.db #< objectType2 ; mech: SAI
	.db #< objectType3 ; mech: DEMON
	.db #< objectType4 ; obstacle: BUILDING
	.db #< objectType5 ; drone: LEMUR

objectTypeH:
	.db #> objectType0
	.db #> objectType1
	.db #> objectType2
	.db #> objectType3
	.db #> objectType2
	.db #> objectType3

objectType0:			; SLINGSHOT
	.db $1E 				; D1
	.db $1C 				; D2 / D6
	.db $1F 				; D3 / D5
	.db $1D 				; D4
	.db $17 				; D1 (moving)
	.db $15 				; D2 / D6 (moving)
	.db $14 				; D3 / D5 (moving)
	.db $16 				; D4 (moving)
									; ------
	.db 44					; 00 mech name : SLINGSHOT
	.db 7						; 01 max hit points
	.db 1						; 02 melee
	.db 2						; 03 movement points
	.db 0						; 04 tile BG
	.db 15					; 05 defense (front)
	.db 15					; 06 defense (side)
	.db 0						; 07 defense (rear)

objectType1:			; UNKNOWN
	.db $1A 				; D1
	.db $18 				; D2 / D6
	.db $1B 				; D3 / D5
	.db $19 				; D4
	.db $17 				; D1 (moving)
	.db $15 				; D2 / D6 (moving)
	.db $14 				; D3 / D5 (moving)
	.db $16 				; D4 (moving)
									; ------
	.db 27					; 00 mech name : SAI
	.db 7						; 01 max hit points
	.db 2						; 02 melee
	.db 3						; 03 movement points
	.db 0						; 04 tile BG
	.db 15					; 05 defense (front)
	.db 0						; 06 defense (side)
	.db 0						; 07 defense (rear)

objectType2:			; SAI
	.db $1A 				; D1
	.db $18 				; D2 / D6
	.db $1B 				; D3 / D5
	.db $19 				; D4
	.db $17 				; D1 (moving)
	.db $15 				; D2 / D6 (moving)
	.db $14 				; D3 / D5 (moving)
	.db $16 				; D4 (moving)
									; ------
	.db 43					; 00 mech name : SAI
	.db 7						; 01 max hit points
	.db 2						; 02 melee
	.db 3						; 03 movement points
	.db 0						; 04 tile BG
	.db 15					; 05 defense (front)
	.db 0						; 06 defense (side)
	.db 0						; 07 defense (rear)

objectType3:			; DEMON
	.db $12 				; D1
	.db $10 				; D2 / D6
	.db $13 				; D3 / D5
	.db $11 				; D4
	.db $17 				; D1 (moving)
	.db $15 				; D2 / D6 (moving)
	.db $14 				; D3 / D5 (moving)
	.db $16 				; D4 (moving)
									; -------
	.db 26					; 00 mech name
	.db 9						; 01 max hit points
	.db 1						; 02 melee
	.db 3						; 03 movement points
	.db 0						; 04 tile BG
	.db 10					; 05 defense (front)
	.db 5						; 06 defense (side)
	.db 0						; 07 defense (rear)

objectType4:				; OBSTACLE
	.hex 26 26 26 26	; obstacle sprite
	.hex 26 26 26 26	; obstacle sprite

	.db 0						; 00 object name
	.db 3						; 01 max hit points
	.db 0						; 02 melee
	.db 0						; 03 movement points
	.db 13					; 04 tile BG
	.db 0						; 05 defense (front)
	.db 0						; 06 defense (side)
	.db 0						; 07 defense (rear)

objectType5:			; drone: LEMUR
	.db $28 				;
	.db $2A 				;
	.db $29 				;
	.db $27 				;
	.db $09 				; shadow
	.db $09 				; shadow
	.db $09 				; shadow
	.db $09 				; shadow
									; ------
	.db 39					; 00 drone name: LEMUR
	.db 4						; 01 max hit points
	.db 0						; 02 melee
	.db 4						; 03 movement points
	.db 14					; 04 tile BG SHADOW
	.db 0						; 05 defense (front)
	.db 0						; 06 defense (side)
	.db 0						; 07 defense (rear)
