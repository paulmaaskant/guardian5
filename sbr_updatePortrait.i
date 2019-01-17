; ---------------------------------
; IN A (b7 + b2-0 pilot ID
; ---------------------------------

;

updatePortrait:
  TAY
  LDA pilotTable+3, Y

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
