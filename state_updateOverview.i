; state 3D

state_updateOverview:

  LDA activeObjectTypeAndNumber
  AND #$F0
  LSR
  LSR
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

  LDA #$4E
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

  LDA #$6E
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
