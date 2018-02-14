state_raiseEvents:
  JSR pullState           ; remove current state
  JSR pullState           ; get parameter byte
  ORA events              ; raise flags
  STA events              ; store
  RTS
;  JMP executeState        ; immediate execute next state
