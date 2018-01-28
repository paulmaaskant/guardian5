state_initializeMove:
  LDA effects
  AND #%10000000						  ; switch off active marker
  STA effects

  LDY activeObjectIndex				; set object's move animation bit (b3)
  LDA object, Y
  ORA #%00001000
  STA object, Y

  LDY activeObjectGridPos			; unblock position in nodeMap
  LDA #0											; FIX: show original meta tile
  STA nodeMap, Y
  TAX
  JSR setTile

  LDA #$00
  STA actionCounter
  STA actionList+0						; node number on path in list1

  JSR clearCurrentEffects

  LDA #$11
  JMP replaceState
