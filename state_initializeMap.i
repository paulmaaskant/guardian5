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

	; --- map collision & object tile data ---

-outterLoop:
	JSR getNextByte
	CMP #0
	BEQ +continue
	STA list1+0					; iterations
	JSR getNextByte
	STA list1+1					; tile byte

-innerLoop:
	JSR getNextByte
	TAX
	LDA list1+1
	STA nodeMap, X
	DEC list1+0
	BNE -innerLoop
	BEQ -outterLoop

+continue:
	; -- object info ---
	JSR getNextByte
	STA objectListSize
	STA activeObjectTypeAndNumber	; set to the last object so that the next is the first

	LDX #0

-nextObject:
	CPX objectListSize
	BEQ +done
	STX list1+2

	JSR getNextByte					; get pilot (b7, b2-b0)
	STA locVar1

	TXA
	ASL											; 8 bytes per object
	ASL
	ASL
	ORA locVar1
	STA objectList, X
	AND #%01111000
	TAX
	STX list1+3								; index

	JSR getNextByte
	STA object+3, X						; set grid position

	JSR getNextByte						; get type & initial facing direction
	PHA
	AND #%11110111
	STA object+0, X

	PLA
	AND #%00001111						; and block it in the node map
	ORA #%11000000
	LDY object+3, X
	STA nodeMap, Y

	LDY list1+3								; object index
	JSR getStatsAddress				; breaks X, sets pointer1

	LDX list1+3
	LDY #1										; initial hit points / heat points
	LDA (pointer1), Y
	STA object+1, X						; set health and heat points

	LDX list1+2
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

	LDY #18								; hardcoded bank change to level 1 tiles
	STY $E000
	INY
	STY $E001
	LDY #$1
	STY $E008
	STY $E009

	JSR pullAndBuildStateStack
	.db 3
	.db $05								; load map
	.db $29, %00000100 		; set sys flag: show object sprites
