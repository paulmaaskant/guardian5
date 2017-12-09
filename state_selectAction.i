; ------------------------------------------
; gameState 06: Wait for player to select action
; ------------------------------------------
state_selectAction:
	JSR random																																		; introduce entropy

	JSR clearCurrentEffects

	LDA effects
	AND #%11111000
	STA effects

	LDA frameCounter
	AND #%00100000
	BEQ +continue

+showTimer:
	LDX objectCount

-loop:
	LDA objectTypeAndNumber-1, X
	CMP targetObjectTypeAndNumber
	BEQ +nextObject
	AND #%00000111
	ASL
	ASL
	TAY
	LDA object+0, Y
	BPL +nextObject							; unit not shutdown

	LDA object+3, Y
	JSR gridPosToScreenPos
	BCC +nextObject							; unit not on screen

	INC effects
	LDA effects
	AND #%00000111
	TAY
	LDA #$0E										; timer sprite
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
	BEQ +continue																																	; if timer is still running,
	DEC blockInputCounter																													; then dec the counter and skip input processing

-done:
	RTS

+continue
	LDA buttons
	BEQ -done

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

	LDA #$08							; block input for 08 frames
	STA blockInputCounter

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
	BEQ +updatePos
	INC locVar1
	JMP +updatePos

+xEven:
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
	CMP #$0F
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
	CMP #$0F
	BEQ +updatePos
	DEC locVar2
	INC locVar1
	BNE +updatePos

+next:
	LSR 									; start
	BCC +next

	JSR buildStateStack
	.db 13
	.db $20, 2					; load hud menu
	.db $32, %00000100	; clear sys flag: object sprites
	.db $23							; expand menu
	.db $24							; load stream 10: game paused
	.db $20, 1					; load hud
	.db $31, #eRefreshStatusBar
	.db $25							; collapse menu
	.db $29, %00000100	; set sys flag: object sprites

	; RTS built in

+next:
	LSR 									; select
	BCC +next

	JSR buildStateStack
	.db 9
	.db $20, 0					; load menu backgorund 0
	.db $01, 10					; load stream 10: start level 1
	.db $30							; restore active unit portrait
	.db $20, 1					; load menu backgorund 0
	.db $31, #eRefreshStatusBar
	; RTS built in

+next:
	LSR 									; get B button
	BCS +toggle

+next:
	LSR 									; get A button
	BCS +lock

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

	JMP updateCamera					; tail chain: update camera in case of new target

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

	LDA #7
	JSR setTargetToolTip

+actionPointCost:
	JMP calculateActionPointCost																									; tail chain

+lock:
	LDA actionMessage				; deny message?
	BPL +continue						; no -> lock

	LDY #sDeny
	JMP soundLoad						; tail chain

+continue:
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
