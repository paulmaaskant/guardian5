; ------------------------------
; game state 28 : decide on node to move to
;
; actionList+0 number of eligible nodes
; actionList+1 active unit run distance
; actionList+2 active unit weapon range
; ------------------------------
state_ai_determineAttackPosition:

  ;LDA #1
  ;STA debug+1

  JSR firstPass
  JSR evaluateNodes           ; look for path
  BCC +pathFound

  ;LDA #2
  ;STA debug+1

  JSR secondPass
  JSR evaluateNodes
  BCC +pathFound

  ;LDA #3
  ;STA debug+1

                              ; if no path is found, simply face the target
  LDA #1                      ; set action point cost directly (1)
  STA list3+0
  JSR applyActionPointCost

  LDA #0                      ; initilize results
  STA list6

  JSR pullAndBuildStateStack
  .db $02							        ; 2 states
  .db $1C							        ; face target
  .db $16							        ; show results

+pathFound:
  LDA par1
  STA cursorGridPos           ; put the cursor on the destination node

  LDA #0                      ; init results
  STA list6

  LDA #1                      ; MOVE costs 1 point
  STA list3+0

  LDA activeObjectStats+2     ; limit # nodes to move points
  AND #$0F
  CMP list1
  BCS +continue
  STA list1                   ;

+continue:
  LDY list1
  LDA list1, Y
  STA cursorGridPos

  LDA #-1
  STA list3+12                  ; movement reduces heat by 1

  JSR applyActionPointCost
  JSR setEvadePoints
  JSR pullAndBuildStateStack
	.db 9						              ; 4 items
	.db $3A, $FF						      ; switch CHR bank 1 to 1
  .db $0B								        ; center camera on cursor
	.db $3B 							        ; init and resolve move
	.db $3A, 0						        ; switch CHR bank 1 back to 0
	.db $1C							          ; face target
  .db $4E                       ; evade points marker
	.db $16							          ; show results
	; built in RTS

firstPass:
  ; ------------------
  ; first pass,
  ; find all reachable nodes that have clear line of sight to target and are withing weapon range
  ; ------------------

  LDX #0
  STX list6									       ;
  STX actionList+0                 ; reset eligble node count
  LDA activeObjectStats+2          ; move
  ASL
  STA actionList+1                 ; act obj run distance
  INC actionList+1                 ; +1 to make compare easier

  LDY activeObjectIndex
  LDA object+5, Y
  AND #$F0										     ; mask the weapon type
  LSR
  TAY
  LDA weaponType+2, Y
  LSR
  LSR
  LSR
  LSR
  STA actionList+2                 ; max range of primary weapon
  INC actionList+2                 ; +1 to make compare easier

-loop:
  STX par1
  LDA nodeMap, X
  BMI +nextNode                     ; node is blocked

  LDA activeObjectGridPos                                                       ;
  JSR distance
  CMP actionList+1
  BCS +nextNode                    ; node too far from active unit

  LDA cursorGridPos
  JSR distance
  CMP actionList+2
  BCS +nextNode                    ; node too far from target unit

  CMP #2
  BCC +nextNode                    ; node too close to target unit

  TXA
  PHA
  JSR checkLineOfSight
  PLA
  TAX
  BCS +nextNode                    ; node has no visibility on target unit

  STX par1
  JSR random
  LDX par1                         ; restore X
  JSR addToSortedList
  LDX par1                         ; restore X

+nextNode:
  INX
  BNE -loop

  ; IMPROVEMENT
  ; score eligble nodes,
  ; e.g. higher score if node is not visble by target
  ; pick node with highest score

  RTS



secondPass:
  LDX #$00
  STX list6							                                                  ;
  STX actionList+0                                                              ; reset eligble node count
  LDA activeObjectStats+2

  LDY activeObjectStats+9
  CPY #2
  BCC +noRunning
  ASL

+noRunning:
  STA actionList+1                                                              ; act obj run distance
  LDX #$00

-loop:
  STX par1
  LDA nodeMap, X
  BMI +nextNode       ; node is blocked

  LDA activeObjectGridPos                                                       ;
  JSR distance
  CMP actionList+1
  BNE +nextNode       ; node too far from active unit

  LDA cursorGridPos
  JSR distance
  JSR addToSortedList
  LDX par1            ; restore X
  BNE +nextNode

+nextNode:
  INX
  BNE -loop
  RTS



evaluateNodes:
-nextNode:
  LDY list6
  BNE +continue
  RTS

+continue:
  LDX list6, Y
  DEC list6

  LDA #$00
  STA actionMessage                                                             ; reset action message

  STX par1                                                                      ; set destination node
  LDA activeObjectGridPos
  JSR distance
  STA distanceToTarget             ; update d-t-t
  LDA activeObjectStats+2          ; move type | move points
  STA par3

  LDA #12                          ; fixed to 12 moves
  STA par2                         ; set max number of moves
  LDA activeObjectGridPos          ; set start node
  JSR findPath                     ; find path
  LDA actionMessage
  BMI +continue
  CLC                              ; path found!!
  RTS

+continue:
  JMP -nextNode
