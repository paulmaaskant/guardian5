; -----------------------------------
; state $49 init laser
; -----------------------------------

state_initializeLaser:
  LDA activeObjectGridPos			; attacking unit position
  JSR gridPosToScreenPos			; attacking unit screen coordinates
  JSR angleToCursor						; takes currentObject coordinates as IN
  STY list1+7									; radius
  STA list1+8									; angle
  LDA #0											; init
  STA list1+0									; frame counter

  STA par1										; divide input parameter
  LDA list1+7									; radius
  STA par2										; divide input parameter
  LDA #3											; divide input parameter
  JSR divide
  LDA par4										; radius / 3
  STA list1+3									;

  LDA #16
  STA list1+1									; initial radius offset

  LDA list1+8                 ; determine animation
  CLC                         ; based on the angle
  ADC #8
  LSR
  LSR
  LSR
  LSR
  TAX
  LDA state_49_spriteMap, X
  STA list1+5                 ; set list1+5 to the right animation
  LDA state_49_flipMap, X
  STA list1+6                 ; set list1+6 to the right flip bits

  LDA #4										  ; switch on controlled effects
  STA effects									;
  LDX #4											; hit animation
; LDY #17										  ; explosion sound

  LDA list3+4
  BMI +continue

  LDX #8											; miss animation
; LDY #27										  ; shield sound

+continue:
  STX list2+0
; STY list2+1

  LDY #sGunFire
  JSR soundLoad

  JSR pullAndBuildStateStack
  .db 3             ; #items
  .db $4B, 4        ; set running effect 4: gun fire
  .db $4A

state_49_spriteMap:
  .hex 2B 2E 2C 2F 2D 2F 2C 2E 2B 2E 2C 2F 2D 2F 2C 2E

state_49_flipMap:
  .hex 00 00 00 00 00 40 40 40 00 00 00 00 00 40 40 40
