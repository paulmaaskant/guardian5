; --------------------------
; calculate attack hit or miss and apply damage
; --------------------------
; IN list3+0, heat
; IN list3+1, hit probability
; IN list3+2, adjusted damage value
; IN list3+20, target hit points

calculateAttack:
	LDX targetObjectIndex						; remove one evasion point
	LDA object+4, X									; of target unit
	AND #%00000111									; unless target has no evasion points left
	BEQ +continue
	DEC object+4, X

+continue:
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
	LDA #0											; initialize result msg
	STA list6

	JSR random100								; random number in A between 0 and 99
	STA list3+5
	CLC
	SBC list3+1
	STA list3+4									; b7 1 = hit
	BMI +hit

	LDX #2											; miss msg
	LDA #1											; message prio
	JSR addToSortedList

	JMP applyActionPointCost		; RTS

	; --- hit, apply damage ---
+hit:
	LDX #1											; miss hit
	LDA #1											; message prio
	JSR addToSortedList

	LDA list3+24								; target current heat
	CLC
	ADC list3+13								; inflicted heat
	CMP #6
	BCC +notOverheat
	LDA #6											; heat cap

+notOverheat:
	TAX
	LDA list3+20								; target dial value
	SEC
	SBC list3+2									; damage value
	BEQ +destroyed
	BCC +destroyed
	ASL													; if not destroyed
	ASL													; write back new target dial value
	ASL
	CLC
	ADC identity, X							; set target's heat points
	LDY targetObjectIndex
	STA object+1, Y

	LDA list3+13								; heat inflicted is not 0
	BEQ +noHeat

	LDX #$82										; target heat modifier
	LDA #2											; message prio
	JSR addToSortedList

+noHeat:
	JMP applyActionPointCost		; RTS

+destroyed:
	LDX #$80										; destroy effect
	LDA #2											; message prio
	JSR addToSortedList

	LDX #5											; msg: target Unit destroyed
	LDA #3											; message prio
	JSR addToSortedList

+continue:
	JMP applyActionPointCost		; RTS
