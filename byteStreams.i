; -----------------------------------------
; get next byte
;
; byteStreamVar+0, 		repeat counter
; byteStreamVar+1, 		repeat byte
; byteStreamVar+2,
; bytePointer,			current position in the byte stream
; -----------------------------------------
getNextByte:
	LDA byteStreamVar+0					; repeat counter non 0?
	BEQ +newByte						; no -> next byte

	LDA	byteStreamVar+2					; yes -> next question: library string?
	BNE +readString						; yes -> read string

	LDA byteStreamVar+1					; yes -> stay on repeat byte
	DEC byteStreamVar+0
	RTS

+newByte:
	LDY #$00
	LDA (bytePointer), Y
	JSR incrementBytePointer
	CMP #$F0
	BCS +opCode
	RTS

+opCode:
	CMP #$FF					; opCode: repeat blank space
	BEQ +repeatBlank
	CMP #$FE					; opCode: repeat character
	BEQ +repeatChar
	CMP #$FD					; opCode: numberValue
	BEQ +numberValue
	CMP #$FC					; opCode: setString
	BEQ +setString
	RTS

+repeatBlank:
	LDA (bytePointer), Y		; number of repeats
	STA byteStreamVar+0
	DEC byteStreamVar+0			; correct for 0 loop
	LDA #$0F
	STA byteStreamVar+1
	JMP incrementBytePointer	; tail chain


+repeatChar:
	LDA (bytePointer), Y		; number of repeats
	STA byteStreamVar+0
	DEC byteStreamVar+0			; correct for 0 loop
	JSR incrementBytePointer
	LDA (bytePointer), Y
	STA byteStreamVar+1
	JMP incrementBytePointer	; tail chain

+numberValue:
	LDA (bytePointer), Y		; index of variable in list1
	TAY
	LDA list3, Y
	JSR toBCD					; find the tile for the number (0-9)
	LDA par3
	JMP incrementBytePointer	; tail chain

+setString:
	LDA (bytePointer), Y		; string index
	STA byteStreamVar+2
	TAY

	JSR incrementBytePointer

	LDA stringListL, Y
	STA pointer1+0
	LDA stringListH, Y
	STA pointer1+1

	LDY #$00
	LDA (pointer1), Y			; length
	STA byteStreamVar+0

	JMP +next
+readString:
	TAY
	LDA stringListL, Y
	STA pointer1+0
	LDA stringListH, Y
	STA pointer1+1
+next:
	LDY #$00
	LDA (pointer1), Y			; length
	SEC
	SBC byteStreamVar+0
	TAY
	INY							; shift one to account for the length byte
	LDA (pointer1), Y			; current byte
	DEC byteStreamVar+0
	BNE +
	LDY #$00
	STY byteStreamVar+2
	RTS

incrementBytePointer:
	INC bytePointer+0
	BNE +
	INC bytePointer+1
+	RTS

; --- byte stream to load status bar ( in reverse )	---
statusBar:
	.db $FF, $23 	; blank row + 3 blank tiles
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

titleScreen:
	.db $FF, $00	; 8 blank rows
	.db $FF, $0F, $67, $4A
	.db $FF, $1E, $5B, $5A, $59
	.db $FF, $1D, $6B, $6A, $69
	.db $FF, $1D, $7B, $7A, $79
	.db $FF, $1D, $48, $47, $46
	.db $FF, $1D, $58, $0F, $56
	.db $FF, $1D, $68, $0F, $66
	.db $FF, $16
	.db $45, $43, $42, $44, $65, $60, $0F, $42, $42, $42, $41, $40, $63, $62, $61, $60 ; RAMULEN5
	.db $FF, $10
	.db $76, $64, $55, $54, $75, $74, $65, $72, $53, $52, $51, $50, $73, $70, $71, $70 ; RAMULEN5
	.db $FF, $A8
	.db $FF, $00			; 8 blank rows
	; --- palettes ---
	.db $FE, $20, $00	; 1 rows, palette

	.db $FE, $18, $00	; 1 rows, palette
	.db $FE, $08, $05	;
storyScreen:
	.db $FF, $00			; 8 rows
	.db $FF, $00			; 8 rows
	.db $FF, $00			; 8 rows
	.db $FF, $C0			; 6 rows
	; --- palettes ---
	.db $FE, $40, $00	; 2 rows, palette 0
storyStream:
	; >RAMULEN LOG ENTRY 43639
	;
	; A DARK WARLORD HAS RISEN
	; TO POWER, BRINGING WAR
	; TO THE COLONIES OF STAR
	; SYSTEM J340-2
	.db $2F, $21, $10, $1C, $24, $1B, $14, $1D, $0F, $17, $20, $0F, $21, $14, $1F, $1E, $21, $23, $0F, $04, $03, $06, $03, $09, $F1, $F1
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
	.db $17, $14, $21, $0F, $10, $21, $1C, $28, $0F, $1E, $15, $0F, $1C, $14, $21, $14, $1D, $10, $21, $18, $14, $22, $F1
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

	; OUR COLONY DEFENCE FORCE
	; INCLUDES FIVE CLASS -M-
	; BI-PEDAL ASSAULT TANKS
	;
	; IN THE PAST DAYS, FOUR
	; HAVE BEEN LOST IN BATTLE
	.db $1E, $24, $21, $0F, $12, $1E, $1B, $1E, $1D, $28, $0F, $13, $14, $15, $14, $1D, $12, $14, $0F, $15, $1E, $21, $12, $14, $F1
	.db $18, $1D, $12, $1B, $24, $13, $14, $22, $0F, $15, $18, $25, $14, $0F, $12, $1B, $10, $22, $22, $0F, $0B, $1C, $0B, $F1
	.db $11, $18, $0B, $1F, $14, $13, $10, $1B, $0F, $10, $22, $22, $10, $24, $1B, $23, $0F, $23, $10, $1D, $1A, $22, $F1, $F1
	.db $18, $1D, $0F, $23, $17, $14, $0F, $1F, $10, $22, $23, $0F, $13, $10, $28, $22, $0E, $0F, $15, $1E, $24, $21, $F1
	.db $17, $10, $25, $14, $0F, $11, $14, $14, $1D, $0F, $1B, $1E, $22, $23, $0F, $18, $1D, $0F, $11, $10, $23, $23, $1B, $14
	.db $F3	; wait for A button
	.db $F2	; clear & reset box

	; ONLY ONE REMAINS
	.db $1E, $1D, $1B, $28, $0F, $1E, $1D, $14, $0F, $21, $14, $1C, $10, $18, $1D, $22
	.db $F3	; wait for A button
	.db $F4	; move to next game state

resultTargetHit:
	.db $F2																																				; clear dialog
	.db $FC, $0E, $0F, $17, $18, $23																							; [TARGET] HIT
	.db $F1																																				; next line
	.db $FD, 2, $0F																																; X (list3+2)
	.db $FC, 15																																		; [DAMAGE]
	.db $F1																																				; next line
	.db $18, $1D, $15, $1B, $18, $12, $23, $14, $13																; INFLICTED
	.db $F3																																				; A button
	.db $F4																																				; end
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
	.db	$FC, $10																																	; [TEMP LEVEL]
	.db $F1																																				; next line
	.db $22, $23, $10, $11, $1B, $14																							; STABLE
	.db $F3																																				; A button
	.db $F4																																				; done
resultTempDecrease:
	.db $F2																																				; clear dialog
	.db	$FC, $10																																	; [TEMP LEVEL]
	.db $F1																																				; next line
	.db $13, $21, $1E, $1F, $1F, $14, $13, $0F, $11, $28, $0F											; DROPPED BY
	.db $FD, $00																																	; X (list3+0)
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

	; EXPLOSION
																																								; 1 DAMAGE
																																								; CAUSED BY

levelOne:																																				; --- blocked nodes (1 bit for movement + 1 bit for line of sight) ---
	.db #$00, #$00, #$80																													; row 0
	.db #$FE, #$05, #$00																													; row 0 & 1
	.db #$00, #$C0, #$80, #$00																										; row 2
	.db #$8A, #$A8, #$80, #$00																										;	row 3
	.db #%00000000, #%00001000, #$80, #$00																				; row 4
	.db #%00000011, #%00001010, #$80, #$00																				; row 5
	.db #%00001100, #$00, #$00, #$00																							; row 6
	.db #$FE, #$24, #$00																													; row 7-15
																																								; --- initial objects ---
	.db	#$02																																			; number of objects (2)
	.db #$03																																			; object 0 type
	.db #$02																																			; object 0 grid position
	.db #$03																																			; object 0 pilot 0 & facing RD
	.db #$03																																			; object 1 type
	.db #$07																																			; object 1 grid position
	.db #$95																																			; object 1 pilot 8 & facing LD
