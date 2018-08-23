clearSystemMenu:
	LDA #space					; clear tile
	LDX #9
-	STA systemMenuLine1, X
	DEX
	BPL -
	LDA #emptyString
	STA systemMenuName
	RTS
