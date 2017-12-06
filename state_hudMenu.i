state_hudMenu:

  LDA buttons
  AND #$F0
  BEQ +continue

  JMP pullState

+continue:
  RTS
