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
