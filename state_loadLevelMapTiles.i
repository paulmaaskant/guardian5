; ------------------------------------------
; gameState 05: Load level map cycle
; ------------------------------------------
state_loadLevelMapTiles:
	LDA cameraY+1						; use regular scrolling to fill NT
	BNE +stillLoading				; once camera is back on 0, the NT is f

	;---- Level load complete ----
	LDA sysFlags
	ORA sysFlag_splitScreen			; switch on split screen
	STA sysFlags

	JMP pullState

+stillLoading:
	SEC										; speed up loading
	SBC #$06							; speed up camera scroll
	BCC +									; make sure not to go negative
	STA cameraY+1
+	RTS
