; state $34
; checks for start of turn events
; needs to be refactored
;
;
state_startTurn:
  LDA activeObjectIndexAndPilot
  JSR updateSystemMenu

  LDA activeObjectIndex
  BNE +done
  LDA roundCount
  BNE +done

  JSR pullAndBuildStateStack
	.db 9
	.db $20, 0					              ; load menu BG 0: dialog
	.db $01, 10					              ; load stream 10: start level 1
	.db $30							              ; restore active unit portrait
	.db $20, 1					              ; load menu BG 1: hud
	.db $31, #eUpdateTarget           ; raise event

+done:
  JSR pullAndBuildStateStack
  .db 2
  .db $31, #eUpdateTarget            ; raise event
