state_initializeMove:
  LDA effects
  AND #%10000000						  ; switch off everything but the cursor
  STA effects

  LDY activeObjectIndex				; set object's move animation bit (b3)
  LDA object, Y
  ORA #%00001000
  STA object, Y

  AND #$07                    ; direction bits
  TAX
  LDA directionLookupMoving, X
  STA list3+61								; set for object sprite cycle in main loop

  LDA list1+0
  STA activeObjectStats+3     ; keep track of # moves spent

  LDA object+5, Y             ; reload obscured background tile
                              ; A parameter for setTile
  LDY activeObjectGridPos			; Y parameter for setTile
  JSR setTile

  LDA #0
  STA blockInputCounter       ; frame counter
  STA actionList+0						; node number on path in list1

  JSR clearCurrentEffects

  LDA activeObjectGridPos
  JSR gridPosToScreenPos

  LDA currentObjectXPos
  STA list3+62

  LDA currentObjectYPos
  STA list3+63

  LDA #$11
  JMP replaceState
