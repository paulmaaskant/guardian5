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

	JSR angleToCursor						; takes currentObject coordinates as IN
	STY list1+7									; radius
	STA list1+8									; angle

	LDY selectedAction
	LDX actionList, Y							; 1 for weapon 1, 2 for weapon 2
	LDA activeObjectStats+3				; default weapon 1 (primary) damage
	CPX #aRANGED2
	BEQ +missile

	; set up for machine gun animation

	DEC list1+8									; offset angle by 1 bin radian
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
	CMP #$02										; if attack is a miss
	BNE +continue
	LDA list1+7									; then adjust angle
	ADC #20											; and radius
	STA list1+7
	LDA list1+8
	ADC #5
	STA list1+8

+continue:
	LDY #sGunFire
	JSR soundLoad

	JSR pullAndBuildStateStack
	.db #3											; 3 items
	.db $2B
	.db $13 										; resolve ranged
	.db $16											; show results
	; built in RTS

+missile:

															; set up for missile animation
	LDA #0											; init
	STA list1+0									; frame counter
	LDA #$02										; switch on controlled effects
	STA effects

	LDX #5											; explosion animation
	LDY #17											; explosion sound
	LDA list3+3
	CMP #2										   ; if attack is a miss
	BNE +continue
	LDX #8											; shield animation
	LDY #27											; shield sound

+continue:
	STX list1+5
	STY list1+6

	JSR pullAndBuildStateStack
	.db #3											; 3 items
	.db $2B
	.db $2E 										; resolve ranged
	.db $16											; show results
	; built in RTS
