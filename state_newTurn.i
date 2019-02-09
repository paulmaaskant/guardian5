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
  BIT bit2                ; turn flag
  BNE +endOfLoop          ; unit already had a turn this round

  BIT bit1to0
  BEQ +endOfLoop          ; obstacle object

  PHA

  AND #%01111000
  TAY
  JSR getStatsAddress     ; takes Y

  PLA
  TAX                     ; X = item

  LDY #4                  ; initiative score
  LDA (pointer1), Y       ;
  AND #$0F

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

  LDA missionRound;
  JSR toBCD
  LDA par2
  STA list3+50
  LDA par3
  STA list3+51
                          ; unMARK all units at the start of a new round

  LDX objectListSize

-loop:
  LDA objectList-1, X
  AND #%11111011            ; reset turn flag
  STA objectList-1, X
  AND #%01111000
  TAY
  LDA object+4, Y
  AND #%11111110            ; reset marked flag
  STA object+4, Y
  DEX
  BNE -loop


  LDA #120
  STA blockInputCounter
  JSR clearActionMenu

  LDY #69
  LDX #16										  ; write to position 0
  JSR writeToActionMenu				;

  JSR buildStateStack
  .db 7
  .db $45, %00111000                   ; blink all lines
  .db $31, eRefreshStatusBar           ; set event: refresh action menu
  .db $1A           ; wait
  .db $45, 0                           ; switch off blinking

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

  LDA object+6, Y
  AND #$0F
  ASL
  STA activeObjectStats+0       ; set crit damage flags

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

                                ; if active unit
  LDA #itemActuator             ; is equipped with actuator
  JSR isEquippedOnActiveObject   ;
  BCC +notEquipped
  INC activeObjectStats+2	      ; then add 1 movement point

+notEquipped:
  AND #$F0
  STA locVar1                   ; mask movement type

  LDY activeObjectIndex
  LDA object+6, Y
  LSR                           ; movement reduced flag
  BCC +continue                 ; reduce movement

  LDA activeObjectStats+2       ; movement type and points
  AND #$0F                      ; mask movement points
  LSR                           ; reduce by half
  ADC #0                        ; rounded up
  ORA locVar1                   ; restore movement type
  STA activeObjectStats+2       ;

+continue:
  LDY #5                        ; #5 damage profile
  LDA (pointer1), Y             ;
  STA activeObjectStats+7			  ; stored

  INY                           ; #6 special actions
  LDA (pointer1), Y             ;
  STA activeObjectStats+8			  ; stored

  LDY #2                        ; #1 structure points
  LDA (pointer1), Y             ;
  CMP activeObjectStats+6
  ROR activeObjectStats+0			  ; raise flag when structure points >= current hit points

  ;-----------------------------  get pilot based stats

;  LDA activeObjectIndexAndPilot ;
;  ASL
;  AND #%00001110
;  BCC +continue
;  ORA #%00010000

;+continue:
;  ASL
  LDY activeObjectIndex
  LDA object+4, Y
  AND #%01111100
  TAY                           ; pilot number x 4

  LDA pilotTable+1, Y           ;
  STA activeObjectStats+5       ; pilot skill level

  LDA pilotTable+2, Y           ;
  STA activeObjectStats+1       ; pilot traits

  LDA #$C0										  ; switch on cursor and active marker
  STA effects

  LDA activeObjectGridPos
  STA cursorGridPos

  LDA #$00
  STA targetObjectTypeAndNumber

  JSR clearSystemMenu
  JSR clearActionMenu
  JSR clearTargetMenu

  JSR buildStateStack
  .db 10							; 10 items
  .db $31, eRefreshStatusBar
  .db $30             ; set active unit portrait
  .db $3C             ; show hourglass
  .db $0B 						; center camera
  .db $0C						  ; wait for camera to center
  .db $34             ; start of turn events
  .db $56							; start 1st action: ai or player
  .db $37             ; end action
  .db $08             ; end turn
  ; built in RTS
