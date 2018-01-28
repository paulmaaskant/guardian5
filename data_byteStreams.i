
; --- byte stream to load status bar ( in reverse )	---
hud:
statusBar:
	.db repeatBlank, 33 	; 2 rows + 3 blank tiles
	.db $2B, repeatBlank, 5, $2A
	.db $2B, repeatBlank, 13, $2A
	.db $2B, repeatBlank, 6, $2A
	.db repeatBlank, 88
	.db $2D, repeatBlank, 6, $2C
	.db repeatBlank, 2
	.db $2D, repeatBlank, 5, $2C
	.db $2D, repeatBlank, 13, $2C
	.db repeatBlank, 9

	.db repeatBlank, $61	; 7 rows
	.db repeatBlank, $00	; 8 blank rows
	.db repeatBlank, $00  ; 8 blank rows

	; offset is 1 blank
	.db repeatBlank, 25, $2B, repeatBlank, 3, $2A
	.db repeatBlank, 20
	.db $2F, T, O, L, I, P
	.db repeatBlank, 26
	.db $2F, A, H, C, E, M
	.db repeatBlank, 8
	.db repeatBlank, 25, $2D, repeatBlank, 3, $2C
	.db repeatBlank, $21 ; 2 rows

	; --- palettes ---
	.db $FE, 64, $AA

hudDialog:
	.db repeatBlank, 33, $2B
	.db repeatBlank, 23, $2A, $2B, repeatBlank, 3, $2A, repeatBlank, 91
	.db $2D, repeatBlank, 3, $2C
	.db repeatBlank, 2
	.db $2D, repeatBlank, 5, $0A, repeatBlank, 17, $2C, repeatBlank, 06

hudMenu:
	.db repeatBlank, 24
	.db 9, 9, $0F, S, Y, S
	.db repeatBlank, 26
	.db 9, 9, $0F, T,C,A
	.db repeatBlank, 26
	.db 9, 9, $0F, C, C, A
	.db repeatBlank, 26
	.db 9, 9, $0F, F, E, D
	.db repeatBlank, 26
	.db 9, 9, $0F, V, O, M
	.db repeatBlank, 3
	.db $2D, repeatBlank, 5, $0A, repeatBlank, 14, $2C, $2D, repeatBlank, 6, $2C
	.db $0F

;hud:
	;.db repeatBlank, 33 	; 2 rows + 3 blank tiles
	;.db $2B, repeatBlank, 5, $2A
	;.db $2B, repeatBlank, 13, $2A
	;.db $2B, repeatBlank, 6, $2A
	;.db repeatBlank, 88
	;.db $2D, repeatBlank, 6, $2C
	;.db repeatBlank, 2
	;.db $2D, repeatBlank, 5, $2C
	;.db $2D, repeatBlank, 13, $2C
	;.db repeatBlank, 9


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
	.db repeatBlank, $97																																	; 7 rows and 23 tiles
	.db $2B, repeatBlank, $04, $2A 																												; 0 rows and 6 tiles
	.db repeatBlank, $7A																																	; 3 rows and 26 tiles
	.db $2D, repeatBlank, $04, $2C 																												; 0 rows and 6 tiles
	.db repeatBlank, $06, $2B, repeatBlank, $18, $2A
	.db repeatBlank, $E6			;
	.db repeatBlank, $00			; 8 rows
	.db $2D, repeatBlank, $18, $2C
	.db repeatBlank, $83			; 4 rows, 3 tiles
	; --- palettes ---
	.db $FE, $16, $AA
	.db $FE, $01, repeatBlank 				; pilot face attributes
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
	.db setPortrait, $20
	.db G, U, A, R, D, I, A, N, space, 5, comma, lineBreak
	.db T, H, I, S, space, I, S, space, C, O, M, M, A, N, D, space, 1, lineBreak
	.db lineBreak
	.db S, T, A, N, D, space, B, Y, space, T, O, space, R, E, C, E, I, V, E, lineBreak
	.db N, E, W, space, O, R, D, E, R, S, waitForA
	.db nextPage
	.db setPortrait, $00
	.db T, H, I, S, space, I, S, space, G, U, A, R, D, I, A, N, space, 5, comma, lineBreak
	.db lineBreak
	.db S, T, A, N, D, I, N, G, space, B, Y, waitForA
	.db nextPage
	.db setPortrait, $20
	.db C, A, P, T, A, I, N, comma, lineBreak
	.db lineBreak
	.db T, W, O, space, E, N, E, M, Y, space, U, N, I, T, S, space, H, A, V, E, lineBreak
	.db B, O, K, E, N, space, T, H, R, O, U, G, H, space, O, U, R, lineBreak
	.db D, E, F, E, N, S, E, space, L, I, N, E, lineBreak
	.db lineBreak
	.db T, H, E, Y, space, M, U, S, T, space, B, E, space, S, T, O, P, P, E, D, lineBreak
	.db B, E, F, O, R, E, space, R, E, A, C, H, I, N, G, space, T, H, E, lineBreak
	.db C, I, T, Y, lineBreak
	.db lineBreak
	.db Y, O, U, R, space, O, R, D, E, R, S, space, A, R, E, space, T, O, space, F, I, N, D, lineBreak
	.db A, N, D, space, E, L, I, M, I, N, A, T, E, space, T, H, E, space, R, O, G, U, E, lineBreak
	.db E, N, E, M, Y, space, U, N, I, T, S, waitForA
	.db nextPage
	.db setPortrait, $00
	.db O, R, D, E, R, S, space, C, O, N, F, I, R, M, E, D, lineBreak
	.db lineBreak
	.db M, O, V, I, N, G, space, O, U, T, space, T, O, space, F, I, N, D, space, A, N, D, lineBreak
	.db E, L, I, M, I, N, A, T, E, space, E, N, E, M, Y, space, U, N, I, T, lineBreak, N, O, W, waitForA
	.db endOfStream

brief2Stream:
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

brief3Stream:
	.db Y, O, U, R, space, M, E, C, H, space, H, A, S, space, B, E, E, N, lineBreak
	.db D, E, S, T, R, O, Y, E, D
	.db waitForA
	.db nextPage
	.db Y, O, U, R, space, M, I, S, S, I, O, N, space, H, A, S, space, F, A, I, L, E, D
	.db waitForA
	.db nextPage
	.db T, H, A, N, K, S, space, F, O, R, space, P, L, A, Y, I, N, G, waitForA
	.db endOfStream

hudConversation02:
	.db A, L, L, space, H, O, S, T, I, L, E, S, space, H, A, V, E, space, B, E, E, N, lineBreak
	.db D, E, S, T, R, O, Y, E, D, waitForA
	.db nextPage
	.db setPortrait, $20
	.db W, E, L, L, space, D, O, N, E, comma, space, C, A, P, T, A, I, N, waitForA
	.db nextPage
	.db R, E, P, O, R, T, space, B, A, C, K, space, T, O, space, B, A, S, E, waitForA
	.db endOfStream

failedStream:
	.db M, I, S, S, I, O, N, lineBreak
	.db F, A, I, L, E, D, waitForA
	.db endOfStream

pausedStream:
	.db G, A, M, E, space, P, A, U, S, E, D, waitForA
	.db endOfStream

hudConversation01:
	.db H, O, S, T, I, L, E, space, A, C, T, I, V, I, T, Y, lineBreak, D, E, T, E, C, T, E, D, waitForA
	.db nextPage
	.db I, space, A, M, space, E, N, G, A, G, I, N, G, space, N, O, W, waitForA
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

levelOne:

	.db 8, 7
	.hex 00 01 02 03 04 05 06 20

	.db 23, 8
	.hex 10 11 12 13 14 15 16 17 18
	.hex 61 62 63 75 76 77 78
	.hex B0 B1 B3 B4 B5 B6 B7

	.db 16, 9
	.hex F2 E2 D2 C2
	.hex F8 E8 D8 C8
	.hex 29 39 49 59 69 89 99 A9

	.db 8, 10
	.hex 19 64 74 B2 79 7A B8 B9

	.db 7, 11
	.hex 1C 2B 1D 2C 3B 2D 3C

	.db 41, 128 ; impassable
	.hex 32 33 34 35 36 46 56 57 58 48 38 28 08
	.hex 92 93 94 95 96 86 87 88
	.hex 5A 5B 6A 6B 6C 6D 6E 6F 7A 7B 7C 7D 7E 7F 8A 8B 9A 9B AA AB

	.db 0

	.db	$02			; number of objects (4)

	.db $20			; object 0 pilot 2
	.db $03			; object 0 grid position
	.db $13			; object 0 type 1 & facing RD

	.db $00			; object 3 building
	.db $14			; object 3 grid position
	.db $0D			; object 3 type obstacle & tile D

	.db $80			; object 1 pilot
	.db $CA			; object 1 grid position
	.db $25			; object 1 type & facing LD

	.db $A0			; object 2 pilot
	.db $C4			; object 2 grid position
	.db $25			; object 2 type & facing LD


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
