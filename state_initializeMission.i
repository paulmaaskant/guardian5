state_initializeMission:
  LDA #0
  STA missionRound
  STA mission

  LDA #< missionOneEventStream
  STA missionEventStreamPointer+0
  LDA #> missionOneEventStream
  STA missionEventStreamPointer+1


  JSR pullAndBuildStateStack
  .db 21
  .db $00, 2						; load screen 2: mission brief screen
	.db $0D, 1						; change brightness 1: fade in
	.db $01, 1						; load stream 01: mission 1 brief
	.db $0D, 0						; change brightness 0: fade out

  .db $00, 8						; load screen: unit select
  .db $0D, 1						; change brightness 1: fade in
  .db $50								; init unit select menu
  .db $0D, 0						; change brightness 0: fade out

	.db $00, 3						; load screen 3: status bar
	.db $04								; load level
	.db $0D, 1						; change brightness 1: fade in
	.db $2A								; new turn
