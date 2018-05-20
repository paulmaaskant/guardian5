; ------------------------------------------
; gameState 00: Initialize title screen
; ------------------------------------------
state_initializeScreen:
	JSR pullParameter							; pull state parameter into A
	TAY														; and transfer to Y
	CPY #255
	BNE +continue
	LDY missionEpilogScreen

+continue:
	LDA state00_screenHi, Y
	STA bytePointer+0
	LDA state00_screenLo, Y
	STA bytePointer+1

	LDA #$0
	STA effects
	STA $E008

	LDA state00_tileBank1, Y
	STA $E000

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

	LDA #28
	STA portraitXPos
	LDA #43
	STA portraitYPos

	JSR buildStateStack
	.db 3 								; # items
	.db $32, %00100100		; clear sys flags
	.db $0E								; load screen



state00_screenLo:
	.db #> titleScreen2								; 00 title screen background
	.db #> blankScreen								; 01 introduction story background
	.db #> briefScreen								; 02 mission brief background
	.db #> statusBar									; 03 status bar
	.db #> blankScreen								; 04 instructions background
	.db #> animationScreen						; 05 play animation background
	.db #> missionAccomplishedScreen	; 06 mission accomplished bg
	.db #> blankScreen								; 07 mission failed bg

state00_screenHi:
	.db #< titleScreen2
	.db #< blankScreen
	.db #< briefScreen
	.db #< statusBar
	.db #< blankScreen
	.db #< animationScreen
	.db #< missionAccomplishedScreen
	.db #< blankScreen

state00_sound:
	.db $00
	.db $02
	.db $C0									; silence
	.db $04
	.db $C0									; silence
	.db $05									;
	.db $05
	.db $02

state00_tileBank1:
	.db $07
	.db $05
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
	.db 0
state00_tilePall1:
	.db 3
	.db 1
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
	.db 2
state00_tilePall3:
	.db 3
	.db 3
	.db 3
	.db 3
	.db 3
	.db 3
	.db 3
	.db 3
