; game state 2F

state_confirmAction:
  LDA events																																		;
  BIT event_updateStatusBar																											;
  BNE +continue
  JMP +nextStep

+continue:														;
  ORA event_refreshStatusBar					; raise event to trigger buffer to screen
  EOR event_updateStatusBar						;
  STA events

  LDY #17 ; confirm >A
  LDX #26
  JSR writeToActionMenu

+nextStep:
  LDA blockInputCounter
  BEQ +continue																																	; if timer is still running,
  DEC blockInputCounter																													; then dec the counter and skip input processing
  RTS

+continue:
	LDA buttons																																		;
	BNE +continue					; if buttons are pressed then proceed

  LDY selectedAction
	LDX actionList, Y

  LDA actionPropertiesTable, X
  BMI +showWayPoints
  RTS

+showWayPoints:
  JSR clearCurrentEffects

  LDA effects
  ORA #$01
  STA effects
  LDX list2
  CPX list1
  BCC +noReset
  LDX #0

+noReset:
  INX
  LDA list1, X
  STX list2
  JSR gridPosToScreenPos
  BCC +done											; off screen!
  LDA currentObjectXPos
  STA currentEffects+6
  LDA currentObjectYPos
  STA currentEffects+12
  LDA #10
  STA currentEffects+0
  LDA #0
  STA currentEffects+18
  STA currentEffects+24

+done:
  RTS										; then skip input processing

+continue:
	LDA buttons
  ASL                      ; A button
  BCC +next
  LDX selectedAction
	LDA actionList, X
	ASL
	TAY
	LDA actionTable, Y
	JSR replaceState
	LDY #sConfirm
	JSR soundLoad					   ; tail chain

  LDA effects																																		; clear possible LOS block effect
  AND #$F0																																      ; cursor and active unit marker stay on, rest turned off
  STA effects

  JMP +setTimer

+next:
  ASL                      ; B button
  BCC +next

  JSR menuIndicatorsBlink

  LDA effects																																		; clear possible LOS block effect
	AND #$F0																																      ; cursor and active unit marker stay on, rest turned off
	STA effects

  LDY #sRelease
	JSR soundLoad					; tail chain

  LDA #8						       ; --- set input timer ---
	STA blockInputCounter

  JSR pullAndBuildStateStack
  .db #3
  .db $31, #eUpdateStatusBar
  .db $06
  ; built in RTS

+next:
  ASL                      ; select button
  ASL                      ; start button

+setTimer:
	LDA #8						       ; --- set input timer ---
	STA blockInputCounter
  RTS
