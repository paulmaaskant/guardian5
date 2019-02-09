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
  .db #> storyStream                ; 00
  .db #> mission01prologue          ; 01
  .db #> mission01epilogSuccess     ; 02
  .db #> mission01epilogFailed      ; 03
  .db #> mission00prologue          ; 04
  .db #> mission00epilogSuccess     ; 05
  .db #> mission00epilogFailed      ; 06
  .db #> hud_threeTurretsLeft       ; 07
  .db #> hud_twoTurretsLeft         ; 08
  .db #> hud_allHostilesDestroyed   ; 09
  .db #> hud_activityDetected       ; 10
  .db #> instructionStream          ; 11
  .db #> hud_missionFailed          ; 12
  .db #> hud_staySharp              ; 13
  .db #> hud_playerDestroyed        ; 14
  .db #> hud_convoyDestroyed        ; 15
  .db #> mission02prologue          ; 16
  .db #> mission03prologue          ; 17
  .db #> hud_oneTurretLeft          ; 18
  .db #> hud_allTurretsDestroyed    ; 19
  .db #> mission02epilogFailed      ; 20
  .db #> hud_takeOutTurrets         ; 21

state01_streamHi:
  .db #< storyStream
  .db #< mission01prologue
  .db #< mission01epilogSuccess
  .db #< mission01epilogFailed
  .db #< mission00prologue
  .db #< mission00epilogSuccess
  .db #< mission00epilogFailed
  .db #< hud_threeTurretsLeft       ; 07
  .db #< hud_twoTurretsLeft         ; 08
  .db #< hud_allHostilesDestroyed
  .db #< hud_activityDetected
  .db #< instructionStream
  .db #< hud_missionFailed
  .db #< hud_staySharp
  .db #< hud_playerDestroyed
  .db #< hud_convoyDestroyed
  .db #< mission02prologue          ; 16
  .db #< mission03prologue          ; 16
  .db #< hud_oneTurretLeft          ; 18
  .db #< hud_allTurretsDestroyed    ; 19
  .db #< mission02epilogFailed
  .db #< hud_takeOutTurrets         ; 21

state01_positionHi:
  .db $25
  .db $25
  .db $25
  .db $25
  .db $25
  .db $25
  .db $25
  .db $24
  .db $24
  .db $24
  .db $24
  .db $25
  .db $24
  .db $24
  .db $24
  .db $24
  .db $25
  .db $25
  .db $24
  .db $24
  .db $25
  .db $24

state01_positionLo:
  .db $44
  .db $64
  .db $88
  .db $64
  .db $64
  .db $88
  .db $64
  .db $46
  .db $46
  .db $46
  .db $46
  .db $44
  .db $46
  .db $46
  .db $46
  .db $46
  .db $64
  .db $64
  .db $46
  .db $46
  .db $64
  .db $46

state01_lastCol:
  .db $1C
  .db $1C
  .db $1E
  .db $1E
  .db $1C
  .db $1E
  .db $1E
  .db $1E
  .db $1E
  .db $1E
  .db $1E
  .db $1C
  .db $1E
  .db $1E
  .db $1E
  .db $1E
  .db $1C
  .db $1C
  .db $1E
  .db $1E
  .db $1E
  .db $1E

state01_lineCount:
  .db 6
  .db 13
  .db 8
  .db 13
  .db 13
  .db 8
  .db 13
  .db 3
  .db 3
  .db 3
  .db 3
  .db 8
  .db 3
  .db 3
  .db 3
  .db 3
  .db 13
  .db 13
  .db 3
  .db 3
  .db 13
  .db 3
