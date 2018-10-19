; 4E

state_resolveImplosion:
  LDA list1+2         ; timer
  AND #$3F
  STA list1+3         ; temp
  LDA #$05
  STA list1+4         ; iteration count
  LDA cursorGridPos
  JSR gridPosToScreenPos

-loop:
  LDY list1+4
  LDX list1+3
  LDA list1+2
  ASL
  ASL
  CLC
  ADC state4E_angles, Y
  JSR getCircleCoordinates
  TXA
  CLC
  ADC currentObjectXPos
  LDX list1+4
  STA currentEffects+6, X
  TYA
  CLC
  ADC currentObjectYPos
  STA currentEffects+12, X

  DEC list1+4
  BPL -loop

  DEC list1+2                   ; value = 63
  BEQ +done
  RTS

+done:
  LDA #0
  STA effects                     ; all effects off
  JMP pullState

state4E_angles:
  .db #0, #43, #85, #128, #171, #213
