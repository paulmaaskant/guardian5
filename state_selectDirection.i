; ------------------------------------------
; gameState 07: Wait for player to confirm spin direction
; ------------------------------------------
state_selectDirection:
	BIT buttons						;
	BVS +controlCamera		; B
	BMI +confirm					; A

	LDX activeObjectIndex			; get current facing direction
	LDA object, X					;
	AND #$07						;
	STA locVar1						;

	LDA buttons						;
	AND #%00000101					; down or right
	BNE +clock

	LDA buttons						;
	AND #%00001010					; left or up
	BNE	+counterClock

	RTS

+clock:
	INC locVar1
	LDA #$07
	CMP locVar1
	BNE +setDirection
	LDA #$01
	STA locVar1
	JMP +setDirection

+counterClock:
	DEC locVar1
	BNE +setDirection
	LDA #$06
	STA locVar1
	JMP +setDirection

+controlCamera:
	LSR buttons							; roll bits into carry flag
	BCC +
	LDA #$10
	JSR updateCameraXPos
+	LSR buttons
	BCC +
	LDA #$F0
	JSR updateCameraXPos		; carry is set: A is signed
+	LSR buttons
	BCC +
	LDA #$10
	JSR updateCameraYPos
+	LSR buttons
	BCC +
	LDA #$F0
	JSR updateCameraYPos		; carry is set: A is signed
+	JMP +done

+confirm:
	;LDA events
	;ORA event_confirmAction
	;STA events

	LDA #$00
	STA menuFlags
	JMP pullState
	; BEQ +done						; JMP

+setDirection:
	LDA object+0, X
	AND #%11111000					; clear direction bits
	ORA locVar1							; set new direction
	STA object, X


	LDY activeObjectGridPos
	AND #%00000111
	ORA #%11000000
	STA nodeMap, Y
	AND #%00000111
	TAX
	JSR setTile

	LDY #sMechStep
	JSR soundLoad

+done:
	LDA #$08
	STA blockInputCounter

	JSR buildStateStack
	.db 1
	.db $1A					; wait
