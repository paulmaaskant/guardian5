clearActionMenu:
	LDA #space
	LDX #25
-	STA actionMenuLine1, X
	DEX
	BPL -
	STA menuIndicator+0					; hide menu indicators
	STA menuIndicator+1
	RTS
