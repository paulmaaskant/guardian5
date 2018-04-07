eff_groundShake:
  LDA frameCounter
  LSR

  LDA cameraY+1
  BCC +continue
  SBC #4
  STA cameraY+1
  RTS

+continue
  ADC #4
  STA cameraY+1
  RTS
