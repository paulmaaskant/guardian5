clearActionMenu:
	LDA #$0F
	LDX #$26
-	STA actionMenuLine1, X
	DEX
	BPL -
	RTS

clearTargetMenu:
	LDA #$0F					; clear tile
	LDX #$14
-	STA targetMenuLine1, X
	DEX
	BPL -
	RTS

clearSystemMenu:
	LDA #$0F					; clear tile
	LDX #8
-	STA systemMenuLine1, X
	DEX
	BPL -
	RTS

showTargetMech:
	LDA #$30
	STA targetMenuLine1+0
	STA targetMenuLine1+2
	LDA #$3B
	STA targetMenuLine1+1
	LDA #$31
	STA targetMenuLine2+0
	LDA #$32
	STA targetMenuLine2+1
	LDA #$33
	STA targetMenuLine2+2
	LDA #$34
	STA targetMenuLine3+0
	LDA #$35
	STA targetMenuLine3+2
	RTS

showHexagon:
	LDA #$36
	STA targetMenuLine2+0
	LDA #$37
	STA targetMenuLine2+1
	LDA #$38
	STA targetMenuLine2+2
	RTS


; IN pointer1 (fixed stats)
showSystemInfo:
	LDA #$3C
	STA systemMenuLine1+0
	LDA #$3D
	STA systemMenuLine1+3

	LDA activeObjectStats+6
	JSR toBCD
	LDA par2
	STA systemMenuLine1+1
	LDA par3
	STA systemMenuLine1+2

	LDY activeObjectIndex
	LDA object+1, Y
	AND #%00000111
	JSR toBCD

	LDA par2
	STA systemMenuLine1+4
	LDA par3
	STA systemMenuLine1+5
	RTS

; -------------------------------------
; Y is string #
; X is position
; -------------------------------------
writeToActionMenu:
	LDA stringListL, Y
	STA pointer1+0
	LDA stringListH, Y
	STA pointer1+1

	LDY #$00
	LDA (pointer1), Y			; length
	TAY

	CLC
	ADC identity, X
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
