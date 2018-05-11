;
; used to show heat or charge damage
;
state_initializeExplosion:
  LDA activeObjectGridPos
  JSR gridPosToScreenPos
  JSR clearCurrentEffects

  ;LDA #$54
  ;STA list3+30          ; "+"

  ;LDA list3+14
  ;BEQ +noMarker
  ;CLC
  ;ADC #$40
  ;STA list3+31          ; "X"

  ;LDA #$55
  ;STA list3+32

  ;LDA #100
  ;STA runningEffectCounter

  LDA #5
  STA currentEffects+0

  LDA currentObjectXPos
  STA currentEffects+6

  LDA currentObjectYPos
  STA currentEffects+12

  LDA #6
  STA runningEffect

  LDA #1
  STA effects
  STA runningEffectCounter

  JMP pullState
