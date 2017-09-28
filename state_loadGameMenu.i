; list1+0 = number of cycles
state_loadGameMenu:

  INC debug

	JSR write32Tiles				; push 64 tiles per cycle
	DEC list1
	BEQ +continue
	;JSR write32Tiles
	;DEC list1
	;BEQ +continue
	RTS								;

	; --- load complete ---
+continue:

  JMP pullState
