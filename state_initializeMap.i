; ------------------------------------------
; gameState 04: Initialize level variables
; ------------------------------------------
state_initializeMap:
	LDA #< levelOne
	STA bytePointer+0
	LDA #> levelOne
	STA bytePointer+1

	LDA #$18			; pallete 1 for map 1
	STA currentPalettes

	; --- map collision data ---
	LDX #$00

-loop:
	JSR getNextByte								; holds data for 4 nodes (2 bits per node)
	LDY #$04

-shift:
	PHA
	AND #%11000000
	CMP #$40
	BNE +store
	LDA #$20
+store:
	STA nodeMap, X								; only b7, b6 are relevant
	PLA
	ASL
	ASL
	INX
	DEY
	BNE -shift
	CPX #$00
	BNE -loop

	; -- object info ---
	JSR getNextByte
	STA objectCount
	STA activeObjectTypeAndNumber	; set to the last object so that the next is the first
	LDX #$00

-nextObject:
	CPX objectCount
	BEQ +done

	TXA
	PHA								; push X

	JSR getNextByte
	ASL
	ASL
	ASL
	CLC
	ADC identity, X
	STA objectTypeAndNumber, X

	JSR getStatsAddress				; breaks X, sets pointer1

	PLA
	TAX
	PHA

	LDY #$00
	LDA (pointer1), Y
	PHA												; push init stats

	TXA
	ASL
	ASL
	TAX

	PLA
	AND #%11111110
	STA object+1, X						; set health and heatsinks

	JSR getNextByte
	STA object+3, X						; set grid position
	TAY												; and block it in the node map
	LDA #$C0
	STA nodeMap, Y

	JSR getNextByte						; get pilot & initial facing direction
	STA object+0, X

	PLA							; pull X
	TAX
	INX

	JMP -nextObject

+done:
	LDA #$00
	STA cameraY+0
	STA cameraX+0
	STA cameraX+1
	STA cameraXDest+0
	STA cameraXDest+1
	STA cameraYDest+0
	STA cameraYDest+1

	LDA #$F4							; start the camera one screen down
	STA cameraY+1					; camera automatically scrolls back up, loading the tiles!


	LDY #18
	STY $E000
	INY
	STY $E001

	LDY #$1
	STY $E008
	STY $E009


	;LDA sysFlags				; set flag
	;ORA #sysObjectSprites
	;STA sysFlags

	;LDA #$05
	;JMP replaceState

	JSR pullAndBuildStateStack
	.db 3
	.db $05								; load map
	.db $29, %00000100 		; set sys flag: show object sprites
