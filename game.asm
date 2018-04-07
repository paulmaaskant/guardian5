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

	activeObjectIndexAndPilot			.dsb 1	; active object type / number
	activeObjectIndex							.dsb 1	; index in objects table
	activeObjectGridPos						.dsb 1	; position of the object that has the turn
	activeObjectStats							.dsb 1	; 0 Weapon 1 (b7) reloading
																.dsb 1	; 1 Weapon 2 (b7) reloading
																.dsb 1	; 2 movement
																.dsb 1  ; 3 NOT USED
																.dsb 1 	; 4 NOT USED
																.dsb 1 	; 5 base accuracy
																.dsb 1	; 6 current hit points
																.dsb 1	; 7 NOT USED
																.dsb 1	; 8 NOT USED
																.dsb 1	; 9 remaining action points

																				; stored memory objects
																				; object grid position is stored separately as it will be sorted regularly
	objectListSize								.dsb 1	; number of objects presently in memory
	objectList										.dsb 16	; (b7) hostile (b6-4) pilot (b3-0) object index
																				; the rest of the object information is stored (4 bytes each) so that it does not require sorting whenever the object's position changes

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
	runningEffect 								.dsb 1
	runningEffectCounter					.dsb 1
	dialog												.dsb 1

	.ende
	.enum $0300														; sound variables

	soundFlags										.dsb 1	; (b7) sound enabled (b6) silence event raised
	soundStreamChannel						.dsb 6	; (b7) stream active? (b1-0) APU channel that the stream using
	soundStreamDutyVolume					.dsb 6	; (b7-6) Duty (b4-0) Volume Offset
	soundStreamPeriodLo						.dsb 6	; (b7-0) Note current (lo)
	soundStreamPeriodHi						.dsb 6	;	(b2-0) Note current (hi)
	soundStreamPointerLo					.dsb 6	; (b7-0) Stream index (lo)
	soundStreamPointerHi					.dsb 6	; (b7-0) Stream index (hi)
	soundStreamTempo							.dsb 6	; this streams tempo
	soundStreamTickerTotal				.dsb 6	; ticker to control tempo
	soundStreamNoteLengthCounter	.dsb 6	;
	soundStreamNoteLength					.dsb 6	; number of ticks a note is playing
	soundStreamEnvelopeCounter		.dsb 6
	soundStreamEnvelope						.dsb 6
	soundStreamNoteOffset					.dsb 6
	soundStreamLoop1Counter				.dsb 6
	soundStreamLoop2Counter				.dsb 6
	soundStreamSweepControl				.dsb 6	;
	softApuPorts									.dsb 16
	currentPortValue							.dsb 4

	actionMenuLine1								.dsb 13	; Buffers used to render the status menu
	actionMenuLine2								.dsb 13
	actionMenuLine3								.dsb 13
	menuIndicator									.dsb 2
	targetMenuLine1								.dsb 6
	targetMenuLine2								.dsb 6
	targetMenuLine3								.dsb 6
	systemMenuLine1								.dsb 3
	systemMenuLine2								.dsb 3
	systemMenuLine3								.dsb 3

	characterPortrait							.dsb 16
	currentEffects								.dsb 30			; effects
																						; 6 sprites, 5 bytes per sprite
																						; (X, Y, animation #, counter, mirror pallette control)

	currentPalettes								.dsb 8			; indexes of the current palettes
	currentTransparant						.dsb 1			; 00 tiles: map 1
																						; 01 tiles: map 2
																						; 02 tiles: pilot face
																						; 03 tiles: status bar & menu
																						; 04 sprites: friendly units
																						; 05 sprite: hostile units
																						; 06 sprite: cursor
																						; 07 sprite: effects


	.ende
	.enum $0400

	; ------------------------------------------------------------
	; nodeMap
	; hashmap for grid map based stuff
	;
	; bbbbbbbb
	; ||||||||
	; ||++++++ meta tile
	; |+------ this node blocks line of sight
	; +------- this node is blocks movement
	; ------------------------------------------------------------
	nodeMap								.dsb 256
	list3									.dsb 64				; path finding and action control
	list4									.dsb 64				; path finding
	list6									.dsb 64				; used by AI for scoring
	list7									.dsb 64				; used by AI for scoring
	list8 								.dsb 256			; generic look up table

	.enum $0700
	object								.dsb 1				; +0: (b7-4) type, (b3) move/still, (b2-0) direction
												.dsb 1				; +1: (b7-3) hit points, (b2-0) heat points
												.dsb 1				; +2: (b7) shut down (b6-0) frame count
												.dsb 1				; +3: (b7-0) grid pos
												.dsb 1				; +4: (b7) target locked (b6-0) target locked unit index + pilot
												.dsb 1				; +5: (b5-0) background tile
												.dsb 1				; +6: weapon 1 : (b7-4) type, (b3-0) ammo or cycle
												.dsb 1				; +7: weapon 2 : (b7-4) type, (b3-0) ammo or cycle
												.dsb 120			; 15 more objects (15x8)
																			; note: code contains 6 places where index is calculated

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
	.include data_lvl1_objects.i
	.include sbr_getNextByte.i

	.include data_spriteFrames.i
	.include data_metaSpriteFrames.i
	.include data_animations.i

	; PRG page 2 and 3 (FIXED): main loop
	.org $C000

	;-----------------------------------------------------------
	; main loop
	;-----------------------------------------------------------
mainGameLoop:
	LDA frameCounter				; wait for next frame
-	CMP frameCounter
	BEQ -

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


	;---------------------------
	; event: update effect sprites
	;---------------------------
+nextEvent:
	LDA #1														; start with sprite 1 (sprite 0 is permanently reserved)
	STA par3													; parameter to "loadAnimationFrame"
	LDA #63														; clear all sprites
	JSR clearSprites

	LDA effects
	BNE +continue											; some effects are active -> continue
	LDY runningEffect
	BNE +showRunningEffect						; there is a running effect active -> show it
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
+nextEffect:												; hit percentage
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
	BVC +nextEffect										; check b6
	LDA activeObjectGridPos						; active unit location on grid
	JSR gridPosToScreenPos						; get the screen coordinates
	BCC +nextEffect										; make sure coordinates are on screen
	LDY #1														; cursor animation #
	JSR loadAnimationFrame						; set sprites!

+nextEffect:												; blocking node marker, sprite 5
	LDA effects
	AND #%00100000										; check b5
	BEQ +nextEffect
	LDA list1+9												; node that is blocking line of sight
	JSR gridPosToScreenPos						; get the screen coordinates
	BCC +nextEffect										; off screen!
	LDY #2														; cursor animation #
	JSR loadAnimationFrame						; set sprites!


+nextEffect:												; running effects (like explosions, and markers)
	LDY runningEffect
	BEQ +nextEffect

+showRunningEffect:
	LDA runningEffectsL-1, Y
	STA pointer1+0
	LDA runningEffectsH-1, Y
	STA pointer1+1
	JSR executeEffect

+nextEffect:												; manage counter for all embedded effects
	LDA currentObjectFrameCount				; FIX
	CMP #$40													; when all effects are off screen, the count continues and does not get reset
	BEQ +nextEffect										; so here we have hard check to make sure the effect never exceeds 64
	ADC #$01													; guarnteed CLC
	STA effectCounter

+nextEffect:												; cycle through all non-embedded effects
	LDA effects
	AND #%00000111										; mask to get number of effect animations
	BEQ +nextEvent
	TAX
	DEX

-loopEffects:
	LDY currentEffects+0, X						; pattern
	BEQ +skip													;
	LDA	currentEffects+6, X						; x pos
	STA currentObjectXPos							;
	LDA currentEffects+12, X					; y pos
	STA currentObjectYPos							;
	LDA currentEffects+18, X					; count
	STA currentObjectFrameCount				;
	LDA currentEffects+24, X					; mirror
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
	BNE +continue
	JMP +nextEvent

+continue:
	LDX #0													; start with object on pos 0

-loopObjects:
	LDA objectList, X								; get next object
	AND #%01111000									; object index
	TAY
	STY locVar1											;

	LDA object+0, Y									; get the object's type
	LSR															;
	LSR															;
	LSR															;
	LSR															;
	TAY															; and store it in Y
	LDA objectTypeL, Y							; get the object type data address
	STA currentObjectType+0
	LDA objectTypeH, Y
	STA currentObjectType+1					; and store it as the current object type

	LDY locVar1											; restore object's index
	TXA															;
	PHA															; save X (object iteration)
	TYA															;
	PHA															; save Y (object index) on stack

	LDA object+2, Y									; retrieve
	AND #%00111111									; object's counter
	STA currentObjectFrameCount			; make it the current counter

	LDA object+3, Y									; get screen coordinates and see if object is visible
	JSR gridPosToScreenPos					; get and set screen X & Y
	BCC +done												; off screen -> done (no need to show sprites)

	LDY #4+8
	LDA (currentObjectType), Y
	CMP #14													; floating object
	BNE +skip

	LDA frameCounter								; take this bit out of the loop
	AND #%01100000
	LSR
	LSR
	LSR
	LSR
	LSR
	CMP #3
	BNE +add
	LDA #0

+add:
	ADC currentObjectYPos
	STA currentObjectYPos

+skip:
	PLA
	TAY
	PHA

	LDA object+0, Y									; check if this is the moving object
	AND #%00001000									; if object move bit (b3) is set
	BEQ +continue										; np -> continue

	CLC															; then add move displacement
	LDA currentObjectYPos						; displacement is updated every frame
	ADC actionList+2								; by the 'resolve move' game state
	STA currentObjectYPos
	CLC
	LDA currentObjectXPos
	TAX
	ADC actionList+1
	STA currentObjectXPos

	CPX #$20												; the following code ensures
	BCS +rightEdge									; that sprites are not wrapped
	LDA actionList+1								; to other side of screen due to displacement
	BPL +continue
	BMI +done												; off screen -> done

+rightEdge:
	CPX #$E0
	BCC +continue
	LDA actionList+1
	BPL +done												; off screen

+continue:												; next, determine mirror, palette & which animation
	LDA object+0, Y
	PHA															; store for possible movement animation
	AND #$07 ; #$0F									; TEMP
	TAY
	LDA mirrorTable, Y
	STA par4													; par4 (b7-6 no mirror, b5 no mask, b4 not obscured, b0 no palette flip)
	LDA directionLookup, Y
	TAY
	LDA (currentObjectType), Y 				; retrieve sequence from the type
	TAY																; IN parameter Y = animation sequence
	JSR loadAnimationFrame						; breaks every variable

	PLA
	BIT bit3
	BEQ +notMoving
	AND #$0F
	TAX
	LDY directionLookup, X
	LDA (currentObjectType), Y 				; retrieve sequence from the type
	TAY																; IN parameter Y = animation sequence
	JSR loadAnimationFrame						; breaks every variable

+notMoving:
	INC currentObjectFrameCount				;

+done:
	PLA																; restore Y
	TAY																; from the stack
	PLA																; restore X
	TAX
	LDA object+2, Y
	AND #%11000000										; save b7 (shutdown) b6 (turn)
	ORA currentObjectFrameCount				; object frame count
	STA object+2, Y
	INX																; next object
	CPX objectListSize								; number of objects presently in memory
	BEQ +continue
	JMP -loopObjects									;

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

	LDA #%00100010
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


;---------------------------
; events have been handled, now launch game state subroutine
;---------------------------
+nextEvent:
	JSR executeState
	JMP mainGameLoop					; restart loop

;-----------------------------------------
; END of main loop
;-----------------------------------------

; ------------------------------------------
; Subroutine to launch game state subroutine, use RTS to jump to address
; ------------------------------------------
executeState:
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

; ------------------------------------------
; Subroutine to launch running effect
; ------------------------------------------
executeEffect:
	JMP (pointer1)

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
	.dw state_initializeMoveAction-1						; 10
	.dw state_resolveMove-1											; 11
	.dw state_initializeRanged-1								; 12
	.dw state_resolveMachineGun-1								; 13
	.dw state_initializeCoolDown-1							; 14
	.dw state_resolveCoolDown-1									; 15
	.dw state_showResults-1											; 16
	.dw state_initializeCloseCombat-1						; 17
	.dw state_resolveCloseCombat-1							; 18
	.dw state_initializePivotTurn-1							; 19
	.dw state_waitFrame-1												; 1A
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
	.dw state_compositeTitleMenu-1							; 36
	.dw state_endAction-1												; 37
	.dw state_initializeMachineGun-1						; 38
	.dw state_initializeMissile-1								; 39
	.dw state_switchBank-1											; 3A
	.dw state_initializeMove-1									; 3B
	.dw state_showHourGlass-1										; 3C
	.dw state_updateOverview-1									; 3D
	.dw state_initializeTargetLock-1						; 3E
	.dw state_resolveTargetLock-1								; 3F
	.dw state_initializeTargetLockMarker-1			; 40
	.dw state_setSelectedObjectPortrait-1				; 41
	.dw state_initializeTempGauge-1							; 42
	.dw state_resolveTempGauge-1								; 43
	.dw state_initializeTargetLockAction-1			; 44
	.dw state_setMenuFlags-1										; 45
	.dw state_refreshMenu-1											; 46
	.dw state_setHudMenuObject-1								; 47
	.dw state_loadHudMenuTab-1									; 48
	.dw state_initializeLaser-1									; 49
	.dw state_resolveLaser-1										; 4A
	.dw state_setRunningEffect-1								; 4B

not_used:																			; label for depricated states

runningEffectsL:
	.db #< eff_blast
	.db #< eff_modifier
	.db #< eff_locked														; 3
	.db #< eff_gunFireFlashes										; 4
	.db #< eff_groundShake											; 5

runningEffectsH:
	.db #> eff_blast
	.db #> eff_modifier
	.db #> eff_locked
	.db #> eff_gunFireFlashes
	.db #> eff_groundShake

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
	.include state_resolveCloseCombat.i
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
	;.include state_showModifiers.i
	.include state_endAction.i
	.include state_initializeMachineGun.i
	.include state_initializeMissile.i
	.include state_waitFrame.i
	.include state_switchBank.i
	.include state_initializeMove.i
	.include state_showHourGlass.i
	.include state_updateOverview.i
	.include state_initializeTargetLock.i
	.include state_resolveTargetLock.i
	.include state_initializeTargetLockMarker.i
	;.include state_resolveTargetLockMarker.i
	.include state_initializeTempGauge.i
	.include state_resolveTempGauge.i
	.include state_showActionMenuMessage.i
	.include state_setMenuFlags.i
	.include state_refreshMenu.i
	.include state_initializeTargetLockAction.i
	.include state_compositeTitleMenu.i
	.include state_setSelectedObjectPortrait.i
	.include state_setHudMenuObject.i
	.include state_loadHudMenuTab.i
	.include state_initializeLaser.i
	.include state_resolveLaser.i
	.include state_setRunningEffect.i

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
	.include sbr_checkRange.i
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
	.include sbr_updateSystemMenu.i
	.include sbr_updateTargetMenu.i

	.include sbr_deleteObject.i
	.include sbr_writeStatusBarToBuffer.i
	.include sbr_writeToActionMenu.i
	.include sbr_writeToList8.i
	.include sbr_write32Tiles.i
	.include sbr_setLineFunction.i
	.include sbr_updateCamera.i
	.include sbr_updateTarget.i
	.include sbr_updateCameraXPos.i
	.include sbr_updateCameraYPos.i
	.include sbr_updatePalette.i
	.include sbr_updateActionList.i
	.include sbr_centerCameraOnNode.i
	.include sbr_initializeExplosion.i
	.include sbr_addToSortedList.i
	.include sbr_angleToCursor.i
	.include sbr_updatePortrait.i
	.include sbr_setTargetToolTip.i
	.include sbr_getSelectedWeaponIndex.i
	.include sbr_setTile.i
	.include sbr_setEffectCoordinates.i

	.include sbr_random.i
	.include sbr_random100.i
	.include sbr_divide.i
	.include sbr_multiply.i
	.include sbr_distance.i
	.include sbr_toBCD.i
	.include sbr_absolute.i
	.include sbr_getCircleCoordinates.i
	.include sbr_squareRoot.i

	.include eff_blast.i
	.include eff_modifier.i
	.include eff_locked.i
	.include eff_gunFireFlashes.i
	.include eff_groundShake.i

	.include reset.i
	.include nmi.i
	.include data_soundHeaders.i
	.include data_pilots.i
	.include data_weapons.i
	.include data_actions.i



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
	.db $0B, $3B, $0B, $0B, $0F, $1A, $09, $30
	.db $08, $18, $0A
	.dsb 5
	.db $08, $15, $08
	.dsb 5
	.db $1B
paletteColor2:
	.db $1B, $1B, $1B, $1B, $0B, $0A, $29, $2D
	.db $18, $28, $19
	.dsb 5
	.db $15, $30, $15
	.dsb 5
	.db $0A
paletteColor3:
	.db $2B, $2B, $2B, $2B, $3B, $3B, $39, $37
	.db $37, $30, $39
	.dsb 5
	.db $35, $35, $35
	.dsb 5
	.db $3B

mirrorTable:
	.hex 00 00 40 40 00 00 00 00

identity:
	.db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
	.db $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
	.db $20


.include data_objectTypes.i
.include data_constants.i

bit7:
menuFlag_blink:
sysFlag_scrollRight:
event_confirmAction:				.db %10000000

bit6:
sysFlag_scrollDown:					.db %01000000

menuFlag_line1:
sysFlag_showPortrait:
event_updateTarget:					.db %00100000

menuFlag_line2:
sysFlag_splitScreen:
event_updateStatusBar:			.db %00010000

menuFlag_line3:
sysFlag_NTSC:
bit3:												.db %00001000

sysFlag_objectSprites:
event_refreshStatusBar:			.db %00000100

sysFlag_scrollAdjustment:		.db %00000001

pilotBits:									.db %10000111
bit2to0											.db %00000111

leftNyble:					.db #$F0
rightNyble:					.db #$0F

; maps object byte 0, b3-0 (direction+move) to the address in the object type table
; that holds the matching animation #

directionLookup:
	.db 0, 0, 1, 2, 3, 2, 1, 0, 0, 4, 5, 6, 7, 6, 5, 0

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
