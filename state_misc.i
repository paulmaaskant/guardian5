; ------------------------------------------
; gameState 00: Initialize title screen
; ------------------------------------------
state_initializeTitleScreen:
	LDA #$1E									; next game state: title screen menu
	STA list1+1
	LDA #< titleScreen				; title screen byte stream hi
	STA list1+2
	LDA #> titleScreen				; title screen byte stream lo
	STA list1+3
	LDA #$40									; fade out, no fade in
	STA list1+4

	LDY #sTitleSong
	JSR soundLoad

	JMP initializeScreen			; tail chain

; ------------------------------------------
; gameState 01: Initialize story screen
; ------------------------------------------
state_initializeStoryScreen:
	LDA #$0D									; next game state: init story text stream
	STA list1+1
	LDA #< storyScreen				; story screen byte stream hi
	STA list1+2
	LDA #> storyScreen				; story screen byte stream lo
	STA list1+3
	LDA #$80									; fade in, but no fade out
	STA list1+4

	LDY #$01
	JSR soundLoad

	JMP initializeScreen			; tail chain

; ------------------------------------------
; gameState 02: fade out fade in
; ------------------------------------------
; list2+0 = counter
; list2+1 = next game state
; list2+2 = brightness
; list2+3 = b7 fade out (0) / fade in (1)
; list2+4 = mask to control timing
; list2+5 = -40 (to black) or +40 (to white)
;
; ------------------------------------------
state_fadeInOut:
	LDA list2+0
	AND list2+4
	BNE +done

	LDA #$10
	CLC
	BIT list2+3
	BMI +										; fading in, so +10
	EOR #$FF								; fading out, so -10
	SEC
+	ADC list2+2
	STA list2+2
	BEQ +complete						; 0 (normal colours)
	CMP list2+5							; -40 (everyting black) or +40 (everyting white)
	BNE +continue
+complete:
	LDY list2+1
	STY gameState
+continue:
	JSR updatePalette
+done:
	INC list2+0
	RTS


; ------------------------------------------
; gameState 04: Initialize level variables
; ------------------------------------------
state_initializeMap:
	; fix me

	LDA #< levelOne
	STA bytePointer+0
	LDA #> levelOne
	STA bytePointer+1

	LDY #$01
	JSR soundLoad


	; --- map collision data ---
	LDX #$00

-loop:
	JSR getNextByte								; holds data for 4 nodes (2 bits per node)
	LDY #$04

-shift:
	STA nodeMap, X								; only b7, b6 are relevant
	ASL
	ASL
	INX
	DEY
	BNE -shift
	CPX #$00
	BNE -loop

	; -- object info ---
	JSR getNextByte
	STA objectCount
	STA activeObjectTypeAndNumber	; set to the last object so that the next is the first
	LDX #$00
-nextObject:
	CPX objectCount
	BEQ +done

	TXA
	PHA								; push X

	JSR getNextByte
	ASL
	ASL
	ASL
	CLC
	ADC identity, X
	STA objectTypeAndNumber, X

	JSR getStatsAddress				; breaks X, sets pointer1

	PLA
	TAX
	PHA

	LDY #$00
	LDA (pointer1), Y
	PHA												; push init stats

	TXA
	ASL
	ASL
	TAX

	PLA												; pull init stats
	STA object+1, X

	JSR getNextByte
	STA object+3, X

	TAY							;
	LDA #$C0
	STA nodeMap, Y

	JSR getNextByte
	STA object+0, X

	PLA							; pull X
	TAX
	INX

	JMP -nextObject
+done

	LDA #$F8							; start the camera one screen down
	STA cameraY+1					; camera automatically scrolls back up, loading the tiles!

	LDA #$05
	STA gameState					; start load level map cycle

	RTS

; ------------------------------------------
; gameState 05: Load level map cycle
; ------------------------------------------
state_loadLevelMapTiles:
	LDA cameraY+1						; use regular scrolling to fill NT
	BNE +stillLoading				; once camera is back on 0, the NT is f

	;---- Level load complete ----
	LDA sysFlags
	ORA sysFlag_splitScreen			; switch on split screen
	STA sysFlags

	; --- set fade in parameters ---
	LDA #$02							; 'fade in / out'
	STA gameState					; next game state
	LDA #$08							; 'assign turn'
	STA list2+1						; next next game state
	LDA #$00
	STA list2+0						; counter for fade out
	LDA #$C0
	STA list2+2						; starting brightness
	LDA #$80
	STA list2+3						; fade in
	LDA #$07
	STA list2+4						; timing mask

	RTS
+stillLoading:
	SEC										; speed up loading
	SBC #$06							; speed up camera scroll
	BCC +									; make sure not to go negative
	STA cameraY+1
+	RTS

; ------------------------------------------
; gameState 06: Wait for player to select action
; ------------------------------------------
state_selectAction:
	JSR random						; introduce entropy

	LDA blockInputCounter
	BEQ +continue					; if timer is still running,
	DEC blockInputCounter	; then dec the counter and skip input processing
	RTS

+continue:
	LDA buttons						;
	BNE +continue					; if no buttons are pressed
	RTS										; then skip input processing

+continue:
	; --- process cursor input ---
	LDA cursorGridPos
	AND #$0F						;
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
	AND #$F0						; clear direction buttons
	STA buttons

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
	LDA sysFlags					; TEST
	EOR sysFlag_splitScreen			;
	STA sysFlags					;
	JMP +setTimer

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
	STA gameState					; set next game state

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

	LDA menuFlags
	EOR menuFlag_indicator
	STA menuFlags

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

	LDY #sRelease
	JSR soundLoad

	LDA menuFlags
	ORA menuFlag_indicator
	STA menuFlags

	LDA #$2E ; 						; "< >"
	STA menuIndicator+0
	LDA #$2F ;
	STA menuIndicator+1

	;BNE +nextEvent				; JMP
	RTS

	; --- toggle ---
+toggle:
	LDY #sSimpleBlip
	JSR soundLoad

	INC selectedAction
	LDA actionList
	CMP selectedAction
	BCS +toggleDone
	LDA #$01
	STA selectedAction

+toggleDone:
	; redo checks
	LDA #$00												; clear action message
	STA actionMessage					;

	LDA targetObjectTypeAndNumber		; if cursor is on other unit
	BEQ +nextEvent
	CMP activeObjectTypeAndNumber
	BEQ +nextEvent

	LDA effects
	AND #%11000000									; cursor and active unit marker stay on, rest turned off
	STA effects

	JMP checkTarget									; possibly different weapon, so re-check range, damage etc

+nextEvent:
	RTS



; ------------------------------------------
; gameState 07: Wait for player to confirm spin direction
; ------------------------------------------
state_setDirection:
	LDA blockInputCounter
	BEQ +takeInput					; if timer is still running, then skip input processing
	DEC blockInputCounter			; timer still running

	; ---- direction is confirmed ----
	LDA events
	BIT event_confirmAction
	BEQ +done
	EOR event_confirmAction
	STA events

	LDA #$16						; show results
	STA gameState
+done:
	RTS

+takeInput:
	BIT buttons						;
	BVS +controlCamera		; B
	BMI +confirm					; A

	LDX activeObjectIndex			; get current facing direction
	LDA object, X					;
	AND #$07						;
	STA locVar1						;

	LDA buttons						;
	AND #%00000101					; down or right
	BNE +clock

	LDA buttons						;
	AND #%00001010					; left or up
	BNE	+counterClock

	RTS

+clock:
	INC locVar1
	LDA #$07
	CMP locVar1
	BNE +setDirection
	LDA #$01
	STA locVar1
	JMP +setDirection

+counterClock:
	DEC locVar1
	BNE +setDirection
	LDA #$06
	STA locVar1
	JMP +setDirection

+controlCamera:
	LSR buttons					; roll bits into carry flag
	BCC +
	LDA #$10
	JSR updateCameraXPos
+	LSR buttons
	BCC +
	LDA #$F0
	JSR updateCameraXPos		; carry is set: A is signed
+	LSR buttons
	BCC +
	LDA #$10
	JSR updateCameraYPos
+	LSR buttons
	BCC +
	LDA #$F0
	JSR updateCameraYPos		; carry is set: A is signed
+	JMP +done

+confirm:
	LDA events
	ORA event_confirmAction
	STA events

	LDA #$00
	STA menuFlags
	BEQ +done						; JMP

+setDirection:
	LDA object, X
	AND #$F8					; clear direction bits
	ORA locVar1					; set new direction
	STA object, X

	LDY #sMechStep
	JSR soundLoad

+done:
	LDA #$08
	STA blockInputCounter

	LDA events
	ORA event_updateSprites
	STA events

	RTS


; ------------------------------------------
; gamesState 08: Selects the object that is up next
;------------------------------------------
; looks up the active object's index and tries to find the object with index+1
; if no such object exits it looks for index+2 etc
; when index+n is equal to the number of objects in memory, the index is reset to 0
state_setNextActiveObject:
	LDA activeObjectTypeAndNumber
	AND #$07
	STA locVar1
	INC locVar1
	LDX #$00
-loop:
	LDA objectTypeAndNumber, X
	AND #$07
	CMP locVar1
	BEQ +setNext
	INX
	CPX objectCount
	BNE -loop:

	LDX #$00								; increase index and try again
	INC locVar1
	CMP #$06								; cycle between 0 and 5
	BNE -loop
	STX locVar1							; reset index to 0
	BEQ -loop								; JMP

+setNext:
	LDA objectTypeAndNumber, X
	STA	activeObjectTypeAndNumber
	;PHA

	; --- retrieve object data ---
	AND #$07
	ASL
	ASL
	STA activeObjectIndex
	TAY
	LDA object+3, Y
	STA activeObjectGridPos

	LDA object+0, Y
	JSR showPilot

	; --- retrieve type data ---
	LDA activeObjectTypeAndNumber
	JSR getStatsAddress

	LDA (pointer1), Y				; attack & defence
	STA activeObjectStats+5
	INY								; damage & movement
	LDA (pointer1), Y
	STA locVar1
	AND #$07
	STA activeObjectStats+3			; weapon damage 1
	LSR locVar1
	LSR locVar1
	LSR locVar1
	LDA locVar1
	AND #$07
	STA activeObjectStats+4			; weapon damage 2
	LDA locVar1
	LSR
	LSR
	LSR
	CLC
	ADC #$02
	STA activeObjectStats+2			; movement

	LDY #$01
	LDA (pointer1), Y				; wpn range 1
	STA activeObjectStats+0
	INY
	LDA (pointer1), Y
	STA activeObjectStats+1			; wpn range 2

	LDA #$C0						; switch on cursor and active marker
	STA effects

	LDA activeObjectGridPos
	STA cursorGridPos

	LDA events
	ORA event_updateTarget
	STA events

	LDA #$0B						; center camera
	STA gameState

	JSR clearSystemMenu
	JMP showSystemInfo				; tail chain


; ------------------------------------------
; gameState 09: run dialog
; ------------------------------------------
; list1+0 address start tile hi
; list1+1 address start tile lo
; list1+2 address current tile hi
; list1+3 address current tile lo
; list1+4 # tiles margin left
; list1+5 # tiles margin right
; list1+6 stream control (b7 stop, b6 wait for A)
; list1+7 reserved
; list1+8 game state

state_runDialog:
	; --- if start button is hit ---
	LDA buttons
	AND #%00010000				; start button
	BEQ +continue

	LDA #$80
	STA list1+6

+continue:
	; --- stream control ----
	LDA list1+6
	ASL
	BCS	+nextGameState			;
	ASL
	BCC +continue
	ASL
	BCS +waitForConfirm
	RTS

+waitForConfirm:
	LDA buttons
	BMI +confirmed				; A button pressed

	LDA frameCounter
	AND #%00000111
	BEQ +cursor
	RTS

+cursor:
	LDA frameCounter
	AND #%00001000
	BEQ +off
	LDA #$2F
	JMP +pushChar

+confirmed:
	LDA #$00
	STA list1+6					; open stream again

+off:
	LDA #$0F
	JMP +pushChar

+nextGameState:
	; --- go to title screen ----
	LDA list1+8					; title screen
	STA gameState
	RTS

+continue:
	JSR getNextByte

	; --- op code: end of stream ---
	CMP #$F0
	BNE +continue
	LDA #$40				; set b6
	STA list1+6
	RTS						; and done

+continue:
	; --- op code: new line ---
	CMP #$F1
	BNE +continue

	LDA list1+1				; lo
	AND #%11100000			; round down (31)
	CLC
	ADC	list1+4				; tiles: offset (never more than 31)
	ADC #$20					; tiles: new line
	STA list1+1
	LDA list1+0
	ADC #$00
	STA list1+0
	RTS						; and done

+continue:
	; --- op code: clear all ---
	CMP #$F2
	BNE +continue

	LDA list1+2				; reset write address to first position
	STA list1+0				;
	LDA list1+3				;
	STA list1+1				;

	LDA #$06				; number of lines to clear
	STA list1+7				;

	LDA #$0F				; game state : clear text box
	STA gameState			;
	RTS						; and done

+continue:
	; --- op code: wait for A button ---
	CMP #$F3
	BNE +continue
	LDA #$60				; stop stream (b6) and wait for A button (b5)
	STA list1+6
	RTS

+continue:
	; --- op code: move to next game state ---
	CMP #$F4
	BNE +continue
	LDA #$80				; (b7) move to next game state
	STA list1+6
	RTS

+continue:

	PHA
	LDA soundStreamChannel+4
	BMI +
	LDY #sSimpleBlip
	JSR soundLoad
+	PLA

+pushChar:
	; --- no op code: output char in A ---
	TSX						; switch stack pointers
	STX	stackPointer1
	LDX stackPointer2
	TXS

	PHA
	LDA list1+1				; lo
	PHA
	LDA list1+0				; hi
	PHA
	LDA #$02
	PHA

	TSX						; switch stack pointers back
	STX	stackPointer2
	LDX stackPointer1
	TXS

	BIT list1+6
	BVS +continue

	INC list1+1				; set pointer to next tile position if stream is open
	BNE +continue
	INC list1+0

+continue:
	RTS

; ------------------------------------------
; gameState 0A: Initialize spin direction state
; ------------------------------------------
state_initializeSetDirection:
	LDA events
	ORA event_refreshStatusBar		; buffer to screen
	STA events

	LDA #$0F ; 						; clear menu indicators
	STA menuIndicator+0
	STA menuIndicator+1

	LDA menuFlags					; switch on blinking for line 1 and 2
	ORA menuFlag_line1				; set flag
	ORA menuFlag_line2				; set flag
	STA menuFlags

	LDA #$07						; Wait for user input set direction
	STA gameState					;

	JSR clearActionMenu				; clear menu and write ...
	LDX #$00						; line 1, pos 0
	LDY #$0B						; "CHOOSE FACING DIRECTION"
	JMP writeToActionMenu			; tail chain

; ------------------------------------------
; gameState 0B: sets the camera destination so that it centres on the active object
; ------------------------------------------
state_centerCamera:

	LDA activeObjectGridPos
	JSR gridPosToScreenPos

	; --- camera X += current X ---
	LDA currentObjectXPos
	CLC
	ADC cameraX+1
	STA cameraXDest+1
	LDA currentObjectXScreen
	ADC cameraX+0
	STA cameraXDest+0

	; --- camera Y += current Y
	LDA currentObjectYPos
	CLC
	ADC cameraY+1
	STA cameraYDest+1
	LDA currentObjectYScreen
	ADC cameraY+0
	STA cameraYDest+0

	LDA #$88					; offset
	JSR updateCameraXPos		;
	LDA #$81					; offset
	JSR updateCameraYPos
	LDA #$0C					; wait for camera to center
	STA gameState

	RTS

; ------------------------------------------
; gameState 0C: Wait for the camera to reach its destination
; ------------------------------------------
state_waitForCamera:

	LDA cameraXDest+0
	CMP cameraX+0
	BNE +
	LDA cameraXDest+1
	CMP cameraX+1
	BNE +

	LDA cameraYDest+0
	CMP cameraY+0
	BNE +
	LDA cameraYDest+1
	CMP cameraY+1
	BNE +

	LDA #$06					; user to select action
	STA gameState
+
	RTS

; ------------------------------------------
; gameState 0D: prepare for intro story stream
; ------------------------------------------
state_initializeIntroDialog

	LDA #< storyStream			; intro story stream hi
	STA bytePointer+0
	LDA #> storyStream			; intro story stream lo
	STA bytePointer+1

	LDA #$25
	STA list1+0					; start address hi
	STA list1+2
	LDA #$44
	STA list1+1					; start address lo
	STA list1+3

	LDA #$04
	STA list1+4					; # tiles: offset
	LDA #$1C
	STA list1+5					; # tiles: last pos

	LDA #$00
	STA list1+6					; stream on
	STA list1+8					; game state once stream is over: title screen

	LDA #$09
	STA gameState

	RTS

; ------------------------------------------
; gameState 0E: Load cycle to fill up the screen
; ------------------------------------------
; list1+0 = number of cycles
; list1+1 = next game state
state_loadScreen:
	JSR write32Tiles				; push 64 tiles per cycle
	DEC list1
	BEQ +
	JSR write32Tiles
	DEC list1
	BEQ +
	RTS								;

	; --- load complete ---
+	LDA list1+1						; move to next game state

	; --- unless there is a fade in ---
	BIT list1+4
	BPL +
	STA list2+1						; next next game state

	; --- fade in parameters
	LDA #$00
	STA list2+0						; counter for fade out
	LDA #$C0
	STA list2+2						; starting brightness
	LDA #$80
	STA list2+3						; fade in
	LDA #$07
	STA list2+4						; timing mask

	LDA #$02						; "fade in"
+	STA gameState					; next gamestate

	RTS



; ------------------------------------------
; gameState 0F: clear all tiles in text dialogue box on screen
; ------------------------------------------
; list1+0 address start tile hi
; list1+1 address start tile lo
; list1+2 address current tile hi
; list1+3 address current tile lo
; list1+4 # tiles margin left
; list1+5 # tiles new line break tile pos
; list1+6 reserved
; list1+7 number of lines to clear
state_clearDialog:

	LDA list1+5
	SEC
	SBC list1+4
	TAY
	ASL
	STA locVar1

	TSX						; switch stack pointers
	STX	stackPointer1
	LDX stackPointer2
	TXS

	LDA #$0F
-	PHA
	DEY
	BNE -

	LDA list1+1				; lo
	PHA
	LDA list1+0				; hi
	PHA
	LDA locVar1
	PHA

	TSX						; switch stack pointers back
	STX	stackPointer2
	LDX stackPointer1
	TXS

	DEC list1+7
	BNE +nextLine

	LDA list1+2				; set back current address to first char position
	STA list1+0
	LDA list1+3
	STA list1+1

	LDA #$09
	STA gameState
	RTS

+nextLine:
	LDA #$20
	CLC
	ADC list1+1
	STA list1+1
	LDA list1+0
	ADC #$00
	STA list1+0

	RTS




	; ------------------------------------------
	; gameState 1C: light flash
	; ------------------------------------------
	; list1+0 return state
	; list1+1 b7 toggle (flash/unflash)
	; list2 reserved for fade in fade out state
	;
state_lightFlash:
	LDA list1+1
	BNE +unflash
	INC list1+1
	STA list2+2						; starting brightness
	LDA #$80
	STA list2+3						; fade in
	LDA #$1C
	STA list2+1						; back to this state
	LDA #$03
	STA list2+4						; timing mask
	LDA #$40
	STA list2+5						; all white
	BNE +done
+unflash:
	LDA #$40
	STA list2+2						; starting brightness
	LDA list1+0						;
	STA list2+1						; next state
	LDA #$03
	STA list2+4						; timing mask
	LDA #$00
	STA list2+3						; fade out
+done:
	LDA #$00
	STA list2+0						; counter for fade out
	LDA #$02
	STA gameState
	RTS

; ------------------------------------------
; gameState 1C: init title screen menu
; ------------------------------------------
state_initializeTitleMenu:
	JSR clearActionMenu

	LDY #$15
	LDX #$00
	JSR writeToActionMenu

	LDY #$17
	LDX #$0D
	JSR writeToActionMenu

	LDY #$16
	LDX #$1A
	JSR writeToActionMenu

	LDA #$2F
	STA menuIndicator+0

	LDA #$0F
	STA menuIndicator+1
	STA menuIndicator+2

	LDA #$00
	STA list1+0						; title screen animation counter
	STA list1+1						; title screen menu choice
	STA list1+2						; sound number

	JSR writeStartMenuToBuffer

	LDA #$02							; 'fade in / out'
	STA gameState					; next game state
	LDA #$03							; title
	STA list2+1						; next next game state
	LDA #$00
	STA list2+0						; counter for fade out
	LDA #$C0
	STA list2+2						; starting brightness
	LDA #$80
	STA list2+3						; fade in
	LDA #$07
	STA list2+4						; timing mask
	RTS
