; ------------------------------------------
; gameState 0A: Initialize spin direction state
; ------------------------------------------
state_initializeSetDirection:
	LDA events
	ORA event_refreshStatusBar		; buffer to screen
	STA events

	LDA #$0F ; 						; clear menu indicators
	STA menuIndicator+0
	STA menuIndicator+1

	LDA menuFlags							; switch on blinking for line 1 and 2
	ORA menuFlag_line1				; set flag
	ORA menuFlag_line2				; set flag
	STA menuFlags

	JSR clearActionMenu				; clear menu and write ...
	LDX #$00						; line 1, pos 0
	LDY #$0B						; "CHOOSE FACING DIRECTION"
	JSR writeToActionMenu			; tail chain

	LDA #$07
	JMP replaceState
