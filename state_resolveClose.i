; --------------------------------------------------
; game state 17: initialize close combat
; --------------------------------------------------
state_initializeCloseCombat:
	LDA #4										; clear from list3+4
	LDX #9										; up to and including list3+9
	JSR clearList3

	JSR calculateAttack

  JSR pullAndBuildStateStack
  .db $06							; 6 items
  .db $3A, 1					; switch CHR bank 1 to 1
  .db $1D 						; close combat animation
  .db $3A, 0					; switch CHR bank 1 back to 0
  .db $16							; show results
  ; built in RTS

; --------------------------------------------------
; game state 1D: initialize close combat
; --------------------------------------------------
state_closeCombatAnimation:
	LDA #$00
	STA actionCounter
	STA currentEffects+18
	TAX

	LDA #5													      ;Animation 5 = hit (explosion)
	STA list3+22
	LDA #17
	STA list3+23
	LDA list3+3													  ; value: (01) for hit, (02) for miss
	CMP #$01
	BEQ +continue
	LDA #8															  ; Animation 8 = miss (shield)
	STA list3+22
	LDA #$1B
	STA list3+23

+continue:
	LDA activeObjectGridPos              ; determine in which direction unit
	SEC                                  ; is attacking
	SBC cursorGridPos

-loop:
	CMP closeCombatDirection, X
	BEQ +setDelta
	INX
	BNE -loop

+setDelta:
	LDA closeCombatDirection+12, X       ; direction is X
	STA list1+1													 ; Y offset

	LDA closeCombatDirection+6, X
	STA list1+0													 ; X offset

	LDY activeObjectIndex
	LDA object, Y
	EOR #%00001000											; set object's move bit (b3) ON
	STA object, Y

  LDY activeObjectGridPos			        ; unblock position in nodeMap
  LDA #0											        ; FIX: show original meta tile
  STA nodeMap, Y
  TAX
  JSR setTile

	LDA activeObjectGridPos
	JSR gridPosToScreenPos

	LDA currentObjectXPos
	CLC
	ADC list1+0
	STA currentEffects+6
	LDA currentObjectYPos
	ADC list1+1
	SBC #$08
	STA currentEffects+12
	LDA #$00
	STA currentEffects+18
	STA currentEffects+24

	LDA list3+22
	STA currentEffects+0

  LDA #$18
  JMP replaceState

; --------------------------------------------------
; game state 18: close combat animation
; --------------------------------------------------
state_resolveClose:
	LDA actionCounter
	AND #%00001111
	TAX

	LDY #$00
	LDA actionCounter
	AND #%00010000
	BEQ +continue
	SEC
	SBC identity, X
	BIT rightNyble
	BNE +noSound
	PHA

	LDY list3+23								; sound
	JSR soundLoad

	PLA

+noSound:
	TAX
	LDY #$01

+continue:
	STY effects
	LDA list1+0
	JSR interpolate
	STA actionList+1
	LDA list1+1
	JSR interpolate
	STA actionList+2					; Y
	INC actionCounter
	LDA actionCounter
	CMP #$60
	BEQ +animationComplete
	RTS

+animationComplete:
  LDY activeObjectIndex
  LDA object+0, Y
  EOR #%00001000							; object move bit (b3) OFF
  STA object+0, Y
  AND #%00000111							; get direction
  LDY activeObjectGridPos			; block final position, move (b7) and sight (b6)
  ORA #%11000000							; blocked for movement and los
  STA nodeMap, Y
  AND #%00000111
  TAX
  JSR setTile
	LDA #0
	STA effects

	JMP pullState                        ; next state

interpolate:
	CLC
	BPL +pos
	EOR #$FF
	ADC #$01
	SEC

+pos:
	PHP													; push sign (in carry)
	JSR multiply
	LDA #$10
	JSR divide
	LDA par4

	PLP													; pull sign (in carry)
	BCC +pos
	EOR #$FF
	CLC
	ADC #$01

+pos:
	RTS

	closeCombatDirection:
		.db #$F1									;up
		.db #$F0									;up right
		.db #$FF									;dw right
		.db #$0F									;dw
		.db #$10									;dw left
		.db #$01									;up left

		.db #$00									; X 0
		.db #$12									; X +18
		.db #$12									; X +18
		.db #$00									; X 0
		.db #$EE									; X -18
		.db #$EE									; X -18

		.db #$F4									; Y -12
		.db #$FA									; Y -6
		.db #$06									; Y +6
		.db #$0C									; Y +12
		.db #$06									; Y +6
		.db #$FA									; Y -6
