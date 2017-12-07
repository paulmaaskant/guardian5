state_showModifiers:
  DEC list1+0
  BNE +continue
  JMP pullState

+continue:
  LDA list1
  AND #$03
  BNE +done
  DEC currentEffects+12

+done:
  RTS
