; -----------------------------------------------
; load sprite meta frame
;
; IN 		pointer2
; IN 		par3 sprite address
; IN 		par4 (b7, b6) mirror (only b6 implemented), (b0) palette switch
; LOC		pointer2
; LOC		locVar5
;
; OUT			par1 X draw position
; OUT 		par2 Y draw position
; OUT 		par3 address
; calls sprite frame
; ------------------------------------------------
loadSpriteMetaFrame:
	LDA par4								; take par4
	AND #%11110001					; keep mirror bits and 1 palette intact and clear all else
	STA locVar5							; shadow copy of par4
	LDY #$00

-nextSpriteFrame:
	LDA currentObjectXPos		; reset X
	STA par1
	LDA currentObjectYPos		; reset Y
	STA par2

	LDA (pointer2), Y				; A is 'LXYpp?MM'
	ASL											; set carry
	PHP											; L(ast frame) in carry, save for later
	ASL
	BCC	+noX								; X byte present?
	PHA							; save control byte for later
	INY
	LDA (pointer2), Y			; read the X byte
	CLC
	ADC currentObjectXPos
	STA par1
	PLA							; restore the control byte
+noX:
	ASL							; Y into carry
	BCC +noY					; Y byte present?
	PHA							; save the control byte
	INY
	LDA (pointer2), Y			; read the Y byte
	CLC
	ADC currentObjectYPos
	STA par2
	PLA
+noY:								; move the pallette bits to b1 and b0
	CLC								; 'pp?MM000' Carry = 0
	ROL								; 'p?MM0000, Carry = p
	ROL								; '?MM0000p, Carry = p
	PHP								; store carry bit
	ROL								; 'MM0000pp, Carry = ?
	EOR locVar5				; this toggles (b7, b6 and b0)

	PLP								; these 3 instructions prevent b0
	BCC +							; from being toggeled from 1 to 0
	ORA #$01					; iow ORA instead of EOR

+	STA par4
	INY
	LDA (pointer2), Y			; sprite data address
	STA pointer1+0
	INY
	LDA (pointer2), Y			; sprite data address
	STA pointer1+1
	TYA							; save Y
	PHA							; on stack
	JSR loadSpriteFrame
	PLA							; restore Y
	TAY							; from stack
	INY
	LDA locVar5
	STA par4					; restore par4 to original value for next sprite frame
	PLP
	BCC -nextSpriteFrame
	RTS
