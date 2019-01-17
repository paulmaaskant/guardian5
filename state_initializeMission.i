state_initializeMission:
  LDA #0
  STA missionRound

  LDA #$FF
  STA missionTargetNode

  LDA #1
  STA mission

  JSR pullAndBuildStateStack
  .db 21
  .db $00, 2						; load screen 2: mission brief screen
	.db $0D, 1						; change brightness 1: fade in
	.db $01, 1						; load stream 01: mission 1 brief
	.db $0D, 0						; change brightness 0: fade out

  .db $00, 4						; load screen 4: mech bay
  .db $32, %00000010    ; clear sys flag: tile animation OFF
  .db $26								; initialize: mech bay
  .db $0D, 0						; change brightness 0: fade out

	.db $00, 3						; load screen 3: status bar
	.db $04								; initalize mission map & events
	.db $0D, 1						; change brightness 1: fade in
	.db $2A								; new turn
