state_showHourGlass:
  LDY #$44
  STY actionMenuLine1+5
  INY
  STY actionMenuLine1+6
  LDY #$54
  STY actionMenuLine2+5
  INY
  STY actionMenuLine2+6

  JMP pullState
