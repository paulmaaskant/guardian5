                                                            ; 07 RUN

calculateActionPointCost:
	BIT actionMessage
	BPL +continue
	RTS

+continue:
  LDY activeObjectIndex
  LDA object+1, Y
  AND #$07
  STA locVar1                                                                   ; current # active heatsinks
  LDY selectedAction
  LDX actionList, Y
	LDA actionPointCostTable, X
  CPX #aCOOLDOWN
  BEQ +restore
  CMP locVar1
  BCC +less
  LDA locVar1                                                                   ; make sure no more heat sinks                                                                 ; go offline than are available

+less:
  STA list3+0
  RTS

+restore:
	LDA activeObjectStats+9
	STA list3+0									; remaining action points

	LDY activeObjectIndex
	JSR getStatsAddress

	LDY #1         							; max health / heat
  LDA (pointer1), Y
	AND #$07
  SEC
  SBC locVar1                 ; # of heat points that can be restored
  CMP list3+0
  BCS +notLess
  STA list3+0

+notLess:
  RTS
