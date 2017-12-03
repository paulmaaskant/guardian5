; IN A (b7-b4) pilot ID
updatePortrait:
  PHA
  AND #%11000000
  ASL
  ROL
  ROL							; clears carry
  ADC #$08
  STA $B000       ; set the bank (8, 9, 10 or 11)

  PLA
  AND #%00110000
  LSR
  LSR            ; clears carry
  STA locVar1

  LDY #15

-loop:
  LDA portraitMap, Y
  ADC locVar1                 ; offset
  STA characterPortrait, Y
  DEY
  BPL -loop

  LDA sysFlags
  ORA sysFlag_showPortrait
  STA sysFlags

  RTS

portraitMap:
  .hex 00 01 02 03
  .hex 10 11 12 13
  .hex 20 21 22 23
  .hex 30 31 32 33
