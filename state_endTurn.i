; ------------------------------------------
; gamesState 08: end turn
;------------------------------------------
; see if end-of-turn events are triggered
; 1) set end turn flag

state_endTurn:
	LDY activeObjectIndex
	LDA object+4, Y
	ORA #%00100000
	STA object+4, Y

+nextEvent:
	JMP pullState
