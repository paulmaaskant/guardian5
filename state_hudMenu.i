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


+next:
  LSR                   ; left
  BCC +next


+next:
  LSR                   ; down
  BCC +next

  LDX list8+255
  LDA #$0F
  STA list8+55, X
  STA list8+59, X
  INX
  CPX #4
  BCC +store
  LDX #0
  BEQ +store

+next:
  LSR                   ; up
  BCC +next

  LDX list8+255
  LDA #$0F
  STA list8+55, X
  STA list8+59, X
  DEX
  BPL +store
  LDX #3
  BNE +store

+next:
  RTS

+store:
  STX list8+255
  LDA #$2F
  STA list8+55, X
  LDA #$2E
  STA list8+59, X
  LDA #8
  STA blockInputCounter

  CPX #3
  BNE +next
  JSR buildStateStack
  .db 4
  .db $46, 3       ; select
  .db $46, 7      ; clear all

+next
  CPX #2
  BNE +next
  JSR buildStateStack
  .db 8
  .db $46, 3      ; select
  .db $46, 7      ; clear all
  .db $46, 5      ; wpn labels
  .db $46, 6      ; wpn 2 values

+next:
  CPX #1
  BNE +next
  JSR buildStateStack
  .db 8
  .db $46, 3      ; select
  .db $46, 7      ; clear
  .db $46, 5      ; wpn labels
  .db $46, 2      ; wpn 1 values

+next:
  JSR buildStateStack
  .db 8
  .db $46, 3      ; select
  .db $46, 7      ; clear
  .db $46, 4      ; mch labels
  .db $46, 1      ; values
