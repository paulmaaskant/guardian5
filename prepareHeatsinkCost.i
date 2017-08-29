heatsinkCostTable:
	.db $01				                                                                ; 00 MOVE
	.db $01  			                                                                ; 01 RANGED ATK 1
	.db $01    		                                                                ; 02 RANGED ATK 2
	.db $03      	                                                                ; 03 COOL DOWN
	.db $01                                                                       ; 04 CLOSE COMBAT
	.db $03                                                                       ; 05 CHARGE
	.db $01                                                                       ; 06 PIVOT TURN
	.db $02                                                                       ; 07 RUN

prepareHeatsinkCost:
  LDY activeObjectIndex
  LDA object+1, Y
  AND #$07
  STA locVar1                                                                   ; current # active heatsinks

  LDY selectedAction
  LDX actionList, Y
  CPX #aCOOLDOWN
  BEQ +restoreHeatsinks
  LDA heatsinkCostTable, X
  CMP locVar1
  BCC +less
  LDA locVar1                                                                   ; make sure no more heat sinks                                                                 ; go offline than are available

+less:
  STA list3+0
  STA systemMenuLine2+4
  LDA #$0C
  STA systemMenuLine2+3
  RTS

+restoreHeatsinks:
  LDA activeObjectTypeAndNumber
  JSR getStatsAddress
  LDY #$00                                                                      ; type max health / heatsinks
  LDA (pointer1), Y
  AND #$07
  SEC
  SBC locVar1                                                                   ; # of heatsinks that can be restored
  CMP list3+0
  BCS +notLess
  STA list3+0

+notLess:
  STA list3+0
  STA systemMenuLine2+4
  LDA #$0D
  STA systemMenuLine2+3
  RTS
