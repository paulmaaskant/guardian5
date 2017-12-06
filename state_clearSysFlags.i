state_clearSysFlags:
  JSR pullState
  JSR pullState

  EOR #$FF

  AND sysFlags
  STA sysFlags

  RTS
