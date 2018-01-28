; -----------------------------------------------
; load sprite frame
;
; IN 		pointer1
; IN 		par1 X draw position
; IN 		par2 Y draw position
; IN 		par3 sprite address
; IN 		par4 b7, b6 -> mirror
; IN		par4 b5 -> mask (REMOVED)
; IN    par4 b4 -> obs
; IN 		par4 b0 -> palette switch
;
; LOC		locVar1 X pixel position
; LOC		locVar2 Y rows (down from par2)
; LOC		locVar3 flip bits for current row
; LOC		locVar4 counter (no of patterns in row)
;
; OUT		$02XX
; ppppOFNL - (ffffffff) - xxxxxxxx - sprite pattern (* p)
;
; -- row header --
; pppp = number of patterns in row
; H = 1, hide sprites in this row if object is obscured REMOVED
; F = 1, optional flip bit byte included
; N = 1, move one row down
; L = 1, last row
; ffffffff = (optional) flip bits for first 4 patterns
; xxxxxxxx = X offset from center vertical axis
; ------------------------------------------------
loadSpriteFrame:
	LDY #$00
	STY	locVar2
	STY locVar3

-nextRow:
	LDA (pointer1), Y
	LSR										; L into carry
	PHP										; store carry flag 1 = last row

+continue:
	LSR										; N into carry move one row down?
	BCC +continue					; no -> continue
	INC locVar2 					; yes -> increase row count

+continue:
	LSR										; F into carry flip bits ?
	BCC	+continue					; no -> continue
	TAX										; store A in X
	INY										; yes -> get flip bits
	LDA (pointer1), Y			; flip bits
	STA locVar3
	TXA										; restore A from X

+continue:
	LSR										; H into carry
	;BCC +continue
	;TAX										; store A
	;LDA par4
	;AND #$10
	;BNE +prepNextRow
	;TXA										; restore A

;+continue:
	STA locVar4						; locVar4 := no. of sprites in current row
	INY
	LDA (pointer1), Y			; x offset
	BIT par4
	BVC +continue
	EOR #$FF							; negate offset in case sprite list is mirrored
	SEC										;
	ADC #$00							;

+continue:
	SEC
	SBC #$04							; default offset
	CLC
	ADC par1							;
	STA locVar1						; x write pos

-nextSprite:
	DEC locVar4
	BMI +prepNextRow
	LDA par3
	ASL
	ASL
	TAX
	LDA locVar2								; row
	ASL
	ASL
	ASL												; x8
	ADC par2									; = row (locVar2) x 8 px + base Y px (par2)
														; if (obscured) and (currentObjectYPos - A <= 8px) then do not show
	STA $0200, X							; sprite Y pos
	INY
	LDA (pointer1), Y					; yes
	BNE +next									; pattern 00 means -> no sprite
	DEC par3									; decrement sprite index so that next sprite overwrites this one
														; als fix the Y coordinate (maybe last sprite!)
+next:
	CMP #$31									; pattern 31 means -> variable
	BNE +next
	INY
	TYA												; store Y
	PHA
	LDA (pointer1), Y
	TAY
	LDA list3, Y
	STA $0201, X							; pattern
	PLA
	TAY												; restore Y
	JMP +variable
	; retrieve variable
+next:
	STA $0201, X							; pattern

+variable:
	LDA #$00
	LSR locVar3								; shift flip bit to A
	ROR
	LSR locVar3								; shift second flip bit to A
	ROR  											; leaves CLC
	EOR par4									; set pallette, priority and toggle flips
	STA $0202, X							; set flip bits (b7,6)

	LDA locVar1
	STA $0203, X 							; sprite X pos
	LDA #$08
	BIT par4
	BVC +continue
	EOR #$FF
	SEC
	ADC #$00

+continue:
	ADC locVar1								; guarantee CLC
	STA locVar1
	INC par3
	JMP -nextSprite

+prepNextRow:
	INY
	PLP
	BCS +done
	JMP -nextRow

+done:
	RTS
