;------------------------------------------
; grid coordinates to screen position
;
; IN		A = hexagon = YYYYXXXX
; OUT 		currentObjectXPos = X screen position
; OUT 		currentObjectYPos = Y screen position
; OUT		carry flag, 1 set when on screen
; LOCAL 	locVar1
; LOCAL		locVar2
; LOCAL 	locVar3
; LOCAL		locVar4
;------------------------------------------
gridPosToScreenPos:
	STA locVar1																																		; store to retrieve X later
	AND	#$F0																																			; Y mask
	LSR
	STA locVar2																																		; store YYYY * 8

	SEC																																						; start by calculating
	LDA #$BF																																			; the screen position of grid 0,0
	SBC cameraY+1																																	; given the current camera position
	STA currentObjectYPos																													; w/o scrolling this would be (X=$20, Y=$BF)
	LDA #$00																																			; store it in the current coordinates
	STA locVar4																																		; reset variable 4 (has nothing to with SBC)
	SBC cameraY+0
	STA currentObjectYScreen
	SEC
	LDA #$20																																			;
	SBC cameraX+1																																	; offset to account for camera
	STA currentObjectXPos
	LDA #$00
	SBC cameraX+0
	STA currentObjectXScreen

	LDA locVar1																																		; determine X
	AND #$0F																																			; x mask
	ASL
	ASL
	ASL
	STA locVar1																																		; XXXX * 8, store for use later
	SEC																																						; calculate Y screen offset relative to grid 0,0
	SBC locVar2																																		; (XXXX - YYYY) * 8
	BPL +continue
	DEC currentObjectYScreen

+continue:
	CLC
	ADC currentObjectYPos
	STA currentObjectYPos																													; final Y screen position
	LDA currentObjectYScreen
	ADC #$00
	STA currentObjectYScreen																											; final Y screen

	LDA locVar1																																		; X screen is next
	CLC
	ADC locVar2
	STA locVar3																																		; (X+Y) * 8 (max value is 240)
	ASL 																																					; multiply locvar3 by 3
	ROL locVar4																																		; and store result in locvar3 (lo) and locVar4 (hi)
	ADC locVar3																																		; this is the X screen offset relative to grid 0,0
	STA locVar3
	LDA locVar4
	ADC #$00
	STA locVar4																																		; add the offset to current
	LDA locVar3
	ADC currentObjectXPos
	STA currentObjectXPos																													; final X screen position
	LDA currentObjectXScreen
	ADC locVar4
	STA currentObjectXScreen

	; --- check if object is within camera rectangle ---
	LDA currentObjectXScreen
	BNE +offScreen
	LDA currentObjectYScreen
	BNE +offScreen
	LDA currentObjectYPos
	CMP #$30
	BCC +offScreen
	CMP #$E0
	BCS +offScreen
	LDA currentObjectXPos
	CMP #$08
	BCC +offScreen
	CMP #$F9
	BCS +offScreen
	SEC
	RTS

+offScreen:
	CLC
	RTS
