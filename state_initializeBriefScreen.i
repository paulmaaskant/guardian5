state_initializeBriefScreen:

  LDA #$21									; next game state: init mission text stream
  STA list1+1
  LDA #< briefScreen				; story screen byte stream hi
  STA list1+2
  LDA #> briefScreen				; story screen byte stream lo
  STA list1+3
  LDA #$C0									; fade in, but no fade out
  STA list1+4

  ;LDY #$03
  ;JSR soundLoad

  JMP initializeScreen			; tail chain
