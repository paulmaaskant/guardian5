state_switchBank:
  JSR pullParameter          ; get parameter in A
  STA softCHRBank1
  LDA #2
  STA blockInputCounter
  LDA #$1A                   ; wait frame state
  JMP pushState
