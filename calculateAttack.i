; --------------------------
; calculate attack hit or miss and apply damage
; --------------------------
;
; IN list3+1, hit probability
; IN list3+2, adjusted damage value
; IN list3+20, target life points
;

calculateAttack:
	JSR random100							; random number in A between 0 and 99
	CMP list3+1								; compare to the hit probability
	BCC +hit
	BEQ +hit

	; --- miss ---
	LDA #$02
	BNE +done

	; --- hit, apply damage ---
+hit:
	LDA list3+20							; target dial value
	SEC
	SBC list3+2								; damage value
	BEQ +destroyed
	BCC +destroyed
	ASL
	ASL
	ASL
	PHA
	LDY targetObjectIndex
	LDA object+1, Y
	AND #$07
	TAX
	PLA
	CLC
	ADC identity, X
	STA object+1, Y
	LDA #$01										; value 1 means HIT
	BNE +done

+destroyed:
	LDY #$80
	STY list3+4
	LDY #$05										; Unit destroyed
	STY list3+5
	LDA #$01										; value 1 means HIT

+done:
	STA list3+3									; stream 1: (01) for hit, (02) for miss

	LDA list3+21
	BEQ +continue
	LDA #$06
	STA list3+6


+continue:
	LDA #$03										; stream 2: temp stable!
	STA list3+7

	RTS
