updateUnitStats:
  LDA objectList+3
  AND #$07
  ASL
  ASL
  TAX
  LDA pilotTable-3, X           ; pilot skill
  STA list8+196

  LDA objectList+3
  AND #%01111000
  TAY													  ; and store it in Y

  JSR getStatsAddress
  LDY #4

-loop:                          ; set ARmor, STructure, MoVement and INitiative
  LDA (pointer1), Y
  AND #$0F
  STA list8+196, Y
  DEY
  BNE -loop

  LDA #space
  STA list8+201

  LDX #3

-loop:
  LDA objectList+3
  AND #%01111000
  TAY

  STX locVar5                       ; save X : range category

  JSR getOverallDamageValue         ; breaks X&Y

  LDX locVar5                       ; restore range category
  STA list8+202, X

  DEX
  BPL -loop

  ; adjustments to Armor

  LDY #24                           ; index for object 3
  LDA #itemArmor
  JSR isEquipped
  BCC +false
  INC list8+197                     ; add 2 armor
  INC list8+197

+false:
  LDA #itemActuator
  JSR isEquipped
  BCC +false
  INC list8+199                     ; add 1 movement


+false:
  RTS
