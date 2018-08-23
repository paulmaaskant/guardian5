setEvadePoints:
  LDA #0
  STA list3+14                ; reset to 0 before calculating

  LDA actionMessage
  BMI +done

  LDX selectedAction				  ; retrieve selected action
  LDA actionList, X           ; distance is calculated differently

  CMP #aJUMP								  ;
  BEQ +jumping
  LDA list1                   ; number of nodes in path for MOVE
  BNE +continue

+jumping:
  LDA distanceToTarget        ; number of nodes in path for JUMP
  INC list3+14                ; one additional evade point when jumping

+continue:
  CLC
  ADC activeObjectStats+3			; moves from previous action
  AND #$0F                    ; filter the jump bit
  TAY
  LDA moveToEvadePointMap-1, Y
  CLC
  ADC list3+14
  STA list3+14

  ; ----------------------------------------------------
  ; if pilot is LUCKY, add another evade point
  ; ----------------------------------------------------
  LDA activeObjectStats+1
  AND #%00001000
  BEQ +continue
  INC list3+14

+continue:
  LDA #13
  STA actionMessage

+done:
  RTS

moveToEvadePointMap:
  .db 0, 0, 1, 2, 2, 3, 3, 4, 4, 4, 4, 4
