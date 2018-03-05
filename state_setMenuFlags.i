state_setMenuFlags
  JSR pullParameter       ; get parameter byte
  STA menuFlags           ; set flags
  RTS
