


; ------------------------------------------
; gameState 02: fade out fade in
; ------------------------------------------
; list2+0 = counter
;
; list2+2 = brightness
; list2+3 = b7 fade out (0) / fade in (1)
; list2+4 = mask to control timing
; list2+5 = -40 (to black) or +40 (to white)
;
; ------------------------------------------
state_fadeInOut:
	LDA list2+0
	AND list2+4
	BNE +done

	LDA #$10
	CLC
	BIT list2+3
	BMI +										; fading in, so +10
	EOR #$FF								; fading out, so -10
	SEC
+	ADC list2+2
	STA list2+2
	BEQ +complete						; 0 (normal colours)
	CMP list2+5							; -40 (everyting black) or +40 (everyting white)
	BNE +continue

+complete:
	PHA
	JSR pullState
	PLA

+continue:
	JSR updatePalette

+done:
	INC list2+0
	RTS



; ------------------------------------------
; gameState 05: Load level map cycle
; ------------------------------------------
state_loadLevelMapTiles:
	LDA cameraY+1						; use regular scrolling to fill NT
	BNE +stillLoading				; once camera is back on 0, the NT is f

	;---- Level load complete ----
	LDA sysFlags
	ORA sysFlag_splitScreen			; switch on split screen
	STA sysFlags

	JMP pullState

+stillLoading:
	SEC										; speed up loading
	SBC #$06							; speed up camera scroll
	BCC +									; make sure not to go negative
	STA cameraY+1
+	RTS

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


; ------------------------------------------
; gameState 0F: clear all tiles in text dialogue box on screen
; ------------------------------------------
; list1+0 address start tile hi
; list1+1 address start tile lo
; list1+2 address current tile hi
; list1+3 address current tile lo
; list1+4 # tiles margin left
; list1+5 # tiles new line break tile pos
; list1+6 reserved
; list1+7 number of lines to clear
state_clearDialog:

	LDA list1+5
	SEC
	SBC list1+4
	TAY
	ASL
	STA locVar1

	TSX						; switch stack pointers
	STX	stackPointer1
	LDX stackPointer2
	TXS

	LDA #$0F
-	PHA
	DEY
	BNE -

	LDA list1+1				; lo
	PHA
	LDA list1+0				; hi
	PHA
	LDA locVar1
	PHA

	TSX						; switch stack pointers back
	STX	stackPointer2
	LDX stackPointer1
	TXS

	DEC list1+7
	BNE +nextLine

	LDA list1+2				; set back current address to first char position
	STA list1+0
	LDA list1+3
	STA list1+1

	JMP pullState			; return to previous state

+nextLine:
	LDA #$20
	CLC
	ADC list1+1
	STA list1+1
	LDA list1+0
	ADC #$00
	STA list1+0

	RTS
