; state 3D

; this state writes the following values to list 8
; 000-009 pilot name
; 010-019 pilot stats
; 020-049 mech stats
; 050-054 menu pilot selector
; 055-058 menu tab selector l
; 059-062 menu tab selector r
; 070-099 weapon 1
; 100-129 weapon 2 values

state_updateOverview:
  LDA #$0F
  LDX #0

-loop:
  STA list8, X
  INX
  BNE -loop

  STX list8+255       ; selected tab index
  LDA #$0C            ; action point icon in pilot area
  STA list8+14
  LDA #$2F            ; tab selector
  STA list8+55
  LDA #$2E            ; tab selector
  STA list8+59
  ;LDA #$40
  ;STA list8+54
  ;LDA #$41
  ;STA list8+50

  ;------------------------------------------------------
  ; pilot stats
  ;------------------------------------------------------

  LDA activeObjectIndexAndPilot ; get pilot based stats
  ASL
  AND #%00001110
  BCC +continue
  ORA #%00010000

+continue:
  ASL
  TAX
  LDA pilotTable-2, X           ; pilot skill
  JSR toBCD
  LDA par2
  STA list8+10
  LDA par3
  STA list8+11

  LDA pilotTable-3, X           ; pilot action points
  STA list8+13

  LDY pilotTable-4, X           ; pilot name
  LDX #0
  JSR writeToList8

  ;------------------------------------------------------
  ; object type stats
  ;------------------------------------------------------

  LDY activeObjectIndex
  JSR getStatsAddress           ; Y goes in; sets pointer1
  LDX #4

-loop:
  LDY state3D_attribute_index, X
  LDA (pointer1), Y
  JSR toBCD
  LDA par2
  LDY state3D_attribute_list_pos_tens, X
  STA list8, Y
  LDA par3
  LDY state3D_attribute_list_pos_ones, X
  STA list8, Y
  DEX
  BPL -loop

  LDY #0                        ; #0 mech name
  LDA (pointer1), Y             ;
  TAY
  LDX #20
  JSR writeToList8

  ;------------------------------------------------------
  ; object stats
  ;------------------------------------------------------

  LDY activeObjectIndex          ; CURRENT STATS

  LDA object+1, Y
  LSR
  LSR
  LSR
  JSR toBCD                      ; current hit points
  LDA par2
  STA list8+30
  LDA par3
  STA list8+40

  LDA object+6, Y
  AND #$0F                        ; weapon 1 ammo
  JSR toBCD
  LDA par2
  STA list8+71
  LDA par3
  STA list8+73

  ; -----------------------------------------------------
  ; weapon stats
  ; -----------------------------------------------------

  LDA #1
  STA locVar2

-weaponLoop:
  LDX #7                        ; number of attributes to retrieve

-attributeLoop:
  CLC
  LDA activeObjectIndex
  ADC locVar2
  TAY
  LDA object+6, Y
  AND #$F0										  ; mask the weapon type
  LSR
  ORA state3D_weaponAttributeIndex, X   ; field 0 .. 7
  TAY

  LDA weaponType, Y
  AND state3D_mask, X

  LDY state3D_numberOfShifts, X
  BEQ +continue

-loop:
  LSR
  DEY
  BNE -loop

+continue:
  STA par3
  LDY state3D_dataType, X
  BMI +charString

  JSR toBCD
  LDY locVar2
  LDA state3D_listOffset, Y
  CLC
  ADC state3D_weaponAttributeListPosTens, X
  TAY
  LDA par2
  STA list8, Y

+charString:
  LDY locVar2
  LDA state3D_listOffset, Y
  CLC
  ADC state3D_weaponAttributeListPosOnes, X
  TAY
  LDA par3
  STA list8, Y

  DEX
  BPL -attributeLoop
  DEC locVar2
  BPL -weaponLoop

  LDY list8+83        ; ID
  LDX #83
  JSR writeToList8

  LDX list8+92
  LDY state3D_weaponCategoryString, X
  SEC
  ADC #83
  TAX
  JSR writeToList8

  LDY list8+133
  LDX #133
  JSR writeToList8

  LDX list8+142
  LDY state3D_weaponCategoryString, X
  SEC
  ADC #133
  TAX
  JSR writeToList8

  LDA list8+74
  BNE +continue
  LDA #dash
  STA list8+71
  STA list8+73

+continue:

  LDA list8+74+50
  BNE +continue
  LDA #dash
  STA list8+71+50
  STA list8+73+50

+continue:

  ;--------------------------------------------------------------------

  JSR pullAndBuildStateStack
  .db 8
  .db $46, 0      ; header
  .db $46, 3      ; menu
  .db $46, 4      ; labels
  .db $46, 1      ; values

state3D_attribute_index:
  .db 2, 3, 5, 6, 7
state3D_attribute_list_pos_tens:
  .db 32, 31, 33, 34, 35
state3D_attribute_list_pos_ones:
  .db 42, 41, 43, 44, 45
state3D_animationType:
  .db 29, 33, 32, 34

state3D_weaponAttributeIndex:
  .db   1,  2,  2,  5,  6,  0,  7,  3
state3D_mask
  .db $FF,$0F,$F0,$07,$07,$FF,$03,$0F
state3D_numberOfShifts:
  .db   0,  0,  4,  0,  0,  0,  0,  0
state3D_weaponAttributeListPosTens:
  .db  70, 76, 78, 82, 82, 83, 92, 74
state3D_weaponAttributeListPosOnes:
  .db  72, 77, 79, 80, 81, 83, 92, 74
state3D_dataType:
  .db   0,  0,  0,  0,  0,128,128,128
state3D_listOffset:
  .db 0, 50
state3D_weaponCategoryString:
  .db 35, 33, 32, 34
