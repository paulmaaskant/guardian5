; ------------------------------------------
; gameState 1E: init title screen menu
; ------------------------------------------
state_initializeTitleMenu:
	JSR clearActionMenu

	LDY #$15
	LDX #$00
	JSR writeToActionMenu

	LDY #$17
	LDX #$0D
	JSR writeToActionMenu

	LDY #$16
	LDX #$1A
	JSR writeToActionMenu

	LDA #$2F
	STA menuIndicator+0

	LDA #$0F
	STA menuIndicator+1
	STA menuIndicator+2

	LDA #$00
	STA list1+0						; title screen animation counter
	STA list1+1						; title screen menu choice
	STA list1+2						; sound number

	JSR writeStartMenuToBuffer

	JMP pullState
