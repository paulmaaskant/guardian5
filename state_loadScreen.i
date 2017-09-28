; ------------------------------------------
; gameState 0E: Load cycle to fill up the screen
; ------------------------------------------
; list1+0 = number of cycles
state_loadScreen:
  LDA list1
  CMP #$20
  BNE +continue

  LDA sysFlags
  AND #%11101111
  STA sysFlags

+continue:
	JSR write32Tiles				; push 64 tiles per cycle
	DEC list1
	BEQ +continue
	JSR write32Tiles
	DEC list1
	BEQ +continue
	RTS								;

	; --- load complete ---
+continue:
  LDA #$00
  STA cameraYStatus
  LDA #$2E			; y pos
  STA $0200			; y pos

  JMP pullState
