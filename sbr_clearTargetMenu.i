clearTargetMenu:
	LDA #$0F					; clear tile
	LDX #$11
-	STA targetMenuLine1, X
	DEX
	BPL -
	RTS
