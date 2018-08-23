clearTargetMenu:
	LDA #space					; clear tile
	LDX #12
-	STA targetMenuLine1, X
	DEX
	BPL -

	LDA #emptyString
	STA targetMenuName

	RTS
