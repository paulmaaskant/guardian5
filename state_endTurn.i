; ------------------------------------------
; gamesState 08: end turn
;------------------------------------------
; see if end-of-turn events are triggered
;

state_endTurn:
	; ---------------------
	; end of turn event : mission accomplished if only friendly units remain
	; ---------------------

	JMP pullState
