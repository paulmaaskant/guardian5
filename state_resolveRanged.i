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

	LDA list1+5												; animation #
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
