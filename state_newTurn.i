; ------------------------
; game state 2A
; ------------------------
state_newTurn:
  LDA activeObjectTypeAndNumber
  AND #$0F
  STA locVar1             ; current active object number
  INC locVar1             ; object number that is up next
  LDX #$00                ; cycle 0 through 7

-loop:
  LDA objectList, X
  AND #$0F
  CMP locVar1
  BNE +noMatch            ; if this object's number is next number

  ASL
  ASL
  TAY
  LDA object+0, Y
  CMP #$10                ; type 0 = inanimate object
  BCS +setNext

+noMatch:
  INX
  CPX objectListSize
  BNE -loop               ; cycle through all objects in objectList

  LDX #$00								; if no object is found
  INC locVar1             ; increase "next number" and try again
  LDA locVar1
  CMP #$08								; cycle between 0 and 7
  BNE -loop

  STX locVar1							; reset index to 0
  INC roundCount
  BNE -loop								; JMP

+setNext:
  LDA objectList, X
  STA	activeObjectTypeAndNumber
  AND #$0F
  ASL
  ASL
  STA activeObjectIndex
  TAY
  LDA object+3, Y
  STA activeObjectGridPos

  ; --- set portrait location
  LDA #14
  STA portraitXPos
  LDA #16
  STA portraitYPos

  LDY activeObjectIndex
  LDA object+1, Y
  LSR
  LSR
  LSR
  STA activeObjectStats+6       ; set current hit points

  JSR getStatsAddress           ; get type data

  LDY #2                        ; #2 action points per turn
  LDA (pointer1), Y
  STA activeObjectStats+9       ; action points per turn

  INY                           ; #3 movement
  LDA (pointer1), Y             ;
  STA activeObjectStats+2			  ;

  INY                           ; #4 accuracy
  LDA (pointer1), Y				      ;
  STA activeObjectStats+5       ; store

  LDY #9                        ; #9 wpn 1 damage
  LDA (pointer1), Y				      ;
  STA activeObjectStats+3			  ; store

  INY                           ; #10 wpn 1 range
  LDA (pointer1), Y				      ;
  STA activeObjectStats+0       ; store

  LDY #12                       ; #12 wpn 2 damage
  LDA (pointer1), Y
  STA activeObjectStats+4			  ; store

  INY                           ; #13 wpn 2 range
  LDA (pointer1), Y				      ;
  STA activeObjectStats+1			  ; store



  LDA #$C0										  ; switch on cursor and active marker
  STA effects

  LDA activeObjectGridPos
  STA cursorGridPos

  LDA #$00
  STA targetObjectTypeAndNumber

  LDA #$0F ;
  STA menuIndicator+0
  STA menuIndicator+1

  LDA events
  ORA event_refreshStatusBar
  STA events

  JSR clearSystemMenu
  JSR clearActionMenu
  JSR clearTargetMenu

  LDY activeObjectIndex
  LDA object+2, Y
  BMI +shutDown

  LDA activeObjectTypeAndNumber
  BMI +aiControlled

  JSR buildStateStack
  .db 6							  ; 5 states
  .db $30             ; set active unit portrait
  .db $0B 						; center camera
  .db $0C						  ; wait for camera to center
  .db $34             ; start of turn events
  .db $06							; wait for user action
  .db $37             ; end action
  .db $08             ; end turn
  ; built in RTS

+shutDown:
  JSR buildStateStack
  .db 7							  ; 5 states
  .db $30             ; set active unit portrait
  .db $0B 						; center camera
  .db $0C							; wait for camera to center
  .db $34             ; start of turn events
  .db $1F							; handle shut down
  .db $35							; show modifiers
  .db $08             ; end turn
  ; built in RTS

+aiControlled:
  JSR buildStateStack
  .db 7							  ; 7 states
  .db $30             ; set active unit portrait
  .db $0B 						; center camera
  .db $0C							; wait for camera to center
  .db $34             ; start of turn events
  .db $27							; ai determines action
  .db $37             ; end action
  .db $08             ; end turn
  ; built in RTS
