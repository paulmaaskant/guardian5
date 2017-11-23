; ------------------------------------------
; gameState 06: Wait for player to select action
; ------------------------------------------
state_selectAction:
	JSR random																																		; introduce entropy

	LDA blockInputCounter
	BEQ +continue																																	; if timer is still running,
	DEC blockInputCounter																													; then dec the counter and skip input processing
	RTS

+continue:
	LDA buttons																																		;
	BNE +continue					; if buttons are pressed then proceed
	RTS										; then skip input processing

+continue:
	LDA cursorGridPos
	AND #$0F							;
	STA locVar2						; grid X coor
	LDA cursorGridPos
	LSR
	LSR
	LSR
	LSR
	STA locVar1						; grid Y coor

+continue:
	LDA buttons
	; --- process directional buttons ---
	LSR 									; read RIGHT bit
	BCC +next							; skip if RIGHT not pressed
	CLC
	LDA locVar2						; translate 'isometric' directions
	ADC locVar1						; to Cartesian
	LSR
	LDA #$0F
	BCC +xEven
	CMP locVar1
	BEQ +setTimer
	INC locVar1
	JMP +setTimer

+xEven:
	CMP locVar2
	BEQ +setTimer
	INC locVar2
	JMP +setTimer

+next:
	LSR 									; read LEFT bit
	BCC +next							; skip if LEFT is not pressed
	CLC
	LDA locVar2
	ADC locVar1
	LSR
	BCS +xUnEven
	LDA locVar1
	BEQ +setTimer
	DEC locVar1
	JMP +setTimer

+xUnEven:
	LDA locVar2
	BEQ +setTimer
	DEC locVar2
	JMP +setTimer

+next:
	LSR
	BCC +next						; skip if DOWN is not pressed
	LDA locVar1
	BEQ +setTimer
	LDA locVar2
	CMP #$0F
	BEQ +setTimer
	DEC locVar1
	INC locVar2
	BNE +setTimer

+next:
	LSR
	BCC +next						; skip if UP is not pressed
	LDA locVar2
	BEQ +setTimer
	LDA locVar1
	CMP #$0F
	BEQ +setTimer
	DEC locVar2
	INC locVar1
	BNE +setTimer

+next:
	LSR 									; start
	BCC +next

	JSR buildStateStack
	.db 6
	.db $20, 0					; load menu backgorund 0
	.db $23
	.db $01, 10					; load stream 10: game paused
	.db $25
	; RTS built in

+next:
	LSR 									; select
	LSR 									; get B button
	BCC +next
	LDA events
	ORA event_releaseAction
	STA events
	BNE +setTimer

+next:
	LSR 									; get A button
	BCC +setTimer

	LDA events
	ORA event_confirmAction
	STA events

+setTimer:
	; --- set input timer ---
	LDA #$08						; block input for 08 frames
	STA blockInputCounter

	; --- put update grid X & Y back together ---
	LDA locVar1
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC locVar2

	; --- check if it changed ---
	CMP cursorGridPos
	STA cursorGridPos
	BEQ +continue

	LDY #sSimpleBlip
	JSR soundLoad

	LDA effects
	AND #%11000000
	STA effects

	; --- new target ---
	LDA events
	ORA event_updateTarget
	STA events
	JMP updateCamera				; tail chain: update camera in case of new target

	; --- action is locked or confirmed ---
+continue:
	LDA events
	BIT event_confirmAction
	BEQ +nextEvent
	EOR event_confirmAction
	STA events

	; --- try to lock ---
	LDA actionMessage				; deny message?
	BPL +lockAction					; no -> lock
	; deny sound					; yes -> deny lock

	LDY #sDeny
	JMP soundLoad						; tail chain

+lockAction:
	; --- lock ---
	LDA sysFlags
	ORA sysFlag_lock
	STA sysFlags

	LDY #sSelect
	JSR soundLoad

	LDA events
	ORA event_refreshStatusBar		; buffer to screen
	STA events

	LDA #$2F ;
	STA menuIndicator+0
	LDA #$2E ;
	STA menuIndicator+1

	LDA #$2F
  JMP replaceState

	;--------------------------------
	; release lock or toggle selected action
	;--------------------------------
+nextEvent:
	LDA events
	BIT event_releaseAction
	BEQ +nextEvent
	EOR event_releaseAction
	ORA event_updateStatusBar
	STA events

	LDY #sSimpleBlip
	JSR soundLoad
	INC selectedAction
	LDA actionList
	CMP selectedAction
	BCS +toggleDone
	LDA #$01
	STA selectedAction

+toggleDone:																																		; redo checks for newly selected action on other unit																														;
	LDA targetObjectTypeAndNumber																									; cursor is on unit?
	BEQ +actionPointCost																													; no -> point cost
	CMP activeObjectTypeAndNumber																									; yes -> on self?
	BEQ +actionPointCost																													; no -> point cost

	LDA #$00																																			; clear action message
	STA actionMessage
	LDA effects																																		; clear possible LOS block effect
	AND #%11000000																																; cursor and active unit marker stay on, rest turned off
	STA effects
	JSR checkTarget																																; possibly different weapon, so re-check range, damage etc

	BIT actionMessage
	BMI +actionPointCost
	LDA effects
	ORA #%00010000
	STA effects

+actionPointCost:
	JMP calculateActionPointCost																									; tail chain

+nextEvent:
	RTS
