;-----------------------------------------
; absolute
;
; assumes A to be signed
;
; IN OUT A
;-----------------------------------------
absolute:
	BPL +continue
	EOR #%11111111
	CLC
	ADC #$01
+continue:
	RTS
