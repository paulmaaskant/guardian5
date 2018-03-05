state_setSysFlags:
  JSR pullParameter       ; get parameter byte
  EOR sysFlags            ; toggle sys flags
  STA sysFlags            ; store
  RTS
