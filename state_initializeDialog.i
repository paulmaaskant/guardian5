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

  LDA state01_lineCount, Y
  STA list1+8

  LDA #$00
  STA list1+6
  STA list1+9

  LDA #$09
  JMP pushState

state01_streamLo:
  .db #> storyStream
  .db #> brief1Stream
  .db #> brief2Stream
  .db #> brief3Stream
  .dsb 5
  .db #> accomplishedStream
  .db #> pausedStream
  .db #> instructionStream
  .db #> failedStream
state01_streamHi:
  .db #< storyStream
  .db #< brief1Stream
  .db #< brief2Stream
  .db #< brief3Stream
  .dsb 5
  .db #< accomplishedStream
  .db #< pausedStream
  .db #< instructionStream
  .db #< failedStream
state01_positionHi:
  .db $25
  .db $25
  .db $25
  .db $25
  .dsb 5
  .db $27
  .db $27
  .db $25
  .db $27
state01_positionLo:
  .db $44
  .db $64
  .db $64
  .db $64
  .dsb 5
  .db $6A
  .db $6A
  .db $44
  .db $6A
state01_lastCol:
  .db $1C
  .db $1C
  .db $1C
  .db $1C
  .dsb 5
  .db $1C
  .db $1C
  .db $1C
  .db $1C
state01_lineCount:
  .db 6
  .db 13
  .db 13
  .db 13
  .dsb 5
  .db 6
  .db 6
  .db 8
  .db 6
