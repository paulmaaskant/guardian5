
showTargetMech:
	LDX #8
-loop:
	LDA mechTiles, X
	LDY mechTilesPos, X
	STA targetMenuLine1, Y
	DEX
	BPL -loop
	RTS


mechTiles:
	.hex 30 31 0F
	.hex 32 33 0F
	.hex 0F 0F 2D

mechTilesPos:
	.hex 00 01 02
	.hex 06 07 08
	.hex 0C 0D 0E
