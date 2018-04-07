eff_gunFireFlashes:
  LDA frameCounter
  AND #$03
  BNE +continue

  LDA frameCounter										; toggle every 8 frames
  AND #$04														; between value $00 and value $10
  ASL
  ASL
  JSR updatePalette

+continue:
  RTS
