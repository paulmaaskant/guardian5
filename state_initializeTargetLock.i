state_initializeTargetLock:
  LDA #$03						; clear from list3+4
  LDX #$09						; up to and including list3+9
  JSR clearList3

  JSR applyActionPointCost

  LDY activeObjectIndex
  LDA targetObjectTypeAndNumber
  STA object+4, Y

  LDA #0
  STA list1+0 				; animation frame count
  STA list1+2					; animation control count

  LDA activeObjectGridPos
  JSR gridPosToScreenPos
  BCC +done
  JSR clearCurrentEffects

  LDX #4
  STX effects
  DEX

-loop:
  LDA #10
  STA currentEffects+0, X
  LDA currentObjectXPos
  STA currentEffects+6, X
  LDA currentObjectYPos
  CLC
  ADC #-14
  STA currentEffects+12, X
  DEX
  BPL -loop

  JMP pullState

+done:
  JMP pullParameter   ; skips the next state
