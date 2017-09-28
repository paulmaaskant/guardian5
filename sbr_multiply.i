;------------------------------------------
; multiply
; M * N = MN
;
; M (1 byte) A
; N (1 byte) X
; MN (2 Bytes) par 1 hi, par 2 lo
;-----------------------------------------
multiply:
	EOR #$FF		; flip bits of M
	STA locVar1		; M
	STX locVar2		; N
	LDA #$00
	STA par1
	STA par2
	LDY #$08
-	ASL par2
	ROL par1
	ASL locVar1
	BCS +			; leverage M flipped bits to prevent CLC
	;CLC
	LDA par2
	ADC locVar2
	STA par2
	LDA par1
	ADC #$00
	STA par1
+	DEY
	BNE -
	RTS
