clearSystemMenu:
	LDA #$0F					; clear tile
	LDX #8
-	STA systemMenuLine1, X
	DEX
	BPL -
	RTS
