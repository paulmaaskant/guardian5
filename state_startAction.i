; --------------------------------------------
; detect if the action is player or AI controlled
;
; --------------------------------------------
state_startAction:
  LDA #0                              ; clear/initialize list3
  LDX #63                             ;

-loop:                                ;
  STA list3, X                        ;
  DEX                                 ;
  BPL -loop

  LDA activeObjectIndexAndPilot       ; check if unit is AI or player
  BMI +continue                       ; -> AI to determine action

  JSR pullAndBuildStateStack
  .db 3
  .db $31, eUpdateTarget              ; make sure action list is set
  .db $06                             ; player to select action

+continue:                            ; AI controlled action
  LDA #0                              ;
  STA list6                           ; reset sorted list
  STA effects                         ; clear all effects

  LDA objectListSize
  STA list1

  LDA activeObjectGridPos
  STA par1

-loop:
  DEC list1
  BMI +endLoop

  LDY list1
  LDA objectList, Y
  TAX
  BIT bit1to0
  BEQ -loop               ; faction 00: obstacle -> next object
  EOR activeObjectIndexAndPilot
  AND #%00000011
  BEQ -loop               ; same faction as active unit -> next object
  TXA
  AND #%01111000
  TAY
  LDA object+3, Y         ; object grid pos
  JSR distance            ;

  STA locVar1

  LDA object+1, Y         ; hit point & heat
  LSR
  LSR
  LSR                     ; target's hit points
  LSR                     ; * 0.5
  CLC
  ADC locVar1             ; Score is DISTANCE to target + 0.5 * target's HIT POINTS
                          ; go for the closest, weakest target

  JSR addToSortedList     ; IN A (score) and X (item)
  JMP -loop

+endLoop:
  LDY list6
  LDA list6, Y
  STA targetObjectTypeAndNumber
  AND #%01111000
  STA targetObjectIndex
  TAX
  LDA object+3, X
  STA cursorGridPos
  LDA list7, Y
  STA distanceToTarget

  JSR updateTargetMenu

  LDA #$28                            ; state: AI movement to attack target
  JMP replaceState
