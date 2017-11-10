; ------------------------------------------
; gameState 00: Initialize title screen
; ------------------------------------------
state_initializeScreen:
	JSR pullState									; discard state
	JSR pullState									; pull state parameter into A
	TAY														; and transfer to Y

	LDA state00_screenHi, Y
	STA bytePointer+0
	LDA state00_screenLo, Y
	STA bytePointer+1

	LDA state00_tileBank1, Y
	STA $D001

	LDA state00_tilePall0, Y
	STA currentPalettes+0

	LDA state00_tilePall1, Y
	STA currentPalettes+1

	LDA state00_tilePall2, Y
	STA currentPalettes+2

	LDA state00_tilePall3, Y
	STA currentPalettes+3

	LDA state00_sound, Y
	BMI +noSound
	TAY

	JSR soundSilence
	JSR soundLoad
	JMP +done

+noSound:
	ASL
	BPL +done
	JSR soundSilence

+done
	LDA #$24																																			; set VRAM address for status bar
	STA list1+1																																; $[24]00
	LDA #$00
	STA list1+2																																; $24[00]
	LDA #$20																																			; full screen 32 rows
	STA list1+0

	; next game state ---
	LDA #$0E
	JMP pushState


state00_screenLo:
	.db #> titleScreen2								; 00 title screen background
	.db #> blankScreen								; 01 introduction story background
	.db #> briefScreen								; 02 mission brief background
	.db #> statusBar									; 03 status bar
	.db #> blankScreen								; 04 instructions background
	.db #> animationScreen						; 05 play animation background
	.db #> missionAccomplishedScreen	; 06 mission accomplished bg

state00_screenHi:
	.db #< titleScreen2
	.db #< blankScreen
	.db #< briefScreen
	.db #< statusBar
	.db #< blankScreen
	.db #< animationScreen
	.db #< missionAccomplishedScreen

state00_sound:
	.db $00
	.db $01
	.db $C0									; silence
	.db $04
	.db $C0									; silence
	.db $05									;
	.db $05

state00_tileBank1:
	.db $07
	.db $05
	.db $05
	.db $05
	.db $05
	.db $05
	.db $05

state00_tileBank2:
state00_tileBank3:

state00_tilePall0:
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
state00_tilePall1:
	.db 3
	.db 1
	.db 1
	.db 1
	.db 1
	.db 1
	.db 1
state00_tilePall2:
	.db 1
	.db 2
	.db 2
	.db 2
	.db 2
	.db 2
	.db 2
state00_tilePall3:
	.db 3
	.db 3
	.db 3
	.db 3
	.db 3
	.db 3
	.db 3
