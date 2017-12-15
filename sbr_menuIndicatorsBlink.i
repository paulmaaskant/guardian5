menuIndicatorsBlink:
  LDA activeObjectTypeAndNumber
  BMI +done
  LDA #$41																																			; set indicator tiles
  STA menuIndicator+0																														; in 'toggle' positions
  LDA #$40
  STA menuIndicator+1

+done:
  RTS
