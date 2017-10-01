


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
