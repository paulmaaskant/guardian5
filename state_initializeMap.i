; ------------------------------------------
; gameState 04: Initialize level variables
; ------------------------------------------
state_initializeMap:
	; clean up events, node map & objects first
	LDA #0
	LDX #4

-loop:
	STA missionEvents-1, X				; 0, 1, 2, 3
	DEX
	BNE -loop

-loop:
	STA nodeMap, X
	DEX
	BNE -loop

	LDY mission
	LDA missionEventsLo, Y
	STA missionEventStreamPointer+0
	LDA missionEventsHi, Y
	STA missionEventStreamPointer+1

	LDA missionSetupLo, Y
	STA bytePointer+0
	LDA missionSetupHi, Y
	STA bytePointer+1

	LDA #$9			; pallete 1 for map 1
	STA currentPalettes

	JSR getNextByte
	STA list1+4

	JSR getNextByte
	STA missionMapSettings

	JSR getNextByte
	STA missionMap+0

	JSR getNextByte
	STA missionMap+1

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
	; ---------------------------------
	; block nodes outside of map's dimensions
	; ---------------------------------
	LDY missionMapSettings
	LDA mapDimL, Y
	ASL
	ASL
	ASL
	ASL
	STA locVar1

	LDX #0

-loop:
	TXA
	AND #$F0
	CMP locVar1
	BEQ +continue
	BCS +blocked

+continue:
	TXA
	AND #$0F
	CMP mapDimW, Y
	BEQ +nextNode
	BCS +blocked
	BCC +nextNode

+blocked:
	LDA #$FF
	STA nodeMap, X

+nextNode:
	DEX
	BNE -loop

	; -- object info ---
	JSR getNextByte						; number of object on map
	STA list1+3

	LDA list1+4
	STA objectListSize

	LDX #0

-nextObject:
	STX list1+2
	TXA
	ASL
	ASL
	ASL														; A = object index

	CPX list1+4										; iterate over all objects
	BCC +playerUnit								; that are player units first, then
	CPX list1+3										; rest are enemy / obstacles
	BNE +continue
	BEQ +done

+playerUnit:										; player unit objects only require an update to their grid pos
	TAX														; object index
	JSR getNextByte								; grid pos
	STA object+3, X								; set directly
	JSR insertObjectGridPosOnly		;
	JMP +endOfLoop

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

+endOfLoop:
	LDX list1+2
	INX
	BNE -nextObject

+done:

	LDX objectListSize:						; ---------------------------
																; adjust initial object stats for pilot traits / equipment
																; ---------------------------
-loop:
	LDA objectList-1, X
	AND #%10000111								; pilot bits
	BEQ +next											; object is an obstacle -> try next
	ASL
	BCC +continue									; move b7 to b3
	ORA #%00010000								;

+continue:
	ASL
	TAY
	LDA pilotTable-2, Y						; pilot traits
	AND #%00000100								; survivor trait (+2 armor)
	PHP														; save 0 flag

	LDA objectList-1, X
	AND #%01111000								; object index
	TAY

	PLP														; restore 0 flag
	BEQ +noSurvivor

	LDA object+1, Y
	CLC
	ADC #16												; +2 (shifted left 3x)
	STA object+1, Y

+noSurvivor:
	LDA #itemArmor								; object has extra armor
	JSR isEquipped
	BCC +next

	LDA object+1, Y
	CLC
	ADC #16												; +2 (shifted left 3x)
	STA object+1, Y

+next:
	DEX
	BNE -loop

	LDY #7								; initialize camera variables
	LDA #0								;
												;
-loop:									;
	STA cameraY, Y				;
	DEY										;
	BPL -loop							;

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

missionSetupHi:
	db #>mission00Setup
	db #>mission01Setup
	db #>mission02Setup

missionSetupLo:
	db #<mission00Setup
	db #<mission01Setup
	db #<mission02Setup

missionEventsHi
	db #>mission00Events
	db #>mission01Events
	db #>mission02Events

missionEventsLo
	db #<mission00Events
	db #<mission01Events
	db #<mission02Events
