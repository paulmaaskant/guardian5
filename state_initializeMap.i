; ------------------------------------------
; gameState 04: Initialize level variables
; ------------------------------------------
state_initializeMap:
	LDA #< levelOne
	STA bytePointer+0
	LDA #> levelOne
	STA bytePointer+1

	LDA #$9			; pallete 1 for map 1
	STA currentPalettes

	LDA #3
	STA $C001                 ; set lvl 1 enemy sprites (3) in bank 3

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
	JSR getNextByte						; number of object on map
	STA list1+3

	LDA #3
	STA objectListSize

	LDX #0

-nextObject:
	STX list1+2
	TXA
	ASL
	ASL
	ASL														; A = object index

	CPX #3												; iterate over all objects
	BCC +playerUnit								; 0-2 are player units
	CPX list1+3										; rest are enemy / obstacles
	BNE +continue
	BEQ +done

+playerUnit:
	TAX														; object index
	JSR getNextByte								; grid pos
	STA object+3, X								; set directly
	JSR insertObjectGridPosOnly
	JMP +temp

+continue:
	TAX														; object index
	JSR getNextByte								; pilot
	STA locVar1										;
	JSR getNextByte								; grid pos
	STA locVar2										;
	JSR getNextByte								; type and facing direction
	STA locVar3										;
	JSR getNextByte								; equipment
	JSR insertObject							;

+temp:
	LDX list1+2
	INX
	JMP -nextObject

+done:

	;LDA #$00
	;STA cameraY+0
	;STA cameraX+0
	;STA cameraX+1
	;STA cameraXDest+0
	;STA cameraXDest+1
	;STA cameraYDest+0
	;STA cameraYDest+1

	LDY #7
	LDA #0

-loop:
	STA cameraY, Y
	DEY
	BPL -loop

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
