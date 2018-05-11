state_initializeMove:
  LDA effects
  AND #%10000000						  ; switch off everything but the cursor
  STA effects

  LDY activeObjectIndex				; set object's move animation bit (b3)
  LDA object, Y
  ORA #%00001000
  STA object, Y

  LDA object+4, Y
  ORA list3+14
  STA object+4, Y

  LDA list1
  STA activeObjectStats+3     ; keep track of # moves

+continue:
  LDA object+5, Y             ; reload obscured background tile
                              ; A parameter for setTile
  LDY activeObjectGridPos			; Y parameter for setTile
  JSR setTile

+continue:
  LDA #0
  STA actionCounter           ; frame counter
  STA actionList+0						; node number on path in list1

  JSR clearCurrentEffects

  LDA #$11
  JMP replaceState
