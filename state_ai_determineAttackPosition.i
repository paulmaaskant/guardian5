; ------------------------------
; game state 28 : decide on node to move to
;
; actionList+0 number of eligible nodes
; actionList+1 active unit run distance
; actionList+2 active unit weapon range
; ------------------------------
state_ai_determineAttackPosition:

  JSR firstPass
  JSR evaluateNodes           ; look for path
  BCC +pathFound
  JSR secondPass
  JSR evaluateNodes
  BCS +noPathFound

+pathFound:
  LDA par1
  STA cursorGridPos           ; put the cursor on the destination node

  LDA #$03										; clear from list3+4
	LDX #$09										; up to and including list3+9
	JSR clearList3

  LDA #$00                    ; FIX me (action point cost)
  STA list3+0

	JSR applyActionPointCost
	JSR initializeMove

  JSR pullAndBuildStateStack
	.db $04							        ; 3 states
  .db $0B 						        ; center camera
	.db $11 						        ; resolve move
	.db $1C							        ; face target
	.db $16							        ; show results
	; built in RTS

+noPathFound:
  LDA #$00                    ; FIX me (action point cost)
  STA list3+0

  JSR applyActionPointCost

  JSR pullAndBuildStateStack
  .db $02							        ; 2 states
  .db $1C							        ; face target
  .db $16							        ; show results



firstPass:
  ; ------------------
  ; first pass,
  ; look for a reachable node that has clear line of sight to target
  ; ------------------

  LDX #$00										                                                  ;
  STX actionList+0                                                              ; reset eligble node count
  LDA activeObjectStats+2
  ASL
  STA actionList+1                                                              ; act obj run distance
  INC actionList+1                                                              ; +1 to make compare easier

  LDA activeObjectStats+0
  LSR
  LSR
  LSR
  LSR
  STA actionList+2                                                                   ; max range of primary weapon
  INC actionList+2                                                                   ; +1 to make compare easier


-loop:
  STX par1
  LDA nodeMap, X
  BMI +discardNode                                                              ; node is blocked

  LDA activeObjectGridPos                                                       ;
  JSR distance
  CMP actionList+1
  BCS +discardNode                                                              ; node too far from active unit

  LDA cursorGridPos
  JSR distance
  CMP actionList+2
  BCS +discardNode                                                              ; node too far from target unit

  TXA
  PHA
  JSR checkLineOfSight
  PLA
  TAX
  BCS +discardNode                                                              ; node has no visibility on target unit

  INC actionList+0
  LDA nodeMap, X                                                                ; eligible node
  ORA #%00010000
  STA nodeMap, X
  BNE +nextNode

+discardNode:
  LDA nodeMap, X
  AND #%11101111
  STA nodeMap, X

+nextNode:
  INX
  BNE -loop

  ; IMPROVEMENT
  ; score eligble nodes,
  ; e.g. higher score if node is not visble by target
  ; pick node with highest score

  RTS



secondPass:
  LDX #$00										                                                  ;
  STX actionList+0                                                              ; reset eligble node count
  LDA activeObjectStats+2
  ASL
  STA actionList+1                                                              ; act obj run distance
  LDX #$00

-loop:
  STX par1
  LDA nodeMap, X
  BMI +discardNode                                                              ; node is blocked

  LDA activeObjectGridPos                                                       ;
  JSR distance
  CMP actionList+1
  BNE +discardNode                                                              ; node too far from active unit

  INC actionList+0
  LDA nodeMap, X                                                                ; eligible node
  ORA #%00010000
  STA nodeMap, X
  BNE +nextNode

+discardNode:
  LDA nodeMap, X
  AND #%11101111
  STA nodeMap, X

+nextNode:
  INX
  BNE -loop
  RTS



evaluateNodes:
-nextNode:
  LDA actionList+0
  BNE +continue
  RTS
+continue:
  JSR random                                                                    ; FIX
  TAX                                                                           ; choose node based on strategy
  LDA nodeMap, X                                                                ; i.e., closest node
  AND #%00010000
  BEQ -nextNode

  LDA #$00
  STA actionMessage                                                             ; reset action message
  STX par1                                                                      ; set destination node
  LDA activeObjectStats+2
  ASL
  STA par2                                                                      ; set max number of moves
  LDA activeObjectGridPos                                                       ; set start node
  JSR findPath                                                                  ; find path
  LDA actionMessage
  BMI +continue
  CLC                                                                           ; path found!!
  RTS

+continue:
  LDX par1
  LDA nodeMap, X
  AND #%11101111
  STA nodeMap, X

  DEC actionList+0
  JMP -nextNode
