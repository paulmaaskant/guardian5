; --------------------------------------------------------
; evaluate all untriggered mission events
; --------------------------------------------------------
state_checkMisionEvents:
  LDA missionEventStreamPointer+0
  STA bytePointer+0
  LDA missionEventStreamPointer+1
  STA bytePointer+1
  LDA #0
  STA locVar1

-loop:
  JSR getNextByte
  STA locVar2
  CMP #0
  BNE +continue

  LDA #$C0
  STA effects

  JMP pullState

+continue:
  JSR getMissionEventFlag
  AND missionEvents, Y                ; mask the flag corresponding with event #
  BNE +nextEvent                      ; event complete -> check next event

  ; process op codes: conditions and events
  LDY #0

-nextOpCode:
  LDA (bytePointer), Y
  TAX
  LDA missionEventOpCodeHi, X
  STA pointer1+1
  LDA missionEventOpCodeLo, X
  STA pointer1+0
  JMP (pointer1)                      ; execute OpCode

+nextEvent:
-nextEvent:
  INC locVar1

  LDA bytePointer+0
  CLC
  ADC locVar2
  STA bytePointer+0
  LDA bytePointer+1
  ADC #0
  STA bytePointer+1
  JMP -loop

  ; ---------------------------------
  ; current mission round => parameter
  ; ---------------------------------
missionConditionRound:
  INY
  LDA missionRound
  CMP (bytePointer), Y
  BCC -nextEvent       ; condition not satisfied
  INY
  BNE -nextOpCode

  ; ---------------------------------
  ; satisfied if number of pilot Y occurrences == X
  ; ---------------------------------
missionConditionPilotCount:
  INC debug
  INY
  LDA (bytePointer), Y
  ASL
  ASL
  STA locVar4                 ; parameter 1 (pilot index)
  INY
  LDA #0
  STA locVar5                 ; occurance count

  LDX objectListSize

-loop:
  STX locVar3
  LDA objectList-1, X
  AND #%01111000
  TAX
  LDA object+4, X
  AND #%01111100              ; pilot ID
  CMP locVar4                 ; object pilot index == parameter pilot index?
  BNE +skip                   ; no -> try next object
  INC locVar5                 ; yes -> increase counter

+skip:
  LDX locVar3
  DEX
  BNE -loop

  LDA locVar5
  CMP (bytePointer), Y
  BNE -nextEvent              ; fail
  INY
  BNE -nextOpCode             ; success

  ; ---------------------------------
  ; check if only friendlies remain
  ; ---------------------------------
missionConditionOnlyFriendlies:
  LDX objectListSize
  LDA #0

-loop:
  ORA objectList-1, X
  DEX
  BNE -loop
  AND #%00000011
  CMP #1
  BNE -nextEvent      ; condition not satisfied
  INY
  BNE -nextOpCode     ; success

  ; ---------------------------------
  ; check if only hostiles remain
  ; ---------------------------------
missionConditionOnlyHostiles:
  LDX objectListSize
  LDA #0

-loop:
  ORA objectList-1, X
  DEX
  BNE -loop
  AND #%00000011
  CMP #2
  BNE -nextEvent      ; condition not satisfied
  INY
  BNE -nextOpCode     ; success

  ; ------------------------------
  ; check if pilot 6 reached the mission target node
  ; ------------------------------
missionConditionNodeReached:
  LDX activeObjectIndex
  LDA object+4, X
  AND #%01111100
  CMP #24
  BNE -nextEvent      ; condition not satisfied
  LDA object+3, X
  CMP missionTargetNode
  BEQ +success
  JMP -nextEvent      ; condition not satisfied

+success:
  INY
  JMP -nextOpCode     ; success

; ---------------------------------
; open a HUD dialog
; ---------------------------------
missionEventOpenDialog:
  INY
  LDA (bytePointer), Y
  STA missionDialogStream

  JSR getMissionEventFlag           ; check off the event flag
  ORA missionEvents, Y              ; Y is destroyed
  STA missionEvents, Y

  JSR buildStateStack
  .db 9
  .db $20, 0					              ; load menu BG 0: dialog
  .db $01, 255					            ; load stream 255: mission parameter
  .db $30							              ; restore active unit portrait
  .db $20, 1					              ; load menu BG 1: hud
  .db $31, #eUpdateTarget           ; raise event


; ---------------------------------
; new unit on map
; ---------------------------------
missionEventNewUnit:
  INY
  STY list1+1                       ; store current read position of the event bytestream
                                    ; this is needed for the spwan unit state

  JSR getMissionEventFlag           ; check off the event flag
  ORA missionEvents, Y              ; Y is destroyed
  STA missionEvents, Y

  JSR buildStateStack
  .db 2
  .db $57				                    ; spawn unit
  .db $0B                           ; center on cursor (back to active unit)

; ---------------------------------
; play sound
; ---------------------------------
missionEventPlaySound:
  INY
  LDA (bytePointer), Y
  TAY
  JSR soundSilence
  JSR soundLoad

  JSR getMissionEventFlag           ; check off the event flag
  ORA missionEvents, Y              ; Y is destroyed
  STA missionEvents, Y

  JMP -nextEvent

; ---------------------------------
; mission accomplished
; ---------------------------------
missionEventMissionAccomplished:
  INY
  LDA (bytePointer), Y
  STA missionDialogStream
  INY
  LDA (bytePointer), Y
  STA missionEpilogScreen

  JSR pullAndBuildStateStack
  .db 11								; # items
  .db $0D, 0						; change brightness 0: fade out
  .db $00, 255					; load screen 255: missionEpilogScreen
  .db $0D, 1						; change brightness 1: fade in
  .db $01, 255					; load stream 255: missionDialogStream
  .db $0D, 0						; change brightness 0: fade out
  .db $36						    ; title menu
  ; built in RTS

; ---------------------------------
; mission failed
; ---------------------------------
missionEventMissionFailed:
  INY
  LDA (bytePointer), Y
  STA missionDialogStream
  INY
  LDA (bytePointer), Y
  STA missionEpilogScreen

  JSR pullAndBuildStateStack
  .db 11								; # items
  .db $0D, 0						; change brightness 0: fade out
  .db $00, 255					; load screen 255: missionEpilogScreen
  .db $0D, 1						; change brightness 1: fade in
  .db $01, 255					; load stream 255: missionDialogStream
  .db $0D, 0						; change brightness 0: fade out
  .db $36						    ; title menu
  ; built in RTS

; -------------------------------------------
;  helper function
;  IN locVar1 mission event #
;  OUT Y  missionEvent byte 0, 1, 2, or 3
;  OUT A  mask for missionEvent bit
; -------------------------------------------
getMissionEventFlag:
  LDA locVar1
  LSR
  LSR
  LSR
  TAY
  LDA locVar1
  AND #7
  TAX
  LDA #0
  SEC

-loop:
  ROL
  DEX
  BPL -loop
  RTS

  ; ---------------------------------
  ; opCode jump table
  ; ---------------------------------
missionEventOpCodeHi:
  db #> missionEventOpenDialog                   ; 0
  db #> missionConditionRound                    ; 1
  db #> missionConditionOnlyFriendlies           ; 2
  db #> missionConditionOnlyHostiles             ; 3
  db #> missionEventMissionAccomplished          ; 4
  db #> missionEventNewUnit                      ; 5
  db #> missionConditionNodeReached              ; 6
  db #> missionConditionPilotCount               ; 7
  db #> missionEventPlaySound                    ; 8
  db #> missionEventMissionFailed                ; 9

missionEventOpCodeLo:
  db #< missionEventOpenDialog
  db #< missionConditionRound
  db #< missionConditionOnlyFriendlies
  db #< missionConditionOnlyHostiles
  db #< missionEventMissionAccomplished
  db #< missionEventNewUnit
  db #< missionConditionNodeReached
  db #< missionConditionPilotCount
  db #< missionEventPlaySound                    ; 8
  db #< missionEventMissionFailed                ; 9
