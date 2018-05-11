eff_groundShake:
  LDA frameCounter
;  LSR

  AND #%00000011
  CMP #2
  BNE +continue

  LDA cameraY+1
  EOR #%00000010
  STA cameraY+1
  STA cameraYDest+1

+continue:
  RTS
