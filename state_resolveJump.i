; -------------------------
; apply pseudo physics
; assume time length of jump is always same
; assume that apex height is always the same
;
;
;

state_resolveJump:
  DEC blockInputCounter
  BNE +continue

  ;-------------------------------
	; JUMP complete
	;-------------------------------
  ; LDA #$FF
  ; JMP replaceState


	LDX activeObjectGridPos		  ; get node map BG tile
	LDA nodeMap, X

  LDY activeObjectIndex
	STA object+5, Y							; and store on the obscuring object, so that it can be put back later

  LDA list1+2                 ; restore original direction and switch off move (b3)
	STA object+0, Y

	JSR getStatsAddress					; sets pointer1 to object type specs
	LDY activeObjectIndex
	LDA object+0, Y
	AND #%00000111							; get objects facing direction
	CLC
	LDY #7
	ADC (pointer1), Y						; add tile map offset to get the correspndin meta tile

	ORA #%11000000							; blocked for movement and los
	LDY activeObjectGridPos
	JSR setTile


  LDA #30
  STA blockInputCounter

  JSR pullAndBuildStateStack
  .db 5								; 13 items
  .db $4B, 5             ; set ground shake effect
  .db $1A                ; wait x frames
  .db $4B, 0             ; unset ground shake
  ; built in RTS


+continue:
  LDA activeObjectGridPos
  JSR gridPosToScreenPos


  LDA blockInputCounter        ; count
  ASL                          ; count x 2
  LDX list1+1                  ; radius
  JSR multiply

  LDX par1                     ; current radius = (count * 2 * radius) / 256
  LDA list1+0                  ; angle

  JSR getCircleCoordinates

	CLC													; ground line Y
  TYA													;
  ADC currentObjectYPos				;
	STA list3+63

	CLC                         ; ground line X
  TXA
  ADC currentObjectXPos
	STA list3+62

  LDA blockInputCounter
  CMP #64
  BNE +continue

  JSR updateSpritePriority
  LDA blockInputCounter       ; account for height (jump arc)

+continue:
  BIT bit6
  BEQ +continue
  EOR #%01111111              ; mirror 127-64 becomes 0 - 63

+continue:
  TAY
  LDA sinTable, Y
  LDX #50                     ; jump apex height in pxls
  JSR multiply

  SEC													; adjust for jump height
  LDA list3+63				;
  SBC par1
	STA list3+63

  RTS
