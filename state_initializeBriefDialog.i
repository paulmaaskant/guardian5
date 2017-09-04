state_initializeBriefDialog:

  LDA #< brief1Stream			; intro story stream hi
  STA bytePointer+0
  LDA #> brief1Stream			; intro story stream lo
  STA bytePointer+1

  LDA #$25
  STA list1+0					; start address hi
  STA list1+2
  LDA #$44
  STA list1+1					; start address lo
  STA list1+3

  LDA #$04
  STA list1+4					; # tiles: offset
  LDA #$1C
  STA list1+5					; # tiles: last pos

  LDA #$00
  STA list1+6					; stream on

  LDA #$22
  STA list1+8					; game state once stream is over: title screen

  LDA #$09
  STA gameState

  RTS
