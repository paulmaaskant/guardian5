; $50

state_controlCamera:
;  LDA #1
;  STA objectListSize

  LDA buttons
  BNE +
  RTS


+ LSR buttons							; roll bits into carry flag
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
+ LDA #7
  STA blockInputCounter

  JSR buildStateStack
  .db 1
  .db $1A					; wait
