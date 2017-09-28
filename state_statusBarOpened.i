state_statusBarOpened:

  LDA buttons
  AND #$F0
  BEQ +continue

  LDA #$25           ; close menu
  JMP replaceState

+continue:
  RTS
