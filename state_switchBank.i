state_switchBank:
  JSR pullState           ; discard current state_switchBank
  JSR pullState           ; get parameter in A

  STA softCHRBank1

  LDA #2
  STA blockInputCounter

  LDA #$1A                ; wait frame state
  JMP pushState
