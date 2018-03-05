state_initializeMove:
  LDA effects
  AND #%10000000						  ; switch off everything but the cursor
  STA effects

  LDY activeObjectIndex				; set object's move animation bit (b3)
  LDA object, Y
  ORA #%00001000
  STA object, Y

  LDA object+5, Y
  AND #%00111111
  LDY activeObjectGridPos			; unblock position in nodeMap
  STA nodeMap, Y
  TAX
  JSR setTile

  LDA #0
  STA actionCounter           ; frame counter
  STA actionList+0						; node number on path in list1

  JSR clearCurrentEffects

  LDA #$11
  JMP replaceState
