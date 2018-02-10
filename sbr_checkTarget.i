
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
;
; make sure target is valid
; - is the target within range (ranged)
; - is the line of sight unblocked (ranged)
; - is target within charge distance (charge)
; - is the action actually an attack (cooldown)
; -----------------------------------------
checkTarget:
	LDY selectedAction					; retrieve selected action
	LDX actionList, Y
	LDA actionPropertiesTable, X
	STA locVar5

	AND #%01000000							; b6 - range check?
	BEQ +nextCheck
	JSR checkRange							; check min / max distance for ranged attacks
	LDA actionMessage
	BEQ +nextCheck
	RTS													; deny -> done

+nextCheck:
	LDA locVar5									; action properties
	AND #%00100000							; b5 - los check?
	BEQ +nextCheck

	LDA activeObjectGridPos			; set parameter A
	JSR checkLineOfSight				; check line of sight
	BCC +nextCheck

	LDA activeObjectIndexAndPilot
	BMI +noMarker								; active unit is player controlled then
	LDA effects
	ORA #%00100000							; show the blocking node marker
	STA effects

+noMarker:
	LDA #$85										; deny (b7) + no line of sight (b6-b0)
	STA actionMessage
	RTS

+nextCheck:
	LDA locVar5									; action properties
	AND #%00010000							; b4 - charge distance check?
	BEQ +nextCheck

	LDX cursorGridPos						; first, unblock target node
	LDA nodeMap, X							; so that findPath() works
	AND #$7F										; unset blocked flag
	STA nodeMap, X

	LDA cursorGridPos
	STA par1										; IN par1 = destination node
	LDA activeObjectStats+2			; movement stat
	ASL													; move x 2
	STA par2										; IN par2 = # moves allowed
	INC par2										; one extra move point to account for target node itself
	LDA activeObjectGridPos			; IN A = start node
	JSR findPath								; CALL: A* search path, may take more than 1 frame

	LDX cursorGridPos						; re-block target node
	LDA nodeMap, X							;
	ORA #$80										; reset blocked flag
	STA nodeMap, X

	LDA actionMessage
	BPL +nextCheck
	RTS

+nextCheck
	LDY targetObjectIndex										; retrieve target's hit points and show in menu
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

	LDX selectedAction											; retrieve selected action
	LDA actionList, X
	CMP #aAIM
	BNE +continue
	;LDA #29																; "INC ACCURACY"
	;STA actionMessage
	RTS

+continue:
	TAX
	LDA actionPropertiesTable, X
	AND #%00001000													; b3 - calculate hit % and damage?
	BNE +continue
	RTS																			; done, no more checks

+continue:
	JSR getStatsAddress											; set pointer1 to target type data

	LDA activeObjectGridPos
	JSR gridPosToScreenPos
	JSR angleToCursor												; determine the angle of attack
	CLC																			; to derive the appropriate defense value
	ADC #32																	; rotate by 45 degrees (32 radial)
	LSR
	LSR
	LSR
	LSR
	LSR
	TAY 																		; Y is the defending direction for the target
	LDA angleToTargetTable, Y
	SEC																			;
	LDX targetObjectIndex
	LDA object+0, X
	AND #$07																; target's facing direction
	SBC angleToTargetTable, Y								; subtract target's defending direction
	JSR absolute														; A absolute value
	TAX
	LDY defenseValueIndexTable, X						; set Y to correct type index for front, flank or rear def value

	LDA (pointer1), Y												; retrieve target's defense value
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

+return:
	RTS

angleToTargetTable:
	.db 4, 4, 5, 6, 1, 1, 2, 3

defenseValueIndexTable:
	.db 5, 6, 6, 7, 6, 6
