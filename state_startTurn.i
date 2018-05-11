; state $34
; checks for mission events

state_startTurn:
  LDA activeObjectIndexAndPilot
  JSR updateSystemMenu

  LDY activeObjectIndex
  LDA object+4, Y
  AND #%01111000                     ; remove BRACE effect, remove all EVADE points
  STA object+4, Y

  JSR pullAndBuildStateStack
  .db 3
  .db $4D                            ; check mission events
  .db $31, eUpdateTarget             ; raise event update target
                                     ; RTS built in
