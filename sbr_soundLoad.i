; --------------------------------------
; soundLoad, play a sound
; IN Y, sound index
; --------------------------------------
soundLoad:
  STY soundHeader
  LDA soundFlags
  ORA bit5
  STA soundFlags
  RTS
