menuIndicatorsBlink:
  LDA activeObjectTypeAndNumber
  BMI +done
  LDA #$C1																																			; set indicator tiles
  STA menuIndicator+0																														; in 'toggle' positions
  LDA #$C0
  STA menuIndicator+1
  
+done:
  RTS
