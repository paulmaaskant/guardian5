; -----------------------------------
; game state 27: ai controls active unit
; -----------------------------------
state_ai_determineAction:
  ; to do
  ;   what if target of choice cannot be attacked, e.g., because in base contact with another?
  ;
  ; 1 select the most attractive player controlled target
  ;
  ;
  ; 2 determine available options
  ; - ranged attack 1 on target
  ; - ranged attack 2 on target
  ; - close combat on target
  ; - charge target
  ; - move / pivot towards attack position on target (this is complex)
  ; - cool down
  ; - move towards defensive position (this is complex)
  ;
  ; 3 score all available options
  ; - based on relevant factors (tbd)
  ;
  ; 4 some randomness: pick best option 70%, second best 20%, third best 10%

  ; move / pivot towards attack position on target (most difficult action)
  ; 1 flag all nodes that
  ;       - are not blocked
  ;       - are within attacker's shooting range to target
  ;       - are within move distance of the attacker
  ;       - have line of sight to the target
  ; 2 randomly pick a flagged node
  ;       - try to move there
  ;       - repeat untill a move is possble


  ; ----------------------------------------
  ; 1. select most attractive target TODO
  ;     consider all player units
  ;     lowest score wins:
  ;     (100-ranged attack hit probability) + target hp + distance
  ; ----------------------------------------
  LDX objectListSize

-loop:
  DEX                                     ; note that this assumes that the game is over when there are no valid targets left
  LDA objectList, X                       ; because DEX is without a stop condition
  BMI -loop                               ; skip other AI (pilot 1xxx )
  BIT pilotBits
  BEQ -loop                               ; skip obstacles (pilot 0000 )

  STA targetObjectTypeAndNumber           ; choose first player unit that comes up
  AND #%01111000                          ; needs to be refined, i.e.,
  TAY
  STY targetObjectIndex
  LDA object+3, Y
	STA cursorGridPos

  LDY activeObjectGridPos
  STY par1
  JSR distance
  STA distanceToTarget

  ; ----------------------------------------
  ; 2. score all options
  ; ----------------------------------------
  LDX #7
  STX selectedAction

-loop:
  LDX selectedAction
  LDA state29_actionID, X
  STA actionList, X
  CPX #3                    ; actions 0,1 & 2 do not require target check
  BCC +continue
  LDA #0                    ; clear msg
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

  DEC selectedAction
  BPL -loop

  ; ----------------------------------------
  ; 3. select best option
  ; ----------------------------------------

  LDX #7
  LDA #0
  STA actionMessage     ; reset
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
  JMP replaceState

state29_nextState:
  .db $14             ; AI_cooldown
  .db $FF             ; AI_move_defensive
  .db $28             ; AI_move_offensive
  .db $12             ; AI_ranged_attack_1
  .db $12             ; AI_ranged_attack_2
  .db $17             ; AI_close_combat
  .db $1B             ; AI_charge
  .db $44             ; AI_aim

state29_actionID:
  .db aCOOLDOWN       ; AI_cooldown
  .db aMOVE           ; AI_move_defensive
  .db aMOVE           ; AI_move_offensive
  .db aRANGED1        ; AI_ranged_attack_1
  .db aRANGED2        ; AI_ranged_attack_2
  .db aCLOSECOMBAT    ; AI_close_combat
  .db aCHARGE         ; AI_charge
  .db aAIM            ; AI_aim

state29_baslineLineScore:
  .db $01             ; AI_cooldown
  .db $00             ; AI_move_defensive
  .db $02             ; AI_move_offensive
  .db $04             ; AI_ranged_attack_1
  .db $03             ; AI_ranged_attack_2
  .db $03             ; AI_close_combat
  .db $00             ; AI_charge
  .db $05             ; AI_aim
