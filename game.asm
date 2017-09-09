;; List
;
; - miss animations
; - shutdown animation
; - cooldown animation
; - restart shutdown unit
; - heat and damage prognosis
; - free spin when attacked in close combat
;	- mission introduction screen
;	- mission result screen
;	- pause menu
; - attribute table scrolling (switch between two palettets)
; - show results state: expand to take opcodes for number reductions!
; - diagonal scrolling (4 & 6 don't matter because it still looks as the same meta row / col)


;; 1 - iNes header
	.db "NES", $1a	; iNes Identifier
	.db $02			; number of PRG-Rom (16kb) blocks the game has
	.db $02			; number of CHR-Rom (8kb) blocks the game has
	; mapper 23
	.db $70 		; left nyble = mapper low nyble
	.db $10			; left nyble = mapper high nyble
	.db $00, $00, $00, $00, $00, $00, $00, $00	; filler

;; 2 - constants and variables
	.enum $0000 ; sets what is known as the zero page

	nmiVar0										.dsb 1
	nmiVar1										.dsb 1
	nmiVar2										.dsb 1
	nmiVar3										.dsb 1
	nmiVar4										.dsb 1

	; ---------------------------------
	; The following are variables that have a lifespan limited to a single frame
	; Used by various subroutines
	; They cannot be relied upon to carry values across frames
	; ---------------------------------

	; LOCAL variables usable by supporting subroutines (never used as IN OUT)
	locVar1 									.dsb 1
	locVar2 									.dsb 1
	locVar3										.dsb 1
	locVar4										.dsb 1
	locVar5										.dsb 1

	; IN / OUT parameters used by supporting subroutines
	par1 											.dsb 1
	par2 											.dsb 1
	par3 											.dsb 1
	par4											.dsb 1
	pointer1									.dsw 1
	pointer2									.dsw 1

	cameraY										.dsw 1	; upper left of camera in relation to background tiles
	cameraX										.dsw 1	; upper left of camera in relation to background tiles
	cameraYDest								.dsw 1	; upper left of camera in relation to background tiles
	cameraXDest								.dsw 1	; upper left of camera in relation to background tiles

	; ---------------------------------
	; The following are variables that have a life span that goes across frames
	; typically used to carry information from one game state to the next
	; ---------------------------------

	; used as game state values, sometimes to transfer values from one game state to the next
	; these values are constant over frame rates (not used by event subroutines)
	list1											.dsb 10
	list2											.dsb 10

	; dedicated to byte streams
	bytePointer								.dsw 1
	byteStreamVar							.dsb 3

	; general purpose variables
	frameCounter 							.dsb 1	; used to pace the main loop, i.e., once per frame
	actionCounter							.dsb 1	; used to time action animations
	blockInputCounter					.dsb 1  ; used to block input for specified time
	effectCounter							.dsb 1  ; used to time cursor sprite animation
	menuCounter								.dsb 1

	sysFlags									.dsb 1	; scroll direction (b7-6), action locked (b5), blank strings (b4)
	events										.dsb 1  ; flags that trigger specific subroutines
	effects										.dsb 1  ; flags that indicate whether screen effects are active
	menuFlags									.dsb 1	;
	actionMessage							.dsb 1	;

	; buffer to write tiles to VRAM
	stackPointer1							.dsb 1
	stackPointer2							.dsb 1

	buttons 									.dsb 1	; used to store controller #1 status
	gameState									.dsb 1	; used to indicate transitions in the game
	seed											.dsw 1	; used to generate random numbers
	cursorGridPos							.dsb 1  ; grid coordinates of cursor XXXX YYYY

	; ---------------------------------
	; The following are variables are dedicated to object management
	; ---------------------------------

	; the object that is currently being handled
	currentObjectType 				.dsw 1	; pointer to the object type (all constants for the object)
	currentObjectYPos 				.dsb 1 	; on screen coordinate Y of active object
	currentObjectYScreen			.dsb 1	;
	currentObjectXPos 				.dsb 1 	; on screen coordinate X of active object
	currentObjectXScreen			.dsb 1	;
	currentObjectFrameCount 	.dsb 1	; used to time the object's sprite animation

	; active / target objects attributes
	targetObjectTypeAndNumber	.dsb 1	; target object type / number
	targetObjectIndex					.dsb 1	; index in objects table

	activeObjectTypeAndNumber	.dsb 1	; active object type / number
	activeObjectIndex					.dsb 1	; index in objects table
	activeObjectGridPos				.dsb 1	; position of the object that has the turn
	activeObjectStats					.dsb 1	; 0 weapon 1 max range (b7-4) min range (b3-2) and type (b1-0)
														.dsb 1	; 1 weapon 2 max range (b7-4) min range (b3-2) and type (b1-0)
														.dsb 1	; 2 movement
														.dsb 1  ; 3 weapon 1 damage
														.dsb 1 	; 4 weapon 2 damage
														.dsb 1 	; 5 accuracy & defence (b7-4) acc, (b3-0) def
														.dsb 1	; 6 armor (dail)
														.dsb 1	; 7 heat modifiers?
														.dsb 1	; 8 special abilities?
														.dsb 1	; 9 special abilities?

	; stored memory objects
	; object grid position is stored separately as it will be sorted regularly
	objectCount								.dsb 1	; number of objects presently in memory
	objectTypeAndNumber				.dsb 6	; (b7) hostile (b6-3) objectType (b2-0) object number
	; the rest of the object information is stored (4 bytes each) so that it does not require sorting whenever the object's position changes
	object										.dsb 1	; +0: (b7) shutdown (b6-4) pilot, (b3) move/still, (b2-0) direction
														.dsb 1	; +1: health dial (b7-3), heat dial (b2-0)
														.dsb 1	; +2: frame count (b7-0)
														.dsb 1	; +3: grid pos
	object1										.dsb 4	;
	object2										.dsb 4	;
	object3										.dsb 4	;
	object4										.dsb 4	;
	object5										.dsb 4	;

	; ------------------------------------------------------
	; various
	; ------------------------------------------------------

	; possible actions used for player and AI
	actionList								.dsb 10	;
	selectedAction						.dsb 1

	debug 										.dsb 2
	distanceToTarget					.dsb 1

	; palette colours
	; store in memory to manipulate brightness
	pal_transparant						.dsb 1
	pal_color1								.dsb 8
	pal_color2								.dsb 8
	pal_color3								.dsb 8

	.ende
	.enum $0300																																		; sound variables
	soundFlags										.dsb 1
	soundStreamChannel						.dsb 6																					; (b7) stream active? (b1-0) APU channel that the stream using
	soundStreamDutyVolume					.dsb 6																					; (b7-6) Duty (b4-0) Volume
	soundStreamPeriodLo						.dsb 6																					; note currently being played
	soundStreamPeriodHi						.dsb 6																					;
	soundStreamPointerLo					.dsb 6																					; current locaiton in the sound stream
	soundStreamPointerHi					.dsb 6																					;
	soundStreamTempo							.dsb 6																					; this streams tempo
	soundStreamTickerTotal				.dsb 6																					; ticker to control tempo
	soundStreamNoteLengthCounter	.dsb 6																					;
	soundStreamNoteLength					.dsb 6																					; number of ticks a note is playing
	soundStreamEnvelopeCounter		.dsb 6
	soundStreamEnvelope						.dsb 6
	soundStreamNoteOffset					.dsb 6
	soundStreamLoop1Counter				.dsb 6
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
	; ||++---- not used
	; |+------ this node blocks line of sight
	; +------- this node is blocks movement
	; ------------------------------------------------------------
	nodeMap								.dsb 256

	; path finding and dialog control
	list3									.dsb 64
	list4									.dsb 64

	; Buffers used to render the status menu
	actionMenuLine1				.dsb 13
	actionMenuLine2				.dsb 13
	actionMenuLine3				.dsb 13
	menuIndicator					.dsb 3
	targetMenuLine1				.dsb 6
	targetMenuLine2				.dsb 6
	targetMenuLine3				.dsb 6
	targetMenuLine4				.dsb 3
	systemMenuLine1				.dsb 5
	systemMenuLine2				.dsb 5
	systemMenuLine3				.dsb 5

	; effects
	; 6 sprites, 4 bytes per sprite (X, Y, animation #, counter)
	currentEffects				.dsb 24

	; indexes of the current palettes
	currentPalettes				.dsb 8
	currentTransparant		.dsb 1
	.ende

	; PRG page 0: tiles
	.org $8000
	.include tiles.i

	; PRG page 1: byteStreams
	.org $A000
	.include byteStreams.i

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
	LDA #$01													; start with sprite 1 (sprite 0 is permanently reserved)
	STA par3													; parameter to "loadAnimationFrame"
	LDA #$0F													; clear up to (including) sprite 15
	JSR clearSprites

	LDA effects
	BNE +continue											; some effects are active -> continue
	JMP +nextEvent										; otherwise consider next event

+continue:
	LDA #$00													; disable mirror
	STA par4													; parameter to "loadAnimationFrame"
	LDA effectCounter									; all embedded effects share the same timer
	STA currentObjectFrameCount

	; --- cursor, sprite 3 to 5 sprites ---
	BIT effects
	BPL +nextEffect										; check b7
	LDA cursorGridPos									; cursor location on grid
	JSR gridPosToScreenPos						; get the screen get screen coordinates
	BCC +nextEffect										; make sure coordinates are on screen
	LDY #$00													; cursor animation #
	JSR loadAnimationFrame						; set sprites!

	LDA targetObjectTypeAndNumber
	BEQ +nextEffect
	BIT actionMessage
	BMI +nextEffect
	CMP activeObjectTypeAndNumber
	BEQ +nextEffect

	LDY #$07													; hit probability
	JSR loadAnimationFrame						; set sprites!

+nextEffect:
	; --- active unit marker, 1 sprite  ---
	BIT effects
	BVC +nextEffect										; checb b6
	LDA activeObjectGridPos						; active unit location on grid
	JSR gridPosToScreenPos						; get the screen coordinates
	BCC +nextEffect										; make sure coordinates are on screen
	LDY #$01													; cursor animation #
	JSR loadAnimationFrame						; set sprites!

+nextEffect:																																		; blocking node marker, sprite 5
	LDA effects
	AND #%00100000
	BEQ +nextEffect
	LDA list1+9																																		; node that is blocking line of sight
	JSR gridPosToScreenPos																												; get the screen coordinates
	BCC +nextEffect																																; off screen!
	LDY #$02																																			; cursor animation #
	JSR loadAnimationFrame																												; set sprites!

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
	ASL
	ASL

-loopEffects:
	SEC
	SBC #$04
	TAX
	LDY currentEffects+2, X
	BEQ +skip
	LDA	currentEffects+0, X
	STA currentObjectXPos
	LDA currentEffects+1, X
	STA currentObjectYPos
	LDA currentEffects+3, X
	STA currentObjectFrameCount
	TXA
	PHA
	JSR loadAnimationFrame
	PLA
	TAX
	LDA currentObjectFrameCount
	STA currentEffects+3, X
	INC currentEffects+3, X
	TXA

+skip:
	BNE -loopEffects

	;---------------------------
	; event: update object sprites
	;---------------------------
+nextEvent:
	LDA events
	BIT event_updateSprites
	BNE +next
	JMP +nextEvent

+next:
	EOR event_updateSprites
	STA events
	LDA #$10																																			; sprite 0-15 are reserved for effects, start with sprite 16
	STA par3																																			; first available sprite
	LDX #$00

-loopObjects
	LDA objectTypeAndNumber, X
	AND #%01111000
	LSR
	LSR
	LSR
	TAY
	LDA objectTypeL, Y
	STA currentObjectType+0
	LDA objectTypeH, Y
	STA currentObjectType+1
	LDA objectTypeAndNumber, X
	AND #%00000111
	ASL
	ASL
	TAY																																						; object index
	PHA																																						; save Y
	TXA
	PHA																																						; save X
	LDA object+2, Y
	STA currentObjectFrameCount
	LDA object+3, Y																																; on screen check
	JSR gridPosToScreenPos																												; get and set screen X & Y
	BCC +done																																			; off screen -> done
	LDA objectTypeAndNumber, X																										; get B7 (neg flag)
	PHP																																						; store neg flag
	LDA object, Y
	AND #%00001000																																; object move bit (b3) ON
	BEQ +next
	CLC																																						; if moving, then add displacement
	LDA currentObjectYPos																													; displacement is updated every frame
	ADC actionList+2																															; by the 'resolve move' game state
	STA currentObjectYPos																													; FIX account for the wrap around
	CLC
	LDA currentObjectXPos
	ADC actionList+1
	STA currentObjectXPos

+next:																																					; next, determine mirror, palette & which animation
	LDX #$00																																			; default value for par4 (no mirror, no palette change)
	LDA object+0, Y
	AND rightNyble																																; right nyble (b3) moving? (b2-0) direction?
	TAY																																						; set animation sequence (Y)
	AND #%00000110																																; mirror if direction is 2 or 3
	CMP	#%00000010
	BNE +next
	LDX #%01000000																																; set mirror bit

+next:																																					; palette 0 for friendly, palette 1 for hostile
	PLP																																						; object type flags
	BPL +next																																			; if hostile (b7) then do unit palette switch
	INX																																						; palette switch

+next:
	STX par4
	CPY #$07																																			; 'moving' animation is required
	BCC +next																																			; the animation's sequence location is Y - 2
	DEY																																						;
	DEY

+next:
	LDA (currentObjectType), Y 																										; retrieve sequence from the type
	TAY																																						; IN parameter Y = animation sequence
	JSR loadAnimationFrame
	INC currentObjectFrameCount																										;

+done:
	PLA																																						; restore X
	TAX																																						; from the stack
	PLA																																						; restore Y
	TAY																																						; in order to save the object's updated frame count
	LDA currentObjectFrameCount																										; object frame count
	STA object+2, Y																																;
	INX																																						; next object
	CPX objectCount																																; number of objects presently in memory
	BNE -loopObjects																															;
	LDA #$3F																																			; clear remaining unused sprites up to and including sprite 63 (last sprite)
	JSR clearSprites																															;

	;---------------------------
	; update target / available actions
	;---------------------------
+nextEvent:
	LDA events
	BIT event_updateTarget
	BEQ +nextEvent
	EOR event_updateTarget
	ORA event_updateStatusBar			; trigger an update of the status bar
	STA events

	LDA effects
	AND #%11000000								; cursor and active unit marker stay on, rest turned off
	STA effects

	JSR updateTargetObject				; load target based on cursor position
	JSR updateActionList					; heavy subroutine: may take more than a single frame
	JSR calculateActionCost				;

	LDA frameCounter							; wait for next frame
-	CMP frameCounter							; to prevent game from freezing (due to half completed stack operations)
	BEQ -

	LDA menuFlags									; switch on blinking for the indicators
	ORA menuFlag_indicator
	STA menuFlags

	LDA #$2E  										; set indicator tiles
	STA menuIndicator+0						; in 'toggle' positions
	LDA #$2F
	STA menuIndicator+1

	; ------------------------------
	; update status bar & trigger refresh
	; ------------------------------
+nextEvent:
	LDA events											;
	BIT event_updateStatusBar				;
	BEQ +nextEvent									;
	ORA event_refreshStatusBar			; raise event to trigger buffer to screen
	EOR event_updateStatusBar				;
	STA events

	JSR clearActionMenu							; set all tiles to blank
	LDY selectedAction							; update the action menu buffer with the selected action
	LDA actionList, Y
	ASL
	TAX
	LDY actionTable+1, X						; Y is the string ID
	LDX #$00												; Show on position 0
	JSR writeToActionMenu						;

	LDA actionMessage
	BEQ +actionMenuDone
	AND #$7F
	TAY
	LDX #$0D
	JSR writeToActionMenu						;

+actionMenuDone:
	JSR clearTargetMenu
	JSR updateTargetMenu

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

	JSR writeMenuToBuffer

; --- events have been handled, now launch game state subroutine ---
+nextEvent:
	LDA gameState
	JSR launchStateSubroutine
	JMP mainGameLoop					; restart loop
;-----------------------------------------
; END of main loop
;-----------------------------------------

; ------------------------------------------
; Subroutine to launch game state subroutine, use RTS to jump to address
; ------------------------------------------
launchStateSubroutine:
	ASL
  TAX
  LDA gameStateJumpTable+1, X
  PHA
  LDA gameStateJumpTable, X
  PHA
  RTS            											; launch!

gameStateJumpTable:
	.dw state_initializeTitleScreen-1		; 00
	.dw state_initializeStoryScreen-1		; 01
	.dw state_fadeInOut-1								; 02
	.dw state_titleScreen-1							; 03
	.dw state_initializeMap-1						; 04
	.dw state_loadLevelMapTiles-1				; 05
	.dw state_selectAction-1						; 06
	.dw state_setDirection-1						; 07
	.dw state_setNextActiveObject-1			; 08
	.dw state_runDialog-1								; 09
	.dw state_initializeSetDirection-1	; 0A
	.dw state_centerCamera-1						; 0B
	.dw state_waitForCamera-1						; 0C
	.dw state_initializeIntroDialog-1		; 0D
	.dw state_loadScreen-1							; 0E
	.dw state_clearDialog-1							; 0F
	.dw state_initializeMove-1					; 10
	.dw state_resolveMove-1							; 11
	.dw state_initializeRanged-1				; 12
	.dw state_resolveRanged-1						; 13
	.dw state_initializeCoolDown-1			; 14
	.dw state_resolveCoolDown-1					; 15
	.dw state_showResults-1							; 16
	.dw state_initializeCloseCombat-1		; 17
	.dw state_resolveClose-1						; 18
	.dw state_initializePivotTurn-1			; 19
	.dw state_initializeFreeSpin-1			; 1A
	.dw state_initializeCharge-1				; 1B
	.dw state_lightFlash-1							; 1C
	.dw state_closeCombatAnimation-1		; 1D
	.dw state_initializeTitleMenu-1			; 1E
	.dw state_shutDown-1								; 1F
	.dw state_initializeBriefScreen-1		; 20
	.dw state_initializeBriefDialog-1		; 21
	.dw state_initializeMissionScreen-1	; 22


; -------------------------
; includes
; -------------------------

	.include state_misc.i
	.include state_setNextActiveObject.i
	.include state_selectAction.i
	.include state_titleScreen.i
	.include state_resolveMove.i
	.include state_resolveSpin.i
	.include state_resolveCoolDown.i
	.include state_resolveRanged.i
	.include state_resolveClose.i
	.include state_showResults.i
	.include state_shutDown.i
	.include state_initializeBriefScreen.i
	.include state_initializeBriefDialog.i
	.include state_initializeMissionScreen.i
	.include subroutines.i
	.include initializeScreen.i
	.include updateActionList.i
	.include calculateActionCost.i
	.include calculateHeat.i
	.include calculateAttack.i
	.include findPath.i
	.include reset.i
	.include nmi.i
	.include sprites.i
	.include statusBar.i
	.include checkTarget.i
	.include audio.i

; ---------------------------------------------------------------------------
; 8 - data tables
; ---------------------------------------------------------------------------

; Palette index
;
; 00 background
; 01 background
; 02 background  status bar
; 03 ------
; 04 sprite desert mech
; 05 sprite fire mech
; 06 sprite tooltip & cursor
; 07 sprite effects
; 08 pilot 0
; 09 pilot 1
; ...
; 17 pilot 15

paletteColor1:
	.db $10, $09, $10, $08, $08, $06, $10, $30
	.db $08, $18
	.dsb 6
	.db $08, $15
	.dsb 6
paletteColor2:
	.db $00, $18, $00, $18, $18, $16, $1B, $27
	.db $18, $28
	.dsb 6
	.db $15, $30
	.dsb 6
paletteColor3:
	.db $30, $37, $2B, $37, $28, $36, $2B, $37
	.db $37, $30
	.dsb 6
	.db $35, $35
	.dsb 6
identity:
	.db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
	.db $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
stringListL:
	.db #< str_RANGED_ATK_1							; 00
	.db #< str_RANGED_ATK_2							; 01
	.db #< str_MOVE											; 02
	.db #< str_CHARGE										; 03
	.db #< str_COOL_DOWN								; 04
	.db #< str_LOS_BLOCKED							; 05
	.db #< str_OPENING_FIRE							; 06
	.db #< str_CLOSE_COMBAT							; 07
	.db #< str_OUT_OF_RANGE							; 08
	.db #< str_IMPASSABLE								; 09
	.db #< str_OUTSIDE_ARC							; 0A
	.db #< str_CHOOSE_FACING_DIRECTION	; 0B
	.db #< str_TARGET_TOO__CLOSE 				; 0C
	.db #< str_AT_TOP_SPEED							; 0D
	.db #< str_TARGET										; 0E
	.db #< str_DAMAGE										; 0F
	.db #< str_HEATSINKS								; 10
	.db #< str_FFW											; 11
	.db #< str_NOT_POSSIBLE							; 12
	.db #< str_PIVOT_TURN								; 13
	.db #< str_STRENGTH									; 14
	.db #< str_START_GAME								; 15
	.db #< str_PLAY_SOUND								; 16
	.db #< str_INSTRUCTIONS							; 17
	.db #< str_RUN											; 18
stringListH:
	.db #> str_RANGED_ATK_1
	.db #> str_RANGED_ATK_2
	.db #> str_MOVE
	.db #> str_CHARGE
	.db #> str_COOL_DOWN
	.db #> str_LOS_BLOCKED
	.db #> str_OPENING_FIRE
	.db #> str_CLOSE_COMBAT
	.db #> str_OUT_OF_RANGE
	.db #> str_IMPASSABLE
	.db #> str_OUTSIDE_ARC
	.db #> str_CHOOSE_FACING_DIRECTION
	.db #> str_TARGET_TOO__CLOSE
	.db #> str_AT_TOP_SPEED   ; not used
	.db #> str_TARGET
	.db #> str_DAMAGE
	.db #> str_HEATSINKS
	.db #> str_FFW
	.db #> str_NOT_POSSIBLE
	.db #> str_PIVOT_TURN
	.db #> str_STRENGTH
	.db #> str_START_GAME
	.db #> str_PLAY_SOUND
	.db #> str_INSTRUCTIONS
	.db #> str_RUN

str_LOS_BLOCKED:
	.db $14, $1B, $18, $1D, $14, $0B, $1E, $15, $0B, $22, $18, $16, $17, $23, $11, $1B, $1E, $12, $1A, $14, $13
str_RANGED_ATK_1:
	.db $0C, $21, $10, $1D, $16, $14, $13, $0F, $10, $23, $1A, $0F, $10
str_RANGED_ATK_2:
	.db $0C, $21, $10, $1D, $16, $14, $13, $0F, $10, $23, $1A, $0F, $11
str_MOVE:
	.db $04, $1C, $1E, $25, $14
str_OPENING_FIRE:
	.db $0C, $1E, $1F, $14, $1D, $18, $1D, $16, $0F, $15, $18, $21, $14
str_COOL_DOWN:
	.db $09, $12, $1E, $1E, $1B, $0F, $13, $1E, $26, $1D
str_CHARGE:
	.db $06, $12, $17, $10, $21, $16, $14
str_CLOSE_COMBAT:
	.db $0C, $12, $1B, $1E, $22, $14, $0F, $12, $1E, $1C, $11, $10, $23
str_OUT_OF_RANGE:
	.db $0C, $1E, $24, $23, $0B, $1E, $15, $0B, $21, $10, $1D, $16, $14
str_IMPASSABLE:
	.db $0A, $18, $1C, $1F, $10, $22, $22, $10, $11, $1B, $14
str_OUTSIDE_ARC:
	 db $16, $15, $10, $12, $18, $1D, $16, $0F, $26, $21, $1E, $1D, $16, $0F, $13, $18, $21, $14, $12, $23, $18, $1E, $1D
str_CHOOSE_FACING_DIRECTION:
	.db $18, $12, $17, $1E, $1E, $22, $14, $0F, $15, $10, $12, $18, $1D, $16, $0F, $0F, $13, $18, $21, $14, $12, $23, $18, $1E, $1D
str_TARGET_TOO__CLOSE:
	.db $12, $23, $10, $21, $16, $14, $23, $0F, $23, $1E, $1E, $0F, $0F, $0F, $12, $1B, $1E, $22, $14
str_AT_TOP_SPEED:
	.db $0C, $10, $23, $0F, $23, $1E, $1F, $0F, $22, $1F, $14, $14, $13
str_TARGET:
	.db $06, $23, $10, $21, $16, $14, $23
str_DAMAGE:
	.db $06, $13, $10, $1C, $10, $16, $14
str_HEATSINKS:
	.db $09, $17, $14, $10, $23, $22, $18, $1D, $1A, $22
str_FFW:
	.db $01, $2F
str_NOT_POSSIBLE:
	.db $0C, $1D, $1E, $23, $0F, $1F, $1E, $22, $22, $18, $11, $1B, $14
str_PIVOT_TURN:
	.db $0A, $1F, $18, $25, $1E, $23, $0F, $23, $24, $21, $1D
str_STRENGTH:
	.db $04, $22, $23, $21, $82
str_START_GAME:
	.db $0A, $22, $23, $10, $21, $23, $0F, $16, $10, $1C, $14
str_PLAY_SOUND:
	.db $0A, $1F, $1B, $10, $28, $0F, $22, $1E, $24, $1D, $13
str_INSTRUCTIONS:
	.db $0C, $18, $1D, $22, $23, $21, $24, $12, $23, $18, $1E, $1D, $22
str_RUN
	.db $03, $21, $24, $1D


; --- unit type attribute tables ---
objectTypeL:
	.dsb 1; reserved
	.dsb 1; reserved
	.dsb 1; reserved
	.db #< typeRamulen1

objectTypeH:
	.dsb 1; reserved
	.dsb 1; reserved
	.dsb 1; reserved
	.db #> typeRamulen1

typeRamulen1:
	; animations (13 bytes)
	.db #$05 ; 0 animation: taking fire
	.db #$16 ; 1 animation: facing U, still
	.db #$12 ; 2 animation: facing RU, still
	.db #$10 ; 3 animation: facing RD, still
	.db #$14 ; 4 animation: facing D, still
	.db #$10 ; 5 animation: facing LD, still
  .db #$12 ; 6 animation: facing LU, still
	.db #$17 ; 1 animation: facing U, walking
	.db #$13 ; 2 animation: facing RU, walking
	.db #$11 ; 3 animation: facing RD, walking
	.db #$15 ; 4 animation: facing D, walking
	.db #$11 ; 5 animation: facing LD, walking
  .db #$13 ; 6 animation: facing LU, walking
	; fixed stats (3 bytes)
	.db #%00110110					; Dail starting positions: (b7-b3) main dial, (b2-b1) heat dial, and cool down (b0)
	.db #%01100101					; Ranged weapon 1 max range (b7-4), min range (b3-2) and type  (b1-0)
	.db #%01101011					; Ranged weapon 2 max range (b7-4), min range (b3-2) and type  (b1-0)
	; dail stats
	; 00000000 00000000
	; |||||||| ||||||||
	; |||||||| |||||+++ weapon 1 damage
	; |||||||| ||+++--- weapon 2 damage
	; |||||||| ++------ movement (add 2)
	; |||||+++--------- armor (add 15)
	; ||+++------------ accuracy (add 5)
	.db #%00100100, #%01101001, #%00000000		; 01; 0-4-4, 1-5-1
	.db #%00100100, #%01101010, #%00000000		; 02; 0-4-4, 1-5-2
	.db #%00100100, #%01101011, #%00000000		; 03; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 04; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 05; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 06; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 07; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 08; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 09; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 10; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 11; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 12; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 13; 0-4-4, 1-5-3
	.db #%00100100, #%01101011, #%00000000		; 14; 0-4-4, 1-5-3
	.db #%00100100, #%01101100, #%00000000		; 15; 0-4-4, 1-5-4


; --- events are automatically unflagged after they are executed
event_confirmAction:				.db #%10000000
event_updateSprites:				.db #%01000000
event_updateTarget:					.db #%00100000
event_updateStatusBar:			.db #%00010000
event_releaseAction:				.db #%00001000
event_refreshStatusBar:			.db #%00000100

; --- system flags remain set ---
sysFlag_scrollRight:				.db #%10000000
sysFlag_scrollDown:					.db #%01000000
sysFlag_lock:								.db #%00100000
sysFlag_splitScreen:				.db #%00010000
sysFlag_NTSC:								.db #%00001000

; --- menu flags control menu tile animation ---
menuFlag_blink:							.db #%10000000
menuFlag_indicator:			.db #%01000000
menuFlag_line1:				.db #%00100000
menuFlag_line2:				.db #%00010000
menuFlag_line3:				.db #%00001000


leftNyble:					.db #$F0
rightNyble:					.db #$0F

hitProbability:				.db #$64	; dif 0 100% (97 due to crit miss
							.db #$64	; dif 1 100% (97 due to crit miss
							.db #$64	; dif 2 100% (97 due to crit miss
							.db #$64	; dif 3 100% (97 due to crit miss
							.db #$64	; dif 4 100% (97 due to crit miss
							.db #$63	; dif 5  99% (97 due to crit miss
							.db #$60	; dif 6  96%
							.db #$5B	; dif 7  91%
							.db #$54	; dif 8  84%
							.db #$4B	; dif 9  75%
							.db #$3F	; dif 10 63%
							.db #$32	; dif 11 50%
							.db #$26	; dif 12 38%
							.db #$1A	; dif 13 26%
							.db #$11	; dif 14 17%
							.db #$0A	; dif 15 10%
							.db #$05	; dif 16  5%
							.db #$02	; dif 17  2% (3% due to crit
							.db #$01	; dif 18  1% (3% due to crit
							.db #$00	; dif 19  0% (3% due to crit




;; 9 - vectors
	.org $fffa 				; sets us up at the very end of the code
	.dw NMI					; points the NMI to our label NMI
	.dw RESET				; points the Reset to our label RESET
	.dw 00					; IRQ reference - not used

;; bank 0 - not used
;; bank 1 - sprites: unit moving
;; bank 2 - sprites: unit stationary
;; bank 3 - sprites: effects
;; bank 4 - tiles: alphabet & menu
;; bank 5 - tiles: title screen pilot
;; bank 6 - tiles: level 1 map
;; bank 7 - tiles: title screen title

;; 10 tiles and sprites
	.incbin "bank_00_03.chr" 		; 4 x 1k CHR for sprites
	.incbin "bank_04_07.chr" 		; 4 x 1k CHR for tiles
	.incbin "bank_08_11.chr" 		; 4 x 1k CHR for tiles
	.incbin "bank_04_07.chr" 		; 4 x 1k CHR for tiles
