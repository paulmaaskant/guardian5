state_initializeMachineGun:
  LDA activeObjectGridPos			; attacking unit position
  JSR gridPosToScreenPos			; attacking unit screen coordinates
  JSR angleToCursor						; takes currentObject coordinates as IN
  STY list1+7									; radius
  STA list1+8									; angle
  DEC list1+8									; offset angle by 1 bin radian (because of wave effect)
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

  LDA #$13                    ; resolve machine gun
  JMP replaceState
