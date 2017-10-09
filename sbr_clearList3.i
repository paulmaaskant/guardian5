; --------------------------
; clear list 3
; position X through A
; --------------------------
clearList3:
	STA locVar1
	LDA #$00
-loop:
	STA list3, X
	DEX
	CPX locVar1
	BCS -loop
	RTS
