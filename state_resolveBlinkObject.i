; --------------------------------------------
; 5A
;
; --------------------------------------------
state_resolveBlinkObject:
  LDA list1+0
  BIT bit2to0
  BNE +continue
  BIT bit3
  BNE +blinkOn

  LDY list1+5
  LDA #0
  JSR setTile

  LDY targetObjectIndex
  LDA #7                ; set direction to 7
  STA object+0, Y

  JMP +continue

+blinkOn:
  LDY list1+5
  LDA list1+4
  JSR setTile

  LDA list1+6           ; original direction

  LDY targetObjectIndex
  STA object+0, Y

+continue:
  DEC list1+0
  BEQ +done
  RTS

+done:
  JMP pullState
