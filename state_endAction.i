state_endAction:
  LDA activeObjectStats+9       ; active unit AP
  BEQ +endTurn                  ; if  all APs are spent, end turn

  LDA activeObjectIndexAndPilot
  BMI +AInextAction

  JSR buildStateStack     ; next action player
  .db 4
  .db $4D                 ; check mission events
  .db $31, eUpdateTarget  ; update target
  .db $06                 ; wait for player to select 2nd action
                          ; RTS

+endTurn:
  JSR pullAndBuildStateStack
  .db 1
  ;.db $58, 0							; active object evade point marker animation
  .db $4D                 ; check mission events
                          ; RTS

+AInextAction:
  JSR buildStateStack     ; next action player
  .db 2
  .db $4D                 ; check mission events
  .db $27                 ; AI to select action
                          : RTS
