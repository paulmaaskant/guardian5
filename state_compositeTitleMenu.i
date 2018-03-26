; ------------
; state 36
; ------------
state_compositeTitleMenu:

  LDA #0
  STA stateStack
  
  JSR buildStateStack
  .db 8								; # items
  .db $00, 0						; load screen 00: title screen
  .db $1E								; initialize title menu
  .db $46, 8						; load title menu option tiles
  .db $0D, 1						; change brightness 1: fade in
  .db $03								; title screen (wait for user)
  ; built in RTS
