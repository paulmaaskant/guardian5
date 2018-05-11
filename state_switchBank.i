state_switchBank:
  JSR pullParameter          ; get parameter in A
  CMP #$FF                   ; opCode FF - select bank based on active unit movement type
  BNE +store
  LDA activeObjectStats+2
  BPL +groundUnit
  LDA #0
  BEQ +store

+groundUnit:
  LDA #1

+store:
  STA softCHRBank1
  LDA #2
  STA blockInputCounter
  LDA #$1A                   ; wait frame state
  JMP pushState
