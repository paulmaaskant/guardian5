; --------------------------
; calculate attack hit or miss and apply damage
; --------------------------
; IN list3+0, heat
; IN list3+1, hit probability
; IN list3+2, adjusted damage value
; IN list3+20, target hit points

calculateAttack:
	LDX targetObjectIndex				; remove one evasion point
	LDA object+7, X							; of target unit
	AND #%00000111							; unless target has no evasion points left
	BEQ +continue
	DEC object+7, X
	LDA #-1

+continue:
	STA list3+27								; to show evade modifier effect

	;LDY selectedAction
	;LDX actionList, Y

	LDA #0											; initialize order list result msg
	STA list6

	LDX #$85										; evade modifier
	LDA #1											; message prio
	JSR addToSortedList

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
	LDX #$84										; damage modifier
	LDA #0											; message prio
	JSR addToSortedList

	LDX #1											; msg hit
	LDA #1											; message prio
	JSR addToSortedList

	LDA list3+24								; target current heat
	CLC
	ADC list3+13								; inflicted heat
	CMP #4
	BCC +heatPointCeiling
	LDA #4											; heat ceiling

+heatPointCeiling:
	STA locVar5									; not used by 'addToSortedList' & 'getStatsAddress'
	LDA list3+20								; target dial value
	SEC
	SBC list3+2									; damage value
	BEQ +destroyed
	BCC +destroyed

	PHA
	LDY targetObjectIndex
	JSR getStatsAddress
	PLA

	LDY #2
	CMP (pointer1), Y
	BCS +notCritical

	PHA
	JSR random100
	LDY #3

-loop:
	CMP critDamageDistribution, Y
	BCS +applyCrit
	DEY
	BPL -loop
	BMI +noCrit

+applyCrit:
	LDX targetObjectIndex
	LDA object+6, X
	ORA critDamageFlag,Y
	STA object+6, X

	LDX critDamageMessage, Y
	LDA #2											; message prio
	JSR addToSortedList

+noCrit:
	PLA

+notCritical:
	ASL													; if not destroyed
	ASL													; write back new target dial value
	ASL
	CLC
	ADC locVar5									; set target's heat points
	LDY targetObjectIndex
	STA object+1, Y

	LDA list3+13								; heat inflicted is not 0
	BEQ +noHeat

	LDX #4											; critical damage inflicted
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

critDamageDistribution:
	.db 20				; between 20-39 -> heat
	.db 40				; between 40-59 -> damage
  .db 60				; between 60-79 -> accuracy
	.db 80				; between 80-99 -> movement
critDamageMessage:
	.db 4					; TARGET
	.db 11				; COOLING SYSTM | WEAPON DAMAGE | ACCURACY | MOBILITY
	.db 7					; MALFUNCTION   | REDUCED				| REDUCED	 | REDUCED
	.db 9
critDamageFlag:
	.db %00001000	; heat generation
	.db %00000100 ; damage reduced
	.db %00000010 ; accuracy reduced
	.db %00000001 ; movement reduced
