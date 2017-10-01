; ------------------------------------------
; gameState 00: Initialize title screen
; ------------------------------------------
state_initializeScreen:
	JSR pullState							; discard state
	JSR pullState							; pull state parameter
	TAY

	LDA state00_screenHi, Y
	STA bytePointer+0
	LDA state00_screenLo, Y
	STA bytePointer+1
	LDA state00_sound, Y
	BMI +noSound
	TAY
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
	.db #> titleScreen
	.db #> storyScreen
	.db #> briefScreen
	.db #> statusBar

state00_screenHi:
	.db #< titleScreen
	.db #< storyScreen
	.db #< briefScreen
	.db #< statusBar

state00_sound:
	.db $00
	.db $01
	.db $C0									; silence
	.db $04									; silence