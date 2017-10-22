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
	ASL																																																																										; save X (object list index)
	LDA object+3, Y
  STY targetObjectIndex
	STA cursorGridPos

  ; ----------------------------------------
  ; 2. score available options
  ; ----------------------------------------

  LDX #$06

-loop:
  LDA #0
  CPX #AI_move_offensive                                 ; assign 1 point
  BNE +continue
  LDA #1

+continue:
  STA list3, X
  DEX
  BPL -loop

  ; ----------------------------------------
  ; 3. select best option
  ; ----------------------------------------

  LDX #6
  LDA #0
  STA locVar1           ; best score
  STA locVar2           ; best action

-loop:
  LDA list3, X
  CMP locVar1
  BCC +continue
  STA locVar1
  STX locVar2

+continue:
  DEX
  BPL -loop

  LDY locVar2
  LDA state29_nextState, Y
  JMP replaceState

  AI_cooldown = 0
  AI_move_defensive = 1
  AI_move_offensive = 2
  AI_ranged_attack_1 = 3
  AI_ranged_attack_2 = 4
  AI_close_combat = 5
  AI_charge = 6

state29_nextState:
  .db $14, $FF, $28, $12, $12, $17, $1B
