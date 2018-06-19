
; list3+00				AP cost
; list3+01				hit Probability
; list3+02				damage value
; list3+03 .. 09	Result messages / streams
; list3+10    		ammo BCD digit tens
; list3+11				ammo BCD digit ones
; list3+12				heat cost
; list3+13 				heat inflict
; list3+14 				evade points
; list3+15				action properties
; list3+16 				active unit heat damage
; list3+7					(b7) 0 rear attack, 1 frontal attack

; list3+20				target's hit points
; list3+21				damage sustained by attacker
; list3+22				attacker dail
; list3+22				close combat animation
; list3+23				close combat sound
; list3+24			  target's current heat points

; list3+30				sprite
; list3+31    		sprite
; list3+32				sprite
; list3+33				sprite
; list3+34    		sprite
; list3+35				sprite

; list3+40 .. 49 	placeholder values in STRING
;
;
;
;
;
;
; make sure target is valid
; - is the target within range (ranged)
; - is the line of sight unblocked (ranged)
; - is target within charge distance (charge)
; - is the action actually an attack (cooldown)
; -----------------------------------------
checkTarget:
;	LDX #63
;	LDA #0

;-loop:															; clear list 3
;	STA list3, X
;	DEX
;	BPL -loop

	LDY selectedAction								; retrieve selected action
	LDX actionList, Y
	LDA actionPropertiesTable, X
	STA list3+15

	AND #%00000100										; b2 - weapon 1 or 2
	BEQ +nextCheck

	JSR getSelectedWeaponTypeIndex
	LDA weaponType+3, Y
	AND #$0F
	BEQ +checkReload

	LDA activeObjectIndex
	CLC
	ADC identity, X
	TAX
	LDA object+5, X
	AND #$0F
	BNE +continue
	LDA #165																; "AUT OF AMMO" +128
	STA actionMessage
	RTS

+continue:
	JSR toBCD
	LDA par2
	STA list3+10
	LDA par3
	STA list3+11

+checkReload:
	LDY selectedAction								; retrieve selected action
	LDX actionList, Y
	LDA activeObjectStats-1, X				; CHECK for once per turn
	BPL +nextCheck
	LDA #$9F													; "RELOADING" +128
	STA actionMessage
	RTS

+nextCheck:
	LDA list3+15
	AND #%01000000							; b6 - range check?
	BEQ +nextCheck
	JSR checkRange							; check min / max distance for ranged attacks
	LDA actionMessage
	BEQ +nextCheck
	RTS													; deny -> done

+nextCheck:
	LDA list3+15									; action properties
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
	LDA list3+15									; action properties
	AND #%00010000							; b4 - charge distance check?
	BEQ +nextCheck

	LDX cursorGridPos						; first, unblock target node
	LDA nodeMap, X							; so that findPath() works
	AND #$7F										; unset blocked flag
	STA nodeMap, X

	LDA cursorGridPos
	STA par1										; IN par1 = destination node
	LDA activeObjectStats+2			; movement type | movement stat
	STA par3										; movement type | xxxx
	AND #$0F										; 0000 | move points
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

+nextCheck:
	LDY targetObjectIndex										; retrieve target's hit points and show in menu
	LDA object+1, Y
 	LSR
	LSR
	LSR
	STA list3+20														; target hit points

	LDA object+1, Y
	AND #%00000111
	STA list3+24

	LDX selectedAction											; retrieve selected action
	LDA actionList, X
	CMP #aMARKTARGET												; is action to mark target?
	BNE +continue
	LDA distanceToTarget
	CMP #10
	BCC +nextCheck
	LDA #8+128															; out of range
	STA actionMessage
	RTS

+nextCheck:
	LDY targetObjectIndex
	LDA object+4, Y													; check if target is not already locked
	AND #%01000000
	BEQ +skip
	LDA #38+128
	STA actionMessage
	RTS

+skip:
	LDA #3
	JMP setTargetToolTip										; RTS

+continue:
	TAX
	LDA actionPropertiesTable, X
	AND #%00001000														; b3 - calculate hit % and damage?
	BNE +continue
	RTS																				; done, no more checks

+continue:
	JSR directionToCursor
	TAX																				; store in X
	LDY targetObjectIndex
	LDA object+0, Y
	AND #%00000111														; defending unit direction
	SEC
	SBC identity, X
	JSR absolute
	CMP #2
	ROR list3+17															; set (b7) 0 rear attack 1 frontal attack
	BMI +continue
	LDA #16
	STA infoMessage


+continue:
	LDY targetObjectIndex											; check and adjust to hit % for evade
	LDA object+4, Y														; evade points?
	AND #$07																	; mask evade points
	TAX
	LDA activeObjectStats+5
	SEC
	SBC evadePointEffect, X
	STA list3+1
	LDA evadeSpriteMap1, X
	STA list3+33
	LDA evadeSpriteMap2, X
	STA list3+34
	LDA evadeSpriteMap3, X
	STA list3+35

	LDA list3+15														; attack properties
	AND #%00000010													; accuracy attack or piloting attack?
	BNE +pilotingAttack											; -> piloting
	LDA object+4, Y													; -> accuracy, check target lock
	AND #%01000000
	BEQ +continue
	CLC
	LDA #10
	ADC list3+1
	STA list3+1
	BNE +continue

+pilotingAttack:
	LDA activeObjectStats+4
	STA list3+1

+continue:
	LDA list3+17														; HIT % increased by 20
	BMI +continue														; for a REAR attack
	LDA list3+1
	CLC
	ADC #20
	STA list3+1

+continue:																; HIT % determined
	LDA list3+1
	CMP #96
	BCC +continue
	LDA #95

+continue:
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

	JSR getSelectedWeaponTypeIndex					; determine damage
	BCS +notRanged
	LDA weaponType+1, Y											; weapon damage
	AND #$0F
	PHA
	LDX weaponType+5, Y											; weapon heat inflict

	LDY targetObjectIndex
	LDA object+4, Y													; is target braced for impact?
	ASL																			; set carry flag
	PLA
	BCC +continue														; carry 0 -> target not BRACED
	LDY list3+17
	BPL +continue														; rear arc attack -> target BRACE ignored
	LSR																			; half damage round up
	ADC #0
	LDY #18					;BUG x is reserved!
	STY infoMessage ;BUG
	BCC +continue

+notRanged:
	LDA activeObjectStats+7									; close combat damage ignores BRACE
	LDX #0																	; no heat inflicted

+continue:																; set inform message indicating expected damage
	STX list3+13
	STA list3+2															; DMG

	LDA #$14																; DAMG X
	STA actionMessage

+return:
	LDA #15
	JMP setTargetToolTip


evadeSpriteMap1:
	.hex 4C 4B 4A 4A 4A 4A

evadeSpriteMap2:
	.hex 4C 4C 4C 4B 4A 4A

evadeSpriteMap3:
	.hex 4D 4D 4D 4D 4D 53

evadePointEffect:
	.db 0, 10, 20, 30, 40, 40, 40
