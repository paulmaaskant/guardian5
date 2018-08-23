; game state 2F

state_confirmAction:
  LDA events												  ;
  BIT event_updateStatusBar						;
  BNE +continue
  JMP +nextStep

+continue:														;
  ORA event_refreshStatusBar					; raise event to trigger buffer to screen
  EOR event_updateStatusBar						;
  STA events

  LDA #0
  STA menuFlags

  LDY #17                             ; confirm >A
  STY actionMessage

+nextStep:
  LDA frameCounter
  AND #$03
  BNE +nextStep

  LDA frameCounter
  AND #%00000100
  BEQ +next
  LDA list3+12               ; heat increment

+next:
  JSR setSystemHeatGauge

  LDA targetObjectTypeAndNumber
  BEQ +skip

  LDA frameCounter
  AND #%00000100
  BEQ +next
  LDA list3+13               ; heat increment

+next:
  JSR setTargetHeatGauge

+skip:
  LDA events
  ORA #eRefreshStatusBar
  STA events

+nextStep:
  LDA blockInputCounter
  BEQ +continue					     ; if timer is still running,
  DEC blockInputCounter      ; then dec the counter and skip input processing
  RTS

+continue:              ; check if buttons are pressed
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
  LDX list1+19
  CPX list1
  BCC +noReset
  LDX #0

+noReset:
  INX
  LDA list1, X
  STX list1+19
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
  RTS										   ; then skip input processing

+continue:                 ; A contains buttons
  ASL                      ; 'A' button
  BCC +next
  LDX selectedAction
	LDA actionList, X
	ASL
	TAY
	LDA actionTable, Y
	JSR replaceState
	LDY #sConfirm
	JSR soundLoad

  LDA effects					   	 ; clear possible LOS block / waypoints effect
  AND #$F0							   ; cursor and active unit marker stay on, rest turned off
  STA effects

  ;LDA list3+12
  ;JSR setSystemHeatGauge   ; set gauge including the heat increment

  LDA events
  ORA #eRefreshStatusBar   ; refresh so that the gauge is updated on the screen
  STA events

  LDA #emptyString
  STA actionMessage

  JMP +setTimer            ; to prevent locking a direction after pivot

+next:
  ASL                      ; 'B' button -> cancel and go back to select action state
  BCC +next
  LDA effects																																		; clear possible LOS block effect
	AND #$F0																																      ; cursor and active unit marker stay on, rest turned off
	STA effects
  LDY #sRelease
	JSR soundLoad					   ;
  LDA #8						       ; set input timer
	STA blockInputCounter
  JSR pullAndBuildStateStack
  .db #3
  .db $31, #eCheckAction
  .db $06
  ; built in RTS

+next:
  ASL                      ; select button
  ASL                      ; start button

+setTimer:
	LDA #8						       ; --- set input timer ---
	STA blockInputCounter
  RTS
