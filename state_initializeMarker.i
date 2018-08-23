state_initializeMarker:
  JSR pullParameter
  PHA
  PHA

  TAY
  LDX #$54              ; default sign to "+"
  LDA modifierValueIndex, Y
  TAY
  LDA list3, Y          ; modifier value
  BEQ +done
  BPL +continue
  JSR absolute
  INX                   ; change sign to "-"

+continue:
  STX list3+30
  CLC
  ADC #$40
  STA list3+31          ; "X"

  PLA
  TAY
  LDA modifierReverseSign, Y
  BEQ +continue
  INC list3+30          ;

+continue:
  LDX activeObjectIndex
  LDA targetOrActive, Y
  BEQ +active
  LDX targetObjectIndex

+active:
  LDA object+3, X
  JSR gridPosToScreenPos

  JSR clearCurrentEffects

  LDA #100
  STA runningEffectCounter

  LDA #7
  STA currentEffects+0

  LDA currentObjectXPos
  STA currentEffects+6

  LDA currentObjectYPos
  STA currentEffects+12

  LDA #2
  STA runningEffect

  PLA
  TAY
  LDA modifierValueQualifier, Y
  STA list3+32

  LDA #50
  STA blockInputCounter
  LDA #$1A
  JMP pushState

+done:
  PLA
  PLA
  RTS

; 0 = active object, 1 = target object
targetOrActive:
  .db 0, 1, 0, 1, 1

; list3 + Y
modifierValueIndex:
  .db 14, 27, 12, 13, 2

; qualifier
modifierValueQualifier:
  .db $56, $56, $57, $57, $61

modifierReverseSign;
  .db 0,0,0,0,1
