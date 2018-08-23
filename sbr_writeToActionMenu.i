; -------------------------------------
; Y is string #
; X is position
; -------------------------------------
writeToActionMenu:
	STX locVar1

	LDA stringListL, Y
	STA pointer1+0
	LDA stringListH, Y
	STA pointer1+1

	LDY #$00
	LDA (pointer1), Y			; length
	TAY

	CLC
	ADC locVar1
	TAX
-loop:
	LDA (pointer1), Y

	BPL +
	STY locVar1
	AND #$7F
	TAY
	LDA list3, Y
	LDY locVar1

+	STA actionMenuLine1-1, X

	DEX
	DEY

	BNE -loop
	RTS

; -------------------------------------
; Y is string #
; X is length of string
; -------------------------------------
writeStringToBuffer:
	PLA
	STA locVar1
	PLA
	STA locVar2

	LDA stringListL, Y
	STA pointer1+0
	LDA stringListH, Y
	STA pointer1+1

	LDY #0
	LDA (pointer1), Y			; length of the string
	TAY
	LDA #space

-loop:
	STY locVar3
	CPX locVar3
	BNE +push
	LDA (pointer1), Y
	BPL +continue
	AND #$7F
	TAY
	LDA list3, Y
	LDY locVar3

+continue:
	DEY

+push:
	PHA
	DEX
	BNE -loop
	LDA locVar2
	PHA
	LDA locVar1
	PHA
	RTS

;		LDA (pointer1), Y
;
;		BPL +
;		STY locVar1
;		AND #$7F
;		TAY
;		LDA list3, Y
;		LDY locVar1
;
;	+	STA actionMenuLine1-1, X
;
;		DEX
;		DEY
