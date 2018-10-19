; ------------------------------------------
; gameState 16: shows the results of an action in the action menu, waiting for user confirmation
; ------------------------------------------
;
; list1+0..9	Reserved for Run Dialog state
; list2+0..9  Reserved for lightflash
;
; list3+0		Action point cost / gain
; list3+1		Hit Probability
; list3+2		Damage value
; list3+3		stream 1
; list3+4		stream 2
; list3+5		stream 3
; list3+6..9 reserve for streams
;
; list3+10		Hit probability sprite x_
; list3+11		Hit probability sprite _x
; list3+20		target click value
;
;
;
;
;

state_showResults:
	LDX list6
	BNE +continue
	JMP pullState

+continue:
	DEC list6
	LDA list6, X
	BPL +startDialog			;

	CMP #$81
	BEQ +startGauge

	CMP #$82
	BEQ +inflictHeat

	CMP #$83
	BEQ +sustainHeatDamage

	CMP #$84
	BEQ +targetDamage

	CMP #$85
	BEQ +reduceEvade



	JSR buildStateStack			; -> opcode $80: unit explosion & flash
	.db 5										; # stack items
	.db $2C									; implode & explode & remove object
	.db $0D, 2							; change brightness 2: flash out
	.db $0D, 3							; change brightness 3: flash out
	; built in RTS

+sustainHeatDamage:			; opcode $83: active unit sustains heat damage
	LDA #$4F
	JMP pushState

+inflictHeat:						; opcode $82: inflicted heat modifier
	JSR buildStateStack
	.db 2
	.db $58, 3						;

+targetDamage:					; opcode $84: display damage modifier on target
	JSR buildStateStack
	.db 2
	.db $58, 4						;

+reduceEvade:						; opcode $85: display evasion modifier on target
	JSR buildStateStack
	.db 2
	.db $58, 1						;

+startGauge:
	LDA #$42							; opcode $81: show gauge update
	JMP pushState

+startDialog:
	TAY																												;
	LDA streamHi-1, Y
	STA bytePointer+0
	LDA streamLo-1, Y
	STA bytePointer+1
	LDX #9

-loop:
	LDA state_16_stream, X
	STA list1, X
	DEX
	BPL -loop

	LDA #$09
	JMP pushState

streamHi:
	.db #< resultTargetHit									; 1
	.db #< resultTargetMiss									; 2
	.db #< resultTargetOffline							; 3
	.db #< resultEngineCriticalDamage							; 4
	.db #< resultUnitDestroyed							; 5
	.db #< resultChargeDamageSustained			; 6
	.db #< resultTargetingCriticalDamage		; 7
	.db #< resultHeatDamageSustained				; 8
	.db #< resultMobilityCriticalDamage						; 9
	.db #< resultUnitRestart								; A
	.db #< resultWeaponsCriticalDamage						; B

streamLo:
	.db #> resultTargetHit
	.db #> resultTargetMiss
	.db #> resultTargetOffline
	.db #> resultEngineCriticalDamage
	.db #> resultUnitDestroyed
	.db #> resultChargeDamageSustained
	.db #> resultTargetingCriticalDamage
	.db #> resultHeatDamageSustained
	.db #> resultMobilityCriticalDamage
	.db #> resultUnitRestart
	.db #> resultWeaponsCriticalDamage

state_16_stream:
	.db $24, $4A, $24, $4A, 10, 23, 0, 0, 3, 0
