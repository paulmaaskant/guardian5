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
	BNE +continue					; if no buttons are pressed
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

	LDA sysFlags					; if action is locked, mask only A, B, Start & Select
	AND sysFlag_lock
	BEQ +continue

	LDA buttons
	AND #$F0							; clear direction buttons
	STA buttons

+continue:
	LDA buttons
	; --- process directional buttons ---
	LSR 									; read RIGHT bit
	BCC +next							; skip if RIGHT not pressed

	LDA locVar2
	CMP #$0F
	BEQ +setTimer
	INC locVar2
	BNE +setTimer

+next:
	LSR 									; read LEFT bit
	BCC +next							; skip if LEFT is not pressed
	LDA locVar2
	BEQ +setTimer
	DEC locVar2
	JMP +setTimer

+next:
	LSR 									; read DOWN bit
	BCC +next

	LDA locVar1
	BEQ +setTimer
	DEC locVar1
	JMP +setTimer

+next:
	LSR 									; read UP bit
	BCC +next
	LDA locVar1
	CMP #$0F
	BCS +setTimer
	INC locVar1
	JMP +setTimer

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
	BCC +next

	LDA events
	ORA event_updateSprites
	STA events

	JMP state_faceTarget

+next:
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
	LDA sysFlags
	BIT sysFlag_lock					; action locked?
	BEQ +tryLockAction				; no -> lock action
	EOR sysFlag_lock					; yes -> confirm action,
	STA sysFlags							; unlock and move to next game state



	; --- action confirmed ---
	LDX selectedAction
	LDA actionList, X
	ASL
	TAY
	LDA actionTable, Y

	JSR replaceState

;JSR pullState
	;JSR pushState

	LDY #sConfirm
	JMP soundLoad					; tail chain

+tryLockAction:
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

	;LDA menuFlags
	;EOR menuFlag_indicator
	;STA menuFlags

	LDA events
	ORA event_refreshStatusBar		; buffer to screen
	STA events

	LDA #$2F ;
	STA menuIndicator+0
	LDA #$2E ;
	STA menuIndicator+1

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

	LDA sysFlags
	BIT sysFlag_lock				; action locked?
	BEQ +toggle							; no -> toggle
													; yes -> release lock

	; --- release lock ---
	EOR sysFlag_lock
	STA sysFlags

	LDA #$C1 ; 						; "< >"
	STA menuIndicator+0
	LDA #$C0 ;
	STA menuIndicator+1

	LDY #sRelease
	JMP soundLoad					; tail chain

+toggle:
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
	BEQ +heatCost																																	; no -> heat cost
	CMP activeObjectTypeAndNumber																									; yes -> on self?
	BEQ +heatCost																																	; no -> heat cost

	LDA #$00																																			; clear action message
	STA actionMessage
	LDA effects																																		; clear possible LOS block effect
	AND #%11000000																																; cursor and active unit marker stay on, rest turned off
	STA effects
	JSR checkTarget																																; possibly different weapon, so re-check range, damage etc

+heatCost:
	JMP calculateActionCost																												; tail chain

+nextEvent:
	RTS
