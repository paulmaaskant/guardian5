; --- unit type attribute tables ---
objectTypeL:
	.db #< objectType0 ; mech: SLINGSHOT
	.db #< objectType1 ; mech: GEIST
	.db #< objectType2 ; mech: SAI
	.db #< objectType3 ; mech: DEMON
	.db #< objectType4 ; obstacle: BUILDING
	.db #< objectType5 ; drone: LEMUR

objectTypeH:
	.db #> objectType0
	.db #> objectType1
	.db #> objectType2
	.db #> objectType3
	.db #> objectType4
	.db #> objectType5

objectType0:				; SLINGSHOT
	.hex 1E 1C 1F 1D	; TORSO animation
	.hex 17 15 14 16 	; LEG animation
	.db 44						; 00 mech name : SLINGSHOT
	.db 7							; 01 max hit points
	.db 1							; 02 melee
	.db 2							; 03 movement points
	.db 0							; 04 tile BG offset
	.db 0							; 05 not used
	.db 0 						; 06 not used
	.db 0							; 07 not used

objectType1:			 	; GEIST
	.hex 32 30 33 31 	; TORSO animation
	.hex 17 15 14 16 	; LEG animation
	.db 21					 	; 00 name: GEIST
	.db 7						 	; 01 max hit points
	.db 1						 	; 02 melee
	.db 5						 	; 03 movement points
	.db 0						 	; 04 tile BG offset
	.db 0							; 05 not used
	.db 0 						; 06 not used
	.db 0							; 07 not used

objectType2:				; SAI
	.hex 1A 18 1B 19 	; TORSO animation
	.hex 17 15 14 16 	; LEG animation
	.db 43						; 00 mech name : SAI
	.db 9							; 01 max hit points
	.db 3							; 02 melee
	.db 3							; 03 movement points
	.db 0							; 04 tile BG offset
	.db 0							; 05 not used
	.db 0 						; 06 not used
	.db 0							; 07 not used

objectType3:				; DEMON
	.hex 12 10 13 11 	;
	.hex 17 15 14 16 	; LEG animation
	.db 26						; 00 mech name
	.db 9							; 01 max hit points
	.db 1							; 02 melee
	.db 3							; 03 movement points
	.db 0							; 04 tile BG offset
	.db 0							; 05 not used
	.db 0 						; 06 not used
	.db 0							; 07 not used

objectType4:				; OBSTACLE
	.hex 26 26 26 26	; obstacle sprite
	.hex 26 26 26 26	; obstacle sprite

	.db 0						  ; 00 object name
	.db 3						  ; 01 max hit points
	.db 0						  ; 02 melee
	.db 0						  ; 03 movement points
	.db 13+128			  ; 04 tile BG (+128 no direction map)
	.db 0							; 05 not used
	.db 0 						; 06 not used
	.db 0							; 07 not used

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
	.db 4+128			  ; 03 movement points + type
	.db 13					; 04 tile BG offset
	.db 0						; 05 defense (front)
	.db 0						; 06 defense (side)
	.db 0						; 07 defense (rear)
