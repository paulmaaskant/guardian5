
; list1+0

state_ai_test:
  LDA frameCounter
  AND #$0F
  BNE +done

-next:
  INC list1+0
  LDX list1+0

  LDA nodeMap, X
  AND #%00010000
  BEQ -next

  LDA effects
	ORA #$01
	STA effects

  TXA
	JSR gridPosToScreenPos
	BCC +done											; off screen!
	LDA currentObjectXPos
	STA currentEffects+6
	LDA currentObjectYPos
	STA currentEffects+12
	LDA #10
	STA currentEffects+0
	LDA #0
	STA currentEffects+18
	STA currentEffects+24


+done:

  LDA blockInputCounter
  BEQ +controlCamera				  ; if timer is still running, then skip input processing
  DEC blockInputCounter			; timer still running
  RTS

+controlCamera:
	LSR buttons					; roll bits into carry flag
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
+
  LDA #$08
	STA blockInputCounter

	LDA events
	ORA event_updateSprites
	STA events

	RTS
