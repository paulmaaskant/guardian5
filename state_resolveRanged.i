; -----------------------------------------------
; game state 12: start ranged attack (laser)
; -----------------------------------------------
state_initializeRanged:
	LDY #sGunFire
	JSR soundLoad

	JSR calculateAttack

	LDA #$06										; switch on controlled effects
	STA effects									;

	LDA #$00										; initialize the
	STA list1+0									; overall animation counter

	; --------------------------------------------------
	; Get active / target object screen coordinates
	; --------------------------------------------------
	LDA activeObjectGridPos			; attacking unit position
	JSR gridPosToScreenPos			; attacking unit screen coordinates
	LDA currentObjectXPos				;
	STA list1+9									;
	LDA currentObjectXScreen		;
	STA list1+8									;
	LDA currentObjectYPos				;
	STA list1+11								;
	LDA currentObjectYScreen		;
	STA list1+10								;

	LDA cursorGridPos						; target unit position
	JSR gridPosToScreenPos			; target unit screen coordinates

	LDA list3+3
	CMP #$02
	BNE +done

	LDA currentObjectXPos
	SBC #$20
	STA currentObjectXPos

+done:

	; --------------------------------------------------
	; Calculate delta X
	; --------------------------------------------------
	LDA list1+9						; determine signed difference
	SEC
	SBC currentObjectXPos
	STA list1+3
	LDA list1+8
	SBC currentObjectXScreen
	STA list1+2						; store the sign for the X delta
	BPL +positive					; now store the absolute value
	LDA list1+3						; for the X delta
	EOR #$FF						; assuming it will never be
	CLC
	ADC #$01
	STA list1+3						; more than 255
+positive:

	; --------------------------------------------------
	; Calculate delta Y
	; --------------------------------------------------
	LDA list1+11
	SEC
	SBC currentObjectYPos
	STA list1+6
	LDA list1+10
	SBC currentObjectYScreen
	STA list1+5

	BPL +positive					; now store the absolute value
	LDA list1+6						; for the Y delta
	EOR #$FF						; assuming it will never be
	CLC
	ADC #$01
	STA list1+6						; more than 255
+positive:

	; --------------------------------------------------
	; Prepare the menu
	; --------------------------------------------------
	JSR clearActionMenu				; clear the menu

	LDA events						; refresh menu
	ORA event_refreshStatusBar		; set flag
	STA events

	LDA #$0F ;
	STA menuIndicator+0
	STA menuIndicator+1

	LDA menuFlags					; switch on blinking for line 1
	ORA menuFlag_line1				; set flag
	STA menuFlags

	LDX #$00						; write to menu
	LDY #$06						; "opening fire"
	JSR writeToActionMenu

	JSR pullAndBuildStateStack
	.db $02							; 2 states
	.db $13 						; resolve
	.db $16							; show results

	; built in RTS





; -----------------------------------------------
; game state 13: resolve ranged attack (laser)
; -----------------------------------------------
;
; list1+00, frame counter
; list1+01, saved target animation
; list1+02, delta X sign (b7)
; list1+03, delta X value
;
; list1+05, delta Y sign (b7)
; list1+06, delta Y value
;
; list1+08, firing unit X HI
; list1+09, firing unit X LO
; list1+10, firing unit Y HI
; list1+11, firing unit Y LO
;
; list1+19, damage stat
; -----------------------------------------------
state_resolveRanged:
	; ------------------------------------------------
	; menu (tile) updates
	; ------------------------------------------------
	LDA list1+0
	AND #$F8
	BEQ +done;

	LSR
	LSR
	LSR
	CLC
	ADC #$0C
	TAX
	LDY #$11
	JSR writeToActionMenu			; write

	LDA events						; refresh menu
	ORA event_refreshStatusBar		; set flag
	STA events


+done:

	; ------------------------------------------------
	; sprite updates
	; ------------------------------------------------
	JSR random
	TAX								; random index between 0 and 127
	LDA #$06						; animation: laser
	LDY	#$00						; effect 0
	JSR setEffect

	JSR random
	TAX								; random index between 0 and 255
	LDA #$06						; animation: laser
	LDY	#$01						; effect 0
	JSR setEffect

	JSR random
	TAX								; random index between 0 and 255
	LDA #$06						; animation: laser
	LDY	#$02						; effect 0
	JSR setEffect

	JSR random
	TAX								; random index between 0 and 255
	LDA #$06						; animation: laser
	LDY	#$03						; effect 0
	JSR setEffect

	JSR random
	TAX								; random index between 0 and 255
	LDA #$06						; animation: laser
	LDY	#$04						; effect 0
	JSR setEffect

	LDA #$05						; animation: explosion
	LDX #$FF						;
	LDY	#$05						; effect 0
	JSR setEffect

	LDA list1+0
	CMP #$69						; 11010001 01101001
	BNE +stillRunning		; complete after 209 frames

	; ------------------------------------------------
	; animation completed , prepare for transition
	; ------------------------------------------------

	LDA #$00						; switch off all blinking
	STA menuFlags

	JMP pullState

+stillRunning:
	CLC
	ADC #$01
	STA list1+0
	RTS


; ------------------------------------------------
; support subroutine
; X, index
; Y, effect # 0-11
; A, animation
; ------------------------------------------------
setEffect:
	PHA						; animation on the stack
	TYA
	PHA						; effect #
	TXA
	PHA						; input

	; --- determine X coordinate ----
							; A = 0...255
	LDX list1+3				; X = delta X
	JSR multiply
	LDA par1
	CLC
	LDX list1+2				; sign
	BMI +skip
	EOR #$FF
	SEC						; adds 1
+skip:
	ADC list1+9				; X coor
	STA list1+8				; temp store X coordinate

	; --- determine Y coordinate ----
	PLA						; A = 0...255
	LDX list1+6				; X = delta Y
	JSR multiply
	LDA par1
	CLC
	LDX list1+5				; sign
	BMI +skip
	EOR #$FF
	SEC
+skip:
	ADC list1+11
	ADC #$F8
	STA list1+10		 	; temp store Y coordinate

	PLA						; effect #
;	ASL
;	ASL
	TAX
	PLA						; animation #

	STA currentEffects+0, X
	LDA list1+8
	STA currentEffects+6, X
	LDA list1+10
	STA currentEffects+12, X

	RTS
