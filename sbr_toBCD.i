;------------------------------------------
; toBCD
; byte to 3 binary coded decimals
;
; IN A = binary number to convert
; OUT par1
; OUT par2
; OUT par3
;-------------------------------------------
toBCD:
	STA locVar1			      ; byte
	LDA #$00			        ; initialize
	STA par3			        ;
	STA par2			        ; 0-3 are ones, 4-7 are tens
	LDA #%00000001		    ; b0 is set to 1 as the stop condition
	STA par1			        ; 0-1 are hundreds

-shiftloop:
	LDA par2
	AND #$0F			; mask the ones
	CMP #$05			; if ones => 5
	BCC	+				; then
	LDA par2
	CLC
	ADC	#$03			; add 3
	STA par2
+	LDA par2
	CMP #$50			; if tens => 5
	BCC +
	CLC
	ADC	#$30			; add 3
+	STA par2			; store ones and tens
	LDA par1
	ADC #$00
	STA par1			; add carry to hundreds

	ASL locVar1			; shift byte
	ROL par2			; shift ones and tens
	ROL par1			; shift hundreds and stop condition
	BCC -shiftloop

	LDA par2			; finally
	AND #$0F			; separate the ones
	STA par3			; into par 3

	LDA par2
	LSR
	LSR
	LSR
	LSR
	STA par2

	RTS
