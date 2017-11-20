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
  LDX objectCount

-loop:
  DEX
  LDA objectTypeAndNumber, X
  BMI -loop                               ; get first available player unit
  STA targetObjectTypeAndNumber
  AND #%00000111
	ASL
	ASL
  TAY																																																																										; save X (object list index)
	LDA object+3, Y
  STY targetObjectIndex
	STA cursorGridPos
  STA debug

  LDY activeObjectGridPos
  STY par1
  JSR distance
  STA distanceToTarget

  ; ----------------------------------------
  ; 2. score all options
  ; ----------------------------------------
  LDX #6
  STX selectedAction

-loop:
  LDX selectedAction

  LDA state29_actionID, X
  STA actionList, X

  CPX #3
  BCC +continue

  LDA #$00
  STA actionMessage
  JSR checkTarget
  LDX selectedAction
  LDA actionMessage
  BPL +continue

  LDA #0
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

  LDX #6
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

  AI_cooldown = 0
  AI_move_defensive = 1
  AI_move_offensive = 2
  AI_ranged_attack_1 = 3
  AI_ranged_attack_2 = 4
  AI_close_combat = 5
  AI_charge = 6

state29_nextState:
  .db $14 ; AI_cooldown
  .db $FF ; AI_move_defensive
  .db $28 ; AI_move_offensive
  .db $12 ; AI_ranged_attack_1
  .db $12 ; AI_ranged_attack_2
  .db $17 ; AI_close_combat
  .db $1B ; AI_charge

state29_actionID:
  .db aCOOLDOWN     ; AI_cooldown
  .db aMOVE         ; AI_move_defensive
  .db aMOVE         ; AI_move_offensive
  .db aRANGED1      ; AI_ranged_attack_1
  .db aRANGED2      ; AI_ranged_attack_2
  .db aCLOSECOMBAT  ; AI_close_combat
  .db aCHARGE       ; AI_charge

state29_baslineLineScore:
  .db $01 ; AI_cooldown
  .db $01 ; AI_move_defensive
  .db $02 ; AI_move_offensive
  .db $03 ; AI_ranged_attack_1
  .db $02 ; AI_ranged_attack_2
  .db $03 ; AI_close_combat
  .db $00 ; AI_charge


; COLS
; col a only if target check is passed


; col 1 always add score
; col 2 if less than 4 AP, add score
; col 3 if less than 2 AP, add score
