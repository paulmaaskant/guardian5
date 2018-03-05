state_clearSysFlags:
  JSR pullParameter
  EOR #$FF
  AND sysFlags
  STA sysFlags
  RTS
