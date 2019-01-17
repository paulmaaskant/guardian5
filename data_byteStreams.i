
; --- byte stream to load status bar ( in reverse )	---
hud:
statusBar:
	.db repeatBlank, 35 	; 2 rows + 3 blank tiles
	.db $2B, repeatBlank, 2, $2A, space
	.db $2B, repeatBlank, 13, $2A
	.db repeatBlank, 4
	.db $2B, repeatBlank, 2, $2A
	.db repeatBlank, 68
	.db $2D, repeatBlank, 2, $2C, space
	.db repeatBlank, 19
	.db $2D, repeatBlank, 2, $2C
	.db repeatBlank, 8, $0A, $2D, repeatBlank, 13, $2C, repeatBlank, 9

	; keep first 6 rows separate

	.db repeatBlank, $41	; 7 rows
	.db repeatBlank, $00	; 8 blank rows
	.db repeatBlank, $00  ; 8 blank rows

	; offset is 1 blank
	.db repeatBlank, 25, $2B, repeatBlank, 3, $2A
	.db repeatBlank, 26
	.db repeatBlank, 32+1
	.db $40
	.db $41
	.db repeatBlank, 3+27

	.db $2D, repeatBlank, 3, $2C
	.db repeatBlank, 1+32+1+18+7 ;

	;.db $0A, A, H, C, E, M, space

	.db $2B, repeatBlank, 3, $2A
	.db repeatBlank, 1

	; --- palettes ---
	.db $FE, 64, $AA

hudDialog:
	.db repeatBlank, 33, $2B
	.db repeatBlank, 24, $2A, $2B, repeatBlank, 2, $2A, repeatBlank, 92
	.db $2D, repeatBlank, 2, $2C
	.db repeatBlank, 2
	.db $2D, repeatBlank, 5, $0A, repeatBlank, 18, $2C, repeatBlank, 5

hudMenu:		; last
	.db repeatBlank, 27
	.db H, C, M
	.db repeatBlank, 29
	.db 1, P, W
	.db repeatBlank, 29
	.db 2, P, W
	.db repeatBlank, 29
	.db C, P ,S
	.db repeatBlank, 2+1+25
	.db $2D, repeatBlank, 3, $2C
	.db repeatBlank, 1 + 7
	.db $0A, repeatBlank, 24

unitSelect:

titleScreen2:
	.db repeatBlank, 0	; 8 rows
	.db repeatBlank, 21, $8D, $8C, $8B
	.db repeatBlank, 29, $9D, $9C, $9B, $9A, $99, $98, $97
	.db repeatBlank, 25, $AD, $AC, $AB, $AA, $A9, $A8, $A7
	.db repeatBlank, 26, $BC, $0F, $BA, $B9, $B8, $B7
	.db repeatBlank, 26, $BE, $BD, $BB, $84, $A3, $90
	.db repeatBlank, 25, $81, $80, $8A, $89, $88, $87
	.db repeatBlank, 26, $86, $85, $0F, $83, $82
	.db repeatBlank, 27, $96, $95, $94, $93, $92, $91
	.db repeatBlank, 26, $A6, $A5, $A4, $0F, $A2, $A1, $A0
	.db repeatBlank, 25, $B6, $B5, $B4, $B3, $B2, $B1, $B0
	.db repeatBlank, 132	; 4 rows + 4 tiles
	.db repeatBlank, 0	; 8 rows

	; --- palettes ---
	.db $FE, 5, $00, %01011010, %01100101
	.db $FE, 6, $00, %01011010, %10101010
	.db $FE, 46, $00 ; 17+29
	.db %01010101, %01100110
	.db $00

missionAccomplishedScreen:
	.db repeatBlank, 0	; 8 blank rows
	.db repeatBlank, 128	; 4 blank rows
	.db repeatBlank, 26, $61, $60									; 17
	.db repeatBlank, 30, $9B, $9A, $99						; 33
	.db repeatBlank, 29, $AB, $AA, $A9
	.db repeatBlank, 29, $BB, $BA, $B9
	.db repeatBlank, 29, $88, $87, $86
	.db repeatBlank, 29, $98, $97, $0F
	.db repeatBlank, 29, $A8, $A7, $A6
	.db repeatBlank, 163	; 5 rows + 3 tiles
	.db repeatBlank, 192	; 8 blank rows
	.db repeatChar, $40, $00	; 2 rows, palette 0

blankScreen:
	.db repeatBlank, $00			; 8 rows
	.db repeatBlank, $00			; 8 rows
	.db repeatBlank, $00			; 8 rows
	.db repeatBlank, $C0			; 6 rows
	; --- palettes ---
	.db repeatChar, $40, $00	; 2 rows, palette 0

animationScreen:
	.db repeatBlank, $00			; 8 rows
	.db repeatBlank, $AC			; 5 rows
	.db $2B, repeatBlank, $06, $2A; 1 row
	.db repeatBlank, $78			; 3 rows
	.db $2D, 	repeatBlank, $06, $2C		; 1 row
	.db repeatBlank, $00			; 8 rows
	.db repeatBlank, $8C			; 4 rows
	; --- palettes ---
	.db repeatChar, $40, $AA	; 2 rows, palette 0

briefScreen:
	.db repeatBlank, $B9																																	; 7 rows and 23 tiles
	.db $2B, repeatBlank, $02, $2A 																												; 0 rows and 6 tiles
	.db repeatBlank, $5C																																	; 3 rows and 26 tiles
	.db $2D, repeatBlank, $02, $2C 																												; 0 rows and 6 tiles
	.db repeatBlank, $06, $2B, repeatBlank, $18, $2A
	.db repeatBlank, $46			;
	.db repeatBlank, $00			; 8 rows
	.db $2D, repeatBlank, $18, $2C
	.db repeatBlank, $C3			; 4 rows, 3 tiles
	.db repeatBlank, $60			; 8 rows
	; --- palettes ---
	.db $FE, $16, $AA
	.db $FE, $01, repeatBlank 				; pilot face attributes
	.db $FE, $09, $AA
	.db $FE, $20, $AA

storyStream:
	.db T, H, E, space, A, T, T, A, C, K, space, O, N, space, O, U, R, space, C, O, L, O, N, Y, lineBreak
	.db S, T, A, R, T, E, D, space , F, I, V, E, space, D, A, Y, S, space, A, G, O, waitForA

	.db nextPage
	.db A, L, L, space, A, T, T, E, M, P, T, S, space, T, O, space, D, I, S, C, U, S, S, lineBreak
	.db T, E, R, M, S, space, O, F, space, S, U, R, R, E, N, D, E, R, space, H, A, V, E, lineBreak
	.db F, A, I, L, E, D, waitForA

	.db nextPage
	.db T, H, E, space, E, N, E, M, Y, space, L, A, U, N, C, H, E, D, space, A, lineBreak
	.db V, I, O, L, E, N, T, space, O, F, F, E, N, S, I, V, E, comma, lineBreak
	.db lineBreak
	.db O, V, E, R, W, H, E, L, M, I, N, G, space, T, H, E, space, C, O, L, O, N, Y, lineBreak
	.db D, E, F, E, N, S, I, V, E, space, F, O, R, C, E, S, waitForA

	.db nextPage
	.db Y, O, U, R, space, U, N, I, T, space, I, S, space, A, M, O, N, G, space, T, H, E, lineBreak
	.db L, A, S, T, space, T, H, A, T, space, A, R, E, space, S, T, I, L, L, lineBreak
	.db S, T, A, N, D, I, N, G, waitForA
	.db endOfStream

instructionStream:

mission01prolog:
	.db setPortrait, 0
	.db S, T, A, N, D, space, B, Y, space, T, O, space, R, E, C, E, I, V, E, lineBreak
	.db N, E, W, space, O, R, D, E, R, S, waitForA
	.db nextPage
	.db S,E,V,E,R,A,L,space, dict, enemy, space, U, N, I, T, S, space, H, A, V, E, lineBreak
	.db B, R, O, K, E, N, space, T, H, R, O, U, G, H, space, O, U, R, lineBreak
	.db D, E, F, E, N, S, E, space, L, I, N, E, waitForA
	.db nextPage
	.db T, H, E, Y, space, M, U, S, T, space, B, E, space, S, T, O, P, P, E, D, lineBreak
	.db B, E, F, O, R, E, space, R, E, A, C, H, I, N, G, space, T, H, E, lineBreak
	.db C, I, T, Y, lineBreak
	.db lineBreak
	.db Y, O, U, R, space, O, R, D, E, R, S, space, A, R, E, space, T, O, space, F, I, N, D, lineBreak
	.db A, N, D, space, E, L, I, M, I, N, A, T, E, space, T, H, E, space, dict, enemy, waitForA
	.db endOfStream

mission01epilogSuccess:
	.db M, I, S, S, I, O, N, space, A, C, C, O, M, P, L, I, S, H, E, D
	.db waitForA
	.db nextPage
	.db Y, O, U, space, H, A, V, E, space, E, L, I, M, I, N, A, T, E, D, lineBreak
	.db T, H, E, space,  E, N, E, M, Y, space, T, H, R, E, A, T
	.db waitForA
	.db nextPage
	.db T, H, E, space, C, I, T, Y, space, I, S, space, S, A, F, E
	.db waitForA
	.db nextPage
	.db F, O, R, space, N, O, W, waitForA
	.db nextPage
	.db T, H, A, N, K, S, space, F, O, R, space, P, L, A, Y, I, N, G, waitForA
	.db endOfStream

mission01epilogFailed:
	.db Y, O, U, R, space, U, N, I, T, space, H, A, S, space, B, E, E, N, lineBreak
	.db D, E, S, T, R, O, Y, E, D
	.db waitForA
	.db nextPage
	.db Y, O, U, R, space, M, I, S, S, I, O, N, space, H, A, S, space, F, A, I, L, E, D
	.db waitForA
	.db nextPage
	.db T, H, A, N, K, S, space, F, O, R, space, P, L, A, Y, I, N, G, waitForA
	.db endOfStream


hud_activityDetected:
	.db H, O, S, T, I, L, E, space, U,N,I,T,S, lineBreak, D, E, T, E, C, T, E, D, waitForA
	.db nextPage
	.db G,E,T,space,R,E,A,D,Y, space, T,O, space, E, N, G, A, G, E, waitForA
	.db endOfStream

hud_playerDestroyed:
	db setPortrait, $40+1
	db I, space, A, M, space, C, H, E, C, K, I, N, G, space,  O, U, T, comma, lineBreak
	db C, O, M, M, A, N, D, E, R, waitForA
	db endOfStream

hud_staySharp:
	.db N,E,W,space,H,O,S,T,I,L,E,S, space, C,O,M,I,N,G,space,O,U,R,lineBreak
	.db W,A,Y,waitForA
	.db nextPage
	.db S, T, A, Y, space, S, H, A, R, P, waitForA
	.db endOfStream

hud_allHostilesDestroyed:
	.db A, L, L, space, H, O, S, T, I, L, E, S, space, H, A, V, E, space, B, E, E, N, lineBreak
	.db D, E, S, T, R, O, Y, E, D, waitForA
	.db nextPage
	.db setPortrait, 0
	.db W, E, L, L, space, D, O, N, E, comma, space, C,O,M,M,A,N,D,E,R, waitForA
	.db nextPage
	.db R, E, P, O, R, T, space, B, A, C, K, space, T, O, space, B, A, S, E, waitForA
	.db endOfStream

hud_missionFailed:
	.db M, I, S, S, I, O, N, lineBreak
	.db F, A, I, L, E, D, waitForA
	.db endOfStream

pausedStream:
	.db G, A, M, E, space, P, A, U, S, E, D, waitForA
	.db endOfStream

resultTargetHit:
	.db nextPage
	.db targetName, space, I, S, space, H, I, T, lineBreak																			;
	.db F, O, R, space, parameter, 2, space, dict, 15, waitForA																	; [15 = DAMAGE]
	.db endOfStream

resultTargetMiss:
	.db nextPage																																	; clear dialog
	.db targetName, space, E,V,A,D,E,D																				;
	.db $F1
	.db T, H, E, space, A, T, T, A, C, K																				; next line
	;.db N, O, space, dict, 15																										  ; NO {DAMAGE}
	;.db $F1																																				; next line
	;.db I,N,F,L,I,C,T,E,D																													; INFLICTED
	.db waitForA
	.db endOfStream

resultUnitDestroyed:
	.db nextPage
	.db targetName, lineBreak
	.db D, E, S, T, R, O, Y, E, D, waitForA
	.db endOfStream

resultChargeDamageSustained:
	.db nextPage
	.db parameter, 21, space, dict, 15, lineBreak																	; [15 = DAMAGE]
	.db S, U, S, T, A, I, N, E, D, waitForA
	.db endOfStream

resultHeatDamageSustained:
	.db nextPage
	.db T, E, M, P, E, R, A, T, U, R, E, lineBreak
	.db C, R, I, T, I, C, A, L, waitForA
	.db nextPage
	.db S, U, S, T, A, I, N, E, D, lineBreak
	.db parameter, 16, space, H, E, A, T, space, dict, 15, waitForA
	.db endOfStream

resultUnitOffline:
	.db nextPage
	.db U, N, I, T, space, O, F, F, L, I, N, E, waitForA
	.db endOfStream

resultTargetOffline:
	.db nextPage
	.db dict, 14, lineBreak, O, F, F, L, I, N, E, waitForA								; [ 14 = TARGET]
	.db endOfStream

resultUnitRestart:
	.db nextPage
	.db H, E, A, T, space, S, T, A, B, L, E, lineBreak
	.db U, N, I, T, space, O, N, L, I, N, E, waitForA
	.db endOfStream

resultEngineCriticalDamage:
	.db nextPage
	.db C,O,O,L,I,N,G,lineBreak
	.db S,Y,S,T,E,M,lineBreak
	.db M,A,L,F,U,N,C,T,I,O,N,waitForA
	.db endOfStream

resultTargetingCriticalDamage:
	.db nextPage
	.db T,A,R,G,E,T,I,N,G,lineBreak
	.db S,Y,S,T,E,M,lineBreak
	.db M,A,L,F,U,N,C,T,I,O,N,waitForA
	.db endOfStream

resultWeaponsCriticalDamage:
	.db nextPage
	.db W,E,A,P,O,N,S,lineBreak
	.db S,Y,S,T,E,M,lineBreak
	.db M,A,L,F,U,N,C,T,I,O,N,waitForA
	.db endOfStream

resultMobilityCriticalDamage:
	.db nextPage
	.db M,O,B,I,L,I,T,Y,lineBreak
	.db R,E,D,U,C,E,D
	.db waitForA
	.db endOfStream
