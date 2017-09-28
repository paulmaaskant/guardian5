; ------
; 29 face target (only works after charge, needs rewrite)
; -----
state_faceTarget:
  LDY activeObjectIndex
  LDA object, Y
  AND #%11111000
  LDX actionList
  INX
  ORA list2, X
  STA object, Y

  JMP pullState
