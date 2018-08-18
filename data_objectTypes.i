; --- unit type attribute tables ---
objectTypeL:
	.db #< objectType0 ; mech: SLINGSHOT
	.db #< objectType1 ; mech: GEIST
	.db #< objectType2 ; mech: SAI
	.db #< objectType3 ; mech: DEMON
	.db #< objectType4 ; obstacle: BUILDING
	.db #< objectType5 ; vtol: LEMUR

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
	.db 8							; 01 max hit point
	.db 4							; 02 structure threshold
	.db $42						; 03 movement attributes | move points
	.db 2							; 04 initiative
	.db %01010111			; 05 damage profile C/S/M/L
	.db 0 						; 06 not used
	.db 0							; 07 tile BG offset

objectType1:			 	; GEIST
	.hex 32 30 33 31 	; TORSO animation
	.hex 17 15 14 16 	; LEG animation
	.db 21					 	; 00 name: GEIST
	.db 6						 	; 01 max hit points
	.db 3							; 02 structure threshold
	.db $45						; 03 movement attributes | move points
	.db 5						 	; 04 initiative
	.db %00010000			; 05 damage
	.db 0 						; 06 not used
	.db 0							; 07 tile BG offset

objectType2:				; SAI
	.hex 1A 18 1B 19 	; TORSO animation
	.hex 17 15 14 16 	; LEG animation
	.db 43						; 00 mech name : SAI
	.db 9						; 01 max hit points
	.db 5							; 02 structure threshold
	.db 3							; 03 movement points
	.db 3							; 04 initiative
	.db %11010100			; 05 damage
	.db 0 						; 06 not used
	.db 0							; 07 tile BG offset

objectType3:				; DEMON
	.hex 12 10 13 11 	;
	.hex 17 15 14 16 	; LEG animation
	.db 26						; 00 mech name
	.db 8							; 01 max hit points
	.db 6							; 02 structure threshold
	.db 3							; 03 movement points
	.db 3							; 04 initiative
	.db %10101010			; 05 damage
	.db 0 						; 06 not used
	.db 0							; 07 tile BG offset

objectType4:				; OBSTACLE
	.hex 26 26 26 26	; obstacle sprite
	.hex 26 26 26 26	; obstacle sprite

	.db 0						  ; 00 object name
	.db 3						  ; 01 max hit points
	.db 0						  ; 02 melee
	.db 0						  ; 03 movement points
	.db 0			  			; 04 initiative
	.db 0							; 05 not used
	.db 0 						; 06 not used
	.db 13			  		; 07 tile BG ()

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
	.db 2						; 02 structure threshold
	.db 128+4			  ; 03 movement points + type
	.db 4					  ; 04 initiative
	.db %01010101		; 05 damage
	.db 0						; 06
	.db 13					; 07 tile BG offset
