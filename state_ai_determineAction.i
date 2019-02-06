; -----------------------------------
; game state 27: ai controls active unit
; -----------------------------------
state_ai_determineAction:
  ;
  ; 1 determine available options
  ; - ranged attack on target
  ; - close combat on target
  ; - charge target
  ; - move / pivot towards attack position on target
  ; - brace
  ;
  ; 2 score all available options
  ; - based on relevant factors (tbd)
  ;
  ; 3 some randomness: pick best option 70%, second best 20%, third best 10%

  LDY targetObjectIndex
  LDA object+3, Y
  STA cursorGridPos             ; set cursor on target

  LDY activeObjectGridPos
  STY par1
  JSR distance
  STA distanceToTarget

  LDA #0
  STA list6                     ; reset sorted list

  ; ----------------------------------------
  ; 1. score all action options
  ; ----------------------------------------
  LDX #6
  STX selectedAction

-loop:
  LDX selectedAction
  LDA state29_actionID, X
  STA actionList, X
  CPX #2                    ; actions 0&1 do not require target check
  BCC +continue
  LDA #emptyString          ; clear msg
  STA actionMessage
  JSR checkTarget           ; can action be executed?

  LDX selectedAction
  LDA actionMessage
  BPL +continue             ; yes -> continue

  LDA #0                    ; no -> zero score
  BEQ +store

+continue:
  LDA state29_baslineLineScore, X

+store:
  STA list5, X

  CPX #aiCLOSECOMBAT          ; Close combat check
  BNE +next
  LDA activeObjectStats+2     ; hovering units cannot do close combat
  BMI +zero
  AND #$0F                    ; stationary units can also not do close
  BEQ +zero
  LDA distanceToTarget        ; close combat only if distance is 1
  CMP #1
  BNE +zero


+next:
  CPX #aiMOVE                 ; second move
  BNE +next
  LDA activeObjectStats+2     ; hovering units cannot sprint
  BMI +zero

+next:
  CPX #aiBRACE                 ; Adjustment #2
  BNE +next                    ; time to cool down
  LDY activeObjectIndex
  LDA object+1, Y
  AND #%00000111
  CMP #2
  BCC +next
  CMP #3
  BCS +forceBrace              ; if heat level is 3 -> force Brace
  JSR random                   ; if heat level is 2
  ASL                          ; there is a 50% change of bracing
  BCC +next

+forceBrace:
  LDA #10                      ; set BRACE score to 10 if unit is overheating
  STA list5, X
  BNE +next

+zero:
  LDA #0
  STA list5, X

+next:
  DEC selectedAction
  BPL -loop

  ; ----------------------------------------
  ; 2. select best option
  ; ----------------------------------------
  LDA #emptyString
  STA actionMessage     ; reset

  LDX #6
  LDA #0
  STA locVar1           ; best score
  STA selectedAction    ; best action

-loop:
  LDA list5, X
  CMP locVar1
  BCC +continue
  STA locVar1
  STX selectedAction

+continue:
  DEX
  BPL -loop

  JSR calculateActionPointCost

  LDX selectedAction
  LDA state29_nextState, X
  JSR replaceState

  LDA state29_actionID, X
  STA actionList+1
  LDA #1
  STA selectedAction
  STA actionList
  RTS

state29_nextState:
  .db $14             ; aiBRACE
  .db $28             ; aiMOVE
  .db $28             ; aiJUMP
  .db $12             ; aiATTACK
  .db $17             ; aiCLOSECOMBAT
  .db $1B             ; aiCHARGE
  .db $44             ; aiMARK

state29_actionID:
  .db aBRACE          ; aiBRACE
  .db aMOVE           ; aiMOVE
  .db aJUMP           ; aiJUMP
  .db aATTACK         ; aiATTACK
  .db aCLOSECOMBAT    ; aiCLOSECOMBAT
  .db aCHARGE         ; aiCHARGE
  .db aMARKTARGET     ; aiMARK

state29_baslineLineScore:
  .db 1               ; aiBRACE
  .db 2               ; aiMOVE
  .db 0               ; aiJUMP
  .db 4               ; aiATTACK
  .db 5               ; aiCLOSECOMBAT
  .db 0               ; aiCHARGE
  .db 0               ; aiMARK
