
; list3+00				AP cost
; list3+01				hit Probability
; list3+02				damage value
; list3+03-09			reserved

; list3+10    		ammo BCD digit tens
; list3+11				ammo BCD digit ones
; list3+12				heat cost
; list3+13 				heat inflict
; list3+14 				evade points
; list3+15				action properties
; list3+16 				active unit heat damage
; list3+17			  (b7) 0 rear attack, 1 frontal attack
; list3+18        range category letter C, S, M, L
; list3+19        range category 0, 1, 2, 3

; list3+20				target's hit points
; list3+21				damage sustained by attacker
; list3+22				attacker dail
; list3+22				close combat animation
; list3+23				close combat sound
; list3+24			  target's current heat points
; list3+25				selected action
; list3+26				available move points
; list3+27				target evade modifier

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
	LDY selectedAction					; retrieve selected action
	LDX actionList, Y
	STX list3+25
	LDA actionPropertiesTable, X
	STA list3+15								; action properties
	LDA #dash
	STA list3+18								; default the range category letter to '-'

	; ---------------------------------------------------------------------------
	; no friendly fire
	; ---------------------------------------------------------------------------
+nextCheck:
	LDA activeObjectIndexAndPilot			; if active and target object have same value for bit7
	EOR targetObjectTypeAndNumber			; then this sets b7 to 0
	ASL
	BCS +nextCheck
	LDA #55+128												; friendly unit
	STA actionMessage
	RTS

	; ---------------------------------------------------------------------------
	; 10 hex is hardcoded max range
	; ---------------------------------------------------------------------------
+nextCheck:
	LDA distanceToTarget
	CMP #10
	BCC +nextCheck
	LDA #8+128									; out of range
	STA actionMessage
	RTS

	; ---------------------------------------------------------------------------
	; determine range category, used to determine damage value later
	; ---------------------------------------------------------------------------
+nextCheck:
	TAX													; set range category based on distance to target
	LDA rangeCategoryMap-1, X
	STA list3+19
	TAX
	LDA rangeCategoryLetter, X
	STA list3+18

	LDA list3+15							  ; action properties
	BIT bit4										; charge or dfa
	BEQ +nextCheck

	LDX 0
	STX list3+19								; use close combat range category

	; ---------------------------------------------------------------------------
	; Check line of sight for ranged attacks
	; ---------------------------------------------------------------------------
+nextCheck
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

	; ---------------------------------------------------------------------------
	; check path availability for charge attack
	; ---------------------------------------------------------------------------
+nextCheck:
	LDA list3+15								; action properties
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

	; ---------------------------------------------------------------------------
	; retrieve target unit information
	; ---------------------------------------------------------------------------
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

	; ---------------------------------------------------------------------------
	; checks that are specific to the MARK TARGET action
	; ---------------------------------------------------------------------------
	LDX list3+25
	CPX #aMARKTARGET												; is action to mark target?
	BNE +continue
	LDY targetObjectIndex
	LDA object+4, Y													; check if target is not already locked
	AND #%01000000
	BEQ +setMarkTargetToolTip
	LDA #38+128
	STA actionMessage
	RTS

+setMarkTargetToolTip:
	LDA #3																		; mark target tool tip
	JMP setTargetToolTip											; RTS


	; ---------------------------------------------------------------------------
	; exit point for actions that do not require damage calculation
	; ---------------------------------------------------------------------------
+continue:
	LDA actionPropertiesTable, X
	AND #%00001000														; b3 - calculate hit % and damage?
	BNE +continue
	RTS																				; done, no more checks

	; ---------------------------------------------------------------------------
	; determine attack direction (to detect a rear attack)
	; ---------------------------------------------------------------------------
+continue:																	; determine if attack is in rear angle
	JSR directionToCursor
	TAX																				; store in X
	LDY targetObjectIndex
	LDA object+0, Y
	AND #%00000111														; defending unit direction
	SEC
	SBC identity, X
	CMP #1
	ROR list3+17															; set (b7) 0 rear attack 1 frontal attack
	BMI +continue
	LDA #16+128																; REAR ATTACK (blinking)
	STA infoMessage

	; ---------------------------------------------------------------------------
	; determine to hit %
	; ---------------------------------------------------------------------------
+continue:
	LDA activeObjectStats+5										; pilot skill
	LDY list3+19															; range category
	CLC
	ADC rangeCategoryModifier, Y							; adjust for range
	STA locVar1

	LDY targetObjectIndex											; adjust for target unit movement
	LDA object+4, Y														;
	AND #$07																	; mask evade points
	PHA																				; used to for the evade sprite map
	CLC
	ADC locVar1																;

	LDX list3+25
	CPX #aATTACK
	BNE +continue															; if action is ranged ATTACK
	ADC activeObjectStats+4										; then adjust for attacking unit heat level

+continue:
	LDY activeObjectStats+3										; adjust for attacking unit movement
	BMI +jumped
	BNE +groundMove
	ADC #-2																		; -1 (actually -2 +1) if attacking unit is stationary
	CLC

+jumped:
	ADC #1																		; +1 if attacking unit jumped

+groundMove:
	; adjust for action
	LDX list3+25
	CPX #aCHARGE
	BNE +continue
	CLC
	ADC #1

+continue:
	TAY
	CPY #12
	BCC +continue
	LDY #12

+continue:
	LDA probabilityDistribution, Y
	STA list3+1

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

	PLA
	TAX

	LDA evadeSpriteMap1, X
	STA list3+33
	LDA evadeSpriteMap2, X
	STA list3+34
	LDA evadeSpriteMap3, X
	STA list3+35

	; ---------------------------------------------------------------------------
	; determine applicable damage in case of hit
	; ---------------------------------------------------------------------------
	LDY activeObjectIndex
	LDX list3+19														; range category
	JSR getOverallDamageValue
	STA list3+2															; overall damage (base + EQ1 + EQ2)

	LDX #0																	;
	STX list3+13														; expected inflicted HEAT


	LDY list3+17														; rear arc attack -> ignore brace and add 1
	BMI +continue
	INC list3+2
	BNE +ignoreBrace

	; ---------------------------------------------------------------------------
	; if target unit is bracing, reduce damage by one
	; ---------------------------------------------------------------------------
+continue:
	LDY targetObjectIndex
	LDA object+4, Y													; is target braced for impact?
	ASL																			; set carry flag = brace indicator
	BCC +continue														; not braced -> FULL DAMAGE

	DEC list3+2															; reduce damage by 1

	LDA #18+128															; msg TARGET BRACED (blink)
	STA infoMessage

	; ---------------------------------------------------------------------------
	; if attack is CHARGE, then add 1 damage for each hex beyond the 3rd
	; ---------------------------------------------------------------------------
+ignoreBrace:
+continue:
	LDX list3+25
	CPX #aCHARGE
	BNE +continue
	LDA distanceToTarget
	CMP #3
	BCC +continue
	SBC #3
	CLC
	ADC list3+2
	STA list3+2


+continue:
	LDA list3+2															; at least 1 damage
	BMI +floor
	BNE +continue

+floor:
	LDA #1
	STA list3+2

+continue:
	LDA #$14																; string "X DMG"
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

rangeCategoryMap:
	.db 0, 1, 1, 2, 2, 2, 3, 3 ,3

rangeCategoryLetter:
	.db C, S, M, L

rangeCategoryModifier:
	.db 0, 0, 2, 4
