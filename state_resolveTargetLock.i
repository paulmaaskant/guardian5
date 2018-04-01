state_resolveTargetLock:
  LDA activeObjectGridPos
  JSR gridPosToScreenPos

  LDA list1+0
  CMP #$40
  BNE +continue

  JSR clearCurrentEffects
  JMP pullState

+continue:
  CMP #$10
  BCC +expand
  CMP	#$30
  BCC +rotate
  BCS +collapse

+rotate:
  AND #%00011111
  ASL
  ASL
  STA list1+2
  JMP +startLoop

+collapse:
  AND #%00011111
  EOR #%00011111

+expand:
  STA list1+3

+startLoop:
  LDX #3

-loop:
  STX list1+1
  LDA state_3F_angle_table, X
  CLC
  ADC list1+2
  LDX list1+3
  JSR getCircleCoordinates
  TXA
  LDX list1+1
  CLC
  ADC currentObjectXPos
  STA currentEffects+6, X
  TYA
  CLC
  ADC currentObjectYPos
  ADC #-14
  STA currentEffects+12, X
  DEX
  BPL -loop

+done:
  INC list1+0
  RTS


state_3F_angle_table:
.db 0, 64, 128, 194
