; -----------------------------------------------
; game state 2E: resolve ranged attack (machine gun)
; -----------------------------------------------
; list1+00, frame counter
; list1+02, loop control
; list1+03, temp
; list1_04, first impact
; list1+05, animation
; list1+06, sound
; list1+07, radius
; list1+08, angle
; list1+09, trajectory count

state_resolveMissile:
  LDA #1                      ; set loop count
  STA list1+2                 ; 2 missiles at the time

-loop:
  LDA activeObjectGridPos
  JSR gridPosToScreenPos      ; sets currentObject coordinats

  LDY list1+2                 ; Y = loop count

  LDA list1+0                 ; A = frame count
  ADC state_2E_offset, Y      ;
  AND #%00111111              ; 0-63
  STA list1+9
  CMP #24                     ; if 0..23 -> move sideways
  BCS +continue
  ADC #8
  TAX                         ; radius in X
  LDA list1+8
  STA list1+3
  ADC state_2E_angle, Y

  JSR getCircleCoordinates    ; X IN radius, A IN angle
  TXA
  CLC
  LDX list1+2
  ADC currentObjectXPos
  STA currentEffects+6, X
  TYA
  CLC
  ADC currentObjectYPos
  STA currentEffects+12, X
  JMP +setAnimation

+continue:
  ; if 24-63 -> move towards target
  LDX list1+2

  LDA currentEffects+6, X
  STA currentObjectXPos
  LDA currentEffects+12, X
  STA currentObjectYPos
  JSR angleToCursor						; takes currentObject coordinates as IN
                              ; A = angle
  CPY #8                      ; if radius is less than 5,
  BCS +continue
  LDA list1+4                 ; then missile impact
  BNE +skip                   ; is this the first impact?
  INC list1+4
  LDA #5                      ; first impact, start ground shake
  STA runningEffect
  INC effects                 ; start explosion sprite

  LDA cursorGridPos
	JSR gridPosToScreenPos
	LDA currentObjectXPos
	STA currentEffects+8
	LDA currentObjectYPos
	STA currentEffects+14
	LDA list1+5
	STA currentEffects+2       ; explision or shield animation

+skip:
  LDY list1+6
  JSR soundLoad              ; explosion sound
  LDX list1+2

  LDA #11 ; no sprites       ; hide missile
  BNE +setAnimationEffect

+continue:                    ; if there is no impact
  STA list1+3                 ; angle
  LDX #6
  JSR getCircleCoordinates    ; X IN radius, A IN angle
  TXA
  CLC
  LDX list1+2
  ADC currentEffects+6, X
  STA currentEffects+6, X
  TYA
  CLC
  ADC currentEffects+12, X
  STA currentEffects+12, X

+setAnimation:
  LDA list1+9      ; fix the animation of missle after 25 frames
  CMP #25          ; so that it doesnt alternate animations
  BCS +continue    ; as it gets closer

  LDX list1+2
  LDA list1+3
  CLC
  ADC #16
  LSR
  AND #$40                  ; mirror in Y axis
  STA currentEffects+24, X

  LDA list1+3
  CLC
  ADC #16
  LSR
  LSR
  LSR
  LSR
  LSR
  TAY
  LDA state_2E_animation, Y

+setAnimationEffect:
  STA currentEffects+0, X

+continue:
  DEC list1+2
  BMI +continue
  JMP -loop

+continue:
  LDA list1+0
  CMP #192								; runs for 128 frames
  BEQ +done
                          ; CLC not  ncessary because of BEQ
  ADC #1
  STA list1+0
  RTS

; ------------------------------------------------
; animation completed , prepare for transition
; ------------------------------------------------
+done:
  LDA #$00						; switch off all blinking
  STA menuFlags
  JMP pullState

state_2E_offset:
  .db 0
  .db 16

state_2E_angle:
  .db -80
  .db 80

state_2E_animation:
  .db $20, $21, $22, $23, $24, $23, $22, $21
