;------------------------------------------
; divide
; N/D = (Q,R)
;
; D cannot be greater than 127
;
; IN 	 N 	Numerator 		(2 bytes)    par1 hi, par2 lo
; IN 	 D 	Denominator 	(1 byte)	 A
; OUT    Q quotient A 		(2 bytes)    par3 hi, par4 lo
; OUT 	 R 	Rest			(1 byte)	 A
;------------------------------------------
divide:
	STA locVar1		; D
	LDA #$00
	STA locVar2		; R
	STA par3			; Q high
	STA par4			; Q low
	INC par4			; set bit b0 to 1 (end condition bit)

-loop:
	ASL par2			;
	ROL	par1			; move b15 from N
	ROL locVar2		; into R
	LDA locVar2		; load R into accumulator
	BCS +rIsBigger
	CMP locVar1		; compare to D
	BCC +rIsSmaller					; if R >= D

+rIsBigger:
	SBC locVar1		; carry is set for sure
	STA locVar2		; then R = R - D, carry is set for sure (because R >= D)
	SEC

+rIsSmaller:
	ROL par4			; move carry flag value into Q
	ROL par3
	BCC -loop			; wait for end condition bit to fall off
	LDA locVar2		; load R
	RTS
