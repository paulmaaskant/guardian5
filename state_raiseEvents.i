state_raiseEvents:
  JSR pullParameter       ; get parameter byte
  ORA events              ; raise flags
  STA events              ; store
  RTS
