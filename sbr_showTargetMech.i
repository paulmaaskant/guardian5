; 30 bytes
showTargetMech:
	;LDA #$30
	;STA targetMenuLine1+0
	;STA targetMenuLine1+2
	;LDA #$39
	;STA targetMenuLine1+1
	;LDA #$31
	;STA targetMenuLine2+0
	;LDA #$32
	;STA targetMenuLine2+1
	;LDA #$33
	;STA targetMenuLine2+2
	;LDA #$34
	;STA targetMenuLine3+0
	;LDA #$35
	;STA targetMenuLine3+2
	;RTS


	LDX #8
-loop:
	LDA mechTiles, X
	LDY mechTilesPos, X
	STA targetMenuLine1, Y
	DEX
	BPL -loop
	RTS


mechTiles:
	.hex 30 39 30
	.hex 31 32 33
	.hex 34 0F 35

mechTilesPos:
	.hex 00 01 02
	.hex 06 07 08
	.hex 0C 0D 0E
