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
;
; list1+07, radius
; list1+08, angle
;

; -----------------------------------------------
state_resolveMachineGun:
	; ------------------------------------------------
	; sprite updates
	; ------------------------------------------------
	LDA activeObjectGridPos
	JSR gridPosToScreenPos

	;LDA currentObjectYPos
	;CLC
	;ADC #-10
	;STA currentObjectYPos

	LDA #3												; loop count
	STA list1+2

	LDA #6												; bullet animation
	STA list1+5

	LDA list1+1										; effect count
	STA list1+4
	TAX														; radius

-loop:
	LDA list1+8										; angle
	JSR getCircleCoordinates
	TXA
	CLC
	LDX list1+2										; restore X
	ADC currentObjectXPos
	STA currentEffects+6, X
	TYA
	CLC
	ADC currentObjectYPos
	STA currentEffects+12, X

	LDA list1+5										; animation #
	STA currentEffects+0, X

	LDA list1+4
	CLC														; current radius += 1/3 of total radius
	ADC list1+3										;

	CMP list1+7										; this makes it more than total radius
	BCC +continue									; subtract total radius
	SEC
	SBC list1+7

+continue:
	STA list1+4										; set the new radius
	TAX														; copy to X

	DEC list1+2										; if last loop cycle
	BNE +continue
																; then
	LDX list1+7										; X = full radius (target position)
	LDA list2+0										; explosion animation
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

	LDA list1+0								; change angle every 16 frames
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
