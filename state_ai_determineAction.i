state_ai_determineAction:
  ; to do
  ;   what if target of choice cannot be attacked, e.g., because in base contact with another?
  ;
  ;
  ;
  ; 1 select the most attractive player controlled target
  ;   consider all player units
  ;   lowest score wins:
  ;   (100-ranged attack hit probability) + target hp + distance
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


  LDX objectCount                   ; get first available player unit

-loop:

  DEX
  LDA objectTypeAndNumber, X
  BMI -loop
	AND #%00000111																																; and mask the object number
	ASL																																						; mulitply by 4 to get the
	ASL																																						; object index																																					; save X (object list index)
	LDA object+3, Y																																; on screen check
	STA cursorGridPosition



  JMP pullState
