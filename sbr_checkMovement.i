checkMovement:
  LDX cursorGridPos
  LDA nodeMap, X
  BPL +notBlocked							; not blocked
  BIT activeObjectStats+2     ; get unit movement type: walk or hover
  BPL +blocked								; if ground unit -> blocked
  LSR													; hovering units can end movement on hex
  BPL +continue							  ; if L-O-S is possible

+blocked:
  LDA #$89										; deny (b7) + impassable (b6-b0)
  STA actionMessage
  RTS

+notBlocked:
  LDX selectedAction				  ; retrieve selected action
  LDA actionList, X
  CMP #aJUMP								  ; is action to mark target?
  BEQ +jumping

  LDA cursorGridPos
  STA par1										; par1 = destination node

  LDA activeObjectStats+2			; move type | movepoints
  STA par3
  AND #$0F										; 0000 | movement points

  LDX activeObjectStats+9
  CPX #2
  BCC +continue
  ADC #1                      ; add 2 points
  ;ASL													; double movement points (sprint) only if 2 action points are available

+continue:
  STA par2										; par2 = # moves allowed
  LDA activeObjectGridPos		  ; A = start node
  JSR findPath								; A* search path, may take more than 1 frame
  LDA actionMessage						; if move is allowed
  BPL +checkForSprint
  RTS                         ; no path found

+checkForSprint:
  LDA list1

  LDA activeObjectStats+2
  AND #$0F
  CMP list1
  BCS +done                  ; regular move
  LDA #aRUN
  STA actionList+1

  JMP +done

+jumping:                    ; JUMP only requires a range check
  LDA activeObjectStats+2
  AND #$0F
  ;CLC
  ;ADC #1                      ; JUMP distance = move + 1
  CMP distanceToTarget
  BCS +done
  LDA #$88										; deny (b7) + out of range (b6-b0)
  STA actionMessage
  RTS

+done:
  JMP setEvadePoints          ; RTS
