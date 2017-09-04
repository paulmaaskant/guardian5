state_initializeMissionScreen:

  LDA #$04								; load level map
  STA list1+1							; is the game state we want to get to
  LDA #< statusBar				; status bar byte stream hi
  STA list1+2
  LDA #> statusBar				; status barbyte stream lo
  STA list1+3
  LDA #$40								; fade control: fade out, but no fade in
  STA list1+4

  JSR soundSilence
  JMP initializeScreen		; tail chain
