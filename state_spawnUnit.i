; -----------------------------------------
; state 57
; -----------------------------------------
state_spawnUnit:
  LDA #%00010000         ; #%_0011___
  STA locVar1            ; start checking object slot N = 3 (0,1&2 are reserved)

-resetLoop:
  LDX objectListSize     ; for each entry in object list
                         ; TODO: if X = 16 all slots have been assigned
-loop:
  LDA objectList-1, X    ; is object 'X' using slot 'N' ?
  AND #%01111000
  CMP locVar1
  BNE +nextObject        ; no -> check next object in list
  CLC                    ; yes -> this slot is unavailable
  LDA #8
  ADC locVar1
  STA locVar1            ; so N = N + 1 and try again
  BNE -resetLoop

+nextObject:
  DEX
  BNE -loop              ; current slot 'N' is not used by any of the objects in the list

  LDX locVar1            ; index for new object
  STX targetObjectIndex

  LDY list1+1            ; event byte stream read position

  LDA (bytePointer), Y
  STA locVar1					   ; object pilot

  INY
  LDA (bytePointer), Y
  STA locVar2						 ; object grid pos

  INY
  LDA (bytePointer), Y
  STA locVar3						 ; object type and direction

  INY
  LDA (bytePointer), Y
  JSR insertObject			 ; equipment

  LDA locVar2                       ; hardcoded location
  JSR centerCameraOnNode

  LDY targetObjectIndex             ;

  LDA object+5, Y                   ;
  STA list1+3                       ; empty tile

  LDA object+0, Y                   ;
  STA list1+6                       ; direction

  LDA #7
  STA object+0, Y                   ; disable sprites

  LDX object+3, Y                   ;
  STX list1+5                       ; gridPos

  LDA nodeMap, X                    ;
  STA list1+4                       ; filled tile

  LDY list1+5
  LDA #0
  JSR setTile

  LDA #128                          ;
  STA list1+0                       ; counter

  JSR pullAndBuildStateStack
  .db 2
  .db $0C                ; wait for camera to center
  .db $5A                ; resolve blink target object
