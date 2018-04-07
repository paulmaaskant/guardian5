stringListL:
	.db #< str_RANGED_ATK_1							; 00
	.db #< str_RANGED_ATK_2							; 01
	.db #< str_MOVE											; 02
	.db #< str_CHARGE										; 03
	.db #< str_COOL_DOWN								; 04
	.db #< str_LOS_BLOCKED							; 05
	.db #< str_OPENING_FIRE							; 06
	.db #< str_CLOSE_COMBAT							; 07
	.db #< str_OUT_OF_RANGE							; 08
	.db #< str_IMPASSABLE								; 09
	.db #< str_MOVING										; 10
	.db #< str_CHOOSE_FACING_DIRECTION	; 11
	.db #< str_TOO_CLOSE 								; 12
	.db #< str_COST											; 13
	.db #< str_TARGET										; 14
	.db #< str_DAMAGE										; 15
	.db #< str_ACTION_PTS								; 16
	.db #< str_CONFIRM									; 17
	.db #< str_RESTORE_AP								; 18
	.db #< str_PIVOT_TURN								; 19
	.db #< str_DAMG_ICONS								; 20
	.db #< str_UNKNOWN									; 21
	.db #< str_UNKNOWN									; 22
	.db #< str_UNKNOWN									; 23
	.db #< str_RUN											; 24
	.db #< str_CAPT_ORTEGA							; 25
	.db #< str_DEMON										; 26
	.db #< str_UNKNOWN									; 27
	.db #< str_TARGET_LOCK							; 28
	.db #< str_REAPER										; 29
	.db #< str_HAILFIRE									; 30
	.db #< str_RELOADING								; 31
	.db #< str_MELEE										; 32
	.db #< str_MISSILE									; 33
	.db #< str_LASER										; 34
	.db #< str_AUTO_GUN									; 35
	.db #< str_XX_USES_LEFT							; 36
	.db #< str_OUT_OF_AMMO							; 37
	.db #< str_ALREADY_LOCKD						; 38
	.db #< str_LEMUR										; 39
	.db #< str_BURKE										; 40
	.db #< str_ENEMY										; 41
	.db #< str_SPARK										; 42
	.db #< str_SAI											; 43
	.db #< str_SLINGSHOT								; 44
	.db #< str_SURGE										; 45

stringListH:
	.db #> str_RANGED_ATK_1
	.db #> str_RANGED_ATK_2
	.db #> str_MOVE
	.db #> str_CHARGE
	.db #> str_COOL_DOWN
	.db #> str_LOS_BLOCKED
	.db #> str_OPENING_FIRE
	.db #> str_CLOSE_COMBAT
	.db #> str_OUT_OF_RANGE
	.db #> str_IMPASSABLE
	.db #> str_MOVING
	.db #> str_CHOOSE_FACING_DIRECTION
	.db #> str_TOO_CLOSE
	.db #> str_COST
	.db #> str_TARGET
	.db #> str_DAMAGE
	.db #> str_ACTION_PTS
	.db #> str_CONFIRM
	.db #> str_RESTORE_AP
	.db #> str_PIVOT_TURN
	.db #> str_DAMG_ICONS
	.db #> str_UNKNOWN
	.db #> str_UNKNOWN
	.db #> str_UNKNOWN
	.db #> str_RUN
	.db #> str_CAPT_ORTEGA
	.db #> str_DEMON
	.db #> str_UNKNOWN
	.db #> str_TARGET_LOCK
	.db #> str_REAPER
	.db #> str_HAILFIRE
	.db #> str_RELOADING
	.db #> str_MELEE
	.db #> str_MISSILE
	.db #> str_LASER
	.db #> str_AUTO_GUN
	.db #> str_XX_USES_LEFT
	.db #> str_OUT_OF_AMMO
	.db #> str_ALREADY_LOCKD
	.db #> str_LEMUR
	.db #> str_BURKE
	.db #> str_ENEMY
	.db #> str_SPARK
	.db #> str_SAI
	.db #> str_SLINGSHOT
	.db #> str_SURGE

str_LOS_BLOCKED:
	.db 12, L, I, N, E, space, B, L, O, C, K, E, D
str_RANGED_ATK_1:
	.db 4, W, P, N, 1
str_RANGED_ATK_2:
	.db 4, W, P, N, 2
str_MOVE:
	.db 4, M, O, V, E
str_OPENING_FIRE:
	.db $0C, $1E, $1F, $14, $1D, $18, $1D, $16, $0F, $15, $18, $21, $14
str_COOL_DOWN:
	.db 8, E, N, D, space, T, U, R, N
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
str_TOO_CLOSE:
	.db 9, T, O, O, space, C, L, O, S, E
str_TARGET:
	.db 6, T, A, R, G, E, T
str_DAMAGE:
	.db 6, D, A, M, A, G, E
str_ACTION_PTS:
	.db 10, A, C, T, I, O, N, space, P, T, S
str_CONFIRM:
	.db 10, C, O, N, F, I, R, M, space, $71, A
str_PIVOT_TURN:
	.db 10, P, I, V, O, T, space, T, U, R, N
str_DAMG_ICONS:
	.db 12, D, A, M, G, space, $80+40, $80+41, $80+42, $80+43, $80+44, $80+45, $80+46
str_RUN:
	.db 3, R, U, N
str_COST:
	.db 4, C, O, S, T
str_RESTORE_AP:
	.db 10, R, E, S, T, O, R, E, space, $80+0, $3B
str_CAPT_ORTEGA:
	.db 6, O, R, T, E, G, A
str_DEMON:
	.db 5, D, E, M, O, N
str_UNKNOWN:
	.db 7, U, N, K, N, O, W, N
str_TARGET_LOCK:
	.db 11, T, A, R, G, E, T, space, L, O, C, K
str_REAPER:
	.db 6, R, E, A, P, E, R
str_HAILFIRE:
	.db 8, H, A, I, L, F, I, R, E
str_RELOADING:
	.db 9, R, E, L, O, A, D, I, N, G
str_MELEE:
	.db 5, M, E, L, E, E
str_MISSILE:
	.db 7, M, I, S, S, I, L, E
str_LASER:
	.db 5, L, A, S, E, R
str_AUTO_GUN:
	.db 8, A, U, T, O, space, G, U, N
str_XX_USES_LEFT:
	.db 12, $80+10, $80+11, space, U, S, E, S, space, L, E, F, T
str_OUT_OF_AMMO:
	.db 11, O, U, T, space, O, F, space, A, M, M, O
str_ALREADY_LOCKD
	.db 11, L, O, C, K, space, A, C, T, I, V, E
str_LEMUR:
	.db 5, L, E, M, U, R
str_BURKE:
	.db 5, B, U, R, K, E
str_ENEMY:
	.db 5, E, N, E, M, Y
str_SPARK:
	.db 5, S, P, A, R, K
str_SAI:
	.db 3, S, A, I
str_SLINGSHOT:
	.db 9, S, L, I, N, G, S, H, O, T
str_SURGE:
	.db 5, S, U, R, G, E
