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
	.db #< str_OUTSIDE_ARC							; 0A
	.db #< str_CHOOSE_FACING_DIRECTION	; 0B
	.db #< str_TARGET_TOO__CLOSE 				; 0C
	.db #< str_COST											; 0D
	.db #< str_TARGET										; 0E
	.db #< str_DAMAGE										; 0F
	.db #< str_ACTION_PTS								; 10
	.db #< str_FFW											; 11
	.db #< str_RUN											; 12 NOT USED
	.db #< str_PIVOT_TURN								; 13
	.db #< str_ATTK											; 14
	.db #< str_START_GAME								; 15
	.db #< str_PLAY_SOUND								; 16
	.db #< str_INSTRUCTIONS							; 17
	.db #< str_RUN											; 18

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
	.db #> str_OUTSIDE_ARC
	.db #> str_CHOOSE_FACING_DIRECTION
	.db #> str_TARGET_TOO__CLOSE
	.db #> str_COST 										; not used
	.db #> str_TARGET
	.db #> str_DAMAGE
	.db #> str_ACTION_PTS
	.db #> str_FFW
	.db #> str_RUN
	.db #> str_PIVOT_TURN
	.db #> str_ATTK
	.db #> str_START_GAME
	.db #> str_PLAY_SOUND
	.db #> str_INSTRUCTIONS
	.db #> str_RUN

str_LOS_BLOCKED:
	.db 20, L, I, N, E, dash, O, F, dash, S, I, G, H, T, B, L, O, C, K, E, D
str_RANGED_ATK_1:
	.db $0C, $21, $10, $1D, $16, $14, $13, $0F, $10, $23, $1A, $0F, $10
str_RANGED_ATK_2:
	.db $0C, $21, $10, $1D, $16, $14, $13, $0F, $10, $23, $1A, $0F, $11
str_MOVE:
	.db $04, $1C, $1E, $25, $14
str_OPENING_FIRE:
	.db $0C, $1E, $1F, $14, $1D, $18, $1D, $16, $0F, $15, $18, $21, $14
str_COOL_DOWN:
	.db 9, C, O, O, L, space, D, O, W, N
str_CHARGE:
	.db 6, C, H, A, R, G, E
str_CLOSE_COMBAT:
	.db 12, C, L, O, S, E, space, C, O, M, B, A, T
str_OUT_OF_RANGE:
	.db 12, O, U, T, dash, O, F, dash, R, A, N, G, E
str_IMPASSABLE:
	.db 10, I, M, P, A, S, S, A, B, L, E
str_OUTSIDE_ARC:
	 db 22, F, A, C, I, N, G, space, W, R, O, N, G, space, D, I, R, E, C, T, I, O, N
str_CHOOSE_FACING_DIRECTION:
	.db 24, C, H, O, O, S, E, space, F, A, C, I, N, G, space, space, D, I, R, E, C, T, I, O, N
str_TARGET_TOO__CLOSE:
	.db 18, T, A, R, G, E, T, space, T, O, O, space, space, space, C, L, O, S, E
str_TARGET:
	.db 6, T, A, R, G, E, T
str_DAMAGE:
	.db 6, D, A, M, A, G, E
str_ACTION_PTS:
	.db 10, A, C, T, I, O, N, space, P, T, S
str_FFW:
	.db 1, $2F
str_PIVOT_TURN:
	.db 10, P, I, V, O, T, space, T, U, R, N
str_ATTK:
	.db 7, A, T, T, K, space, $80+2, $3F
str_START_GAME:
	.db 10, S, T, A, R, T, space, G, A, M, E
str_PLAY_SOUND:
	.db 10, P, L , A, Y, space, S, O, U, N, D
str_INSTRUCTIONS:
	.db 12, I, N, S, T, R, U, C, T, I, O, N, S
str_RUN:
	.db 3, R, U, N
str_COST
	.db 10, C, O, S, T, space, $80+0, $3D, space, $80+21, $3C
