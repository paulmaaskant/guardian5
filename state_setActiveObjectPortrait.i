state_setActiveObjectPortrait:
  LDA activeObjectIndexAndPilot
  JSR updatePortrait
  JMP pullState
