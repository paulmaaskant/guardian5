state_shutDown:
  LDA events
  ORA event_refreshStatusBar
  STA events

  LDA #$00
  STA menuFlags
  STA selectedAction

  ;LDA #$03										                                                  ; clear from list3+3
  ;LDX #$09										                                                  ; up to and including list3+9
  ;JSR clearList3

  ;LDA #$09                                                                      ; msg shutdown
  ;STA list3+3

  LDA #aCOOLDOWN
  STA actionList
  JSR calculateActionPointCost
  JSR applyActionPointCost
  JMP pullState
