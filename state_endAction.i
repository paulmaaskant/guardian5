state_endAction:
  ; ---------------------
  ; end of turn event : mission accomplished if only friendly units remain
  ; ---------------------
  LDX objectListSize
  LDA #00
  STA effects

-loop:
  ORA objectList-1, X
  DEX
  BNE -loop
  ASL
  BCC +missionAccomplished

  ; ---------------------
  ; end of turn event : mission failed if only hostile units remain
  ; ---------------------
  LDX objectListSize

-loop:
  LDA objectList-1, X
  BMI +next
  AND #$07
  BNE +continue

+next:
  DEX
  BNE -loop

  JSR pullAndBuildStateStack
  .db 15								; # items
  .db $20, 0						; load hud: conversation box
  .db $01, 12						; load stream 12: mission failed
  .db $0D, 0						; change brightness 0: fade out
  .db $00, 7						; load screen 07: failed screen
  .db $0D, 1						; change brightness 1: fade in
  .db $01, 3						; load stream 01: mission 3 brief
  .db $0D, 0						; change brightness 0: fade out
  .db $36						    ; title menu
  ; built in RTS

+missionAccomplished:
  JSR pullAndBuildStateStack
  .db 15							; # items
  .db $20, 0					; load hud: conversation box
  .db $01, 9					; load stream 09: mission accomplished
  .db $0D, 0					; change brightness 0: fade out
  .db $00, 6					; load screen 06: mission accomplished screen
  .db $0D, 1					; change brightness 1: fade in
  .db $01, 2					; load stream 01: mission 2 brief
  .db $0D, 0					; change brightness 0: fade out
  .db $36             ; title menu
  ; built in RTS

+continue:
  LDA activeObjectStats+9
  BEQ +endTurn                  ; if  all APs are spent, end turn

  JSR updateSystemMenu

  LDY activeObjectIndex         ; if unit is down, end turn
  LDA object+2, Y
  BMI +endTurn

  LDA effects
  ORA #$C0
  STA effects

  LDA activeObjectIndexAndPilot
  BMI +ai

  JSR buildStateStack
  .db 3
  .db $31, %00100000
  .db $06

+endTurn:
  JMP pullState

+ai:
  LDA #$27          ; ai determines action
  JMP replaceState
