; ------------------------------------------
; gamesState 08: end turn
;------------------------------------------
; see if end-of-turn events are triggered
; 1) loose target lock if locked target is no longer visible


state_endTurn:
	LDY activeObjectIndex
	LDA object+4
	BPL +nextEvent						; no target lock

	AND #%01111000
	TAY
	LDA object+3, Y
	STA cursorGridPos					; grid position of target locked object
	LDA activeObjectGridPos
	JSR checkLineOfSight
	BCC +nextEvent

	LDY activeObjectIndex
	LDA #0
	STA object+4, Y


+nextEvent
	JMP pullState
