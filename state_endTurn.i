; ------------------------------------------
; gamesState 08: end turn
;------------------------------------------
; see if end-of-turn events are triggered
; 1) set end turn flag

state_endTurn:

	LDX objectListSize

-loop:
	LDA objectList-1, X
	CMP activeObjectIndexAndPilot
	BEQ +flagTurn
	DEX
	BNE -loop

+flagTurn:
	ORA #%00000100							; set turn flag
	STA objectList-1, X
	JMP pullState
