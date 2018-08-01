; -------------------------------------
; Y is string #
; X is position
; -------------------------------------
writeToList8:
	LDA stringListL, Y
	STA pointer2+0
	LDA stringListH, Y
	STA pointer2+1

	LDY #0
	LDA (pointer2), Y			; length
	TAY
	PHA

  STX locVar1           ; X = A + X
	CLC
	ADC locVar1
	TAX

-loop:
	LDA (pointer2), Y
  STA list8-1, X
	DEX
	DEY

	BNE -loop
	PLA									; length in A
	RTS
