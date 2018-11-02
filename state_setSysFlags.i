state_setSysFlags:
  JSR pullParameter       ; get parameter byte
  ORA sysFlags            ; toggle sys flags
  STA sysFlags            ; store
  RTS
