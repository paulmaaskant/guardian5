; #$47

state_loadHudMenuTab:
  LDX #3
  LDA #$0F

-loop:
  STA list8+55, X
  STA list8+59, X
  DEX
  BPL -loop

  LDX list8+255
  LDA #$2F
  STA list8+55, X
  LDA #$2E
  STA list8+59, X

  CPX #3
  BNE +next

  JSR pullAndBuildStateStack
  .db 4
  .db $46, 3       ; select
  .db $46, 7      ; clear all

+next
  CPX #2
  BNE +next
  JSR pullAndBuildStateStack
  .db 8
  .db $46, 3      ; select
  .db $46, 7      ; clear all
  .db $46, 5      ; wpn labels
  .db $46, 6      ; wpn 2 values

+next:
  CPX #1
  BNE +next
  JSR pullAndBuildStateStack
  .db 8
  .db $46, 3      ; select
  .db $46, 7      ; clear
  .db $46, 5      ; wpn labels
  .db $46, 2      ; wpn 1 values

+next:
  JSR pullAndBuildStateStack
  .db 8
  .db $46, 3      ; select
  .db $46, 7      ; clear
  .db $46, 4      ; mch labels
  .db $46, 1      ; values
