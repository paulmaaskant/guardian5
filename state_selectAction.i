; ------------------------------------------
; gameState 06: Wait for player to select action
; ------------------------------------------
state_selectAction:
	JSR random													; introduce entropy

	JSR clearCurrentEffects							;
	LDA effects
	AND #%11111000
	STA effects

	LDA events
	BIT event_checkAction
	BEQ +continue
	ORA event_updateStatusBar
	EOR event_checkAction
	STA events
	JMP +toggleDone

+continue																	;
	BIT event_updateStatusBar																											;
	BNE +continue
	JMP +nextStep

+continue:														; if status bar is updated, buffer it as well
	ORA event_refreshStatusBar					; raise event to trigger buffer to screen
	EOR event_updateStatusBar						;
	STA events

	JSR clearActionMenu
	JSR clearTargetMenu

	LDY #$40
	STY menuIndicator+1
	INY																	; set indicator blinking tiles
	STY menuIndicator+0									; indicating 'toggle' mode

	LDY selectedAction									; update the action menu buffer with the selected action
	LDA actionList, Y
	ASL
	TAX
	LDA actionTable+1, X								; action string
	TAY
	LDX #$00														; write to position 0
	JSR writeToActionMenu								;

	;LDA actionMessage
	;BEQ +continue
	;AND #$7F														; show it on line 3
	;TAY
	;LDX #26															; line 3
	;JSR writeToActionMenu								;

+continue:
	LDA infoMessage
	ASL
	BCC +continue
	LDX #%0010000
	STX menuFlags

+continue
	LSR
	BEQ +continue
	TAY
	LDX #13															; line 2
	JSR writeToActionMenu								;

+continue:
	JSR updateTargetMenu
	JSR updateSystemMenu

+nextStep:
	LDA frameCounter
	AND #%00100000
	BEQ +continue
																	; ----------------------------------
																	; show markers
																	; show markers above all shutdown units
																	; and the locked target (if present)



	LDX objectListSize

-loop:
	LDA objectList-1, X
	CMP targetObjectTypeAndNumber
	BEQ +nextObject									; ignore current target unit -> go to next unit
	AND #%01111000									;
	TAY															; index of iterated object
	LDA object+4, Y
	AND #%00000001									; marked?
	BEQ +nextObject

	LDA #3													; 'MARK'
	STA locVar5

	LDA object+3, Y
	JSR gridPosToScreenPos
	BCC +nextObject									; unit not on screen, next unit

	INC effects
	LDA effects
	AND #%00000111
	TAY
	LDA locVar5

	STA currentEffects-1, Y
	LDA currentObjectXPos
	STA currentEffects+5, Y
	LDA currentObjectYPos
	STA currentEffects+11, Y

+nextObject:
	DEX
	BNE -loop


+continue:
	LDA blockInputCounter
	BEQ +continue								; if timer is still running,
	DEC blockInputCounter				; then dec the counter and skip input processing

-done:
	RTS

+continue
	LDA buttons									; if no buttons are pushed, this frame is done
	BEQ -done

+continue:
	LDA #7								; button pressed -> block input for 08 frames
	STA blockInputCounter
	LDA cursorGridPos
	AND #$0F							;
	STA locVar2						; grid X coor
	LDA cursorGridPos
	LSR
	LSR
	LSR
	LSR
	STA locVar1						; grid Y coor
	LDA buttons						; process directional buttons ---
	LDY missionMapSettings

	LSR 									; read RIGHT bit
	BCC +next							; skip if RIGHT not pressed
	CLC
	LDA locVar2						; translate 'isometric' directions
	ADC locVar1						; to Cartesian
	LSR
	BCC +xEven
	LDA mapDimL, Y				; cursor cant go over map dimensions
	CMP locVar1
	BEQ +updatePos
	INC locVar1
	JMP +updatePos

+xEven:
	LDA mapDimW, Y				; cursor cant go over map dimensions
	CMP locVar2
	BEQ +updatePos
	INC locVar2
	JMP +updatePos

+next:
	LSR 									; read LEFT bit
	BCC +next							; skip if LEFT is not pressed
	CLC
	LDA locVar2
	ADC locVar1
	LSR
	BCS +xUnEven
	LDA locVar1
	BEQ +updatePos
	DEC locVar1
	JMP +updatePos

+xUnEven:
	LDA locVar2
	BEQ +updatePos
	DEC locVar2
	JMP +updatePos

+next:
	LSR
	BCC +next						; skip if DOWN is not pressed
	LDA locVar1
	BEQ +updatePos
	LDA locVar2
	CMP mapDimW, Y
	BEQ +updatePos
	DEC locVar1
	INC locVar2
	BNE +updatePos

+next:
	LSR
	BCC +next						; skip if UP is not pressed
	LDA locVar2
	BEQ +updatePos
	LDA locVar1
	CMP mapDimL, Y
	BEQ +updatePos
	DEC locVar2
	INC locVar1
	BNE +updatePos

+next:
	LSR 									; start
	BCC +next
;
;	JSR buildStateStack		; open start menu
;	.db 12
;	.db $32, %00100100		; clear sys flag: portrait & object sprites
;	.db $45, %00000000		; blink action menu (switch off)
;	.db $20, 2						; load hud menu background
;	.db $47, 0						; set target object as hud objec
;	.db $3D								; load hud menu values
;	.db $23								; expand menu
;	.db $41								; reload portrait
;	.db $24								;
;	; RTS built in

+next:
	LSR 									; select
	BCC +next							; no function

+next:
	LSR 									; get B button
	BCS +toggle						; toggle

+next:
	LSR 									; get A button
	BCS +lock							; lock

+updatePos:
	; --- put update grid X & Y back together ---
	LDA locVar1
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC locVar2

	CMP cursorGridPos					; check if it changed
	BNE +continue							; changed -> continue
	RTS

+continue:
	STA cursorGridPos					; store new value

	LDY #sSimpleBlip
	JSR soundLoad

	LDA effects
	AND #%11000111
	STA effects

	LDA events
	ORA event_updateTarget
	STA events

	JMP updateCamera					; tail chain: update camera in case of new cursor position

+toggle:
	LDA events
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

+toggleDone:
	LDA #emptyString										; clear action message
	STA actionMessage

	LDA #$00
	STA infoMessage
	STA menuFlags

	LDA effects													; clear possible LOS block effect
	AND #%11000000											; cursor and active unit marker stay on, rest turned off
	STA effects
																			; redo checks for newly selected action on other unit																														;
	LDA targetObjectTypeAndNumber				; cursor is on unit?
	BEQ +move														; empty hex -> validate move actions
	CMP activeObjectIndexAndPilot				; cursor on self?
	BEQ +actionPointCost								; yes -> point cost
	JSR checkTarget

+actionPointCost:										  ;
	JMP calculateActionPointCost

+move:
	JSR checkMovement
	JMP calculateActionPointCost																									; tail chain

+lock:
	LDA actionMessage				; deny message?
	BPL +continue						; no -> lock

	LDY #sDeny
	JSR soundLoad						; tail chain

	LDA #64
	STA blockInputCounter

	JSR buildStateStack
	.db 7									; 7 items
	.db $45, %00001000		; blink action menu line 3 (switch on)
	.db $1A								; wait
	.db $45, %00000000		; blink action menu (switch off)
	.db $31, #eRefreshStatusBar

+continue:
	LDY #sSelect
	JSR soundLoad

	LDA #$2F ;
	STA menuIndicator+0
	LDA #$2E ;
	STA menuIndicator+1

	JSR pullAndBuildStateStack
	.db #3
	.db $31, #eUpdateStatusBar
	.db $2F
