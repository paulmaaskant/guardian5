state_initializeDialog:
  JSR pullState           ; discard current state_initializeDialog
  JSR pullState           ; get parameter
  TAY

  LDA state01_streamHi, Y
  STA bytePointer+0
  LDA state01_streamLo, Y
  STA bytePointer+1

  LDA state01_positionHi, Y
  STA list1+0
  STA list1+2
  LDA state01_positionLo, Y
  STA list1+1							; start address lo
  STA list1+3

  LDA state01_lastCol, Y
  STA list1+5

  LDA #$00
  STA list1+6

  LDA #$09
  JMP pushState

state01_streamLo:
  .db #> storyStream
  .db #> brief1Stream
  .dsb 7
  .db #> accomplishedStream
  .db #> pausedStream
  .db #> instructionStream
state01_streamHi:
  .db #< storyStream
  .db #< brief1Stream
  .dsb 7
  .db #< accomplishedStream
  .db #< pausedStream
  .db #< instructionStream
state01_positionHi:
  .db $25
  .db $25
  .dsb 7
  .db $27
  .db $27
  .db $25
state01_positionLo:
  .db $44
  .db $64
  .dsb 7
  .db $6A
  .db $6A
  .db $44
state01_lastCol:
  .db $1C
  .db $1C
  .dsb 7
  .db $1C
  .db $1C
  .db $1C
