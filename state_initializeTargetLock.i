state_initializeTargetLock:
  JSR applyActionPointCost



  

  LDA #0
  STA list1+0 				; animation frame count
  STA list1+2					;

  LDA activeObjectGridPos
  JSR gridPosToScreenPos
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

  JSR pullAndBuildStateStack
  .db 2			; 2 items
  .db $15   ; focus animation
  .db $40   ; LOCK marker animation

  ; built in RTS
