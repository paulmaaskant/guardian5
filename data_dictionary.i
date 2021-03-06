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
	.db #< str_DAMG_ICONS								; 20 ??
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
	.db #< str_BATTLE_ANGEL							; 43
	.db #< str_SLINGSHOT								; 44
	.db #< str_MEDIUM_LASER							; 45
	.db #< str_APC											; 46
	.db #< str_ACTUATOR									; 47
	.db #< str_TURRET										; 48
	.db #< str_CONVOY										; 49
	.db #< str_THE											; 50
	.db #< str_EXTRA_ARMOR							; 51
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
	.db #< str_SPCL											; 64
	.db #< str_NAME											; 65
	.db #< str_TYPE											; 66
	.db #< str_ITEM											; 67
	.db #< str_FLAMER										; 68
	.db #< str_ROUND										; 69
	.db #< str_MISSION_ACCOMPLISHED			; 70
	.db #< str_BUILD										; 71
	.db #< str_COMMANDER								; 72
	.db #< str_MINUTES									; 73
	.db #< str_NONE								; 74

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
	.db #> str_BATTLE_ANGEL
	.db #> str_SLINGSHOT
	.db #> str_MEDIUM_LASER
	.db #> str_APC
	.db #> str_ACTUATOR
	.db #> str_TURRET
	.db #> str_CONVOY
	.db #> str_THE
	.db #> str_EXTRA_ARMOR
	.db #> str_CASE
	.db #> str_RANGE
	.db #> str_HEAT
	.db #> str_FRIENDLY_UNIT
	.db #> str_JUMP
	.db #> str_SPEED_X
	.db #> str_BRAWLER
	.db #> str_CRACK_SHOT
	.db #> str_SURVIVOR
	.db #> str_LUCKY
	.db #> str_DARE_DEVIL
	.db #> str_SPRINTER
	.db #> str_SPCL
	.db #> str_NAME
	.db #> str_TYPE
	.db #> str_ITEM
	.db #> str_FLAMER
	.db #> str_ROUND
	.db #> str_MISSION_ACCOMPLISHED
	.db #> str_BUILD
	.db #> str_COMMANDER
	.db #> str_MINUTES
	.db #> str_NONE

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
	.db 4, U,N,I,T
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
str_BATTLE_ANGEL:
	.db 12, B, A, T, T, L, E, space, A,N,G,E,L
str_SLINGSHOT:
	.db 9, S, L, I, N, G, S, H, O, T
str_MEDIUM_LASER:
	.db 12, M, E, D, I, U, M, space, L, A, S, E, R
str_NIKOLI:
	.db 6, N, I, K, O, L, I
str_THE:
	.db 3, T, H, E
str_EXTRA_ARMOR:
	.db 11, E, X, T, R, A, space, A, R, M, O, R
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
str_SPCL
	.db 4, S, P, C, L
str_NAME:
	.db 4, N, A, M, E
str_TYPE:
	.db 4, T, Y, P, E
str_ITEM:
	.db 4, I, T, E, M
str_FLAMER:
	.db 6, F, L, A, M, E, R
str_ROUND:
	.db 8, R, O, U, N, D, space, $80+50, $80+51
str_APC
	.db 3, A, P, C
str_ACTUATOR:
	.db 8, A, C, T, U, A, T, O, R
str_TURRET:
	.db 6, T, U, R, R, E, T
str_CONVOY:
	.db 6, C, O, N, V, O, Y
str_BUILD
	.db 5, B, U, I, L, D
str_COMMANDER
	db 9, C, O, M, M, A, N, D, E, R
str_MISSION_ACCOMPLISHED
	db 20, M, I, S, S, I, O, N, space, A, C, C, O, M, P, L, I, S, H, E, D
str_MINUTES
	db 7, M, I, N, U, T, E, S
str_NONE
	db 4, N, O, N, E
