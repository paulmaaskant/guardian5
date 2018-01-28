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
	.db #< str_START_GAME								; 21
	.db #< str_PLAY_SOUND								; 22
	.db #< str_INSTRUCTIONS							; 23
	.db #< str_RUN											; 24
	.db #< str_CAPT_ORTEGA							; 25
	.db #< str_DEMON										; 26
	.db #< str_UNKNOWN									; 27

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
	.db #> str_START_GAME
	.db #> str_PLAY_SOUND
	.db #> str_INSTRUCTIONS
	.db #> str_RUN
	.db #> str_CAPT_ORTEGA
	.db #> str_DEMON
	.db #> str_UNKNOWN

str_LOS_BLOCKED:
	.db 20, L, I, N, E, dash, O, F, dash, S, I, G, H, T, B, L, O, C, K, E, D
str_RANGED_ATK_1:
	.db 12, $21, $10, $1D, $16, $14, $13, $0F, $10, $23, $1A, $0F, $10
str_RANGED_ATK_2:
	.db 12, $21, $10, $1D, $16, $14, $13, $0F, $10, $23, $1A, $0F, $11
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
	.db 10, D, A, M, G, space, $80+40, $80+41, $80+42, $80+43, $80+44
str_START_GAME:
	.db 10, S, T, A, R, T, space, G, A, M, E
str_PLAY_SOUND:
	.db 10, P, L , A, Y, space, S, O, U, N, D
str_INSTRUCTIONS:
	.db 12, I, N, S, T, R, U, C, T, I, O, N, S
str_RUN:
	.db 3, R, U, N
str_COST:
	.db 4, C, O, S, T
str_RESTORE_AP:
	.db 10, R, E, S, T, O, R, E, space, $80+0, $3B
str_CAPT_ORTEGA:
	.db 11, C, A, P, T, space, O, R, T, E, G, A
str_DEMON:
	.db 5, D, E, M, O, N
str_UNKNOWN:
	.db 7, U, N, K, N, O, W, N
