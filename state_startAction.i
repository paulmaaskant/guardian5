;
;
;

state_startAction:
  LDA activeObjectIndexAndPilot       ; check if unit is AI or player
  BMI +continue
  LDA #$06                            ; state: user select action
  JMP replaceState

  ; ----------------------------------------
  ; AI action, then first select AI target
  ;
  ; current: closest target
  ; ----------------------------------------
+continue:
  LDA #0
  STA list6               ; reset sorted list
  STA effects             ; clear all effects

  LDA objectListSize
  STA list1

  LDA activeObjectGridPos
  STA par1

-loop:
  DEC list1
  BMI +endLoop

  LDY list1
  LDA objectList, Y
  BMI -loop               ; other AI unit -> next object
  BIT pilotBits
  BEQ -loop               ; inanimate - > next object
  TAX
  AND #%01111000
  TAY
  LDA object+3, Y         ; object grid pos
  JSR distance
  JSR addToSortedList
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

  LDA #$27                            ; state: AI to select action
  JMP replaceState
