
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
	.db $FF, $0F, $4B, $4A
	.db $FF, $1E, $5B, $5A, $59
	.db $FF, $1D, $6B, $6A, $69
	.db $FF, $1D, $7B, $7A, $79
	.db $FF, $1D, $48, $47, $46
	.db $FF, $1D, $58, $57, $0F
	.db $FF, $1D, $68, $67, $66
	.db $FF, $16
	.db $45, $43, $42, $44, $61, $62, $42, $61, $60, $61, $60, $61, $62, $42, $42, $65, $62	; GUARDIAN5
	.db $FF, $0F
	.db $76, $64, $55, $54, $73, $70, $51, $53, $72, $71, $70, $73, $70 , $53, $52, $53, $74;
	.db $FF, $A7
	.db $FF, $00			; 8 blank rows
	; --- palettes ---
	.db $FE, $20, $00	; 1 rows, palette
	.db $FE, $18, $00	; 1 rows, palette
	.db $FE, $08, $05	;

storyScreen:
	.db repeatBlank, $00			; 8 rows
	.db repeatBlank, $00			; 8 rows
	.db repeatBlank, $00			; 8 rows
	.db repeatBlank, $C0			; 6 rows
	; --- palettes ---
	.db repeatChar, $40, $00	; 2 rows, palette 0

briefScreen:
	.db $FF, $97																																	; 7 rows and 23 tiles
	.db $2B, $FF, $04, $2A 																												; 0 rows and 6 tiles
	.db $FF, $7A																																	; 3 rows and 26 tiles
	.db $2D, $FF, $04, $2C 																												; 0 rows and 6 tiles
	.db $FF, $06, $2B, $FF, $18, $2A
	.db $FF, $C6			; 3 rows
	.db $FF, $00			; 8 rows
	.db $2D, $FF, $18, $2C
	.db $FF, $A3			; 5 rows
	; --- palettes ---
	.db $FE, $16, $AA
	.db $FE, $01, $FF 				; pilot face attributes
	.db $FE, $09, $AA
	.db $FE, $20, $AA

storyStream:
	; >YETHEL HQ ENTRY 43639
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
	; IS INVADING ONE COLONY
	; AFTER THE OTHER
	; ---
	; LEAVING BEHIND A TRAIL
	; OF DEATH AND DESTRUCTION
	.db H, E, R, space, A, R, M, Y, space, O, F, space, M, E, R, C, E, N, A, R, I, E, S, lineBreak
	.db $18, $22, $0F, $18, $1D, $25, $10, $13, $18, $1D, $16, $0F, $1E, $1D, $14, $0F, $12, $1E, $1B, $1E, $1D, $28, $F1
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
	.db T, H, I, S, space, I, S, space, A, space, T, U, R, N, dash, B, A, S, E, D, lineBreak
	.db S, T, R, A, T, E, G, Y, space, G, A, M, E
	.db waitForA
	.db endOfStream

brief1Stream:
	.db setPortrait, $00
	.db S, T, A, R, T, space, M, I, S, S, I, O, N, space, $01, waitForA
	.db endOfStream

accomplishedStream:
	.db M, I, S, S, I, O, N, lineBreak
	.db A, C, C, O, M, P, L, I, S, H, E, D, waitForA
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

resultTempStable:
	.db $F2																																				; clear dialog
	.db	$FC, $10																																	; [HEATSINKS]
	.db $F1																																				; next line
	.db $22, $23, $10, $11, $1B, $14																							; STABLE
	.db $F3																																				; A button
	.db $F4																																				; done

resultHeatSinksRestored:
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
	.db $F2																																				; clear dialog
	.db $FD, $00, $0F																															; X (list3+0)
	.db	$FC, $10																																	; [HEATSINKS]
	.db $F1																																				; next line
	.db $1E, $15, $15, $1B, $18, $1D, $14																					; OFFLINE
	;.db $22, $10, $23, $24, $21, $10, $23, $14, $13															; SATURATED
	.db $F3																																				; A button
	.db $F4																																				; done

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
	.db #$00, #$00, #$80																													; row 0
	.db #$FE, #$05, #$00																													; row 0 & 1
	.db #$00, #$C0, #$80, #$00																										; row 2
	.db #$8A, #$A8, #$80, #$00																										;	row 3
	.db #%00000000, #%00001000, #$80, #$00																				; row 4
	.db #%00000011, #%00001010, #$80, #$00																				; row 5
	.db #%00000100, #$C0, #$00, #$00																							; row 6
	.db #%00000001, #$00, #$00, #$00																							; row 6
	.db #$FE, #$20, #$00																													; row 8-15
																																								; --- initial objects ---
	.db	#$02																																			; number of objects (2)
	.db #$03																																			; object 0 f type 3
	.db #$02																																			; object 0 grid position
	.db #$03																																			; object 0 pilot f0 & facing RD
	.db #$13																																			; object 1 h type 3
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

dict = $FC
parameter = $FD

comma = $0E
space = $0F
dash = $0B
