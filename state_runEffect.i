state_runEffect:

  LDA list1+2
  AND #$3F
  STA list1+3

  LDA #$05
  STA list1+4

  LDA cursorGridPos
  JSR gridPosToScreenPos

-loop:
  LDY list1+4
  LDX list1+3
  LDA list1+2
  ASL
  ASL
  CLC
  ADC state2D_angles, Y
  JSR getCircleCoordinates
  TXA
  CLC
  ADC currentObjectXPos
  LDX list1+4
  STA currentEffects+6, X
  TYA
  CLC
  ADC currentObjectYPos
  ADC #-8
  STA currentEffects+12, X

  DEC list1+4
  BPL -loop





  DEC list1+2
  BNE +done

  LDA #0
  STA effects

  JSR initializeExplosion

  ;LDA events											; update so that the unit is no longer shown
  ;ORA event_updateSprites
  ;STA events

  LDA targetObjectTypeAndNumber
	JSR deleteObject	

  INC cameraYDest+1               ; start ground shake
                                  ; because camera move adjustments are mulitples of 2
                                  ; camera keeps trembling until camera destination
                                  ; is reset to an even number

  LDY #22                         ; sound: explosion
  JSR soundLoad

  JMP pullState

+done:
  RTS

state2D_angles:
  .db #0, #43, #85, #128, #171, #213
