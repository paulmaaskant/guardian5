;------------------------------------------
; distance
; number of hex grid cells between start & dest
;
; IN A	xxxx yyyy (start)
; IN par1 	XXXX YYYY (dest)
; OUT A		distance
; LOCAL locVar1,2
; LOCAL locVar3,4
; LOCAL locVar5
;-----------------------------------------
distance:
	PHA
	LSR
	LSR
	LSR
	LSR
	STA locVar2 	; start.Y
	PLA
	AND #$0F
	STA locVar1		; start.X
	LDA par1
	LSR
	LSR
	LSR
	LSR
	STA locVar4 	; dest.Y
	LDA par1
	AND #$0F
	STA locVar3		; dest.X

	LDA locVar1
	SEC
	SBC locVar3
	JSR absolute
	STA locVar5		; absolute X distance

	LDA locVar2
	SEC
	SBC locVar4
	JSR absolute	; absolute Y distance
	CMP locVar5
	BCC +
	STA locVar5

+	CLC

	LDA locVar1
	ADC locVar2
 	SEC
	SBC locVar3
	SEC
	SBC locVar4

	JSR absolute

	CMP locVar5
	BCC +
	STA locVar5
+
	LDA locVar5
	RTS
