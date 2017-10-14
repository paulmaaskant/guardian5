
; --- byte stream to load status bar ( in reverse )	---
statusBar:
	.db $FF, $23 	; 2 rows + 3 blank tiles
	.db $2B, $FF, $03, $2A, $2B, $FF, $0D, $2A, $FF, $69
	.db $FF, $03, $2D, $FF, $03, $2C, $2D, $FF, $0D, $2C, $FF, $09
	.db $FF, $00	; 8 blank rows
	.db $FF, $00  ; 8 blank rows
	.db $FF, $00	; 8 blank rows

	; --- palettes ---
	.db $FE, $17, $AA
	.db $AF 				; pilot face attributes
	.db $FE, $07, $AA
	.db $FA				; pilot face attributes
	.db $FE, $20, $AA

statusMenu:
	.db $FF, $43, $2B, $FF, $12, $2A, $FF, $49	; 6 rows
	.db $FF, $03, $2D, $FF, $12, $2C, $FF, $09

titleScreen:
	.db $FF, $00	; 8 blank rows
	.db $FF, $0F, $E1, $E0
	.db $FF, $1E, $5B, $5A, $59
	.db $FF, $1D, $6B, $6A, $69
	.db $FF, $1D, $7B, $7A, $79
	.db $FF, $1D, $48, $47, $46
	.db $FF, $1D, $58, $57, $0F
	.db $FF, $1D, $68, $67, $66
	.db $FF, $16
	.db $41, $40, $42, $44, $61, $62, $42, $61, $60, $61, $60, $61, $62, $42, $42, $41, $74; GUARDIAN5
	.db $FF, $0F
	.db $51, $50, $64, $54, $73, $70, $63, $53, $72, $71, $70, $73, $70, $53, $52, $51, $43;
	.db $FF, $A7
	.db $FF, $00			; 8 blank rows
	; --- palettes ---
	.db $FE, $20, $00	; 1 rows, palette
	.db $FE, $18, $00	; 1 rows, palette
	.db $FE, $08, $05	;

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
	.db $FF, $97																																	; 7 rows and 23 tiles
	.db $2B, $FF, $04, $2A 																												; 0 rows and 6 tiles
	.db $FF, $7A																																	; 3 rows and 26 tiles
	.db $2D, $FF, $04, $2C 																												; 0 rows and 6 tiles
	.db $FF, $06, $2B, $FF, $18, $2A
	.db $FF, $E6			;
	.db $FF, $00			; 8 rows
	.db $2D, $FF, $18, $2C
	.db $FF, $83			; 4 rows, 3 tiles
	; --- palettes ---
	.db $FE, $16, $AA
	.db $FE, $01, $FF 				; pilot face attributes
	.db $FE, $09, $AA
	.db $FE, $20, $AA

storyStream:
	; >RYDON HQ ENTRY 43639
	;
	; A DARK WARLORD HAS RISEN
	; TO POWER, BRINGING WAR
	; TO THE COLONIES OF STAR
	; SYSTEM J340-2
	.db $2F, R, Y, D, O, N, space, H, Q, space, $21, $14, $1F, $1E, $21, $23, $0F, $04, $03, $06, $03, $09, $F1, $F1
	.db $10, $0F, $13, $10, $21, $1A, $0F, $26, $10, $21, $1B, $1E, $21, $13, $0F, $17, $10, $22, $0F, $21, $18, $22, $14, $1D, $F1
	.db $23, $1E, $0F, $1F, $1E, $26, $14, $21, $0E, $0F, $11, $21, $18, $1D, $16, $18, $1D, $16, $0F, $26, $10, $21, $F1
	.db $23, $1E, $0F, $23, $17, $14, $0F, $12, $1E, $1B, $1E, $1D, $18, $14, $22, $0F, $1E, $15, $0F, $22, $23, $10, $21, $F1
	.db $22, $28, $22, $23, $14, $1C, $0F, $19, $03, $04, $00, $0B, $02
	.db $F3	; wait for A button
	.db $F2	; clear & reset box

	; HER ARMY OF MERCENARIES
	; IS PILLAGING ONE COLONY
	; AFTER THE OTHER
	; ---
	; LEAVING BEHIND A TRAIL
	; OF DEATH AND DESTRUCTION
	.db H, E, R, space, A, R, M, Y, space, O, F, space, M, E, R, C, E, N, A, R, I, E, S, lineBreak
	.db I, S, space, P, I, L, L, A, G, I, N, G, space, O, N, E, space, C, O, L, O, N, Y, lineBreak
	.db $10, $15, $23, $14, $21, $0F, $23, $17, $14, $0F, $1E, $23, $17, $14, $21, $0E, $F1, $F1
	.db $1B, $14, $10, $25, $18, $1D, $16, $0F, $11, $14, $17, $18, $1D, $13, $0F, $10, $0F, $23, $21, $10, $18, $1B, $F1
	.db $1E, $15, $0F, $13, $14, $10, $23, $17, $0F, $10, $1D, $13, $0F, $13, $14, $22, $23, $21, $24, $12, $23, $18, $1E, $1D
	.db $F3	; wait for A button
	.db $F2	; clear & reset box

	; OUR COLONY WAS INVADED
	; FIVE DAYS AGO
	; ---
	; ALL ATTEMPTS TO DISCUSS
	; TERMS OF SURRENDER HAVE
	; FAILED
	.db $1E, $24, $21, $0F, $12, $1E, $1B, $1E, $1D, $28, $0F, $26, $10, $22, $0F, $18, $1D, $25, $10, $13, $14, $13, $F1
	.db $15, $18, $25, $14, $0F, $13, $10, $28, $22, $0F, $10, $16, $1E, $0E, $F1, $F1
	.db $10, $1B, $1B, $0F, $10, $23, $23, $14, $1C, $1F, $23, $22, $0F, $23, $1E, $0F, $13, $18, $22, $12, $24, $22, $22, $F1
	.db $23, $14, $21, $1C, $22, $0F, $1E, $15, $0F, $22, $24, $21, $21, $14, $1D, $13, $14, $21, $0F, $17, $10, $25, $14, $F1
	.db $15, $10, $18, $1B, $14, $13
	.db $F3	; wait for A button
	.db $F2	; clear & reset box

	.db O, U, R, space, C, O, L, O, N, Y, space, D, E, F, E, N, C, E, space, F, O, R, C, E, lineBreak
	.db I, N, C, L, U, D, E, S, space, F, I, V, E, space, C, L, A, S, S, space, dash, G, dash, lineBreak
	.db B, I, dash, P, E, D, A, L, space, A, S, S, A, U, L, T, space, T, A, N, K, S, lineBreak
	.db lineBreak
	.db I, N, space, T, H, E, space, P, A, S, T, space, D, A, Y, S, comma, space, F, O, U, R, lineBreak
	.db H, A, V, E, space, B, E, E, N, space, L, O, S, T, space, I, N, space, B, A, T, T, L, E, waitForA
	.db nextPage

	.db O, N, L, Y, space, O, N, E, space, R, E, M, A, I, N, S, waitForA
	.db endOfStream

instructionStream:
	.db P, R, E, S, S, space, S, T, A, R, T, space, T, O , space, R, E, T, U, R, N, lineBreak
	.db T, O, space, T, H, E, space, M, A, I, N, space, M, E, N, U, lineBreak
	.db lineBreak
	.db P, R, E, S, S, space, A, space,  T, O , space, C, O, N, T, I , N, U, E, waitForA
	.db nextPage

	.db I, N, space, T, H, I, S, space, T, U, R, N, dash, B, A, S, E, D, lineBreak
	.db S, T, R, A, T, E, G, Y, space, G, A, M, E, space, Y, O, U, lineBreak
	.db C, O, N, T, R, O, L, space, A, space, S, Q, U, A, D, space, O, F, lineBreak
	.db W, A, L, K, I, N, G, space, T, A, N, K, S, waitForA
	.db nextPage

	.db Y, O, U, space, P, R, O, G, R, E, S, S, space, T, H, R, O, U, G, H, lineBreak
	.db T, H, E, space, G, A, M, E, space, B, Y, space, C, O, M , P, L, E, T, I, N, G, lineBreak
	.db A, space, S, E, R, I, E, S, space, O, F, space, M, I, S, S, I, O, N, S, waitForA
	.db nextPage

	.db D, U, R, I, N, G, space, A, space, M, I, S, S, I, O, N, comma, lineBreak
	.db U, N, I, T, S, space, T, A, K, E, space, T, U, R, N, S, lineBreak
	.db P, E, R, F, O, R, M, I, N, G, space, A, C, T, I, O, N, S, lineBreak
	.db U, N, T, I, L, space, T, H, E, space, M, I, S, S, I, O, N, lineBreak
	.db C, O, M, P, L, E, T, E, S, space, O, R, space, F, A, I, L, S, waitForA
	.db nextPage

	.db W, H, E, N, space, A, space, U, N, I, T, space, H, A, S, space, T, H, E, space, T, U, R, N, lineBreak
	.db I, T, space, M, U, S, T, space, S, E, L, E, C, T, space, A, N, space, A, C, T, I, O, N, lineBreak
	.db lineBreak
	.db T, H, E, space, A, V, A, I, L, A, B, L, E, space, A, C, T, I, O, N, S, lineBreak
	.db D, E, P, E, N, D, space, O, N, space, T, H, E, space, P, O, S, I, T, I, O, N, lineBreak
	.db O, F, space, T, H, E, space, C, U, R, S, O, R, waitForA
	.db nextPage

	.db C, O, N, T, R, O, L, S, space, F, O, R, lineBreak
	.db S, E, L, E, C, T, I, N, G, space, A, N, space, A, C, T, I, O, N, lineBreak
	.db lineBreak
	.db D, space, dash, space, M, O, V, E, space, C, U, R, S, O, R, lineBreak
	.db B, space, dash, space, T, O, G, G, L, E, space, A, C, T, I, O, N, lineBreak
	.db A, space, dash, space, X, 1, space, L, O, C, K, space, A, C, T, I, O, N, lineBreak
	.db space, space, space, space, X, 2, space, C, O, N, F, I, R, M, space, A, C, T, I, O, N, waitForA
	.db nextPage

	.db S, O, M, E, space, A, C, T, I, O, N, S, space, R, E, Q, U, I, R, E, lineBreak
	.db Y, O, U, space, T, O, space, C, H, O, O, S, E, space, T, H, E, lineBreak
	.db D, I, R, E, C, T, I, O, N, space, T, H, A, T, space, T, H, E, lineBreak
	.db T, A, N, K, space, I, S, space, F, A, C, I, N, G, waitForA
	.db nextPage

	.db C, O, N, T, R, O, L, S, space, F, O, R, lineBreak
	.db C, H, O, O, S, I, N, G, space, A, space, D, I, R, E, C, T, I, O, N, lineBreak
	.db lineBreak
	.db D, space, dash, space, C, H, A, N, G, E, space, D, I, R, E, C, T, I, O, N, lineBreak
	.db A, space, dash, space, C, O, N, F, I, R, M, space, D, I, R, E, C, T, I, O, N, lineBreak
	.db B, space, dash, space, H, O, L, D, space, T, O, space, S, C, R, O, L, L, waitForA
	.db nextPage

	.db E, X, C, E, P, T, space, F, O, R, space, dash, C, O, O, L, D, O, W, N, dash, comma, lineBreak
	.db E, V, E, R, Y, space, A, C, T, I, O, N, space, C, O, S, T, S, space, A, lineBreak
	.db N, U, M, B, E, R, space, O, F, space, A, C, T, I, O, N, space, P, O, I, N, T, S, lineBreak
	.db lineBreak
	.db T, H, E, space, dash, C, O, O, L, D, O, W, N, dash, space, A, C, T, I, O, N, lineBreak
	.db R, E, S, T, O, R, E, S, space, A, C, T, I, O, N, space, P, O, I, N, T, S, waitForA
	.db nextPage

	.db W, H, E, N, space, A, space, T, A, N, K, space, R, U, N, S, space, O, U, T, space, O, F, lineBreak
	.db A, C, T, I, O, N, space, P, O, I, N, T, S, comma, space, I, T, space, S, H, U, T, S, lineBreak
	.db D, O, W, N, space, A, U, T, O, M, A, T, I, C, A, L, L, Y, comma, lineBreak
	.db lineBreak
	.db L, E, A, V, I, N, G, space, I, T, space, V, U, L, N, E, R, A, B, L, E, lineBreak
	.db T, O, space, A, T, T, A, C, K, S, waitForA
	.db nextPage

	.db H, A, V, E, space, F, U, N, space, P, L ,A, Y, I, N, G
	.db waitForA
	.db endOfStream

brief1Stream:
	.db setPortrait, $10
	.db G, U, A, R, D, I, A, N, space, 5, comma, lineBreak
	.db T, H, I, S, space, I, S, space, C, O, M, M, A, N, D, space, 1, lineBreak
	.db lineBreak
	.db S, T, A, N, D, space, B, Y, space, F, O, R, space, N, E, W, space, O, R, D, E, R, S, waitForA
	.db nextPage
	.db setPortrait, $00
	.db T, H, I, S, space, I, S, space, G, U, A, R, D, I, A, N, space, 5, comma, lineBreak
	.db S, T, A, N, D, I, N, G, space, B, Y, waitForA
	.db nextPage
	.db setPortrait, $10
	.db C, A, P, T, A, I, N, comma, lineBreak
	.db lineBreak
	.db A, space, S, I, N, G, L, E, space, E, N, E, M, Y, space, U, N, I, T, lineBreak
	.db H, A, S, space, M, A, D, E, space, I, T, S, space, W, A, Y, space, P, A, S, T, lineBreak
	.db O, U, R, space, D, E, F, E, N, S, E, space, L, I, N, E, lineBreak
	.db lineBreak
	.db I, T, space, M, U, S, T, space, B, E, space, D, E, S, T, R, O, Y, E, D, lineBreak
	.db B, E, F, O, R, E, space, I, T, space, R, E, A, C, H, E, S, space, T, H, E, lineBreak
	.db C, I, T, Y, lineBreak
	.db lineBreak
	.db Y, O, U, R, space, O, R, D, E, R, S, space, A, R, E, space, T, O, space, F, I, N, D, lineBreak
	.db A, N, D, space, E, L, I, M, I, N, A, T, E, space, T, H, E, space, R, O, G, U, E, lineBreak
	.db E, N, E, M, Y, space, U, N, I, T, waitForA
	.db nextPage
	.db setPortrait, $00
	.db O, R, D, E, R, S, space, C, O, N, F, I, R, M, E, D, lineBreak
	.db lineBreak
	.db M, O, V, I, N, G, space, O, U, T, space, T, O, space, F, I, N, D, space, A, N, D, lineBreak
	.db E, L, I, M, I, N, A, T, E, space, E, N, E, M, Y, space, U, N, I, T, lineBreak, N, O, W, waitForA
	.db endOfStream

brief2Stream:
	.db setPortrait, $00
	.db C, O, M, M, A, N, D, space, 1, comma, lineBreak
	.db T, H, I, S, space, I, S, space, G, U, A, R, D, I, A, N, space, 5, lineBreak
	.db lineBreak
	.db T, H, E, space,  E, N, E, M, Y, space, T, H, R, E, A, T, space, H, A, S, lineBreak
	.db B, E, E, N, space, E, L, I, M, I, N, A, T, E, D, lineBreak
	.db lineBreak
	.db I, space, A, M, space, R, E, T, U, R, N, I, N, G, space, T, O, space, B, A, S, E, lineBreak
	.db C, A, M, P, space, F, O, R, space, R, E, P, A, I, R, S, waitForA
	.db nextPage
	.db setPortrait, $10
	.db E, X, C, E, L, L, E, N, T, space, W, O, R, K, comma, space, C, A, P, T, A, I, N, lineBreak
	.db lineBreak
	.db T, H, A, N, K, S, space, F, O, R, space, P, L, A, Y, I, N, G, waitForA
	.db endOfStream

brief3Stream:
	.db T, H, A, N, K, S, space, F, O, R, space, P, L, A, Y, I, N, G, waitForA
	.db endOfStream

accomplishedStream:
	.db M, I, S, S, I, O, N, lineBreak
	.db A, C, C, O, M, P, L, I, S, H, E, D, waitForA
	.db endOfStream

failedStream:
	.db M, I, S, S, I, O, N, lineBreak
	.db F, A, I, L, E, D, waitForA
	.db endOfStream

pausedStream:
	.db G, A, M, E, space, P, A, U, S, E, D, waitForA
	.db endOfStream


resultTargetHit:
	.db nextPage
	.db dict, 14, space, H, I, T, lineBreak																				; [14 = TARGET]
	.db parameter, 2, space, dict, 15, lineBreak																	; [15 = DAMAGE]
	.db I, N, F, L, I, C, T, E, D, waitForA
	.db endOfStream

resultTargetMiss:
	.db $F2																																				; clear dialog
	.db $FC, $0E, $0F, $1C, $18, $22, $22																					; [TARGET] MISS
	.db $F1																																				; next line
	.db $1D, $1E, $0F 																														; NO
	.db $FC, $0F																																	; [DAMAGE]
	.db $F1																																				; next line
	.db $18, $1D, $15, $1B, $18, $12, $23, $14, $13																; INFLICTED
	.db $F3																																				; A button
	.db $F4																																				; end

resultActionPointsRestored:
	.db $F2																																				; clear dialog
	.db $FD, $00, $0F																															; X (list3+0)
	.db	$FC, $10																																	; [ACTION PTS]
	.db $F1																																				; next line
	.db $21, $14, $22, $23, $1E, $21, $14, $13																		; RESTORED
	.db $F3																																				; A button
	.db $F4																																				; done

resultUnitDestroyed:
	.db $F2																																				; clear dialog
	.db $24, $1D, $18, $23																												; UNIT
	.db $F1																																				; next line
	.db $13, $14, $22, $23, $21, $1E, $28, $14, $13																; DESTROYED
	.db $F3																																				; A button
	.db $F4

resultChargeDamageSustained:
	.db $F2																																				; clear dialog
	.db $FD, 21																																		; X (list3+21)
	.db $0F, $FC, 15																															; [DAMAGE]
	.db $F1																																				; next line
	.db $22, $24, $22, $23, $10, $18, $1D, $14, $13																; SUSTAINED
	.db $F3																																				; A button
	.db $F4

resultHeatSinksSaturated:
	.db nextPage
	.db parameter, 0, space, dict, 16, lineBreak																	; 16 =  action pts
	.db S, P, E, N, T, waitForA
	.db endOfStream

resultShutdown:
	.db nextPage
	.db H, E, A, T, space, C, R, I, T, I, C, A, L, lineBreak
	.db U, N, I, T, space, S, H, U, T, T, I, N, G, lineBreak																																			;
	.db D, O, W, N, waitForA
	.db endOfStream

resultUnitOffline:
	.db nextPage
	.db U, N, I, T, space, O, F, F, L, I, N, E, waitForA
	.db endOfStream

resultUnitRestart:
	.db nextPage
	.db H, E, A, T, space, S, T, A, B, L, E, lineBreak
	.db U, N, I, T, space, O, N, L, I, N, E, waitForA
	.db endOfStream

levelOne:																																				; --- blocked nodes (1 bit for movement + 1 bit for line of sight) ---
	.db $00, $00, $80																													; row 0
	.db $FE, 5, $00																													  ; row 0 & 1
	.db $00, $C0, $80, $00																										; row 2
	.db %10001010, $A8, $80, $00																							;	row 3
	.db %10000000, %00001000, $80, $00																				; row 4
	.db %10000011, %00001010, $80, $00																				; row 5
	.db %10000100, $C0, %00001010, $AA																							; row 6
	.db %10000001, $00, %00001010, $AA																							; row 7
	.db %10000000, %00001010, %10001010, $00																	; row 8
	.db %10001010, %10101000, %00001010, $00																	; row 9
	.db %00000000, %00000000, %00001010, $00																	; row 10
	.db #$FE, 20, #$00																												; row 11-15
																																								; --- initial objects ---
	.db	#$02																																			; number of objects (2)
	.db #$03																																			; object 0 f type 3
	.db #$02																																			; object 0 grid position
	.db #$03																																			; object 0 pilot f0 & facing RD
	.db #$12																																			; object 1 h type 2
	.db #$07																																			; object 1 grid position
	.db #$05																																			; object 1 pilot ho & facing LD

A = $10
B = $11
C = $12
D = $13
E = $14
F = $15
G = $16
H = $17
I = $18
J = $19
K = $1A
L = $1B
M = $1C
N = $1D
O = $1E
P = $1F
Q = $20
R = $21
S = $22
T = $23
U = $24
V = $25
W = $26
X = $27
Y = $28
Z = $29

lineBreak = $F1
nextPage = $F2
waitForA = $F3
endOfStream = $F4
setPortrait = $F5

dict = $FC
parameter = $FD

comma = $0E
space = $0F
dash = $0B
