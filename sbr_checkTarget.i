
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



; -----------------------------------------
; the following subroutines are used to determine the visibility of a target

; - is the target within the firing arc (ranged, close combat)
; - is the target within range (ranged)
; - is the line of sight unblocked (ranged)
; - is the grid pos in contact with only one hostile (charge)
; -----------------------------------------
checkTarget:
	LDA #$00																																			; set charge damage to 0
	STA list3+21

	; --- retrieve action ---
	LDY selectedAction
	LDX actionList, Y
	CPX #aCHARGE																																	; if action is CHARGE
	BEQ +chargeChecks																															; continue to charge checks

	; --- check arc ---																														; otherwise, check field of vision
	JSR checkFiringArc																														; note: leaves X intact
	BCS +nextCheck
	LDA #$8A																																			; deny (b7) + outside of arc (b6-b0)
	STA actionMessage
	RTS

+nextCheck:
	; --- check min / max distance for ranged attacks ---
	JSR checkRange							; destroys X
	LDA actionMessage
	BEQ +nextCheck
	RTS

+nextCheck:
	CPX #aCLOSECOMBAT						; if action is CC
	BEQ +checksDone							; all checks are done

	; --- check line of sight ---
	LDA activeObjectGridPos
	JSR checkLineOfSight
	BCC +checksDone

	LDA activeObjectTypeAndNumber
	BMI +skipMarker							; if AI then skip

	LDA effects
	ORA #%00100000							; active block marker
	STA effects

+skipMarker:
	LDA #$85										; deny (b7) + no line of sight (b6-b0)
	STA actionMessage
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
	BMI +return

	; TODO
	; condition for charge: adjacent to exactly 1 hostile
	; JSR isChargePossible

	LDA #$01
	STA list3+21																																	; 1 charge damage sustained

+checksDone:
	LDA activeObjectStats+5																												; calculate hit chance
	AND #%00111000																																; first get attacker accuracy
	LSR
	LSR
	LSR
	ADC #$05																																			; CLC guaranteed
	PHA 																																					; ACCURACY on stack

	LDY targetObjectIndex
	LDA object+0, Y

	JSR getStatsAddress
	STA list3+20																																	; target health points
	JSR toBCD																																			; convert health points to BCD for display purposes
	LDA par2																																			; the tens
	STA list3+12
	LDA par3																																			; the ones
	STA list3+13
	PLA
	TAX														; move ACCURACY to X
	LDA (pointer1), Y							; retrieve target's defence
	AND #$07
	CLC
	ADC #$0F											; target's DEFENSE
	SEC
	SBC identity, X								; minus active unit's ACCURACY
	TAY
	LDA hitProbability, Y					; look up the hit probability
	STA list3+1										; store hit probability
	JSR toBCD											; convert to BCD for display purposes
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

+continue:
	STA list3+2										; damage
	LDA #$14											; STR4 RNG 2-8
	STA actionMessage

+return
	RTS

; -----------------------------------------
;
; -----------------------------------------
checkRange:
	; -- determine which weapon is selected ---
	LDA #%00010000									; default: close combat (max 1, min 0)

	LDY selectedAction
	LDX actionList, Y								; 1 for weapon 1, 2 for weapon 2
	CPX #aCLOSECOMBAT
	BEQ +continue										; if true, stick with current value of A
	LDA activeObjectStats-1, X			; max range (b7-4) min range (b3-2)

+continue:
	LSR
	LSR
	STA locVar2
	INC locVar2											; minimum range
	LSR
	LSR
	CMP distanceToTarget
	BCS +checkMinRange
	LDA #$88							; deny (b7) + out of range (b6-b0)
	STA actionMessage
	RTS

+checkMinRange:
	LDA locVar2							; minimum distance
	AND #$03								; distance
	CMP distanceToTarget
	BEQ +done
	BCC +done
	LDA #$8C								; deny (b7) + target too close (b6-b0)
	STA actionMessage
+done:
	RTS
; -----------------------------------------
; is target in firing arc?
;
; - firing arc always spans 120 degrees
; - facing directions always are aligned with the X, Y & Z axis
;
; algorithm
; using the firing node as the origin, the target is within the
; firing arc if it is within the sextant left or right of the axis
; that aligns with the facing direction
;
; to determine this locVar5 is created first:
;
; bbbbbbbb
; ||||||||
; |||||||+ 1: Z target <= Z source
; ||||||+- 1: Z target >= Z source
; |||||+-- 1: Y target <= Y source
; ||||+--- 1: Y target >= Y source
; |||+---- 1: X target <= X source
; ||+----- 1: X target >= X source
; ++------ not used
;
; -----------------------------------------
checkFiringArc:
	LDA cursorGridPos
	LSR
	LSR
	LSR
	LSR
	STA locVar2									; target grid Y
	LDA cursorGridPos
	AND #$0F										; x mask
	STA locVar1									; target grid X

	LDA activeObjectGridPos
	LSR
	LSR
	LSR
	LSR
	STA locVar4									; firing unit grid Y
	LDA activeObjectGridPos
	AND #$0F										; x mask
	STA locVar3									; firing unit grid X

	LDA locVar1
	CMP locVar3
	ROL locVar5

	LDA locVar3
	CMP locVar1
	ROL locVar5

	LDA locVar2
	CMP locVar4
	ROL locVar5

	LDA locVar4
	CMP locVar2
	ROL locVar5

	LDA locVar1
	CLC
	ADC locVar2
	STA locVar1

	LDA locVar3
	CLC
	ADC locVar4
	STA locVar3

	LDA locVar1
	CMP locVar3
	ROL locVar5

	LDA locVar3
	CMP locVar1
	ROL locVar5

	LDY activeObjectIndex
	LDA object, Y
	AND #$07
	TAY
	LDA fireArc-1, Y	;
	AND locVar5			;
	CMP fireArc-1, Y
	BEQ +
	CLC								; clear if not in firing arc
+	RTS

fireArc:
	.db #%00011000		;1 Xt<, Yt>
	.db #%00001010		;2 Yt>, Zt>
	.db #%00100010		;3 Xt>, Zt>
	.db #%00100100		;4 Yt<, Xt>
	.db #%00000101		;5 Yt<, Zt<
	.db #%00010001		;6 Xt<, Zt<
