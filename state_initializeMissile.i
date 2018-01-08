state_initializeMissile:
  LDA activeObjectGridPos			; attacking unit position
  JSR gridPosToScreenPos			; attacking unit screen coordinates
  JSR angleToCursor						; takes currentObject coordinates as IN
  STY list1+7									; radius
  STA list1+8									; angle
  LDA #0											; set up for missile animation
  STA list1+0									; frame counter
  STA list1+4									; first hit counter
  LDA #$02										; switch on controlled effects
  STA effects
  LDX #5											; explosion animation
  LDY #17											; explosion sound
  LDA list3+3
  CMP #2										  ; if attack is a miss
  BNE +continue
  LDX #8											; shield animation
  LDY #27											; shield sound

+continue:
  STX list1+5
  STY list1+6

  LDA #$2E
  JMP replaceState
