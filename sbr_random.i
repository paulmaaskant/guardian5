;------------------------------------------
; random 255
;
; IN OUT 	seed
; OUT A 	random byte
;------------------------------------------
random:
	LDX #$08
	LDA seed+0
--	ASL
	ROL seed+1
	BCC +
	EOR #$2D
+	DEX
	BNE --
	STA seed+0
	CMP #$00
	RTS
