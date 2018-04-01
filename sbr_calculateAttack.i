; --------------------------
; calculate attack hit or miss and apply damage
; --------------------------
; IN list3+0, heat
; IN list3+1, hit probability
; IN list3+2, adjusted damage value
; IN list3+20, target hit points

calculateAttack:
	JSR getSelectedWeaponTypeIndex
	BCS +continue

	ASL activeObjectStats-1, X
	LDA weaponType+3, Y
	ASL
	ROR activeObjectStats-1, X	; set once per turn bit

	AND #%00011110							; uses ammo?
	BEQ +continue								; no -> continue

	LDA activeObjectIndex
	CLC
	ADC identity, X
	TAX
	DEC object+5, X

+continue:
	LDA #$03										; clear from list3+3
	LDX #$09										; up to and including list3+9
	JSR clearList3

	LDX activeObjectIndex				; remove target lock if its another unit here
	LDA object+4, X
	CMP targetObjectTypeAndNumber
	BEQ +continue
	LDA #0
	STA object+4, X

+continue:
	JSR random100								; random number in A between 0 and 99
	CMP list3+1									; compare to the hit probability
	BCC +hit
	BEQ +hit
	LDA #$02										; miss
	BNE +continue

	; --- hit, apply damage ---
+hit:
	LDA list3+20								; target dial value
	SEC
	SBC list3+2									; damage value
	BEQ +destroyed
	BCC +destroyed
	ASL													; if not destroyed
	ASL													; write back new target dial value
	ASL
	PHA													; new value on stack
	LDY targetObjectIndex
	LDA object+1, Y
	AND #$07										; clear old value, keep heat value
	TAX
	PLA
	CLC
	ADC identity, X
	STA object+1, Y
	LDA #$01									; value 1 means HIT
	BNE +continue

+destroyed:
	LDY #$80
	STY list3+4
	LDY #$05									; Target Unit destroyed
	STY list3+5
	LDA #$01									; value 1 means HIT

+continue:																																			; check charge damage next
	STA list3+3																																		; stream 1: (01) for hit, (02) for miss
	LDX list3+21																																	; charge damage?
	BEQ +continue																																	; no -> continue
	LDA #$06																																			; yes
	STA list3+6																																		; set result message
	LDA activeObjectStats+6		; active unit armor value
	SEC
	SBC list3+21							; charge damage
	LDY activeObjectIndex
	ASL
	ASL
	ASL
	PHA
	LDA object+1, Y
	AND #$07									; clear old value, keep heat value
	TAX
	PLA
	CLC
	ADC identity, X
	STA object+1, Y

+continue:
	JMP applyActionPointCost																											; tail chain
