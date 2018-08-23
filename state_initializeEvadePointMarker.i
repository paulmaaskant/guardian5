state_initializeEvadePointMarker:
  LDA cursorGridPos
  JSR gridPosToScreenPos
  JSR clearCurrentEffects

  LDX #$54              ; "+"
  LDA list3+14          ; evade point adjustment
  BEQ +noMarker
  BPL +continue
  JSR absolute
  LDX #$56              ; "-"

+continue:
  STX list3+30
  CLC
  ADC #$40
  STA list3+31          ; "X"

  LDA #$55
  STA list3+32

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

  LDA #50
  STA blockInputCounter
  LDA #$1A
  JMP replaceState

+noMarker:
  JMP pullState
