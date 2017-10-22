; ------------------------------
; game state 28 : decide on node to move to
;
; list1    used by line of sight
;
; list2+7 number of eligible nodes
; list2+8 active unit run distance
; list2+9 active unit weapon range
; ------------------------------
state_ai_determineAttackPosition:

  LDX #$00										;
  STX list2+7
-loop:
  LDA nodeMap, x
  AND leftNyble								; clears right nyble
  STA nodeMap, x							;
  INX													;
  BNE -loop										; node map initialized

  LDA activeObjectStats+2
  ASL
  STA list2+8                                                                   ; act obj run distance
  INC list2+8

  LDA activeObjectStats+0
  LSR
  LSR
  LSR
  LSR
  STA list2+9
  INC list2+9

  LDX #$00

-loop:
  STX par1

  LDA nodeMap, X
  BMI +discardNode                                                              ; node is blocked

  LDA activeObjectGridPos                                                       ;
  JSR distance
  CMP list2+8
  BCS +discardNode                                                              ; node too far from active unit

  LDA cursorGridPos
  JSR distance
  CMP list2+9
  BCS +discardNode                                                              ; node too far from target unit

  TXA
  PHA
	JSR checkLineOfSight
  PLA
  TAX
	BCS +discardNode                                                              ; node has no visibility on target unit

  INC list2+7
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
                                                                                ; test to make sure that there are available nodes
                                                                                ; otherwise this next part is an infinite loop

                                                                                ; FIX
                                                                                ; add eligble nodes to a list sorted on score
                                                                                ; score examples
                                                                                ; +1 point if target has no visibility arc on node

-nextNode:
  LDA list2+7
  BEQ +noMoreNodes

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
  BPL +foundNode

  LDX par1
  LDA nodeMap, X
  AND #%11101111
  STA nodeMap, X

  DEC list2+7

  JMP -nextNode

+foundNode:

  LDA par1
  STA cursorGridPos

  LDA #$03										; clear from list3+4
	LDX #$09										; up to and including list3+9
	JSR clearList3

  LDA #$00                    ; FIX me (action point cost)
  STA list3+0

	JSR calculateHeat
	JSR initializeMove
	JSR pullAndBuildStateStack
	.db $03							; 3 states
	.db $11 						; resolve move
	.db $1C							; face target
	.db $16							; show results
	; built in RTS

+noMoreNodes:

  LDA #$00                    ; FIX me (action point cost)
  STA list3+0

  JSR calculateHeat

  JSR pullAndBuildStateStack
  .db $02							; 3 states
  .db $1C							; face target
  .db $16							; show results
