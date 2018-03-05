; --------------------------
; A brightness (-64 +64
; --------------------------
updatePalette:
	STA locVar1								; adjustment value
	LDY #$07

-loop:
	LDX currentPalettes, Y

	LDA paletteColor1, X
	CLC
	ADC locVar1
	BPL +											; if color value becomes negative
	LDA #$0F									; make it BLACK (0F)
+	CMP #$3E
	BCC +											; if color vale becomes bigger than 60
	LDA #$30									; make it white
+	STA pal_color1, Y

	LDA paletteColor2, X
	CLC
	ADC locVar1
	BPL +
	LDA #$0F
+	CMP #$3E
	BCC +
	LDA #$30
+	STA pal_color2, Y

	LDA paletteColor3, X
	CLC
	ADC locVar1
	BPL +
	LDA #$0F
+	CMP #$3E
	BCC +
	LDA #$30
+	STA pal_color3, Y

	DEY
	BPL -loop

	LDA currentTransparant
	CLC
	ADC locVar1
	BPL +
	LDA #$0F
+	CMP #$3E
	BCC +
	LDA #$30
+	STA pal_transparant

	RTS
