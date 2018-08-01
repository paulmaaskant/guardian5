; IN A (b7 + b2-0 pilot ID

updatePortrait:
  ASL
  LDY #8
  BCC +continue
  LDY #10

+continue:
  BIT bit3
  BEQ +continue
  INY

+continue:
  STY $B000
  ASL
  AND #%00001100
  STA locVar1
  LDY #8

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
