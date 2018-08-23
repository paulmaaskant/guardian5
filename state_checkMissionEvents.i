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
  BCC -nextEvent
  INY
  BNE -nextOpCode

  ; ---------------------------------
  ; check if only friendlies remain
  ; ---------------------------------
missionConditionOnlyFriendlies:
  LDX objectListSize
  LDA #00

-loop:
  ORA objectList-1, X
  DEX
  BNE -loop
  ASL
  BCS -nextEvent    ; failed -> go to next event
  INY
  BNE -nextOpCode   ; success -> check next condition

  ; ---------------------------------
  ; check if only hostiles remain
  ; ---------------------------------
missionConditionOnlyHostiles:
  LDX objectListSize

-loop:
  LDA objectList-1, X
  BMI +next
  AND #7
  BNE -nextEvent

+next:
  DEX
  BNE -loop
  INY
  BNE -nextOpCode

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
  JSR getMissionEventFlag           ; check off the event flag
  ORA missionEvents, Y              ; Y is destroyed
  STA missionEvents, Y

  JSR buildStateStack
  .db 2
  .db $57				                    ; spawn unit
  .db $0B

; ---------------------------------
; end the mission
; ---------------------------------
missionEventEndMission:
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
  .db #> missionEventOpenDialog
  .db #> missionConditionRound
  .db #> missionConditionOnlyFriendlies
  .db #> missionConditionOnlyHostiles
  .db #> missionEventEndMission
  .db #> missionEventNewUnit

missionEventOpCodeLo:
  .db #< missionEventOpenDialog
  .db #< missionConditionRound
  .db #< missionConditionOnlyFriendlies
  .db #< missionConditionOnlyHostiles
  .db #< missionEventEndMission
  .db #< missionEventNewUnit
