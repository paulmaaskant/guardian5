; ------------------------
; game state 2A
; ------------------------
state_newTurn:
  LDA #0
  STA list6               ; reset sorted list

-restartLoop:
  LDX objectListSize

-loop:
  TXA
  PHA

  LDA objectList-1, X
  BIT pilotBits
  BEQ +endOfLoop

  AND #%01111000
  TAY
  LDA object+4, Y
  AND #%00100000
  BNE +endOfLoop

  LDA objectList-1, X
  PHA

  JSR getStatsAddress     ; takes Y

  PLA
  TAX                     ; X = item

  LDY #4                  ; initiative score
  LDA (pointer1), Y       ;

  JSR addToSortedList     ; input: X item, A score

+endOfLoop:
  PLA
  TAX
  DEX
  BNE -loop

  LDA list6
  BNE +continue

                          ; make a state out of this
  INC missionRound        ; INCREASE ROUND

                          ; unMARK all units at the start of a new round
  LDY #120

-unmarkLoop:
  LDA object+4, Y
  AND #%10011111          ; reset mark flag & turn flag
  STA object+4, Y
  TYA
  SEC
  SBC #8
  TAY
  BPL -unmarkLoop
  BMI -restartLoop			

+continue:
  LDA #0
  STA list6                     ; reset sorted list
  STA activeObjectStats+3       ; reset current # moves

  LDA #2                        ;
  STA activeObjectStats+9			  ; action points per turn

  LDA list6+1
  STA	activeObjectIndexAndPilot
  AND #%01111000
  STA activeObjectIndex
  TAY
  LDA object+3, Y
  STA activeObjectGridPos

  ; --- set portrait location
  LDA #12
  STA portraitXPos
  LDA #11
  STA portraitYPos

  LDY activeObjectIndex
  LDA object+1, Y
  PHA
  AND #$07
  STA activeObjectStats+4       ; set current heat points

  PLA
  LSR
  LSR
  LSR
  STA activeObjectStats+6       ; set current hit points


  ;-----------------------------  get object type stats
  JSR getStatsAddress           ; Y goes in; sets pointer1
  LDY #3                        ; #3 movement
  LDA (pointer1), Y             ;
  STA activeObjectStats+2			  ;

  LDY #5                        ; #5 damage profile
  LDA (pointer1), Y             ;
  STA activeObjectStats+7			  ; stored

  ;-----------------------------  get pilot based stats
  LDA activeObjectIndexAndPilot ;
  ASL
  AND #%00001110
  BCC +continue
  ORA #%00010000

+continue:
  ASL
  TAY                           ; pilot number x 4

  LDA pilotTable-3, Y           ;
  STA activeObjectStats+5       ; pilot skill

  LDA #$C0										  ; switch on cursor and active marker
  STA effects

  LDA activeObjectGridPos
  STA cursorGridPos

  LDA #$00
  STA targetObjectTypeAndNumber

  LDA events
  ORA #eRefreshStatusBar
  STA events

  JSR clearSystemMenu
  JSR clearActionMenu
  JSR clearTargetMenu

  JSR buildStateStack
  .db 8							  ; 7 items
  .db $30             ; set active unit portrait
  .db $3C             ; show hourglass
  .db $0B 						; center camera
  .db $0C						  ; wait for camera to center
  .db $34             ; start of turn events
  .db $56							; start action: ai or player
  .db $37             ; end action
  .db $08             ; end turn
  ; built in RTS
