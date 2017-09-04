; ------------------------------------------
; Initialize screen
; ------------------------------------------
; list1+0 , number of tile rows
; list1+1 , next game state
; list1+2 , pointer byte stream hi
; list1+3 , pointer byte stream lo
; list1+4 , b7 fade in / b6 fade out
; ------------------------------------------
initializeScreen:
	LDA #$24																																			; set VRAM address for status bar
	STA pointer2+0																																; $[24]00
	LDA #$00
	STA pointer2+1																																; $24[00]
	LDA list1+2																																		; set byte stream address ---
	STA bytePointer+0
	LDA list1+3
	STA bytePointer+1
	LDA #$20																																			; full screen
	STA list1+0

	; --- determine next game state ---
	LDA #$0E							; goal game state "load screen"
	BIT list1+4						; fade out first?
	BVC +

	; --- set fade out parameters ---
	STA list2+1						; next next game state
	LDA #$00							; fade out parameters
	STA list2+0						; counter for fade out
	STA list2+2						; starting brightness
	STA list2+3						; fade out
	LDA #$07
	STA list2+4						; timing mask
	LDA #$C0
	STA list2+5						; all black

	LDA #$02							; game state "fade out"
+	STA gameState					; next gamestate
	RTS
