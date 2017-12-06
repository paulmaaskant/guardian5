state_setSysFlags:
  JSR pullState
  JSR pullState
  EOR sysFlags
  STA sysFlags
  RTS
