; ------------------------------
; game state 28 : decide on node to move to
;
; actionList+0 number of eligible nodes
; actionList+1 active unit run distance
; actionList+2 active unit weapon range
; ------------------------------
state_ai_determineAttackPosition:
  LDX activeObjectIndex
  LDA object+4, X
  AND #%01111100
  CMP #24                     ; if pilot is LUCKY
  BNE +continue

  LDA missionTargetNode
  STA cursorGridPos

  JSR moveToCursorGridPos     ; look for best node to move to destination
  JSR evaluateNodes
  BCC +pathFound

+continue:
  JSR moveToAttackPosition    ; sort nodes based on best attack position
  JSR evaluateNodes           ; look for path
  BCC +pathFound

  JSR moveToCursorGridPos     ; sort nodes based on closest to target
  JSR evaluateNodes

+pathFound:
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
  LDA object+7, Y             ; set evade points
  AND #%11111000							; clear evade points
  ORA list3+14
  STA object+7, Y

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

moveToAttackPosition:
  ; ------------------
  ; first pass,
  ; sort reachable nodes that have clear line of sight to target and are within weapon range
  ; the most attractive node is the one that allows to deal the most damage
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
  CPX activeObjectGridPos          ; implement remaining stationary
  BEQ +continue                    ; (ignore that node is blocked if the unit itself is blocking it)

  LDA nodeMap, X                   ;
  BIT activeObjectStats+2
  BPL +unitNotHovering             ; CHECK if unit can hover!
  ASL                              ; nodeMap b6 becomes nodeMap b7

+unitNotHovering:
  AND #%10000000                   ; reset NEG flag based on A
  BMI +nextNode                    ; node is blocked, so try the next node

  LDA activeObjectGridPos                                                       ;
  JSR distance
  CMP actionList+1
  BCS +nextNode                    ; node too far away to reach

+continue:
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

  LDX par1                         ; C is current node (index)
  JSR addToSortedList
  LDX par1                         ; restore X

+nextNode:
  TXA                              ; of all nodes with the same score, AI will always pick the first in the array
  CLC                              ; which, if we increment X by 1, would always be the lowest number node
  ADC #97                          ; this gives AI a tendency to always move towards node 0 if possible
  TAX
  BNE -loop                        ; to prevent this we increment by 97, which will still loop over all nodes
  RTS                              ; but gives us a better distribution

moveToCursorGridPos:
  ; ------------------
  ; sort all potentially reachable nodes
  ; the one that is closest to the cursor node is the most attractive
  ; ------------------

  LDX #0
  STX list6									       ; reset sorted list
  LDA activeObjectStats+2          ; retrieve move stats
  AND #$0F                         ; mask to get move points
  STA par2                         ;
  INC par2                         ; +1 to make compare easier

-loop:                             ; loop over all nodes on the map
  STX par1                         ; store X, par1 is an IN parameter for sbr distance
  CPX activeObjectGridPos          ; implement remaining stationary
  BEQ +continue                    ; (ignore that node is blocked if the unit itself is blocking it)

  LDA nodeMap, X                   ;
  BIT activeObjectStats+2
  BPL +unitNotHovering             ; CHECK if unit can hover!
  ASL                              ; nodeMap b6 becomes nodeMap b7

+unitNotHovering:
  AND #%10000000                   ; reset NEG flag based on A
  BMI +nextNode                    ; node is blocked, so try the next node

+continue:
  LDA activeObjectGridPos                                                       ;
  JSR distance                     ; distance between current node (par1) and start node (A)
  CMP par2
  BCS +nextNode                    ; node too far away to reach, so try next node

  LDA cursorGridPos                ;
  JSR distance                     ; distance between current node (par1) and start node (A)
                                   ; the lower the value, the more attractive the candidate node is
  JSR addToSortedList
  LDX par1                         ; restore X

+nextNode:
  TXA                              ; of all nodes with the same score, AI will always pick the first in the array
  CLC                              ; which, if we increment X by 1, would always be the lowest number node
  ADC #97                          ; this gives AI a tendency to always move towards node 0 if possible
  TAX
  BNE -loop                        ; to prevent this we increment by 97, which will still loop over all nodes
  RTS                              ; but gives us a better distribution

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
  BEQ +stayPut
  LDA activeObjectStats+2          ; move type | move points
  STA par3

  AND #$0F                         ; regular movement
  STA par2                         ; set max number of moves
  LDA activeObjectGridPos          ; set start node
  JSR findPath                     ; find path
  LDA actionMessage
  BMI +continue

+stayPut:
  CLC                              ; path found!!
  RTS

+continue:
  JMP -nextNode
