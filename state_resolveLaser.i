; list1
; 0 frame counter
; 1 radius offset for the frame
; 2 loop count
; 3 1/3 of total radius (used to increment 4)
; 4 radius offset per loop
; 5 animation #
; 6 flip bits for animation
; 7 total radius
; 8 angle
; 9 temp used in loop


state_resolveLaser:


  LDA activeObjectGridPos
  JSR gridPosToScreenPos

  LDA #3												; loop count
  STA list1+2

  LDA list1+5                   ; animation
  STA list1+9

  LDA list1+1										; A = radius offset
  STA list1+4                   ; store copy
  TAX														; store in X

-loop:
  LDA list1+8										; angle
  JSR getCircleCoordinates

  TXA
  CLC
  LDX list1+2										; restore loop count to X
  ADC currentObjectXPos
  STA currentEffects+6, X
  TYA
  CLC
  ADC currentObjectYPos
  STA currentEffects+12, X

  LDA list1+9										; animation #
  STA currentEffects+0, X

  LDA list1+6										; animation #
  STA currentEffects+24, X

  LDA list1+4
  CLC														; current radius += 1/3 of total radius
  ADC list1+3										;

  CMP list1+7										; this makes it more than total radius
  BCC +continue									; subtract total radius
  SEC
  SBC list1+7
  CLC
  ADC #16


+continue:
  STA list1+4										; set the new radius

  DEC list1+2										; if last loop cycle
  BNE +continue                 ; then  set values for next iteration

  ;LDA #0                        ; doesnt work: sets value for current iteration while should be next
  ;STA currentEffects+24, X      ; no mirroring
  LDA list2+0										; miss or hit animation
  STA list1+9
  LDA list1+7										; X = full radius (target position)

+continue:
  TAX

  LDA list1+2
  BPL -loop

  LDA list1+0
	CMP #128								; runs for 128 frames
	BEQ +done
	INC list1+0

	LDA list1+1
	ADC #8
	CMP list1+7
	BCC +continue
	LDA #16

+continue:
	STA list1+1
	RTS

	; ------------------------------------------------
	; animation completed , prepare for transition
	; ------------------------------------------------
+done:
	LDA #$00						; switch off all blinking
	STA menuFlags
	JMP pullState
