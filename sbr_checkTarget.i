
; list3+00				AP cost
; list3+01				hit Probability
; list3+02				damage value
; list3+03 .. 09	Result messages / streams
; list3+10    		ammo BCD digit tens
; list3+11				ammo BCD digit ones
; list3+12				target's hit points BCD digit 10
; list3+13				target's hit points BCD digit 01

; list3+20				target's hit points
; list3+21				damage sustained by attacker
; list3+22				attacker dail
; list3+22				close combat animation
; list3+23				close combat sound

; list3+30				sprite
; list3+31    		sprite
; list3+32				sprite

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
	LDY selectedAction								; retrieve selected action
	LDX actionList, Y
	LDA actionPropertiesTable, X
	STA locVar5

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
	LDA locVar5
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

	LDX selectedAction											; retrieve selected action
	LDA actionList, X
	CMP #aAIM																; is action target lock?
	BNE +continue
	LDA distanceToTarget
	CMP #10
	BCC +nextCheck
	LDA #8+128
	STA actionMessage
	RTS

+nextCheck:
	LDA targetObjectTypeAndNumber
	ORA #%10000000
	STA locVar1
	LDY activeObjectIndex
	LDA object+4, Y													; check if target is not already locked
	BPL +skip																; there is no target lock
	CMP locVar1
	BNE +skip
	LDA #38+128
	STA actionMessage
	RTS

+skip:
	LDA #3
	JMP setTargetToolTip

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
	LDA object+2, X
	BMI +shutdown
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

	LDY activeObjectIndex
	LDA object+4, Y													; target lock?
	BPL +continue														; no -> continue

	LDA targetObjectTypeAndNumber						; yes, is this the target?
	ORA #%10000000
	CMP object+4, Y
	BNE +continue														; no -> continue

	CLC
	LDA #10
	ADC list3+1
	STA list3+1
	BNE +continue

+shutdown:
	LDA #99
	STA list3+1

+continue:
	LDA list3+1
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

	JSR getSelectedWeaponTypeIndex
	BCS +notRanged
	LDA weaponType+1, Y									;
	AND #$0F
	BCC +continue

+notRanged:
	LDA #2												; close combat damage

+continue
	CPX #aCHARGE
	BNE +continue
	CLC
	ADC #$01											; add one damage if charging

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
	LDA #7
	JMP setTargetToolTip


angleToTargetTable:
	.db 4, 4, 5, 6, 1, 1, 2, 3

defenseValueIndexTable:
	.db 5, 6, 6, 7, 6, 6
