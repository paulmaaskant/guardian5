state_testFace
  LDA #$08
  STA $C001

  LDA buttons
  BEQ +continue
  JMP pullState

+continue:

  LDY #11

-loop:
  TYA
  ASL
  ASL
  TAX
  LDA frameCounter
  LSR
  LDA $CF
  BCC +continue
  LDA state_testFace_tile, Y

+continue:
  STA $0201+4, X
  LDA state_testFace_X, Y
  STA $0203+4, X
  LDA state_testFace_Y, Y
  STA $0200+4, X
  LDA #%00000010
  STA $0202+4, X
  DEY
  BPL -loop
  RTS

state_testFace_X:
  .db $70, $78, $80, $88
  .db $70, $78, $80, $88
  .db $70, $78, $80, $88

state_testFace_Y:
  .db $70, $70, $70, $70
  .db $78, $78, $78, $78
  .db $80, $80, $80, $80

state_testFace_tile:
  .db $C0, $C1, $C2, $C3
  .db $D0, $D1, $D2, $D3
  .db $E0, $E1, $E2, $E3
