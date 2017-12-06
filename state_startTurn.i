; state $34
; checks for start of turn events
; needs to be refactored
;
;
state_startTurn:

  LDA activeObjectIndex
  BNE +done
  LDA roundCount
  CMP #1
  BNE +done

  JSR pullAndBuildStateStack
	.db 9
	.db $20, 0					              ; load menu backgorund 0
	.db $01, 10					              ; load stream 10: start level 1
	.db $30							              ; restore active unit portrait
	.db $20, 1					              ; load menu backgorund 0
	.db $31, #eRefreshStatusBar       ; raise event

+done:
  JMP pullState
