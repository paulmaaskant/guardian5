; --------------------------------------------------
; game state 1D: initialize close combat
; --------------------------------------------------
state_closeCombatAnimation:
	LDA #0
	STA actionCounter
	STA currentEffects+18
	TAX

	LDA #5													      ; Animation 5 = hit (explosion)
	STA list3+22
	LDA #17
	STA list3+23

	LDA list3+4
  BMI +continue

	LDA #8															  ; Animation 8 = miss
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
  ;STA nodeMap, Y
  ;TAX
  JSR setTile

	LDA cursorGridPos
	JSR gridPosToScreenPos

	LDA currentObjectXPos
	STA currentEffects+6

	LDA currentObjectYPos
	STA currentEffects+12

	LDA #0
	STA currentEffects+18
	STA currentEffects+24
	STA effects

	LDA list3+22
	STA currentEffects+0

  LDA #$18
  JMP replaceState

; --------------------------------------------------
; game state 18: close combat animation
; --------------------------------------------------
state_resolveCloseCombat:
	LDA actionCounter
	AND #%00011111
	CMP #%00010000
	BCC +continue
	BEQ +invert

	PHA
	LDY list3+23								; sound
	JSR soundLoad
	LDA #1
	STA effects
	PLA

+invert:
	EOR #%00011111

+continue:
	TAX

+continue:
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
															; base tile is assumed to be tile 0
  AND #%00000111							; add direction bits
  ORA #%11000000							; add blocked for movement and los

  LDY activeObjectGridPos			; Y is parameter for setTile
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

		.db 0										; X 0
		.db 18									; X +18
		.db 18									; X +18
		.db 0										; X 0
		.db -18									; X -18
		.db -18									; X -18

		.db #$F4									; Y -12
		.db #$FA									; Y -6
		.db #$06									; Y +6
		.db #$0C									; Y +12
		.db #$06									; Y +6
		.db #$FA									; Y -6
