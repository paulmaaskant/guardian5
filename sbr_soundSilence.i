soundSilence:
  LDA soundFlags
  ORA #$40
  STA soundFlags

  LDA frameCounter				; wait for next frame
-	CMP frameCounter
  BEQ -

  RTS
