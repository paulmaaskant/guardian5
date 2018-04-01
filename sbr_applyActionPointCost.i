applyActionPointCost:
  LDA activeObjectStats+9
  SEC
  SBC list3+0
  STA activeObjectStats+9

  LDA #$81               ; show gauge message																																			; msg heatsinks restore
  STA list3+7

  JSR getSelectedWeaponTypeIndex  ; sets X to selected action

  LDY activeObjectIndex
  LDA object+1, Y
  AND #$07
  STA locVar1            ; current unused heat points

  CPX #aCOOLDOWN
  BEQ +restoreHeatPoints

  LDA list3+12                    ; calculated heat cost
  CMP locVar1
  BCC +less
  LDA #8                          ; shut down msg                                                  ; msg shutdown
  STA list3+8

  LDA object+2, Y                                                               ; set shutdown flag
  ORA #$80
  STA object+2, Y
  LDA #0
  STA locVar1
  BEQ +continue                  ; JMP

+less:
  EOR #$FF                         ; calculate remaining action points
  SEC                              ; after current action point cost is subtracted
  ADC locVar1                      ; - selected action heat cost + current available unused  heat points
  STA locVar1                      ; = remaining unused heat points
  BNE +continue                    ; JMP

+restoreHeatPoints:
  LDA locVar1
  CLC
  ADC list3+12
  CMP #6
  BCC +notMaxed
  LDA #6

+notMaxed:                                                             ; A = action points available
  STA locVar1
  BCC +continue

  LDA object+2, Y
  BPL +continue                ; if shut down
  AND #$7F                     ; unset shutdown flag
  STA object+2, Y
  LDA #10
  STA list3+8                  ; set result message: restart

+continue:
  LDA object+1, Y
  AND #%11111000
  ORA locVar1
  STA object+1, Y
  RTS
