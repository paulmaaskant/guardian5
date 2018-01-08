
; --- unit type attribute tables ---
objectTypeL:
	.db #< tankType0
	.db #< tankType1
	.db #< tankType2
	.db #< tankType3

objectTypeH:
	.db #> tankType0
	.db #> tankType1
	.db #> tankType2
	.db #> tankType3

tankType0:
	.hex 26 26 26 26	; obstacle
	.hex 26 26 26 26	; obstacle
	.db #0						; 00 mech name
	.db #%11111110		; 01 max hit points / max heat points

tankType1:
	.db $1A 				; D1
	.db $18 				; D2 / D6
	.db $1B 				; D3 / D5
	.db $19 				; D4

	.db $1F 				; D1 (moving)
	.db $1D 				; D2 / D6 (moving)
	.db $1C 				; D3 / D5 (moving)
	.db $1E 				; D4 (moving)

	.db #0					; 00 mech name
	.db #%01010110	; 01 max hit points / max heat points
	.db #2					; 02 (temp) action points per turn
	.db #3					; 03 movement points
	.db #80					; 04 accuracy
	.db #5					; 05 defense (front)
	.db #5					; 06 defense (side)
	.db #0					; 07 defense (rear)
	.db #0					; 08 weapon 1 name
	.db #3 					; 09 weapon 1 damage
	.db $82					; 10 weapon 1 range (max|min)
	.db #0					; 11 weapon 2 name
	.db #5 					; 12 weapon 2 damage
	.db $83					; 13 weapon 2 range (max|min)

tankType2:
	.db $1A 				; D1
	.db $18 				; D2 / D6
	.db $1B 				; D3 / D5
	.db $19 				; D4

	.db $1F 				; D1 (moving)
	.db $1D 				; D2 / D6 (moving)
	.db $1C 				; D3 / D5 (moving)
	.db $1E 				; D4 (moving)

	.db #0					; 00 mech name
	.db #%01000110	; 01 max hit points / max heat points
	.db #1					; 02 (temp) action points per turn
	.db #3					; 03 movement points
	.db #70					; 04 accuracy
	.db #5					; 05 defense (front)
	.db #5					; 06 defense (side)
	.db #0					; 07 defense (rear)
	.db #0					; 08 weapon 1 name
	.db #3 					; 09 weapon 1 damage
	.db $82					; 10 weapon 1 range (max|min)
	.db #0					; 11 weapon 2 name
	.db #5 					; 12 weapon 2 damage
	.db $83					; 13 weapon 2 range (max|min)

tankType3:
	; animations (8 bytes)

	.db #$16 ; 1 animation: facing U, still
	.db #$12 ; 2 animation: facing RU/LU, still
	.db #$10 ; 3 animation: facing RD/LD, still
	.db #$14 ; 4 animation: facing D, still
	.db #$17 ; 1 animation: facing U, walking
	.db #$13 ; 2 animation: facing RU/LU, walking
	.db #$11 ; 3 animation: facing RD/LD, walking
	.db #$15 ; 4 animation: facing D, walking

	; fixed stats (3 bytes)
	.db #%01001110					; Dail starting positions: (b7-b3) main dial, (b2-b1) heat dial, and cool down (b0)
	.db #%01100101					; Ranged weapon 1 max range (b7-4), min range (b3-2) and type  (b1-0)
	.db #%01101011					; Ranged weapon 2 max range (b7-4), min range (b3-2) and type  (b1-0)
	; dail stats
	; 00000000 00000000
	; |||||||| ||||||||
	; |||||||| |||||+++ weapon 1 damage
	; |||||||| ||+++--- weapon 2 damage
	; |||||||| ++------ movement (add 2)
	; |||||+++--------- armor (add 15)
	; ||+++------------ accuracy (add 5)
	.db #%00100100, #%01101001, #%00000000		; 01; 0-4-4, 1-5-1
