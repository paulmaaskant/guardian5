; -----------------------------------------
; state 57
;
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

  LDA #$84
  STA locVar1										;
  LDA #$F2
  STA locVar2										;
  LDA #$54
  STA locVar3										;
  LDA #$11						           ; equipment
  JSR insertObject							;


  LDA #$F2
  JSR centerCameraOnNode

  JSR pullAndBuildStateStack
  .db 1
  .db $0C                       ; wait for camera to center
