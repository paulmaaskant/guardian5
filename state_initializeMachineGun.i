; -----------------------------------
; state $38 init machine gun
; -----------------------------------

state_initializeMachineGun:
  LDA activeObjectGridPos			; attacking unit position
  JSR gridPosToScreenPos			; attacking unit screen coordinates
  JSR angleToCursor						; takes currentObject coordinates as IN
  STY list1+7									; radius
  STA list1+8									; angle
  LDA #0											; init
  STA list1+0									; frame counter

  STA list1+1									; effect counter
  DEC list1+8									; offset angle by 1 bin radian (because of wave effect)

  STA par1										; divide input parameter
  LDA list1+7									; radius
  STA par2										; divide input parameter
  LDA #3											; divide input parameter
  JSR divide
  LDA par4										; radius / 3
  STA list1+3									;

  LDX #5											; explosion animation
  LDA list3+4
  BMI +continue
  LDX #8											; miss animation


+continue:
  STX currentEffects+0

  LDA #2
  STA list1+6                 ; speed

  LDY activeObjectIndex
  LDA #itemFlamer
  JSR isEquipped
  BCC +no
  LDA #5          ; flame
  BNE +set

+no:
  ASL list1+6     ; double speed
  LDA #6          ; bullet

+set:
  STA currentEffects+1
  STA currentEffects+2
  STA currentEffects+3



  LDA #$04										; switch on controlled effects
  STA effects									;

+continue:
  LDY #sGunFire
  JSR soundLoad

  JSR pullAndBuildStateStack
  .db 3             ; #items
  .db $4B, 4        ; set running effect 4: gun fire
  .db $13
