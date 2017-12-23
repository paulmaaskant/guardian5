applyActionPointCost:
  LDY activeObjectIndex
  LDA object+1, Y
  AND #$07
  STA locVar1                                                                   ; current available action points

  LDX selectedAction
  LDA actionList, X
  CMP #aCOOLDOWN
  BEQ +heatSinksRestore

  LDA list3+0
  BEQ +continue         ; no change

  CMP locVar1
  BCC +less
  LDA #$08                                                                      ; msg shutdown
  STA list3+8

  LDA object+2, Y                                                               ; set shutdown flag
  ORA #$80
  STA object+2, Y
  LDA locVar1

+less:
  EOR #$FF                                                                      ; calculate remaining heatsinks
  SEC
  ADC locVar1
  STA locVar1
  ;LDA #$07																																			; msg action point spent
  ;STA list3+7
  JMP +continue

+heatSinksRestore:
  LDA locVar1
  CLC
  ADC list3+0                                                                   ; A = action points available
  STA locVar1
  LDA #$04																																			; msg heatsinks restore
  STA list3+7

  LDY activeObjectIndex
  LDA object+0, Y

  JSR getStatsAddress
  LDY #$00                                                                      ; type max health / heatsinks
  LDA (pointer1), Y
	AND #$06
  CMP locVar1
	BNE +continue
  LDY activeObjectIndex
  LDA object+2, Y                                                               ;
  BPL +continue                                                                 ; if shut down
  AND #$7F                                                                      ; unset shutdown flag
  STA object+2, Y
  LDA #$0A
  STA list3+8

+continue:
  LDY activeObjectIndex
  LDA object+1, Y
  AND #%11111000
  ORA locVar1
  STA object+1, Y
  RTS
