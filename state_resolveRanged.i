; -----------------------------------------------
; game state 12: start ranged attack (laser)
; -----------------------------------------------

; list1+0 = delta X
; list1+1 (b7) = X delta sign
; list1+2 = delta Y
; list1+3 (b7) = Y delta sign
; list1+4 delta X^2 hi
; list1+5 delta X^2 lo
; list1+6 (b7) delta Y > delta X
;
; list1+7 = angle
; list1+8 = radius


state_initializeRanged:
	LDY #sGunFire
	JSR soundLoad

	JSR calculateAttack

	JSR clearCurrentEffects

	; --------------------------------------------------
	; Prepare the menu
	; --------------------------------------------------
	JSR clearActionMenu					; clear the menu

	LDA #$0F 										; hide menu indicators
	STA menuIndicator+0
	STA menuIndicator+1

	LDA menuFlags								; switch on blinking for line 1
	ORA menuFlag_line1					; set flag
	STA menuFlags

	LDX #$00										; write to menu
	LDY #$06										; "opening fire"
	JSR writeToActionMenu

	LDA events									; refresh menu
	ORA event_refreshStatusBar	; set flag
	STA events

	; --------------------------------------------------
	; Calculate radius and angle
	; --------------------------------------------------
	LDA activeObjectGridPos			; attacking unit position
	JSR gridPosToScreenPos			; attacking unit screen coordinates

	LDA currentObjectXPos				;
	STA list1+0									;
	LDA currentObjectXScreen		;
	STA list1+1									;
	LDA currentObjectYPos				;
	STA list1+2									;
	LDA currentObjectYScreen		;
	STA list1+3									;

	LDA cursorGridPos						; target unit position
	JSR gridPosToScreenPos			; target unit screen coordinates

	LDA list1+0									; determine signed difference
	SEC
	SBC currentObjectXPos
	STA list1+0
	LDA list1+1
	SBC currentObjectXScreen
	STA list1+1									; store the sign (b7) for the X delta

	BPL +continue								; now store the absolute value
	LDA list1+0									; for the X delta
	EOR #$FF										; assuming it will never be
	CLC
	ADC #$01
	STA list1+0									; more than 255

+continue:
	LDA list1+2
	SEC
	SBC currentObjectYPos
	STA list1+2
	LDA list1+3
	SBC currentObjectYScreen
	STA list1+3									; store the sign (b7) for the Y delta

	BPL +continue								; now store the absolute value
	LDA list1+2									; for the Y delta
	EOR #$FF										; assuming it will never be
	CLC
	ADC #$01
	STA list1+2									; more than 255

+continue:
	LDA list1+0									; delta X in A
	TAX													; delta X in X
	JSR multiply
	LDA par1										; dX^2 HI
	STA list1+4
	LDA par2										; dX^2 LO
	STA list1+5

	LDA list1+2									; delta Y
	TAX
	JSR multiply

	CLC													; dY^2 + dX^2
	LDA par2										;
	ADC list1+5									;
	STA par2
	LDA par1
	ADC list1+4
	STA par1

	JSR squareRoot
	STA list1+7									; sqrt(dY^2 + dX^2) = radius !

	; sin(angle) = delta X or Y / radius

	LDA #0
	STA par2

	LDA list1+0									; compare dX
	CMP list1+2									; to dY, and go with the smallest
	BCC +continue
	ROR list1+6									; set B7 if dY >= dX
	LDA list1+2

+continue:
	STA par1										; min(dX, dY)

	LDA list1+7
	JSR divide

	LDX #0											;
	LDA par4										; = (min(dX, dY) / radius) * 256
	STA list1+8									; sin(angle)
	BEQ +continue

-loop:
	LDA sinTable, X							; inverse sin function
	CMP list1+8
	INX
	BCC -loop

+continue:
	TXA
	BIT list1+6
	BPL +continue								; if dY >= dX then
	EOR #%00111111							; angle =  64 - angle
	CLC
	ADC #1

+continue:
	BIT list1+3
	BPL +continue								; if dY < 0 then
	EOR #%01111111							; angle = 128 - angle
	CLC
	ADC #1

+continue:
	BIT list1+1
	BMI +continue								; if dX < 0 then
	EOR #$FF										; angle = 256 - angle
	CLC
	ADC #1

+continue:
	ADC #-1											; offset for the changing angle in the gunfire
	STA list1+8

	LDA #0											; init
	STA list1+0									; frame counter
	STA list1+1									; effect counter
	STA par1										; divide input parameter

	LDA list1+7									; radius
	STA par2										; divide input parameter

	LDA #3											; divide input parameter
	JSR divide
	LDA par4										; radius / 3
	STA list1+3									;

	LDA #$04										; switch on controlled effects
	STA effects									;

	LDA list3+3
	CMP #$02
	BNE +continue

	LDA list1+7
	ADC #20
	STA list1+7

	LDA list1+8
	ADC #5
	STA list1+8

+continue:
	JSR pullAndBuildStateStack
	.db #3											; 3 items
	.db $2B
	.db $13 										; resolve ranged
	.db $16											; show results
	; built in RTS


; -----------------------------------------------
; game state 13: resolve ranged attack (machine gun)
; -----------------------------------------------
;
; list1+00, frame counter
; list1+01, frame counter up to radius
; list1+02, loop control
; list1+03, radius / 3
; list1+04, incremental radius
; list1+05, animation #

; list1+07, radius
; list1+08, angle
;
; list1+19, damage stat
; -----------------------------------------------
state_resolveRanged:
	LDA list1+0
	AND #$F8
	BEQ +continue												; skip the first 8 frames

	LSR																	; show filling gauge while firing
	LSR
	LSR
	CLC
	ADC #$0C
	TAX
	LDY #$11
	JSR writeToActionMenu								; write

	LDA events													; refresh menu
	ORA event_refreshStatusBar					; set flag
	STA events

+continue:
	LDA list1+0													; lightning effect
	AND #$03
	BNE +continue

	LDA list1+0													; toggle every 8 frames
	AND #$04														; between value $00 and value $10
	ASL
	ASL
	JSR updatePalette

+continue:
	; ------------------------------------------------
	; sprite updates
	; ------------------------------------------------
	LDA activeObjectGridPos
	JSR gridPosToScreenPos

	LDA currentObjectYPos
	CLC
	ADC #-10
	STA currentObjectYPos

	LDA #3
	STA list1+2

	LDA #6
	STA list1+5

	LDA list1+1
	STA list1+4
	TAX														; radius

-loop:
	LDA list1+8										; angle
	JSR getCircleCoordinates
	TXA
	CLC
	LDX list1+2
	ADC currentObjectXPos
	STA currentEffects+6, X
	TYA
	CLC
	ADC currentObjectYPos
	STA currentEffects+12, X

	LDA list1+5												; waypoint animation
	STA currentEffects+0, X

	LDA list1+4
	CLC
	ADC list1+3

	CMP list1+7
	BCC +continue
	SEC
	SBC list1+7

+continue:
	STA list1+4
	TAX

	DEC list1+2
	BNE +continue

	LDX list1+7
	LDA #5
	STA list1+5

+continue:
	LDA list1+2
	BPL -loop




	LDA list1+0
	CMP #128								; runs for 128 frames
	BEQ +done
	CLC											; not really ncessary as long as max is 128 frames
	ADC #1
	STA list1+0

	LDA list1+1
	ADC #6
	CMP list1+7
	BCC +continue
	LDA #0

+continue
	STA list1+1

	LDA list1+0
	AND #%00001111
	BNE +continue
	LDA list1+0
	AND #%00100000
	BEQ +decrement

	INC list1+8
	RTS

+decrement
	DEC list1+8

+continue
	RTS

	; ------------------------------------------------
	; animation completed , prepare for transition
	; ------------------------------------------------
+done:
	LDA #$00						; switch off all blinking
	STA menuFlags
	JMP pullState
