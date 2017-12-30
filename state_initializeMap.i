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
	STA objectCount
	STA activeObjectTypeAndNumber	; set to the last object so that the next is the first

	LDX #0

-nextObject:
	CPX objectCount
	BEQ +done

	STX list1+2

	JSR getNextByte
	CLC
	ADC identity, X
	STA objectTypeAndNumber, X

	TXA
	ASL
	ASL
	TAX
	STX list1+3

	JSR getNextByte
	STA object+3, X						; set grid position

	JSR getNextByte						; get type & initial facing direction
	STA object+0, X

	AND #%00000111											; and block it in the node map
	ORA #%11000000
	LDY object+3, X
	STA nodeMap, Y

	LDY list1+3								; object index
	JSR getStatsAddress				; breaks X, sets pointer1

	LDY #0
	LDA (pointer1), Y

	LDX list1+3
	AND #%11111110
	STA object+1, X						; set health and actionpoints

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
