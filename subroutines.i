
















;-----------------------------------------
; updateCamera
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
	CMP #$E0
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
	ADC cameraXDest+1
	STA cameraXDest+1
	LDA cameraXDest+0
	ADC #$00
	STA cameraXDest+0
	BPL +
	LDA #$00
	STA cameraXDest+0
	STA cameraXDest+1
+	CMP #$02
	BCC +done
	BNE +limit
	LDA cameraXDest+1
	CMP #$00
	BCC +done
+limit:
	LDA #$02
	STA cameraXDest+0
	LDA #$00
	STA cameraXDest+1
+done:
	RTS

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
	CMP #$70
	BCC +done
+limit:
	LDA #$00
	STA cameraYDest+0
	LDA #$70
	STA cameraYDest+1
+done:
	RTS

;-----------------------------------------
; load target object
;	IN
;-----------------------------------------
updateTargetObject:
	LDA activeObjectGridPos
	STA par1
	LDA cursorGridPos
	JSR distance
	STA distanceToTarget

	LDX #$00
	STX targetObjectIndex
	STX targetObjectTypeAndNumber
-loop:
	LDA objectTypeAndNumber, X
	AND #$07
	ASL
	ASL
	TAY
	LDA object+3, Y
	CMP cursorGridPos
	BEQ +setObjectAsTarget
	INX
	CPX objectCount
	BNE -loop
	RTS
+setObjectAsTarget:
	STY targetObjectIndex
	LDA objectTypeAndNumber, X
	STA targetObjectTypeAndNumber
	RTS


;------------------------------------------
; Update Target Menu
; called when cursor has moved
; still very messy
; -----------------------------------------
updateTargetMenu:
	;---- show distance to target ---
	LDA distanceToTarget
	JSR toBCD
	LDA #$3E
	STA targetMenuLine3+3
	LDA par2
	STA targetMenuLine3+4
	LDA par3
	STA targetMenuLine3+5

	;--- determine the target type (unit or empty node)
	LDA targetObjectTypeAndNumber
	BNE +displayTarget
	JMP showHexagon				; tail chain

+displayTarget:
	CMP activeObjectTypeAndNumber
	BEQ +done

	; --- target stats ---
	LDA #$3C
	STA targetMenuLine1+3
	LDA #$0F
	STA targetMenuLine1+4
	STA targetMenuLine2+4
	LDA #$0B
	STA targetMenuLine1+5
	STA targetMenuLine2+5

	LDA #$3D
	STA targetMenuLine2+3


	;LDA #$1F

	BIT actionMessage					; check for invalid target
	BMI +done							; skip power & hit

	; --- hit points ---
	LDA list3+12
	STA targetMenuLine1+4
	LDA list3+13
	STA targetMenuLine1+5

+done:
	JMP showTargetMech					; tail chain

; ------------------------------------------
; retrieves dail position address
; IN A (object)TypeAndNumber
; OUT pointer1, fixed stats
; OUT Y , pointer1 + Y = current stats
; OUT A, current dail pos
; ------------------------------------------
getStatsAddress:
	PHA
	AND #%00000111
	ASL
	ASL
	TAY

	PLA
	AND #%01111000
	LSR
	LSR
	LSR
	TAX
	LDA objectTypeL, X
	CLC
	ADC #$0D
	STA pointer1+0
	LDA objectTypeH, X
	ADC #$00
	STA pointer1+1

	LDA object+1, Y					; current dail pos
	LSR
	LSR								; 3x shift right
	LSR
	PHA
	TAY								; multiply by 3 (3 bytes per dail click)
	ASL								; carry is guaranteed 0
	ADC identity, Y
	TAY
	PLA								; current dail pos in A
	RTS
