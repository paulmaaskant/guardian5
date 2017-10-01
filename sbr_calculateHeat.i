calculateHeat:
  LDY activeObjectIndex
  LDA object+1, Y
  AND #$07
  STA locVar1                                                                   ; current # active heatsinks

  LDX selectedAction
  LDA actionList, X
  CMP #aCOOLDOWN
  BEQ +heatSinksRestore

  LDA list3+0
  BNE +notStable
  LDA #$03																																			; msg temp stable!
  STA list3+7
  BNE +continue

+notStable:
  CMP locVar1
  BCC +less
  LDA #$08                                                                      ; msg shutdown
  STA list3+8
  ;LDY activeObjectIndex
  LDA object+0, Y                                                               ; set shutdown flag
  ORA #$80
  STA object+0, Y
  LDA locVar1

+less:
  EOR #$FF                                                                      ; calculate remaining heatsinks
  SEC
  ADC locVar1
  STA locVar1
  LDA #$07																																			; msg heatsinks offline
  STA list3+7
  BNE +continue

+heatSinksRestore:
  LDA locVar1
  CLC
  ADC list3+0                                                                   ; A is currently active heat sinks
  STA locVar1
  LDA #$04																																			; msg heatsinks restore
  STA list3+7

  LDA activeObjectTypeAndNumber
  JSR getStatsAddress
  LDY #$00                                                                      ; type max health / heatsinks
  LDA (pointer1), Y
	AND #$06
  CMP locVar1
	BNE +continue
  LDY activeObjectIndex
  LDA object+0, Y                                                               ;
  BPL +continue                                                                 ; if shut down
  AND #$7F                                                                      ; unset shutdown flag
  STA object+0, Y
  LDA #$0A
  STA list3+8

+continue:
  LDY activeObjectIndex
  LDA object+1, Y
  AND #%11111000
  ORA locVar1
  STA object+1, Y
  RTS