calculateHeat:
  LDA activeObjectTypeAndNumber
  JSR getStatsAddress
  LDY #$00                                                                      ; type max health / heatsinks
  LDA (pointer1), Y
  AND #$07
  STA locVar2                                                                   ; max # active heatsinks

  LDY activeObjectIndex
  LDA object+1, Y
  AND #$07
  STA locVar1                                                                   ; current # active heatsinks

  LDA list3+0
  BNE +notStable
  LDA #$03																																			; msg temp stable!
  STA list3+7
  BNE +continue

+notStable:
  BMI +heatSinksRestore
  CMP locVar1
  BCC +less
  LDA #$08                                                                      ; msg shutdown
  STA list3+8
  LDA object+0, Y                                                               ; set shutdown flag
  ORA #$80
  STA object+0, Y
  LDA locVar1                                                                   ; make sure no more heat sinks
  STA list3+0                                                                   ; go offline than are available

+less:
  EOR #$FF                                                                      ; calculate remaining heatsinks
  SEC
  ADC locVar1
  STA locVar1

  LDA #$07																																			; msg heatsinks offline
  STA list3+7
  BNE +continue

+heatSinksRestore:
  EOR #$FF
  CLC
  ADC #$01
  TAX

  LDA locVar2                                                                   ; calc # of heatsinks that can be restored
  SEC
  SBC locVar1
  CMP identity, X
  BCS +notLess
  STA list3+0
  TAX

+notLess:
  LDA locVar1
  CLC
  ADC identity, X
  STA locVar1
  LDA #$04																																			; msg heatsinks restore
  STA list3+7

+continue:
  LDA object+1, Y
  AND #%11111000
  ORA locVar1
  STA object+1, Y

  RTS
