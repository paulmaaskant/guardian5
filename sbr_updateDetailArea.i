
updateDetailArea:

  LDA #$0B                      ; clear equip cursor
  STA currentEffects+4          ; and mech sprites
  STA currentEffects+5

  LDA #2
  STA list1+14

  LDY #127                      ; clear buffer (list8+0 - 127)
  LDA #space

-loop:
  STA list8, Y
  DEY
  BPL -loop

  LDY #9

-loop:
  STA list8+206, Y
  DEY
  BPL -loop


  LDY #32
  LDX #0
  JSR writeToList8

  LDA list1+15
  STA list8+4                   ; write unit #


  ASL
  ASL
  TAX
  LDA #$88
  STA list8+206, X
  LDA #$98
  STA list8+207, X

  LDX list1+13
  LDA list1, X
  CMP list1+12
  BEQ +continue

  LDA #$34
  STA currentEffects+5

  LDY #35                       ; "PRESS A TO CONFIRM"
  LDX #45
  JSR writeToList8              ;

+continue:
  LDX list1+13                  ; type: pilot (0-2), mech (3-5) or weapon (6-11)
  LDA list1+12                  ; index
  CPX #6
  BCS +weaponDetails            ; weapon view
  CPX #3
  BCC +pilotDetails             ; mech view
  JMP +mechDetails

+pilotDetails:                  ; pilot view
  AND #$07
  BNE +continue
  ORA #1                        ; skip pilot 0

+continue:
  STA list1+12                  ; index
  ASL
  ASL
  TAX
  STX locVar5
  LDY pilotTable-4, X           ; pilot name
  LDX #16
  JSR writeToList8

  LDY #65                       ; "NAME"
  LDX #11
  JSR writeToList8

  LDY #64                       ; "SPCL"
  LDX #28
  JSR writeToList8



  LDX locVar5
  LDA pilotTable-2, X           ; pilot traits

  LDX #7

-loop:                          ; every bit represents an ability
  ASL                           ; show the first ability
  BCS +break
  DEX
  BPL -loop
  BMI +noTrait

+break:
  LDY traitName, X              ; first trait
  LDX #33
  JSR writeToList8

+noTrait:
  LDY #31                       ; "pilot"
  LDX #6
  JSR writeToList8

  LDA #%00011000                ; write pilot to current object
  ORA list1+12
  STA objectList+3

  INC list1+14                  ; activate pilot sprites
  LDX #15                       ; set pilot bg tiles

-loop:
  LDA currentItemTilePilot, X
  STA list8+64, X
  DEX
  BPL -loop
  RTS

+weaponDetails:
  AND #$07
  STA list1+12                  ; index
  ASL                           ; set weapon details
  ASL
  TAX
  LDY weaponType+0, X          ; item name
  LDX #16
  JSR writeToList8

  LDY #67                       ; "item"
  LDX #11                       ; line 1
  JSR writeToList8

  LDY #37                      ; "slot X"
  LDX #6
  JSR writeToList8

  LDA list1+12                ; update current object
  ASL
  ASL
  ASL
  ASL
  LDX list1+13
  CPX #9
  BCS +slot2                   ; slot 1
  STA object+30
  LDA #1
  BCC +continue

+slot2:                        ; slot 2
  STA object+31
  LDA #2


+continue:
  STA list8+10
  LDX #15

-loop:
  LDA currentItemTileWeapon, X
  STA list8+64, X
  DEX
  BPL -loop

  LDX #7
  LDA list1+12
  ASL
  ASL
  ASL
  ADC #7
  TAY

-loop:
  LDA weaponTiles, Y
  STA list8+68, X
  DEY
  DEX
  BPL -loop
  RTS

+mechDetails:
  AND #$03
  STA list1+12                  ; index
  TAY													  ; and store it in Y
  LDA objectTypeL, Y						; get the object type data address
  STA pointer1+0
  LDA objectTypeH, Y
  STA pointer1+1					      ; and store it as the current object type

  TYA                           ; update current unit object
  ASL
  ASL
  ASL
  ASL
  STA object+0+24

  LDY #8
  LDA (pointer1), Y             ; mech name
  TAY
  LDX #16                       ;
  JSR writeToList8

  LDY #66                       ; "TYPE"
  LDX #11
  JSR writeToList8

  LDY #64                       ; "SPCL"
  LDX #28
  JSR writeToList8

  LDY #36                       ; "mech"
  LDX #6                        ; line 1
  JSR writeToList8

  LDY #3
  LDA (pointer1), Y
  STA currentEffects+4          ; set mech sprites

  LDY #14                       ; special action
  LDA (pointer1), Y             ;
  BEQ +noSpecialAction
  ASL
  TAX
  LDY actionTable+1, X
  LDX #33
  JSR writeToList8

+noSpecialAction:
  LDX #15

-loop:
  LDA currentItemTileMech, X
  STA list8+64, X
  DEX
  BPL -loop
  RTS

currentItemTilePilot:
  .hex 2A 0F 0F 2B
  .hex 0F 0F 0F 0F
  .hex 0F 0F 0F 0F
  .hex 2C 0F 0F 2D

currentItemTileMech:
  .hex 80 81 81 83
  .hex 90 B0 B0 93
  .hex 90 91 92 93
  .hex A0 A1 A2 A3

currentItemTileWeapon:
  .hex 80 81 81 83
  .hex 0F 0F 0F 0F
  .hex 0F 0F 0F 0F
  .hex A0 82 82 A3
