state_mechBayUpdateMech:
  LDX #38                     ; load background tiles

-loop:
  LDA mechBayBackground-1, X
  STA list8+91, X
  DEX
  BNE -loop

;  LDA objectList+3             ; pilot object 3
;  AND #%00000111
;  TAX
;  DEX

  LDA object+28
  LSR
  LSR
  TAX

  STX list1+4
  LDA pilotTileIndex, X
  TAX
  LDY #0

-loop:
  LDA pilotMenuTiles, X
  STA list8+108, Y
  CPY #2
  BNE +skip
  TXA
  CLC
  ADC #8
  TAX
  TYA
  ADC #8
  TAY

+skip:
  INX
  INY
  CPY #14
  BNE -loop                   ; done loading pilot tiles

  LDA object+24               ; mech type object 3
  AND #$F0
  TAX
  LSR
  LSR
  LSR
  LSR
  STA list1+5
  LDA objectType0+3, X
  STA currentEffects+0        ; done setting mech sprites

  LDA object+30               ; object 3 item 1
  PHA
  LSR
  LSR
  LSR
  LSR
  STA list1+6
  PLA

  JSR local_1F_getItemTilePos

  LDA itemMenuTiles+0, Y
  STA list8+92
  LDA itemMenuTiles+1, Y
  STA list8+93
  LDA itemMenuTiles+23, Y
  STA list8+100
  LDA itemMenuTiles+24, Y
  STA list8+101                ; done with item 1

  LDA object+31                ; object 3 item 2
  PHA
  LSR
  LSR
  LSR
  LSR
  STA list1+7
  PLA

  JSR local_1F_getItemTilePos

  LDA itemMenuTiles+0, Y
  STA list8+95
  LDA itemMenuTiles+1, Y
  STA list8+96
  LDA itemMenuTiles+23, Y
  STA list8+103
  LDA itemMenuTiles+24, Y
  STA list8+104                ; done with item 2

  LDY list1+0
  LDA list1+4, Y
  STA list1+2

  LDA list1+1
  ASL
  ASL
  ADC #3
  TAY
  LDX #3

-loop:
  LDA unitNumberTiles, Y
  STA list8+172, X
  DEY
  DEX
  BPL -loop

  JSR calculateUnitStats

  LDA #$3C
  LDX #27

-loop:
  STA list8+176, X
  DEX
  BPL -loop

  LDX list3+1               ; hitpoints
  LDY #176                  ; position
  LDA #0
  JSR numberToGauge

  LDX list3+5               ; longrange
  LDY #184                  ; position
  LDA #0
  JSR numberToGauge

  LDX list3+6               ; longrange
  LDY #189                  ; position
  LDA #0
  JSR numberToGauge

  LDX list3+7               ; longrange
  LDY #194                  ; position
  LDA #0
  JSR numberToGauge

  LDX list3+8               ; longrange
  LDY #199                  ; position
  LDA #0
  JSR numberToGauge

  LDA list3+0
  STA list8+211

  LDA list3+4
  STA list8+210

  LDA list3+3
  STA list8+209

  LDA object+24
  LSR
  LSR
  LSR
  LSR
  TAX
  LDA mechTileSet, X
  JSR replaceState

  LDA #$46
  JSR pushState

  JSR buildStateStack
  db 5
  db $46, 6            ; item equipped (temp)
  db $46, 27           ; stats
  db $4C


mechBayBackground:
  .hex  F0 F0 AB F0 F0 AB F8 0F
  .hex  F0 F0 BB F0 F0 BB F9 0F
  .hex  0F 0F 0F AB 1B BD 0F 8D F0 D1 E1
  .hex  0F 0F 0F BB 01 BE 0F 8E F0 D2 E2

pilotTileIndex:
  db 0
  db 22
  db 4
  db 26
  db 8
  db 30

local_1F_getItemTilePos:
  LSR
  LSR
  LSR
  LSR
  LSR
  PHP
  LDX #3
  JSR multiply
  LDA par2
  PLP
  BCC +skip
  ADC #45

+skip:
  TAY
  RTS

mechTileSet:
  db 16, 25, 26, 10

unitNumberTiles:
  .hex DB DC EB EC
  .hex DD DE ED EE
  .hex DD DE FD FE

calculateUnitStats:
  ;LDA objectList+3
  ;AND #$07
  ;ASL
  ;ASL
  LDA object+28
  TAX
  ;LDA pilotTable-3, X           ; pilot skill
  LDA pilotTable+1, X
  STA list3+0

  LDY #24													  ; and store it in Y
  JSR getStatsAddress
  LDY #4

-loop:                              ; set ARmor, STructure, MoVement and INitiative
  LDA (pointer1), Y
  AND #$0F
  STA list3+0, Y
  DEY
  BNE -loop

  LDX #3

-loop:
  LDY #24
  STX locVar5                       ; save X : range category
  JSR getOverallDamageValue         ; breaks X&Y
  LDX locVar5                       ; restore range category
  STA list3+5, X
  DEX
  BPL -loop

  ; adjustments to Armor

  LDY #24                           ; index for object 3
  LDA #itemArmor
  JSR isEquipped
  BCC +false
  INC list3+1                     ; add 2 armor
  INC list3+1

+false:
  LDA #itemActuator
  JSR isEquipped
  BCC +false
  INC list3+3                     ; add 1 movement

+false:
  RTS
