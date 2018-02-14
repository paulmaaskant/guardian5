state_setMenuFlags
  JSR pullState           ; remove current state
  JSR pullState           ; get parameter byte
  STA menuFlags           ; set flags
  RTS
  
  ;JMP executeState        ; immediate execute next state
