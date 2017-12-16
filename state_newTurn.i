; ------------------------
; game state 2A
; ------------------------
state_newTurn:
  LDA activeObjectTypeAndNumber
  AND #$07
  STA locVar1
  INC locVar1
  LDX #$00

-loop:
  LDA objectTypeAndNumber, X
  AND #$07
  CMP locVar1
  BEQ +setNext

  INX
  CPX objectCount
  BNE -loop

  LDX #$00								; increase index and try again
  INC locVar1
  LDA locVar1
  CMP #$06								; cycle between 0 and 5
  BNE -loop



  STX locVar1							; reset index to 0
  INC roundCount
  BNE -loop								; JMP

+setNext:
  LDA objectTypeAndNumber, X
  STA	activeObjectTypeAndNumber
  AND #$07
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

  ; --- retrieve type data ---
  LDA activeObjectTypeAndNumber
  JSR getStatsAddress
  STA activeObjectStats+6
  LDA (pointer1), Y				; attack & defence
  STA activeObjectStats+5
  INY								; damage & movement
  LDA (pointer1), Y
  PHA
  AND #$07
  STA activeObjectStats+3			; weapon damage 1
  PLA						; 3c, 1b
  LSR						; 6c, 3b
  LSR
  LSR
  PHA						; 3c, 1b
  AND #$07
  STA activeObjectStats+4			; weapon damage 2
  PLA
  LSR
  LSR
  LSR
  CLC
  ADC #$02
  STA activeObjectStats+2			; movement

  LDY #$01
  LDA (pointer1), Y						; wpn range 1
  STA activeObjectStats+0
  INY
  LDA (pointer1), Y
  STA activeObjectStats+1			; wpn range 2

  LDA #$C0										; switch on cursor and active marker
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
  LDA object+0, Y
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
  .db 6							; 4 states
  .db $30             ; set active unit portrait
  .db $0B 						; center camera
  .db $0C							; wait for camera to center
  .db $34             ; start of turn events
  .db $27							; ai determines action
  .db $08             ; end turn
  ; built in RTS
