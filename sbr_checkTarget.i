
; list3+0			heat increase / decrease
; list3+1			Hit Probability
; list3+2			Damage value
; list3+3..9	Result messages / streams

; list3+12		target dial BCD digit 10
; list3+13		target dial BCD digit 01

; list3+20		target dial
; list3+21		damage sustained by attacker
; list3+22		attacker dail
; list3+22		close combat animation
; list3+23		close combat sound

; list3+30		sprite
; list3+31
; list3+32

; list3+40 .. 49 used in informative message



; -----------------------------------------
; the following subroutines are used to determine the visibility of a target

; - is the target within range (ranged)
; - is the line of sight unblocked (ranged)
; - is the grid pos in contact with only one hostile (charge)
; -----------------------------------------
checkTarget:
	LDY selectedAction					; retrieve selected action
	LDX actionList, Y
	CPX #aCHARGE								; if action is CHARGE
	BEQ +chargeChecks						; continue to charge checks

	CPX #aCOOLDOWN
	BNE +nextCheck
	RTS

+nextCheck:
	JSR checkRange							; --- check min / max distance for ranged attacks ---
	LDA actionMessage
	BEQ +nextCheck
	RTS

+nextCheck:
	CPX #aCLOSECOMBAT						; if action is CC
	BEQ +checksDone							; all checks are done

	LDA activeObjectGridPos
	JSR checkLineOfSight					;  check line of sight ---
	BCC +checksDone

	LDA activeObjectTypeAndNumber
	BMI +skipMarker							; if AI then skip

	LDA effects
	ORA #%00100000							; active block marker
	STA effects

+skipMarker:
	LDA #$85										; deny (b7) + no line of sight (b6-b0)
	STA actionMessage

-done:
	RTS

+chargeChecks:
	LDX cursorGridPos						; unblock target node first: to make sure findPath works
	LDA nodeMap, X							;
	AND #$7F										; unset blocked flag
	STA nodeMap, X

	; --------------------------
	; Call find path
	; --------------------------
	LDA cursorGridPos
	STA par1										; par1 = destination node
	LDA activeObjectStats+2			; movement stat
	ASL													; x 2
	STA par2										; par2 = # moves allowed
	INC par2										; one extra (specific to charge)
	LDA activeObjectGridPos			; A =  start node
	JSR findPath								; CALL: A* search path, may take more than 1 frame

	LDX cursorGridPos						; re-block target node
	LDA nodeMap, X							;
	ORA #$80										; reset blocked flag
	STA nodeMap, X

	LDA actionMessage
	BMI -done

+checksDone:
	LDY targetObjectIndex
	LDA object+1, Y
 	LSR
	LSR
	LSR
	STA list3+20														; target hit points
	JSR toBCD																; convert health points to BCD for display purposes
	LDA par2																; the tens
	STA list3+12
	LDA par3																; the ones
	STA list3+13

	JSR getStatsAddress											; set pointer1 to target type data

	LDA activeObjectGridPos
	JSR gridPosToScreenPos
	JSR angleToCursor												; detrmine the angle of attack
	CLC																			; to derive the appropriate defense value
	ADC #32																	; rotate by 45 degrees (32 radial)
	LSR
	LSR
	LSR
	LSR
	LSR
	TAY 																	; Y is the defending direction for the target
	LDA angleToTargetTable, Y
	SEC																		;
	LDX targetObjectIndex
	LDA object+0, X
	AND #$07															; target's facing direction
	SBC angleToTargetTable, Y							; subtract target's defending direction
	JSR absolute													; A absolute value
	TAX
	LDY defenseValueIndexTable, X					; set Y to correct type index for front, flank or rear def value

	LDA (pointer1), Y												; retrieve target's defense value
	STA debug
	EOR #$FF
	SEC
	ADC activeObjectStats+5									; - DEF + ACC
	STA list3+1															; store hit probability

	JSR toBCD																; convert to BCD for display purposes
	LDA par2
	CLC
	ADC #$40
	STA list3+31
	LDA par3
	CLC
	ADC #$40
	STA list3+32
	LDA #$51
	STA list3+30

	LDY selectedAction
	LDX actionList, Y							; 1 for weapon 1, 2 for weapon 2
	LDA activeObjectStats+3				; default weapon 1 (primary) damage
	CPX #aRANGED2									; unless the secondary weapon is selected
	BNE +continue
	LDA activeObjectStats+4				; weapon 2

+continue
	CPX #aCHARGE
	BNE +continue
	CLC
	ADC #$01											; add one damage if CHARGing

+continue:											; set inform message indicating expected damage
	STA list3+2
	LDA #$0F
	LDX #10

-loop:
	CPX list3+2										; damage
	BNE +store
	LDA #$3D

+store:
	STA list3+39, X
	DEX
	BNE -loop
	LDA #$14											; DAMG XXXXXXXX
	STA actionMessage

+return
	RTS

; -----------------------------------------
;
; -----------------------------------------
checkRange:
	; -- determine which weapon is selected ---
	LDA #%00010000									; default range for close combat (max 1, min 0)

	LDY selectedAction
	LDX actionList, Y								; 1 for weapon 1, 2 for weapon 2
	CPX #aCLOSECOMBAT
	BEQ +continue										; if true, stick with current value of A

	LDA activeObjectStats-1, X			; max range (b7-4) min range (b3-2)

+continue:
	STA locVar2
	LSR
	LSR
	LSR
	LSR										; max range
	CMP distanceToTarget
	BCS +checkMinRange
	LDA #$88							; deny (b7) + out of range (b6-b0)
	STA actionMessage
	RTS

+checkMinRange:
	LDA locVar2							; minimum range
	AND #$0F								; distance
	CMP distanceToTarget
	BEQ +done
	BCC +done
	LDA #$8C								; deny (b7) + target too close (b6-b0)
	STA actionMessage

+done:
	RTS


angleToTargetTable:
	.db 4, 4, 5, 6, 1, 1, 2, 3

defenseValueIndexTable:
	.db 5, 6, 6, 7, 6, 6
