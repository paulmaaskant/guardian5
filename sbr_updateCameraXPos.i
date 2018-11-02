; -------------------------------------------
; update Camera X position
;
; IN 	A				number of pixels to be added
; OUT	cameraYDest
; -------------------------------------------
updateCameraXPos:
	BPL +
	DEC cameraXDest+0
+	CLC
	LDY missionMapSettings
	ADC cameraXDest+1
	STA cameraXDest+1
	LDA cameraXDest+0
	ADC #$00
	STA cameraXDest+0
	BPL +
	LDA #$00
	STA cameraXDest+0
	STA cameraXDest+1
+	CMP mapMaxCameraXHi,Y												;02
	BCC +done
	BNE +limit
	LDA cameraXDest+1
	CMP mapMaxCameraXLo,Y												; 0
	BCC +done
+limit:
	LDA mapMaxCameraXHi,Y												; 02
	STA cameraXDest+0
	LDA mapMaxCameraXLo,Y												; 0
	STA cameraXDest+1
+done:
	RTS
