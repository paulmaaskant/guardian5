;; 1 - iNes header
	.db "NES", $1A	; iNes Identifier
	.db $02			; number of PRG-Rom (16kb) blocks the game has
	.db $04			; number of CHR-Rom (8kb) blocks the game has
	; mapper 25
	.db $90 		; left nyble = mapper low nyble
	.db $10			; left nyble = mapper high nyble
	.db $00, $00, $00, $00, $00, $00, $00, $00	; filler

;; 2 - constants and variables
	.enum $0000 													; zero page

	nmiVar0											.dsb 1		; local variables used by NMI and
	nmiVar1											.dsb 1		; subroutines that are NMI specific
	nmiVar2											.dsb 1
	nmiVar3											.dsb 1
	nmiVar4											.dsb 1
	nmiVar5											.dsb 1
	nmiVar6											.dsb 1
	nmiVar7											.dsb 1

																				; ---------------------------------
																				; The following are variables that have a lifespan limited to a single frame
																				; Used by various subroutines
																				; They cannot be relied upon to carry values across frames
																				; ---------------------------------

	locVar1 											.dsb 1	; LOCAL variables usable by supporting subroutines (never used as IN OUT)
	locVar2 											.dsb 1
	locVar3												.dsb 1
	locVar4												.dsb 1
	locVar5												.dsb 1

	par1 													.dsb 1	; IN / OUT parameters used by supporting subroutines
	par2 													.dsb 1
	par3 													.dsb 1
	par4													.dsb 1
	pointer1											.dsw 1
	pointer2											.dsw 1	;

	cameraY												.dsw 1	; upper left of camera in relation to background tiles
	cameraX												.dsw 1	; upper left of camera in relation to background tiles
	cameraYDest										.dsw 1	; upper left of camera in relation to background tiles
	cameraXDest										.dsw 1	; upper left of camera in relation to background tiles
	cameraYStatus									.dsb 1
																				; ---------------------------------
																				; The following are variables that have a life span that goes across frames
																				; typically used to carry information from one game state to the next
																				; ---------------------------------

	list1													.dsb 10	; used as game state values, sometimes to transfer values from one game state to the next
	list2													.dsb 10	; these values are constant over frame rates (not used by event subroutines)

	bytePointer										.dsw 1	; dedicated to byte streams
	byteStreamVar									.dsb 3	; dedicated to byte streams

	frameCounter 									.dsb 1	; used to pace the main loop, i.e., once per frame
	actionCounter									.dsb 1	; used to time action animations
	blockInputCounter							.dsb 1  ; used to block input for specified time
	effectCounter									.dsb 1  ; used to time cursor sprite animation
	menuCounter										.dsb 1	; used to time menu blinking

	sysFlags											.dsb 1	; scroll direction (b7-6), action locked (b5), screen split (b4), PAL vs NTSC (b3)
	events												.dsb 1  ; flags that trigger specific subroutines
	effects												.dsb 1  ; flags that trigger embedded sprite effects
	menuFlags											.dsb 1	; flags that causes menu areas to blink
	actionMessage									.dsb 1	;

	stackPointer1									.dsb 1	;
	stackPointer2									.dsb 1	;

	buttons 											.dsb 1	; used to store controller #1 status
	gameProgress									.dsb 1  ; used to keep track of game progress
	seed													.dsw 1	; used to generate random numbers
	cursorGridPos									.dsb 1  ; grid coordinates of cursor XXXX YYYY

	stateStack										.dsb 25 ; used to control state transitions in the game

																				; the object that is currently being handled
	currentObjectType 						.dsw 1	; pointer to the object type (all constants for the object)
	currentObjectYPos 						.dsb 1 	; on screen coordinate Y of active object
	currentObjectYScreen					.dsb 1	;
	currentObjectXPos 						.dsb 1 	; on screen coordinate X of active object
	currentObjectXScreen					.dsb 1	;
	currentObjectFrameCount 			.dsb 1	; used to time the object's sprite animation

	targetObjectTypeAndNumber			.dsb 1	; target object type / number
	targetObjectIndex							.dsb 1	; index in objects table

	activeObjectTypeAndNumber			.dsb 1	; active object type / number
	activeObjectIndex							.dsb 1	; index in objects table
	activeObjectGridPos						.dsb 1	; position of the object that has the turn
	activeObjectStats							.dsb 1	; 0 weapon 1 max range (b7-4) min range (b3-2) and type (b1-0)
																.dsb 1	; 1 weapon 2 max range (b7-4) min range (b3-2) and type (b1-0)
																.dsb 1	; 2 movement
																.dsb 1  ; 3 weapon 1 damage
																.dsb 1 	; 4 weapon 2 damage
																.dsb 1 	; 5 accuracy
																.dsb 1	; 6 hit points
																.dsb 1	; 7 weapon 1 details
																.dsb 1	; 8 weapon 2 details
																.dsb 1	; 9 remaining action points

																				; stored memory objects
																				; object grid position is stored separately as it will be sorted regularly
	objectListSize								.dsb 1	; number of objects presently in memory
	objectList										.dsb 8	; (b7) hostile (b6-4) pilot (b3-0) object index
																				; the rest of the object information is stored (4 bytes each) so that it does not require sorting whenever the object's position changes

	object												.dsb 1	; +0: (b7-4) type, (b3) move/still, (b2-0) direction
																.dsb 1	; +1: health dial (b7-3), heat dial (b2-0)
																.dsb 1	; +2: (b7) shut down (b6-0) frame count
																.dsb 1	; +3: grid pos

	object1												.dsb 4	;
	object2												.dsb 4	;
	object3												.dsb 4	;
	object4												.dsb 4	;
	object5												.dsb 4	;
	object6												.dsb 4	;
	object7												.dsb 4	;

	actionList										.dsb 10	; ------------------------------------------------------
	selectedAction								.dsb 1	; various
	debug 												.dsb 5	; possible actions used for player and AI
	distanceToTarget							.dsb 1

	pal_transparant								.dsb 1	; ------------------------------------------------------
	pal_color1										.dsb 8	; palette colours
	pal_color2										.dsb 8	; store in memory to manipulate brightness
	pal_color3										.dsb 8

	list5													.dsb 10	; all purpose
	portraitXPos									.dsb 1
	portraitYPos									.dsb 1
	softCHRBank1									.dsb 1
	level													.dsb 1
	roundCount										.dsb 1
	targetEffectAnimation					.dsb 1

	.ende
	.enum $0300																																		; sound variables

	soundFlags										.dsb 1																					; (b7) sound enabled (b6) silence event raised
	soundStreamChannel						.dsb 6																					; (b7) stream active? (b1-0) APU channel that the stream using
	soundStreamDutyVolume					.dsb 6																					; (b7-6) Duty (b4-0) Volume Offset
	soundStreamPeriodLo						.dsb 6																					; (b7-0) Note current (lo)
	soundStreamPeriodHi						.dsb 6																					;	(b2-0) Note current (hi)
	soundStreamPointerLo					.dsb 6																					; (b7-0) Stream index (lo)
	soundStreamPointerHi					.dsb 6																					; (b7-0) Stream index (hi)
	soundStreamTempo							.dsb 6																					; this streams tempo
	soundStreamTickerTotal				.dsb 6																					; ticker to control tempo
	soundStreamNoteLengthCounter	.dsb 6																					;
	soundStreamNoteLength					.dsb 6																					; number of ticks a note is playing
	soundStreamEnvelopeCounter		.dsb 6
	soundStreamEnvelope						.dsb 6
	soundStreamNoteOffset					.dsb 6
	soundStreamLoop1Counter				.dsb 6
	soundStreamLoop2Counter				.dsb 6
	soundStreamSweepControl				.dsb 6																					;
	softApuPorts									.dsb 16
	currentPortValue							.dsb 4

	.ende
	.enum $0400
	; ------------------------------------------------------------
	; nodeMap
	; hashmap for grid map based stuff
	;
	; bbbbbbbb
	; ||||||||
	; |||||+++ reference to neighbour node (used in findPath)
	; ||||+--- closed node (used in findPath)
	; |||+---- possible destination (used in AI determine move)
	; ||+----- not used
	; |+------ this node blocks line of sight
	; +------- this node is blocks movement
	; ------------------------------------------------------------
	nodeMap								.dsb 256
	list3									.dsb 64							; path finding and action control
	list4									.dsb 64							; path finding
	list6									.dsb 64							; used by AI for scoring
	list7									.dsb 64							; used by AI for scoring

	actionMenuLine1				.dsb 13							; Buffers used to render the status menu
	actionMenuLine2				.dsb 13
	actionMenuLine3				.dsb 13
	menuIndicator					.dsb 2
	targetMenuLine1				.dsb 6
	targetMenuLine2				.dsb 6
	targetMenuLine3				.dsb 6
	systemMenuLine1				.dsb 3
	systemMenuLine2				.dsb 3
	systemMenuLine3				.dsb 3

	characterPortrait			.dsb 16

	currentEffects				.dsb 30							; effects
																						; 6 sprites, 5 bytes per sprite
																						; (X, Y, animation #, counter, mirror pallette control)

	currentPalettes				.dsb 8							; indexes of the current palettes
	currentTransparant		.dsb 1							; 00 tiles: map 1
																						; 01 tiles: map 2
																						; 02 tiles: pilot face
																						; 03 tiles: status bar & menu
																						; 04 sprites: friendly units
																						; 05 sprite: hostile units
																						; 06 sprite: cursor
																						; 07 sprite: effects
	.ende

	.enum $0700																; generic look up table
	list8 .dsb 256


	.ende

	; PRG page 0: tiles
	.org $8000
	.include data_tiles.i
	.include sbr_nmi_writeNextRowToBuffer.i
	.include sbr_nmi_writeNextColumnToBuffer.i
	.include sbr_nmi_soundNextFrame.i
	.include sbr_nmi_seNextByte.i
	.include sbr_nmi_seWriteToSoftApu.i
	.include sbr_nmi_seWriteToApu.i

	.include sound00.i
	.include sound01.i
	.include sound02.i
	.include sound03.i
	.include sound04.i
	.include sound05.i
	.include sound06.i
	.include soundEffects.i

	; PRG page 1: byteStreams
	.org $A000
	.include data_dictionary.i
	.include data_byteStreams.i
	.include sbr_getNextByte.i

	; PRG page 2 and 3 (FIXED): main loop
	.org $C000

	;-----------------------------------------------------------
	; main loop
	;-----------------------------------------------------------
mainGameLoop:
	LDA frameCounter				; wait for next frame
-	CMP frameCounter
	BEQ -



	;---------------------------
	; event: update effect sprites
	;---------------------------
+nextEvent:
	LDA #1													; start with sprite 1 (sprite 0 is permanently reserved)
	STA par3													; parameter to "loadAnimationFrame"
	LDA #63													; clear up to (including) sprite 15
	JSR clearSprites

	LDA effects
	BNE +continue											; some effects are active -> continue
	JMP +nextEvent										; otherwise consider next event

+continue:
	LDA #$00													; disable mirror
	STA par4													; parameter to "loadAnimationFrame"
	LDA effectCounter									; all embedded effects share the same timer
	STA currentObjectFrameCount

	; --- cursor ---
	BIT effects
	BPL +nextEffect										; check b7
	LDA cursorGridPos									; cursor location on grid
	JSR gridPosToScreenPos						; get the screen get screen coordinates
	BCC +nextEffect										; make sure coordinates are on screen
	LDY #0														; cursor animation #
	JSR loadAnimationFrame						; set sprites!

	; --- target tool tip effect ---
+nextEffect:																																		; hit percentage
	LDA effects
	AND #%00010000										; check b4
	BEQ +nextEffect
	LDY targetObjectIndex
	LDA object+3, Y										; target's grid coordinates
	JSR gridPosToScreenPos						; get the screen get screen coordinates
	LDY targetEffectAnimation					; hit probability animation
	JSR loadAnimationFrame						; set sprites!

+nextEffect:
	; --- active unit marker, 1 sprite  ---
	BIT effects
	BVC +nextEffect										; checb b6
	LDA activeObjectGridPos						; active unit location on grid
	JSR gridPosToScreenPos						; get the screen coordinates
	BCC +nextEffect										; make sure coordinates are on screen
	LDY #1														; cursor animation #
	JSR loadAnimationFrame						; set sprites!

+nextEffect:																																		; blocking node marker, sprite 5
	LDA effects
	AND #%00100000										; check b5
	BEQ +nextEffect
	LDA list1+9																																		; node that is blocking line of sight
	JSR gridPosToScreenPos																												; get the screen coordinates
	BCC +nextEffect																																; off screen!
	LDY #2																																				; cursor animation #
	JSR loadAnimationFrame																												; set sprites!


+nextEffect:																																		; explode effect, sprite 4
	LDA effects
	AND #%00001000										; check b4
	BEQ +nextEffect
	JSR runExplosion

+nextEffect:																																		; manage counter for all embedded effects
	LDA currentObjectFrameCount																										; FIX
	CMP #$40																																			; when all effects are off screen, the count continues and does not get reset
	BEQ +nextEffect																																; so here we have hard check to make sure the effect never exceeds 64
	ADC #$01																																			; guarnteed CLC
	STA effectCounter

+nextEffect:																																		; cycle through all non-embedded effects
	LDA effects
	AND #%00000111																																; mask to get number of effect animations
	BEQ +nextEvent
	TAX
	DEX

-loopEffects:
	LDY currentEffects+0, X																												; pattern
	BEQ +skip
	LDA	currentEffects+6, X																												; x pos
	STA currentObjectXPos
	LDA currentEffects+12, X																											; y pos
	STA currentObjectYPos
	LDA currentEffects+18, X																											; count
	STA currentObjectFrameCount
	LDA currentEffects+24, X																											; mirror
	STA par4

	TXA
	PHA
	JSR loadAnimationFrame
	PLA
	TAX

	LDA currentObjectFrameCount
	STA currentEffects+18, X
	INC currentEffects+18, X

+skip:
	DEX
	BPL -loopEffects

	;---------------------------
	; event: update object sprites
	;---------------------------
+nextEvent:
	LDA sysFlags
	AND #sysObjectSprites
	BNE +next
	JMP +nextEvent

+next:
	LDX #$00																																			; start with object on pos 0

-loopObjects
	LDA objectList, X																										; get next object
	AND #$0F
	ASL
	ASL
	TAY
	LDA object+0, Y
	LSR
	LSR																																						;
	LSR																																						;
	LSR																																						;
	TAY																																						; and store it in Y
	LDA objectTypeL, Y																														; get the object type data address
	STA currentObjectType+0
	LDA objectTypeH, Y
	STA currentObjectType+1																												; and store it as the current object type

	LDA objectList, X																										; reload the object
	AND #%00001111																																; and mask the object number
	ASL																																						; mulitply by 4 to get the
	ASL																																						; object index
	TAY																																						; (part of the object stored in memory)
	PHA																																						; save Y (object index) on stack
	TXA																																						;
	PHA																																						; save X (object list index)
	LDA object+2, Y
	AND #%01111111
	STA currentObjectFrameCount
	LDA object+3, Y																																; on screen check
	JSR gridPosToScreenPos																												; get and set screen X & Y
	BCC +done																																			; off screen -> done (no need to show sprites)

	LDA objectList, X																										; get B7 (neg flag)
	PHP																																						; store neg flag
	LDA object+0, Y
	AND #%00001000																																; object move bit (b3) ON
	BEQ +next
	CLC																																						; if moving, then add displacement
	LDA currentObjectYPos																													; displacement is updated every frame
	ADC actionList+2																															; by the 'resolve move' game state
	STA currentObjectYPos

	CLC
	LDA currentObjectXPos
	TAX
	ADC actionList+1
	STA currentObjectXPos

	CPX #$20																																			; the following code ensures
	BCS +rightEdge																																; that sprites arent wrapped
	LDA actionList+1																															; to other side of screen
	BPL +notObscured
	PLP
	JMP +done

+rightEdge:
	CPX #$E0
	BCC +notObscured
	LDA actionList+1
	BMI +notObscured
	PLP
	JMP +done

+next:
	;LDX object+3, Y
	;LDA nodeMap, X
	;AND #%01000000																																		; is position obscured?
	JMP +notObscured				; fix

	;LDA #$20								; this can go																									; yes -> set up sprite mask to parially hide object
	;STA par4																																			; sprite priority 1
	;TYA																																						; store Y (object )
	;PHA
	;LDY #$03																																			; mask srpite to obscure part of the object sprite
	;JSR loadAnimationFrame	; loads mask
	;PLA
	;TAY
	;LDX #%00010000																																; restore Y
	;JMP +skip

+notObscured:																																		; next, determine mirror, palette & which animation
	LDX #%00000000																																; default value for par4 (b7-6 no mirror, b5 no mask, b4 not obscured, b0 no palette flip)

;+skip:
	LDA object+0, Y																																; derive the animation # based on object's direction and move
	AND rightNyble																																; (b3) moving? (b2-0) direction
	TAY

	AND #%00000110																																; mirror sprite if direction is 2 or 3
	CMP	#%00000010
	BNE +next
	TXA																																						; set b6 in X to mirror
	ORA #%01000000
	TAX

+next:																																					; palette 0 for friendly, palette 1 for hostile
	PLP																																						; object type flags
	BPL +next																																			; if hostile (b7) then do unit palette switch
	INX																																						; palette switch

+next:
	STX par4
	LDA directionLookup, Y
	TAY

+next:
	LDA (currentObjectType), Y 																										; retrieve sequence from the type
	TAY																																						; IN parameter Y = animation sequence
	JSR loadAnimationFrame
	INC currentObjectFrameCount																										;

+done:
	PLA																																						; restore X
	TAX																																						; from the stack
	PLA																																						; restore Y
	TAY
	LDA object+2, Y
	AND #$80
	ORA currentObjectFrameCount																										; object frame count
	STA object+2, Y
	INX																																						; next object
	CPX objectListSize																																; number of objects presently in memory
	BEQ +continue
	JMP -loopObjects																															;

+continue:

+nextEvent:
	LDA sysFlags
	AND sysFlag_showPortrait
	BNE +continue
	JMP +nextEvent

+continue:
	LDY #11

-loop:
	TYA
	ASL
	ASL
	TAX

	LDA characterPortrait, Y
	STA $0201+208, X

	LDA portraitBaseXPos, Y
	ADC portraitXPos
	STA $0203+208, X

	LDA portraitBaseYPos, Y
	ADC portraitYPos
	STA $0200+208, X

	LDA #%00000010
	STA $0202+208, X

	DEY
	BPL -loop


	;---------------------------
	; update target / available actions
	;---------------------------
+nextEvent:
	LDA events
	BIT event_updateTarget
	BEQ +nextEvent
	EOR event_updateTarget
	ORA event_updateStatusBar																											; trigger an update of the status bar
	STA events

	LDA effects
	AND #%11000000																																; cursor and active unit marker stay on, rest turned off
	STA effects

	JSR updateTargetObject																												; load target based on cursor position
	JSR updateActionList																													; heavy subroutine: may take more than a single frame
	JSR calculateActionPointCost																									;

	LDA frameCounter																															; wait for next frame
-	CMP frameCounter																															; to prevent game from freezing (due to half completed stack operations)
	BEQ -

	JSR menuIndicatorsBlink

	; ------------------------------
	; update status bar & trigger refresh
	; ------------------------------
+nextEvent:
	LDA events																																		;
	BIT event_updateStatusBar																											;
	BNE +continue
	JMP +nextEvent

+continue:																															;
	ORA event_refreshStatusBar																										; raise event to trigger buffer to screen
	EOR event_updateStatusBar																											;
	STA events

	JSR clearActionMenu																														; set all tiles to blank
	JSR clearTargetMenu

	BIT activeObjectTypeAndNumber
	BMI +radar

	LDY activeObjectIndex
	LDA object+2, Y
	BMI +radar

	LDY selectedAction																														; update the action menu buffer with the selected action
	LDA actionList, Y
	ASL
	TAX
	LDY actionTable+1, X																													; Y is the string ID
	LDX #$00																																			; Show on position 0
	JSR writeToActionMenu																													;

	LDA actionMessage
	BEQ +continue
	AND #$7F
	TAY
	LDX #$0D
	JSR writeToActionMenu						;

+continue:
	LDA actionMessage
	BMI +continue										; if not denied,
																	; show COST
	LDX #2													; AP per turn

-loop:
	LDY #$0D
	CPX activeObjectStats+9					; remaining AP this turn
	BEQ +next
	BCS +store

+next:
	LDY #$50
	LDA activeObjectStats+9
	SEC
	SBC list3+0
	SBC identity, X
	BCC +store
	LDY #$3A

+store:
	TYA
	STA actionMenuLine3-1, X
	DEX
	BNE -loop

	LDX selectedAction
  LDA actionList, X
  CMP #aCOOLDOWN
	BNE +continue
	LDY #18													; GAIN

+skip:
	LDX #26
	JSR writeToActionMenu						;

+continue:
	JSR updateTargetMenu
	JMP +nextEvent

+radar:
	LDY #$44
	STY actionMenuLine1+5
	INY
	STY actionMenuLine1+6
	LDY #$54
	STY actionMenuLine2+5
	INY
	STY actionMenuLine2+6


	; ------------------------------
	; refresh status bar
	; ------------------------------
+nextEvent:
	LDA stackPointer2								; only flush status bar buffer
	CMP #$99												; if buffer is empty
	BNE +nextEvent									; otherwise event flag remains set and tries again next frame

	LDA events
	BIT event_refreshStatusBar
	BEQ +nextEvent
	EOR event_refreshStatusBar			;
	STA events

	JSR writeStatusBarToBuffer

; --- events have been handled, now launch game state subroutine ---
+nextEvent:
	JSR launchStateSubroutine
	JMP mainGameLoop					; restart loop
;-----------------------------------------
; END of main loop
;-----------------------------------------

; ------------------------------------------
; Subroutine to launch game state subroutine, use RTS to jump to address
; ------------------------------------------
launchStateSubroutine:
	LDX stateStack
	LDA stateStack, X
	CMP #$FF
	BEQ +
	ASL
  TAX
  LDA gameStateJumpTable+1, X
  PHA
  LDA gameStateJumpTable, X
  PHA
 +
  RTS            											; launch!

gameStateJumpTable:
	.dw state_initializeScreen-1								; 00
	.dw state_initializeDialog-1								; 01
	.dw state_fadeInOut-1												; 02
	.dw state_titleScreen-1											; 03
	.dw state_initializeMap-1										; 04
	.dw state_loadLevelMapTiles-1								; 05
	.dw state_selectAction-1										; 06
	.dw state_selectDirection-1									; 07
	.dw state_endTurn-1													; 08
	.dw state_runDialog-1												; 09
	.dw state_initializeSetDirection-1					; 0A
	.dw state_centerCameraOnCursor-1						; 0B
	.dw state_waitForCamera-1										; 0C
	.dw state_changeBrightness-1								; 0D
	.dw state_loadScreen-1											; 0E
	.dw state_clearDialog-1											; 0F
	.dw state_initializeMove-1									; 10
	.dw state_resolveMove-1											; 11
	.dw state_initializeRanged-1								; 12
	.dw state_resolveMachineGun-1								; 13
	.dw state_initializeCoolDown-1							; 14
	.dw state_resolveCoolDown-1									; 15
	.dw state_showResults-1											; 16
	.dw state_initializeCloseCombat-1						; 17
	.dw state_resolveClose-1										; 18
	.dw state_initializePivotTurn-1							; 19
	.dw not_used																; 1A NOT USED
	.dw state_initializeCharge-1								; 1B
	.dw state_faceTarget-1											; 1C
	.dw state_closeCombatAnimation-1						; 1D
	.dw state_initializeTitleMenu-1							; 1E
	.dw state_shutDown-1												; 1F
	.dw state_initializeGameMenu-1							; 20
	.dw state_playAnimation-1										; 21
	.dw state_loadGameMenu-1										; 22
	.dw state_expandStatusBar-1									; 23
	.dw state_hudMenu-1													; 24
	.dw state_collapseStatusBar-1								; 25
	.dw state_initializePlayAnimation-1					; 26
	.dw state_ai_determineAction-1							; 27
	.dw state_ai_determineAttackPosition-1 			; 28
	.dw state_setSysFlags-1											; 29
	.dw state_newTurn-1													; 2A
	.dw state_centerCameraOnAttack-1						; 2B
	.dw state_initializeEffect-1								; 2C
	.dw state_runEffect-1												; 2D
	.dw state_resolveMissile-1									; 2E
	.dw state_confirmAction-1										; 2F
	.dw state_setActiveObjectPortrait-1					; 30
	.dw state_raiseEvents-1											; 31
	.dw state_clearSysFlags-1										; 32
	.dw state_initializeLevel-1									; 33
	.dw state_startTurn-1												; 34
	.dw state_initializeModifiers-1							; 35
	.dw state_showModifiers-1										; 36
	.dw state_endAction-1												; 37
	.dw state_initializeMachineGun-1						; 38
	.dw state_initializeMissile-1								; 39

:not_used

; -------------------------
; includes
; -------------------------

	.include state_initializeSetDirection.i
	.include state_initializeDialog.i
	.include state_initializeMap.i
	.include state_initializeTitleMenu.i
	.include state_initializeScreen.i
	.include state_initializeGameMenu.i
	.include state_initializeLevel.i
	.include state_fadeInOut.i
	.include state_loadLevelMapTiles.i
	.include state_centerCameraOnCursor.i
	.include state_waitForCamera.i
	.include state_runDialog.i
	.include state_loadScreen.i
	.include state_endTurn.i
	.include state_selectAction.i
	.include state_selectDirection.i
	.include state_titleScreen.i
	.include state_resolveMove.i
	.include state_resolveSpin.i
	.include state_resolveCoolDown.i
	.include state_initializeRanged.i
	.include state_resolveMachineGun.i
	.include state_resolveClose.i
	.include state_showResults.i
	.include state_shutDown.i
	.include state_expandStatusBar.i
	.include state_hudMenu.i
	.include state_collapseStatusBar.i
	.include state_changeBrightness.i
	.include state_loadGameMenu.i
	.include state_faceTarget.i
	.include state_clearDialog.i
	.include state_playAnimation.i
	.include state_initializePlayAnimation.i
	.include state_ai_determineAction.i
	.include state_ai_determineAttackPosition.i
	.include state_newTurn.i
	.include state_centerCameraOnAttack.i
	.include state_initializeEffect.i
	.include state_runEffect.i
	.include state_resolveMissile.i
	.include state_confirmAction.i
	.include state_setActiveObjectPortrait.i
	.include state_raiseEvents.i
	.include state_setSysFlags.i
	.include state_clearSysFlags.i
	.include state_startTurn.i
	.include state_initializeModifiers.i
	.include state_showModifiers.i
	.include state_endAction.i
	.include state_initializeMachineGun.i
	.include state_initializeMissile.i

	.include sbr_getStatsAddress.i
	.include sbr_pushState.i
	.include sbr_pullState.i
	.include sbr_replaceState.i
	.include sbr_buildStateStack.i

	.include sbr_gridPosToScreenPos.i
	.include sbr_gridPosToTilePos.i
	.include sbr_calculateActionPointCost.i
	.include sbr_applyActionPointCost.i
	.include sbr_calculateAttack.i
	.include sbr_checkTarget.i
	.include sbr_checkLineOfSight.i
	.include sbr_findPath.i

	.include sbr_soundLoad.i
	;.include sbr_soundDisable.i not used currently
	.include sbr_soundInitialize.i
	.include sbr_soundSilence.i

	.include sbr_loadSpriteFrame.i
	.include sbr_loadSpriteMetaFrame.i
	.include sbr_loadAnimationFrame.i

	.include sbr_clearCurrentEffects.i
	.include sbr_clearSprites.i
	.include sbr_clearList3.i
	.include sbr_clearActionMenu.i
	.include sbr_clearTargetMenu.i
	.include sbr_clearSystemMenu.i

	.include sbr_showTargetMech.i
	.include sbr_showHexagon.i
	.include sbr_showSystemInfo.i

	.include sbr_deleteObject.i
	.include sbr_writeStatusBarToBuffer.i
	.include sbr_writeStartMenuToBuffer.i
	.include sbr_writeToActionMenu.i
	.include sbr_write32Tiles.i
	.include sbr_setLineFunction.i
	.include sbr_updateCamera.i
	.include sbr_updateTarget.i
	.include sbr_updateTargetMenu.i
	.include sbr_updateCameraXPos.i
	.include sbr_updateCameraYPos.i
	.include sbr_updatePalette.i
	.include sbr_updateActionList.i
	.include sbr_centerCameraOnNode.i
	.include sbr_initializeExplosion.i
	.include sbr_runExplosion.i
	.include sbr_addToSortedList.i
	.include sbr_angleToCursor.i
	.include sbr_menuIndicatorsBlink.i
	.include sbr_updatePortrait.i
	.include sbr_setTargetToolTip.i
	;.include sbr_setDamageToolTip.i
	.include sbr_setTile.i

	.include sbr_random.i
	.include sbr_random100.i
	.include sbr_divide.i
	.include sbr_multiply.i
	.include sbr_distance.i
	.include sbr_toBCD.i
	.include sbr_absolute.i
	.include sbr_getCircleCoordinates.i
	.include sbr_squareRoot.i

	.include reset.i
	.include nmi.i
	.include data_spriteFrames.i
	.include data_metaSpriteFrames.i
	.include data_animations.i
	.include data_soundHeaders.i



; ---------------------------------------------------------------------------
; 8 - data tables
; ---------------------------------------------------------------------------

; Palette index
;
; 00 background  title screen
; 01 background	 title screen light
; 02 background  status bar
; 03 background  title screen dark
; 04 sprite desert mech
; 05 sprite fire mech
; 06 sprite tooltip & cursor
; 07 sprite effects
; 08 pilot 0
; 09 pilot 1
; ...
; 17 (23) pilot 15
; 18 (24) map 1-1


paletteColor1:
	.db $0B, $38, $0B, $08, $0F, $0F, $09, $30
	.db $08, $18, $0A
	.dsb 5
	.db $08, $15, $08
	.dsb 5
	.db $1B
paletteColor2:
	.db $1B, $18, $1B, $18, $0A, $0A, $29, $2D
	.db $18, $28, $19
	.dsb 5
	.db $15, $30, $15
	.dsb 5
	.db $0A
paletteColor3:
	.db $2B, $28, $2B, $28, $3B, $3B, $39, $37
	.db $37, $30, $39
	.dsb 5
	.db $35, $35, $35
	.dsb 5
	.db $3B

identity:
	.db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
	.db $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
	.db $20


.include data_objectTypes.i

; --- events are automatically unflagged after they are executed
event_confirmAction:				.db %10000000
event_updateTarget:					.db %00100000
event_updateStatusBar:			.db %00010000
event_refreshStatusBar:			.db %00000100

eRefreshStatusBar = %00000100
eUpdateStatusBar 	= %00010000
eUpdateTarget = 		%00100000

; --- system flags remain set ---
sysFlag_scrollRight:				.db %10000000
sysFlag_scrollDown:					.db %01000000
sysFlag_showPortrait:				.db %00100000
sysFlag_splitScreen:				.db %00010000
sysFlag_NTSC:								.db %00001000
sysFlag_objectSprites:			.db %00000100
sysFlag_scrollAdjustment:		.db %00000001

sysObjectSprites = %00000100


; --- menu flags control menu tile animation ---
menuFlag_blink:							.db %10000000
menuFlag_line1:							.db %00100000
menuFlag_line2:							.db %00010000
menuFlag_line3:							.db %00001000


leftNyble:					.db #$F0
rightNyble:					.db #$0F

; maps object byte 0, b3-0 (direction+move) to the address in the object type table
; that holds the matching animation #

directionLookup:
	.db 0, 0, 1, 2, 3, 2, 1, 0, 0, 4, 5, 6, 7, 6, 5

portraitBaseXPos:
  .db 0, 8, 16, 24
	.db 0, 8, 16, 24
	.db 0, 8, 16, 24

portraitBaseYPos:
  .db 0, 0, 0, 0
  .db 8, 8, 8, 8
  .db 16, 16, 16, 16




;; 9 - vectors
	.org $fffa 				; sets us up at the very end of the code
	.dw NMI					; points the NMI to our label NMI
	.dw RESET				; points the Reset to our label RESET
	.dw 00					; IRQ reference - not used

;; bank 0 - sprites: cursor and effects
;; bank 1 - sprites: unit moving
;; bank 2 - sprites: unit stationary
;; bank 3 - sprites: not used
;; bank 4 - tiles: alphabet & menu
;; bank 5 - tiles: title screen
;; bank 6 - tiles: level 1 map
;; bank 7 - tiles: not used

;; 10 tiles and sprites
	.incbin "bank_00_03.chr" 		; 4 x 1k CHR for sprites
	.incbin "bank_04_07.chr" 		; 4 x 1k CHR for tiles
	.incbin "bank_08_11.chr" 		; 4 x 1k CHR for tiles
	.incbin "bank_12_15.chr" 		; 4 x 1k CHR for tiles

	.incbin "bank_16_19.chr" 		; 4 x 1k CHR for tiles
	.incbin "bank_16_19.chr" 		; 4 x 1k CHR for tiles
	.incbin "bank_16_19.chr" 		; 4 x 1k CHR for tiles
	.incbin "bank_16_19.chr" 		; 4 x 1k CHR for tiles
