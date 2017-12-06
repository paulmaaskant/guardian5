; list1+0 = number of cycles
state_loadGameMenu:

	JSR write32Tiles				; push 32 tiles per cycle
	DEC list1
	BEQ +continue
	RTS

	; --- load complete ---
+continue:
  JMP pullState
