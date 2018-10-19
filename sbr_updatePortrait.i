; ---------------------------------
; IN A (b7 + b2-0 pilot ID
; ---------------------------------

;

updatePortrait:
  AND #%10000111
  ASL
  BCC +skip
  ORA #%00010000

+skip:
  ASL
  TAY
  LDA pilotTable-1, Y

updatePortrait2:
  LDY #8
  CMP #8
  BCC +skip
  INY

+skip:
  STY $B000

  AND #%00000111
  LDX #9
  JSR multiply

  LDY #8

-loop:
  TYA
  CLC
  ADC par2
  STA characterPortrait, Y
  DEY
  BPL -loop

  LDA sysFlags
  ORA sysFlag_showPortrait
  STA sysFlags

  RTS
