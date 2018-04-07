state_setRunningEffect:
  JSR pullParameter
  STA runningEffect
  BNE +done                   ; restore to normal
  JSR updatePalette           ; pallete to normal

  ;LDA cameraY+1
  ;AND #%11111100
  ;STA cameraY+1

+done:
  RTS
