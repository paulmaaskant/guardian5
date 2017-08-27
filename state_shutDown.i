state_shutDown:
  LDA #$00
  STA menuFlags

  LDA #$03										                                                  ; clear from list3+3
  LDX #$09										                                                  ; up to and including list3+9
  JSR clearList3

  LDA #$09                                                                      ; msg shutdown
  STA list3+8

  LDA #$16						; show results
  STA gameState

  RTS
