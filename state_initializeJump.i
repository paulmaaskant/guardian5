state_initializeJump:
  LDA effects
  AND #%10000000						  ; switch off everything but the cursor
  STA effects

  LDX #%00001101
  LDY activeObjectIndex				; set object's move animation bit (b3)
  LDA object, Y
  STA list1+2
  BIT bit2
  BNE +continue
  LDX #%00001011

+continue:
  AND #$F0
  ORA identity, X
  STA object, Y

  LDA #$35                    ; MECH jump leg animation
  STA list3+61								; set for object sprite cycle in main loop

  LDA object+4, Y             ; set evade points
  AND #%11111000							; clear evade points
  ORA list3+14
  STA object+4, Y

  LDA distanceToTarget        ;
  ORA #$80                    ; set jump bit
  STA activeObjectStats+3     ; keep track of # moves spent

  LDA object+5, Y             ; reload obscured background tile
                              ; A parameter for setTile
  LDY activeObjectGridPos			; Y parameter for setTile
  JSR setTile                 ;

  JSR clearCurrentEffects

  LDA activeObjectGridPos     ; set initial screen coordinates of active unit
  JSR gridPosToScreenPos
  LDA currentObjectXPos
  STA list3+62
  LDA currentObjectYPos
  STA list3+63

  JSR angleToCursor
  EOR #$80                    ; inverse angle
  STA list1+0                 ; angle
  STY list1+1                 ; radius

  LDY #127
  STY blockInputCounter       ; frame counter

  LDA cursorGridPos
  LDY activeObjectIndex
  STA object+3, Y
  STA activeObjectGridPos

  LDA #$55
  JMP replaceState
