state_runEffect:

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
  STA currentEffects+12, X

  DEC list1+4
  BPL -loop

  DEC list1+2                   ; value = 63
  BNE +done

  LDA #0
  STA effects

  JSR initializeExplosion
  LDY cursorGridPos
  LDA #12                         ; debris tile
  JSR setTile

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
