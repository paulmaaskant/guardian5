state_hudMenu:
  LDA blockInputCounter
  BEQ +continue								; if timer is still running,
  DEC blockInputCounter				; then dec the counter and skip input processing
  RTS

+continue:
  LDA buttons
  BIT leftNyble
  BEQ +continue
  JSR pullAndBuildStateStack
	.db 10
	.db $32, %00100000		; clear sys flag: portrait & object sprites
	.db $20, 1						; load hud
	.db $31, #eRefreshStatusBar
	.db $25								; collapse menu
	.db $29, %00000100		; set sys flag: object sprites
	.db $30								; load portrait
  ; RTS

+continue:
  LSR                   ; right
  BCC +next

  LDA #12
  STA blockInputCounter

  JSR buildStateStack		; show next unit
	.db 7
	.db $47, 1						; set next
  .db $32, %00100100		; clear sys flag: portrait & object sprites
	.db $3D								; load hud menu values
	.db $41								; reload portrait
  .db $1A
	; RTS built in

+next:
  LSR                   ; left
  BCC +next

  LDA #12
  STA blockInputCounter

  JSR buildStateStack		; show next unit
  .db 7
  .db $47, 2						; set previous
  .db $32, %00100100		; clear sys flag: portrait & object sprites
  .db $3D								; load hud menu values
  .db $41								; reload portrait
  .db $1A
  ; RTS built in


+next:
  LSR                   ; down
  BCC +next

  LDX list8+255
  ;LDA #$0F
  ;STA list8+55, X
  ;STA list8+59, X
  INX
  CPX #4
  BCC +store
  LDX #0
  BEQ +store

+next:
  LSR                   ; up
  BCC +next

  LDX list8+255
  ;LDA #$0F
  ;STA list8+55, X
  ;STA list8+59, X
  DEX
  BPL +store
  LDX #3
  BNE +store

+next:
  RTS

+store:
  STX list8+255
  ;LDA #$2F
  ;STA list8+55, X
  ;LDA #$2E
  ;STA list8+59, X

  LDA #8
  STA blockInputCounter

  LDA #$48
  JMP pushState
