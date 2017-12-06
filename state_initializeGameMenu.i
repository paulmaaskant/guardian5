state_initializeGameMenu:
  JSR pullState							; discard state
  JSR pullState							; pull state parameter
  TAY

  LDA state20_screenHi, Y
  STA bytePointer+0
  LDA state20_screenLo, Y
  STA bytePointer+1

+done

  LDA state20_screenPos, Y																																		; set VRAM address for status bar
  STA list1+1																															; $[24]00
  LDA #$00
  STA list1+2																															; $24[00]
  LDA state20_rows, Y																																			;  8 rows
  STA list1+0

  ; next game state ---
  LDA #$22
  JMP pushState

state20_screenLo:
  .db #> hudDialog
  .db #> hud
  .db #> hudMenu

state20_screenHi:
  .db #< hudDialog
  .db #< hud
  .db #< hudMenu

state20_screenPos:
  .db $24
  .db $24
  .db $24

state20_rows:
  .db 6
  .db 6
  .db 6
