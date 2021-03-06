; -------------------------
; state $39 initialize missile
; -------------------------

state_initializeMissile:
  LDA activeObjectGridPos			; attacking unit position
  JSR gridPosToScreenPos			; attacking unit screen coordinates
  JSR angleToCursor						; takes currentObject coordinates as IN
  STY list1+7									; radius
  STA list1+8									; angle
  LDA #0											; init
  STA list1+0									; frame counter

  STA list1+4									; first hit counter

  LDA #2										  ; switch on controlled effects
  STA effects
  LDX #5											; explosion animation
  LDY #17											; explosion sound
  LDA list3+4
  BMI +continue
  LDX #8											; miss animation
  LDY #27											; miss sound

+continue:
  STX list1+5
  STY list1+6

  LDA #$2E
  JMP replaceState
