clearActionMenu:
	LDA #$0F
	LDX #$26
-	STA actionMenuLine1, X
	DEX
	BPL -
	RTS
