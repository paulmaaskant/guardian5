
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
	db dict, dTHE, space, A, T, T, A, C, K, space, O, N, space, O, U, R, space, C, O, L, O, N, Y, lineBreak
	db S, T, A, R, T, E, D, space , F, I, V, E, space, D, A, Y, S, space, A, G, O, waitForA
	db nextPage
	db dict, dTHE, R, E, space, W, E, R, E, space, N, O, lineBreak
	db N, E, G, O, T, I, A, T, I, O, N, S, waitForA

	.db nextPage
	.db dict, dTHE, space, dict, dENEMY, space, L, A, U, N, C, H, E, D, space, A, lineBreak
	.db V, I, O, L, E, N, T, space, O, F, F, E, N, S, I, V, E, comma, lineBreak
	.db lineBreak
	.db O, V, E, R, W, H, E, L, M, I, N, G, space, dict, dTHE, space, C, O, L, O, N, Y, lineBreak
	.db D, E, F, E, N, S, I, V, E, space, F, O, R, C, E, S, waitForA

	.db nextPage
	.db Y, O, U, R, space, dict, dUNIT, space, I, S, space, A, M, O, N, G, space, dict, dTHE, lineBreak
	.db L, A, S, T, space, T, H, A, T, space, A, R, E, space, S, T, I, L, L, lineBreak
	.db S, T, A, N, D, I, N, G, waitForA
	.db endOfStream

instructionStream:


mission00prologue:
	db setPortrait, 0
	db dict, dCOMMANDER, comma, lineBreak, lineBreak
	db O, U, R, space, L, A, S, T, space, D, E, F, E, N, C, E, S, space, H, A, V, E, lineBreak
	db F, A, I, L, E, D, lineBreak
	db lineBreak
	db W, I, T, H, I, N, space, A, space, F, E, W, space, H, O, U, R, S, space, W, E, lineBreak
	db W, I, L, L, space, H, A, V, E, space, L, O, S, T, space, dict, dTHE, space, C, I, T, Y, waitForA
	db nextPage
	db O, U, R, space, O, N, L, Y, space, R, E, M, A, I, N, I, N, G, lineBreak
	db O, B, J, E, C, T, I, V, E, space, I, S, space, T, O, space, E, N, S, U, R, E, lineBreak
	db T, H, A, T, space, L, A, D, Y, space, N, O, V, E, M, B, E, R, lineBreak
	db L, E, A, V, E, S, space, T, H, I, S, space, P, L, A, N, E, T, lineBreak
	db S, A, F, E, L, Y, waitForA
	db nextPage
	db W, E, space, N, E, E, D, space, H, E, R, space, dict, dCONVOY, space, T, O, lineBreak
	db G, E, T, space, O, U, T, space, O, F, space, dict, dTHE, space, C, I, T, Y, lineBreak
	db I, M, M, E, D, I, A, T, L, Y, comma, space, S, O, space, T, H, A, T, space, S, H, E, lineBreak
	db R, E, A, C, H, E, S, space, dict, dTHE, space, L, A, S, T, lineBreak
	db O, P, E, R, A, T, I, O, N, A, L, space, S, P, A, C, E, P, O, R, T, lineBreak
	db U, N, N, O, T, I, C, E, D, waitForA
	db nextPage
	db T, O, space, M, A, K, E, space, T, H, I, S, space, P, O, S, S, I, B, L, E, comma, lineBreak
	db Y, O, U, space, A, R, E, space, T, O, space, C, R, E, A, T, E, space, A, lineBreak
	db D, I, S, T, R, A, C, T, I, O, N, space, B, Y, space, E, N, G, A, G, I, N, G, lineBreak
  db A, N, D, space, D, E, S, T, R, O, Y, I, N, G, space, dict, dTHE, space, dict, dENEMY, lineBreak
	db F, O, R, C, E, S, space, I, N, space, S, E, C, T, O, R, space, 3, waitForA
	db nextPage
	db G, O, O, D, space, L, U, C, K, space, dict, dCOMMANDER, comma, lineBreak
	db lineBreak
	db A, N, D, space, S, T, A, Y, space, A, L, I, V, E, waitForA
	db endOfStream

mission01prologue:
	db setPortrait, 0
	db W, E, space, H, A, V, E, space, P, I, C, K, E, D, space, U, P, space, N, E, W, lineBreak
	db dict, dENEMY, space, U, N, I, T, S, space, O, N, space, O, U, R, lineBreak
	db L, O, N, G, space, dict, dRANGE, space, S, E, N, S, O, R, S, lineBreak
	db lineBreak
	db dict, dTHE, Y, space, A, R, E, space, O, N, space,	A, space, D, I, R, E, C, T, lineBreak
	db I, N, T, E, R, C, E, P, T, space, C, O, U, R, S, E, space, W, I, T, H, lineBreak
	db dict, dCONVOY, space, O, N, E, waitForA
	db nextPage
	db dict, dTHE, space, L, A, S, T, space, O, F, F, dash, W, O, R, L, D, lineBreak
	db T, R, A, N, S, P, O, R, T, space, L, E, A, V, E, S, space, I, N, lineBreak
	db 9, 0, space, dict, dMINUTES, comma, lineBreak
	db lineBreak
	db T, H, I, S, space, M, E, A, N, S, space, W, E, space, D, O, N, T, space, H, A, V, E, lineBreak
	db T, I, M, E, space, T, O, space, A, L, T, E, R, space, C, O, U, R, S, E
	db waitForA
	db nextPage
	db Y, O, U, R, space, O, R, D, E, R, S, space, A, R, E, space, T, O, lineBreak
  db D, E, P, L, O, Y, space, I, M, M, E, D, I, A, T, L, Y, space, A, N, D, lineBreak
	db P, R, O, T, E, C, T, space, dict, dCONVOY, space, O, N, E, space, F, R, O, M, lineBreak
	db dict, dTHE, space, I, N, T, E, R, C, E, P, T, I, N, G, space, F, O, R, C, E, S, waitForA
	db nextPage
	db dict, dCOMMANDER, comma, lineBreak, lineBreak
	db M, A, K, E, space, S, U, R, E, space, dict, dCONVOY, space, O, N, E, lineBreak
	db S, U, R, V, I, V, E, S, space, T, H, I, S, space, E, N, C, O, U, N, T, E, R
	db waitForA
	db endOfStream

mission02prologue:
	db setPortrait, 0
	db dict, dCOMMANDER, comma, lineBreak, lineBreak
	db dict, dTHE, space, S,P,A,C,E, P, O, R, T, space, I,S, space, S, T, I, L, L, lineBreak
	db U, N, D, E, R, space, O, U, R, space, C, O, N, T, R, O, L, comma, space, B, U, T, lineBreak
	db T, I, M, E, space, I, S, space, R, U, N, N, I, N, G, space, O, U, T
	db waitForA
	db lineBreak, lineBreak
	db A, N, D, space, W, E, space, H, A, V, E, space, A, N, O, T, H, E, R, lineBreak
	db P,R, O, B, L, E, M, waitForA
	db nextPage
	db W, E, space, H, A, V, E, space, D, E, T, E, C, T, E, D, space, A, space, N, E, W, lineBreak
	db F, O, R, T, I, F, I, E, D, space, dict, dENEMY, space, O, U, T, P, O, S, T, lineBreak
	db lineBreak
	db I, T, space, I, S, space, B, L, O, C, K, I, N, G, space, A, C, C, E, S, S, lineBreak
	db T, O, space, dict, dTHE, space, S, P, A, C, E, P, O, R, T
	db waitForA
	db nextPage
	db W, E, space, D, O, N, T, space, H, A, V, E, space, T, I, M, E, space, T, O, lineBreak
	db G, O, space, A, R, O, U, N, D, lineBreak
	db lineBreak
	db A, N, D, space, W, E, space, C, A, N, T, space, A, F, F, O, R, D, space, T, O, lineBreak
	db D, E, L, A, Y, space, dict, dCONVOY, space, O, N, E, space, B, Y, space, M, O, R, E, lineBreak
	db T, H, A, N, space, A, space, F, E, W, space, dict, dMINUTES, waitForA
	db nextPage
	db dict, dTHE, space, O, U, T, P, O, S, T, space, H, A, S, space, M, O, U, N, T, E, D, lineBreak
	db 4, space, H, E, A, V, I, L, Y, space, A, R, M, E, D, space, dict, dTURRET, S, lineBreak
	db lineBreak
	db T, A, K, E, space, dict, dTHE, M, space, O, U, T, space, B, E, F, O, R, E, lineBreak
	db dict, dCONVOY, space, O, N, E, space, A, R, R, I, V, E, S
	db waitForA
	db endOfStream

mission03prologue:
	db setPortrait, 0
	db dict, dCOMMANDER, comma, lineBreak
	db lineBreak
	db dict, dCONVOY, space, O, N, E, space, H, A, S, space, R, E, A, C, H, E, D, lineBreak
	db dict, dTHE, space, S, P, A, C, E, P, O, R, T, lineBreak
	db lineBreak
	db L, A, D, Y, space, N, O, V, E, M, B, E, R, space, H, A, S, lineBreak
	db B, O, A, R, D, E, D, space, dict, dTHE, space, L, A, S, T, lineBreak
	db T, R, A, N, S, P, O, R, T, space, S, H, I, P, waitForA
	db nextPage
	db dict, dTHE, space, S, H, I, P, space, I, S, space, C, U, R, R, E, N, T, L, Y, lineBreak
	db S, T, A, R, T, I, N, G, space, U, P, space, I, T, S, space, F, L, I, G, H, T, lineBreak
	db S, Y, S, T, E, M, S, lineBreak
	db lineBreak
	db dict, dTHE, space, L, A, U, N, C, H, space, T, I, M, E, space, I, S, space, S, E, T, lineBreak
	db A, T, space, T, dash, 1, 0, space, dict, dMINUTES, waitForA
	db nextPage
	db dict, dCOMMANDER, comma, space, T, H, I, S, space, I, S, space, Y, O, U, R, lineBreak
	db F, I, N, A, L, space, M, I, S, S, I, O, N, lineBreak
	db lineBreak
	db Y, O, U, space, H, A, V, E, space, T, O, space, P, R, O, T, E, C, T, space, dict, dTHE, lineBreak
	db S, H, I, P, space, W, H, I, L, E, space , I, T, space, I, S, lineBreak
	db P, O, W, E, R, I, N, G, space, U, P, waitForA
	db nextPage
	db P, R, O, T, E, C, T, space, I, T, space, A, T, space, A, L, L, space, C, O, S, T, S, waitForA
	db endOfStream

mission00epilogSuccess:
	db dict, dMISSION_ACCOMPLISHED, waitForA
	db nextPage
	db dict, dCONVOY, space, O, N, E, space, W, A, S, space, A, B, L, E, lineBreak
	db T, O, space, E, S, C, A, P, E, space, dict, dTHE, space, C, I, T, Y, lineBreak
	db U, N, D, E, T, E, C, T, E, D, waitForA
	db nextPage
	db H, A, V, E, space, Y, O, U, R, space, S, U, P, P, O, R, T, space, T, E, A, M, lineBreak
	db D, O, space, E, M, E, R, G, E, N, C, Y, space, R, E, P, A, I, R, S, lineBreak
	db A, N, D, space, P, R, O, C, E, E, D, space, T, O, lineBreak
	db R, E, N, D, E, Z, V, O, U, S, space, P, O, I, N, T, space, B, E, T, A
	db waitForA
	db endOfStream

mission01epilogSuccess:
	db dict, dMISSION_ACCOMPLISHED, waitForA
	.db nextPage
	.db Y, O, U, space, H, A, V, E, space, E, L, I, M, I, N, A, T, E, D, lineBreak
	.db dict, dTHE, space, dict, dENEMY, space, T, H, R, E, A, T
	.db waitForA
	.db nextPage
	.db dict, dTHE, space, C, I, T, Y, space, I, S, space, S, A, F, E
	.db waitForA
	.db nextPage
	.db F, O, R, space, N, O, W, waitForA
	.db nextPage
	.db T, H, A, N, K, S, space, F, O, R, space, P, L, A, Y, I, N, G, waitForA
	.db endOfStream

mission00epilogFailed:
	db T, R, Y, space, A, G, A, I, N, waitForA
	db endOfStream

mission01epilogFailed:
	.db Y, O, U, R, space, dict, dUNIT, S, space, H, A, S, space, B, E, E, N, lineBreak
	.db D, E, S, T, R, O, Y, E, D
	.db waitForA
	.db nextPage
	.db Y, O, U, R, space, M, I, S, S, I, O, N, space, H, A, S, space, F, A, I, L, E, D
	.db waitForA
	.db nextPage
	.db T, H, A, N, K, S, space, F, O, R, space, P, L, A, Y, I, N, G, waitForA
	.db endOfStream


hud_activityDetected:
	.db H, O, S, T, I, L, E, space, dict, dUNIT, S, space, D, E, T, E, C, T, E, D, waitForA
	.db nextPage
	.db G, E, T, space, R, E, A, D, Y, space, T, O, space, E, N, G, A, G, E, waitForA
	.db endOfStream

hud_playerDestroyed:
	db setPortrait, $40+1
	db dict, dCOMMANDER, comma, lineBreak
	db I, space, H, A, V, E, space, T, A, K, E, N, space, C, R, I, T, I, C, A, L, lineBreak
	db dict, dDAMAGE, waitForA
	db nextPage
	db E, J, E, C, T, I, N, G, space, N, O, W, waitForA
	db endOfStream

hud_staySharp:
	.db N, E, W, space, H, O, S, T, I, L, E, S, space, C, O, M, I, N, G, space, O, U, R, lineBreak
	.db W, A, Y, waitForA
	.db nextPage
	.db S, T, A, Y, space, S, H, A, R, P, waitForA
	.db endOfStream

hud_convoyDestroyed:
	.db dict, dCONVOY, space, O, N, E, space, H, A, S, space, B, E, E, N, lineBreak
	.db D, E, S, T, R, O, Y, E, D, waitForA
	.db endOfStream


hud_allHostilesDestroyed:
	.db A, L, L, space, H, O, S, T, I, L, E, S, space, H, A, V, E, space, B, E, E, N, lineBreak
	.db D, E, S, T, R, O, Y, E, D, waitForA
	.db nextPage
	.db setPortrait, 0
	.db W, E, L, L, space, D, O, N, E, comma, space, dict, dCOMMANDER, waitForA
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
	.db nextPage
	.db targetName, space, E, V, A, D, E, D, lineBreak
	.db dict, dTHE, space, A, T, T, A, C, K, waitForA
	.db endOfStream

resultUnitDestroyed:
	.db nextPage
	.db targetName, lineBreak
	.db D, E, S, T, R, O, Y, E, D, waitForA
	.db endOfStream

resultChargeDamageSustained:
	.db nextPage
	.db parameter, 21, space, dict, dDAMAGE, lineBreak
	.db S, U, S, T, A, I, N, E, D, waitForA
	.db endOfStream

resultHeatDamageSustained:
	.db nextPage
	.db T, E, M, P, E, R, A, T, U, R, E, lineBreak
	.db C, R, I, T, I, C, A, L, waitForA
	.db nextPage
	.db S, U, S, T, A, I, N, E, D, lineBreak
	.db parameter, 16, space, dict, dHEAT, space, dict, dDAMAGE, waitForA
	.db endOfStream

resultUnitOffline:
	.db nextPage
	.db dict, dUNIT, space, O, F, F, L, I, N, E, waitForA
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
	.db C, O, O, L, I, N, G, lineBreak
	.db S, Y, S, T, E, M, lineBreak
	.db M, A, L, F, U, N, C, T, I, O, N, waitForA
	.db endOfStream

resultTargetingCriticalDamage:
	.db nextPage
	.db T, A, R, G, E, T, I, N, G, lineBreak
	.db S, Y, S, T, E, M, lineBreak
	.db M, A, L, F, U, N, C, T, I, O, N, waitForA
	.db endOfStream

resultWeaponsCriticalDamage:
	.db nextPage
	.db W, E, A, P, O, N, S, lineBreak
	.db S, Y, S, T, E, M, lineBreak
	.db M, A, L, F, U, N, C, T, I, O, N, waitForA
	.db endOfStream

resultMobilityCriticalDamage:
	.db nextPage
	.db M, O, B, I, L, I, T, Y, lineBreak
	.db R, E, D, U, C, E, D, waitForA
	.db endOfStream
