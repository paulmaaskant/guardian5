state_initializeDialog:
  JSR pullParameter        ; get parameter
  TAY
  CPY #255
  BNE +continue
  LDY missionDialogStream

+continue:
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
  .db #> mission01prolog
  .db #> mission01epilogSuccess
  .db #> mission01epilogFailed
  .dsb 5
  .db #> hud_allHostilesDestroyed
  .db #> hud_activityDetected
  .db #> instructionStream
  .db #> hud_missionFailed
  .db #> hud_staySharp
state01_streamHi:
  .db #< storyStream
  .db #< mission01prolog
  .db #< mission01epilogSuccess
  .db #< mission01epilogFailed
  .dsb 5
  .db #< hud_allHostilesDestroyed
  .db #< hud_activityDetected
  .db #< instructionStream
  .db #< hud_missionFailed
  .db #< hud_staySharp
state01_positionHi:
  .db $25
  .db $25
  .db $25
  .db $25
  .dsb 5
  .db $24
  .db $24
  .db $25
  .db $24
  .db $24
state01_positionLo:
  .db $44
  .db $64
  .db $88
  .db $64
  .dsb 5
  .db $46
  .db $46
  .db $44
  .db $46
  .db $46
state01_lastCol:
  .db $1C
  .db $1C
  .db $1E
  .db $1E
  .dsb 5
  .db $1E
  .db $1E
  .db $1C
  .db $1E
  .db $1E

state01_lineCount:
  .db 6
  .db 13
  .db 8
  .db 13
  .dsb 5
  .db 3
  .db 3
  .db 8
  .db 3
  .db 3
