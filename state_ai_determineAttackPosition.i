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
  BCC +pathFound

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
  ;LDA #$FF                   ; debug statement
  ;JMP replaceState

  LDA par1
  STA cursorGridPos           ; put the cursor on the destination node

  LDA #0                      ; init results
  STA list6

  LDA #1                      ; MOVE costs 1 AP (even when remaining stationary)
  STA list3+0

  LDA distanceToTarget        ; if zero, then unit remains stationary
  BNE +move

  JSR applyActionPointCost
  JSR setEvadePoints
  JMP pullState               ; remain stationary

+move:
  LDA activeObjectStats+2     ; limit # nodes to move points
  AND #$0F
  CMP list1
  BCS +continue
  STA list1                   ;

+continue:
  LDA activeObjectStats+9     ; remaining AP
  CMP #2                      ; is less than 2
  BCS +continue               ; sprint -> then limit the movement to 2 points
  LDA #2
  CMP list1                   ; if the number of nodes in the path is larger than 2
  BCS +continue
  STA list1                   ; then cap it at 2

+continue:
  LDY list1
  LDA list1, Y
  STA cursorGridPos

  LDA #0
  STA list3+12                  ; movement has no impact on heat

  JSR applyActionPointCost
  JSR setEvadePoints

  LDY activeObjectIndex
  LDA object+4, Y             ; set evade points
  AND #%11111000							; clear evade points
  ORA list3+14
  STA object+4, Y

  JSR pullAndBuildStateStack
	.db 10						              ; 4 items
	.db $3A, $FF						      ; switch CHR bank 1 to 1
  .db $0B								        ; center camera on cursor
	.db $3B 							        ; init and resolve move
	.db $3A, 0						        ; switch CHR bank 1 back to 0
	.db $1C							          ; face target
  .db $58, 0							; active object evade point marker animation
	.db $16							          ; show results
	; built in RTS

firstPass:
  ; ------------------
  ; first pass,
  ; find all reachable nodes that have clear line of sight to target and are withing weapon range
  ; ------------------

  LDX #0
  STX list6									       ; reset sorted list
  STX actionList+0

  LDA activeObjectStats+2          ; retrieve move stats
  AND #$0F                         ; mask to get move points
  STA actionList+1                 ;
  INC actionList+1                 ; +1 to make compare easier

-loop:
  STX par1
  CPX activeObjectGridPos         ; implement remaining stationairy
  BEQ +continue
  LDA nodeMap, X
  BMI +nextNode                    ; node is blocked

  LDA activeObjectGridPos                                                       ;
  JSR distance
  CMP actionList+1
  BCS +nextNode                    ; node too far away to reach

  LDA cursorGridPos
  JSR distance
  CMP #10
  BCS +nextNode                    ; node too far from target unit

  TXA
  PHA
  JSR checkLineOfSight             ; A is parameter
  PLA
  TAX
  BCS +nextNode                    ; node has no visibility on target unit

  STX par1                         ; save current X (node)

  LDA cursorGridPos
  JSR distance
  TAY
  LDA rangeCategoryMap, Y
  LDY activeObjectIndex

  JSR getOverallDamageValue        ; A is damage (score)
  EOR #$0F                         ; invert sort value (so that list is sorted low to high)
  ASL
  ASL

  LDX par1                         ; C is current node (index)
  JSR addToSortedList
  LDX par1                         ; restore X

+nextNode:
  INX
  BNE -loop
  RTS

secondPass:
  LDX #0
  STX list6							             ; reset sorted list
  STX actionList+0

  LDA activeObjectStats+2
  AND #$0F
  STA actionList+1

  LDX #0

-loop:
  STX par1
  LDA nodeMap, X
  BMI +nextNode       ; node is blocked

  LDA activeObjectGridPos                                                       ;
  JSR distance
  CMP actionList+1
  BNE +nextNode       ; not on max radius

  LDA cursorGridPos
  JSR distance        ; sort value is distance to target
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
  SEC                              ; path not found - no reachable nodes
  RTS

+continue:
  LDX list6, Y
  DEC list6

  LDA #emptyString
  STA actionMessage                ; reset action message

  STX par1                         ; set destination node
  LDA activeObjectGridPos
  JSR distance
  STA distanceToTarget             ; update d-t-t
  BEQ +pathFound                   ; current node is target node!

  LDA activeObjectStats+2          ; move type | move points
  STA par3

  AND #$0F                         ; regular movement
  STA par2                         ; set max number of moves
  LDA activeObjectGridPos          ; set start node
  JSR findPath                     ; find path
  LDA actionMessage
  BMI +continue

+pathFound:
  CLC                              ; path found!!
  RTS

+continue:
  JMP -nextNode
