; -------------------------------------------
; update Camera Y position
;
; IN 	A				number of pixels to be added
; OUT	cameraYDest
; -------------------------------------------
updateCameraYPos:
	BPL +
	DEC cameraYDest+0
+	CLC
	LDY missionMapSettings
	ADC cameraYDest+1
	STA cameraYDest+1
	LDA cameraYDest+0
	ADC #$00
	STA cameraYDest+0
	BPL +
	LDA #$00
	STA cameraYDest+0
	STA cameraYDest+1
+	CMP #$00
	BCC +done
	BNE +limit
	LDA cameraYDest+1
	CMP mapMaxCameraYLo, Y												;max camera Y
	BCC +done
+limit:
	LDA #$00
	STA cameraYDest+0
	LDA mapMaxCameraYLo, Y												;max camera Y
	STA cameraYDest+1
+done:
	RTS
