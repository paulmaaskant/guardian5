;-----------------------------------------
; updateCamera
; used to scroll when cursor is near edge of the screen
;
; IN cursorGridPos
; OUT cameraYDest, cameraXDest
;-----------------------------------------
updateCamera:
	LDA cursorGridPos
	JSR gridPosToScreenPos																												; sets currentObject_Pos
	LDA currentObjectYPos																													; if cursor screen pos < 70
	CMP #$46
	BCS +
	LDA #$F0																																			; move camera Y up by 16 px
	JSR updateCameraYPos
+	LDA currentObjectYPos																													; if cursor screen pos > 200
	CMP #$A8
	BCC +downScrollDone																														; then skip scroll
	LDA #$10																																			;
	JSR updateCameraYPos																													; move camera Y down by 16 px

+downScrollDone:
	LDA currentObjectXPos			; if screen pos > 224 = 128+64+32
	CMP #224
	BCC +rightScrollDone			; then skip scroll


	LDA blockInputCounter
	CLC
	ADC #$04
	STA blockInputCounter

	LDA #$18									; + 24
	JSR updateCameraXPos

+rightScrollDone:
	LDA currentObjectXPos			; if screen pos < 40
	CMP #$28
	BCS +

	LDA blockInputCounter
	CLC
	ADC #$04
	STA blockInputCounter

	LDA #$E8						; -24							; A is signed
	JMP updateCameraXPos						; tail chain
+	RTS
