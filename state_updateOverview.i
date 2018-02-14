; state 3D

state_updateOverview:
  JSR clearActionMenu

  LDA activeObjectIndexAndPilot ; get pilot based stats
  ASL
  AND #%00001110
  BCC +continue
  ORA #%00010000

+continue:
  ASL
  TAX
  LDY pilotTable-4, X    ; pilot name
  LDX #0
  JSR writeToActionMenu

  LDY activeObjectIndex
  JSR getStatsAddress           ; Y goes in; sets pointer1
  LDY #0                        ; #0 mech name
  LDA (pointer1), Y             ;
  TAY
  LDX #13
  JSR writeToActionMenu

  TSX										 ; switch stack pointers
  STX	stackPointer1
  LDX stackPointer2
  TXS

  LDX #12

-loop:
  LDA actionMenuLine1, X
  PHA
  DEX
  BPL -loop

  LDA #$47
  PHA
  LDA #$27
  PHA
  LDA #26								; 13 * 2
  PHA

  LDX #12

-loop:
  LDA actionMenuLine2, X
  PHA
  DEX
  BPL -loop

  LDA #$67
  PHA
  LDA #$27
  PHA
  LDA #26								; 13 * 2
  PHA

  TSX										; switch stack pointers
  STX	stackPointer2
  LDX stackPointer1
  TXS

  JMP pullState
