; ------------------------------------------
; gameState 0D: prepare for intro story stream
; ------------------------------------------
state_initializeIntroDialog:

	LDA #< storyStream			; intro story stream hi
	STA bytePointer+0
	LDA #> storyStream			; intro story stream lo
	STA bytePointer+1

	LDA #$25
	STA list1+0							; start address hi
	STA list1+2
	LDA #$44
	STA list1+1							; start address lo
	STA list1+3

	LDA #$1C
	STA list1+5							; # tiles: last pos
	LDA #$00
	STA list1+6							; stream on

	LDA #$09
	JMP replaceState
