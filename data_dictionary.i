stringListL:
	.db #< str_EMPTY										; 00
	.db #< str_ATTACK										; 01
	.db #< str_MOVE											; 02
	.db #< str_CHARGE										; 03
	.db #< str_BRACE_FOR_IMPACT					; 04
	.db #< str_LOS_BLOCKED							; 05
	.db #< str_ATTACKING								; 06
	.db #< str_CLOSE_COMBAT							; 07
	.db #< str_OUT_OF_RANGE							; 08
	.db #< str_IMPASSABLE								; 09
	.db #< str_MOVING										; 10
	.db #< str_CHOOSE_FACING_DIRECTION	; 11
	.db #< str___JUMP_JETS 				  		; 12
	.db #< str_GAIN_X_EVADE							; 13
	.db #< str_TARGET										; 14
	.db #< str_DAMAGE										; 15
	.db #< str_REAR_ANGLE							  ; 16
	.db #< str_CONFIRM									; 17
	.db #< str_TARGET_BRACED						; 18
	.db #< str_PIVOT_TURN								; 19
	.db #< str_DAMG_ICONS								; 20
	.db #< str_GEIST										; 21
	.db #< str_MARU											; 22
	.db #< str_NIKOLI										; 23
	.db #< str_SPRINT										; 24
	.db #< str_CAPT_ORTEGA							; 25
	.db #< str_DEMON										; 26
	.db #< str_UNKNOWN									; 27
	.db #< str_TARGET_LOCK							; 28
	.db #< str_MACHINE_GUN							; 29
	.db #< str_LR_MISSILES							; 30
	.db #< str_PILOT										; 31
	.db #< str_UNIT											; 32
	.db #< str_MISSILE									; 33
	.db #< str_LASER										; 34
	.db #< str_PRESS_A_TO_EQUIP					; 35
	.db #< str_MECH											; 36
	.db #< str_SLOT_X										; 37
	.db #< str_ALREADY_LOCKD						; 38
	.db #< str_LEMUR										; 39
	.db #< str_BURKE										; 40
	.db #< str_ENEMY										; 41
	.db #< str_GIANT_BLADE							; 42
	.db #< str_SAI											; 43
	.db #< str_SLINGSHOT								; 44
	.db #< str_MEDIUM_LASER							; 45
	.db #< scr_UNIT_1										; 46
	.db #< scr_UNIT_2										; 47
	.db #< scr_UNIT_3										; 48
	.db #< scr_UNIT_4										; 49
	.db #< str_ACCUR										; 50
	.db #< str_ARMOR										; 51
	.db #< str_CASE											; 52
	.db #< str_RANGE										; 53
	.db #< str_HEAT											; 54
	.db #< str_FRIENDLY_UNIT						; 55
	.db #< str_JUMP											; 56
	.db #< str_SPEED_X									; 57
	.db #< str_BRAWLER									; 58
	.db #< str_CRACK_SHOT								; 59
	.db #< str_SURVIVOR									; 60
	.db #< str_LUCKY										; 61
	.db #< str_DARE_DEVIL								; 62
	.db #< str_SPRINTER									; 63

stringListH:
	.db #> str_EMPTY
	.db #> str_ATTACK
	.db #> str_MOVE
	.db #> str_CHARGE
	.db #> str_BRACE_FOR_IMPACT
	.db #> str_LOS_BLOCKED
	.db #> str_ATTACKING
	.db #> str_CLOSE_COMBAT
	.db #> str_OUT_OF_RANGE
	.db #> str_IMPASSABLE
	.db #> str_MOVING
	.db #> str_CHOOSE_FACING_DIRECTION
	.db #> str___JUMP_JETS
	.db #> str_GAIN_X_EVADE
	.db #> str_TARGET
	.db #> str_DAMAGE
	.db #> str_REAR_ANGLE
	.db #> str_CONFIRM
	.db #> str_TARGET_BRACED
	.db #> str_PIVOT_TURN
	.db #> str_DAMG_ICONS
	.db #> str_GEIST
	.db #> str_MARU
	.db #> str_NIKOLI
	.db #> str_SPRINT
	.db #> str_CAPT_ORTEGA
	.db #> str_DEMON
	.db #> str_UNKNOWN
	.db #> str_TARGET_LOCK
	.db #> str_MACHINE_GUN
	.db #> str_LR_MISSILES
	.db #> str_PILOT
	.db #> str_UNIT
	.db #> str_MISSILE
	.db #> str_LASER
	.db #> str_PRESS_A_TO_EQUIP
	.db #> str_MECH
	.db #> str_SLOT_X
	.db #> str_ALREADY_LOCKD
	.db #> str_LEMUR
	.db #> str_BURKE
	.db #> str_ENEMY
	.db #> str_GIANT_BLADE
	.db #> str_SAI
	.db #> str_SLINGSHOT
	.db #> str_MEDIUM_LASER
	.db #> scr_UNIT_1
	.db #> scr_UNIT_2
	.db #> scr_UNIT_3
	.db #> scr_UNIT_4
	.db #> str_ACCUR
	.db #> str_ARMOR										; 51
	.db #> str_CASE										; 52
	.db #> str_RANGE										; 53
	.db #> str_HEAT											; 54
	.db #> str_FRIENDLY_UNIT						; 55
	.db #> str_JUMP
	.db #> str_SPEED_X
	.db #> str_BRAWLER
	.db #> str_CRACK_SHOT
	.db #> str_SURVIVOR
	.db #> str_LUCKY
	.db #> str_DARE_DEVIL
	.db #> str_SPRINTER

str_EMPTY:
	.db 0
str_LOS_BLOCKED:
	.db 12, L, I, N, E, space, B, L, O, C, K, E, D
str_JUMP:
	.db 4, J, U, M , P
str_ATTACK:
	.db 9, A, T, T, A, C, K, space, $80+18, R
str_MOVE:
	.db 4, M, O, V, E
str_ATTACKING:
	.db 9, A, T, T, A, C, K, I, N, G
str_BRACE_FOR_IMPACT:
	.db 19, B, R, A, C, E, space, F, O, R, space, space, space, space, I, M, P, A, C, T
str_CHARGE:
	.db 6, C, H, A, R, G, E
str_CLOSE_COMBAT:
	.db 12, C, L, O, S, E, space, C, O, M, B, A, T
str_OUT_OF_RANGE:
	.db 12, O, U, T, dash, O, F, dash, R, A, N, G, E
str_IMPASSABLE:
	.db 10, I, M, P, A, S, S, A, B, L, E
str_MOVING:
	 db 9, space, space, space, M, O, V, I, N, G
str_CHOOSE_FACING_DIRECTION:
	.db 24, C, H, O, O, S, E, space, F, A, C, I, N, G, space, space, D, I, R, E, C, T, I, O, N
str___JUMP_JETS:
	.db 11, space, space, J, U, M, P, space, J, E, T, S
str_TARGET:
	.db 6, T, A, R, G, E, T
str_DAMAGE:
	.db 6, D, A, M, A, G, E
str_REAR_ANGLE:
	.db 10, R, E, A, R, space, A, N, G, L, E
str_CONFIRM:
	.db 10, C, O, N, F, I, R, M, space, $71, A
str_PIVOT_TURN:
	.db 10, P, I, V, O, T, space, T, U, R, N
str_DAMG_ICONS:
	.db 5, $80+2, space, D, M, G
str_GEIST:
	.db 5, G, E, I, S, T
str_MARU:
	.db 4, M, A, R, U
str_SPRINT:
	.db 6, S, P, R, I, N, T
str_GAIN_X_EVADE:
	.db 12, G, A, I, N, space, $80+14, space, E, V, A, D, E
str_TARGET_BRACED:
	.db 13, T, A, R, G, E, T, space, B, R, A, C, E, D
str_CAPT_ORTEGA:
	.db 6, O, R, T, E, G, A
str_DEMON:
	.db 5, D, E, M, O, N
str_UNKNOWN:
	.db 7, U, N, K, N, O, W, N
str_TARGET_LOCK:
	.db 11, M, A, R, K, space, T, A, R, G, E, T
str_MACHINE_GUN:
	.db 11, M, A, C, H, I, N, E, space, G, U, N
str_LR_MISSILES:
	.db 11, L, R, space, M, I, S, S, I, L, E, S
str_PILOT:
	.db 5, P, I, L, O, T
str_UNIT:
	.db 6, U,N,I,T, space, dash
str_MISSILE:
	.db 7, M, I, S, S, I, L, E
str_LASER:
	.db 5, L, A, S, E, R
str_PRESS_A_TO_EQUIP:
	.db 16, P,R,E,S,S,space,A,space,T,O,space,E,Q,U,I,P
str_MECH:
	.db 4, M, E, C, H
str_SLOT_X:
	.db 4, S, L, O, T
str_ALREADY_LOCKD
	.db 11, L, O, C, K, space, A, C, T, I, V, E
str_LEMUR:
	.db 5, L, E, M, U, R
str_BURKE:
	.db 5, B, U, R, K, E
str_ENEMY:
	.db 5, E, N, E, M, Y
str_GIANT_BLADE:
	.db 11, G,I,A,N,T,space,B,L,A,D,E
str_SAI:
	.db 3, S, A, I
str_SLINGSHOT:
	.db 9, S, L, I, N, G, S, H, O, T
str_MEDIUM_LASER:
	.db 12, M, E, D, I, U, M, space, L, A, S, E, R
str_NIKOLI:
	.db 6, N, I, K, O, L, I
str_ACCUR:
	.db 5, A, C, C, U, R
str_ARMOR:
	.db 5, A, R, M, O, R
str_CASE:
	.db 4, C,A,S,E
str_RANGE:
	.db 5, R, A, N, G, E
str_HEAT:
	.db 4, H, E, A, T
str_FRIENDLY_UNIT:
	.db 13,F,R,I,E,N,D,L,Y,space,U,N,I,T
str_SPEED_X:
	.db 7, S, P, E, E, D, space, $80+26
str_BRAWLER:
	.db 7, B, R, A, W, L, E, R
str_CRACK_SHOT:
	.db 10, C, R, A, C, K, space, S, H, O, T
str_SURVIVOR:
	.db 8, S, U, R, V, I, V, O, R
str_LUCKY:
	.db 5, L, U, C, K, Y
str_DARE_DEVIL
	.db 10, D, A, R, E, space, D, E, V, I, L
str_SPRINTER
	.db 8, S, P, R, I, N, T, E, R


scr_UNIT_1:
	.db 16
	.db $83, $81, $81, $80
	.db $83, $81, $81, $80
	.db $83, $81, $81, $80
	.db $2B, space, space, $2A
scr_UNIT_2:
	.db 12
	.db $93, $B0, $B0, $90
	.db $93, $B0, $B0, $90
	.db $93, $B0, $B0, $90
scr_UNIT_3:
	.db 12
	.db $93, $B0, $B0, $90
	.db $93, $B0, $B0, $90
	.db $93, $92, $91, $90
scr_UNIT_4:
	.db 16
	.db $A3, $82, $82, $A0
	.db $A3, $82, $82, $A0
	.db $A3, $A2, $A1, $A0
	.db $2D, space, space, $2C
