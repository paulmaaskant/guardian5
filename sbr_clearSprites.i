;------------------------------------------
; clear sprites v2
; IN 	par3 = from sprite (0-63)
; IN 	A = through sprite (0-63)
; LOC	X, Y
;-----------------------------------------
clearSprites:
	TAY
-loop:
	CPY par3
	BCC +done		; locvar < par3
	ASL
	ASL
	TAX
	LDA #$FF
	STA $0200, X
	DEY
	TYA
	JMP -loop
+done:
	RTS
