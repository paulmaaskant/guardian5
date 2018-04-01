
; state $41
state_resolveXTargetLockMarker:
  DEC list1+0
  BNE +continue
  JMP pullState

+continue:
  LDA list1
  AND #%00000111
  BNE +done

  LDA effects
  EOR #%00000001
  STA effects

+done:
  RTS
