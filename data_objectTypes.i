; --- unit type attribute tables ---
objectTypeL:
	.db #< objectType0 ; mech: SLINGSHOT
	.db #< objectType1 ; mech: GEIST
	.db #< objectType2 ; mech: BATTLE ANGEL
	.db #< objectType3 ; mech: DEMON
	.db #< objectType4 ; building: BUILD
	.db #< objectType5 ; vtol: LEMUR
	.db #< objectType6 ; vtol: APC
	.db #< objectType7 ; building: TURRET
	.db #< objectType8 ; mech: GRUNT

objectTypeH:
	.db #> objectType0
	.db #> objectType1
	.db #> objectType2
	.db #> objectType3
	.db #> objectType4
	.db #> objectType5
	.db #> objectType6
	.db #> objectType7
	.db #> objectType8

objectType0:				; SLINGSHOT
	.hex 1E 1C 1F 1D	; TORSO animation
	.hex 17 15 14 16 	; LEG animation
	.db 44						; 00 mech name : SLINGSHOT
	.db 12						; 01 max hit point
	.db 6							; 02 structure threshold
	.db 2						  ; 03 type settings | movement points
	.db 2*16 + 2			; 04 icon | initiative
	.db %01010110			; 05 damage profile C/S/M/L
	.db 0 						; 06 special action: none
	.db 0							; 07 tile BG offset

objectType1:			 	; GEIST
	.hex 32 30 33 31 	; TORSO animation
	.hex 17 15 14 16 	; LEG animation
	.db 21					 	; 00 name: GEIST
	.db 9						 	; 01 max hit points
	.db 4							; 02 structure threshold
	.db 5						  ; 03 type settings | movement points
	.db 3*16 + 5			; 04 target icon + initiative
	.db %01010101			; 05 damage profile C/S/M/L
	.db 8							; 06 special actions MARK
	.db 0							; 07 tile BG offset

objectType2:				; BATTLE ANGEL
	.hex 1A 18 1B 19 	; TORSO animation
	.hex 17 15 14 16 	; LEG animation
	.db 43						; 00 mech name : SAI
	.db 14						; 01 max hit points
	.db 2							; 02 structure threshold
	.db 3							; 03 type settings | movement points
	.db 2*16+3			  ; 04 icon | initiative
	.db %11010101			; 05 damage
	.db 1  						; 06 special action JUMP
	.db 0							; 07 tile BG offset

objectType3:				; DEMON
	.hex 12 10 13 11 	;
	.hex 17 15 14 16 	; LEG animation
	.db 26						; 00 mech name
	.db 12						; 01 max hit points
	.db 5							; 02 hp structure threshold
	.db 3							; 03 type settings | movement points
	.db 2*16+3			  ; 04 icon | initiative
	.db %10101010			; 05 damage
	.db 0 						; 06 not used
	.db 0							; 07 tile BG offset

objectType4:				; OBSTACLE
	.hex 26 26 26 26	; obstacle sprite
	.hex 26 26 26 26	; obstacle sprite
										; -----
	.db 0						  ; 00 object name
	.db 3						  ; 01 max hit points
	.db 0						  ; 02 melee
	.db 0						  ; 03 type settings | movement points
	.db 1*16+0			  ; 04 icon | initiative
	.db 0							; 05 not used
	.db 0 						; 06 not used
	.db 13			  		; 07 tile BG

objectType5:			; hover: LEMUR
	.hex 28 2A 29 27	; lemur
	.hex 09 09 09 09	; shadow
										; ------
	.db 39						; 00 drone name: LEMUR
	.db 3							; 01 max hit points
	.db 3							; 02 hit point structure threshold
	.db 128+4			  	; 03 type settings | movement points
	.db 4*16+4				; 04 icon | initiative
	.db %01010101			; 05 damage
	.db 0							; 06 special action: none
	.db 13						; 07 tile BG offset

objectType6:				; hover: CONVOY
	.hex 39 3C 3B 3A	; apc
	.hex 09 09 09 09	; shadow
										; ------
	.db 46						; 00 name: APC
	.db 1							; 01 max hit points
	.db 0							; 02 hp structure threshold
	.db 128+3					; 03 type + movement points
	.db 5*16+5			  ; 04 icon | initiative
	.db %00010000			; 05 damage
	.db 0 						; 06 special action: none
	.db 13						; 07 tile BG offset

objectType7:				; building: turret
	.hex 3D 40 3F 3E	; turretn sprites
	.hex 00 00 00 00	; n/a
										; ------
	.db 46						; 00 name: Turret
	.db 8							; 01 max hit points
	.db 0							; 02 hp structure threshold
	.db typeNoHeat+0	; 03 movement points + type
	.db 6*16 + 1			; 04 icon | initiative
	.db %10101010			; 05 damage
	.db 0 						; 06 special action: none
	.db 21						; 07 tile BG offset

objectType8:				; mech:
	.hex 3D 40 3F 3E	; turret sprites
	.hex 17 15 14 16 	; LEG animation
										; ------
	.db 46						; 00 name: Turret
	.db 8							; 01 max hit points
	.db 0							; 02 hp structure threshold
	.db 3							; 03 movement points + type
	.db 3*16 + 5			; 04 icon | initiative
	.db %10101010			; 05 damage
	.db 0 						; 06 special action: none
	.db 0						  ; 07 tile BG offset
