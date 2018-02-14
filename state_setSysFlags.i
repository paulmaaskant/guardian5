state_setSysFlags:
  JSR pullState           ; remove current state
  JSR pullState           ; get parameter byte
  EOR sysFlags            ; toggle sys flags
  STA sysFlags            ; store
  RTS

  ;JMP ;executeState        ; immediate execute next state
