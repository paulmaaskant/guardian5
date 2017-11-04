actionPointCostTable:
	.db $01				                                                                ; 00 MOVE
	.db $01  			                                                                ; 01 RANGED ATK 1
	.db $01    		                                                                ; 02 RANGED ATK 2
	.db $02      	                                                                ; 03 COOL DOWN
	.db $01                                                                       ; 04 CLOSE COMBAT
	.db $03                                                                       ; 05 CHARGE
	.db $01                                                                       ; 06 PIVOT TURN
	.db $02                                                                       ; 07 RUN

calculateActionPointCost:
	;LDA #$0F
	;STA systemMenuLine1+4
	;STA systemMenuLine1+3
	;STA systemMenuLine2+4
	;STA systemMenuLine2+3
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
  BEQ +restoreHeatsinks
  CMP locVar1
  BCC +less
  LDA locVar1                                                                   ; make sure no more heat sinks                                                                 ; go offline than are available

+less:
  STA list3+0
	;STA systemMenuLine2+4
  ;LDA #$D0
  ;STA systemMenuLine2+3
	;CPX #aCHARGE
	;BNE +continue
	;LDA #$01
	;STA systemMenuLine1+4
  ;LDA #$D0
  ;STA systemMenuLine1+3

+continue:
  RTS

+restoreHeatsinks:
	STA list3+0
  LDA activeObjectTypeAndNumber
  JSR getStatsAddress
  LDY #$00                                                                      ; type max health / heatsinks
  LDA (pointer1), Y
	AND #$07
	LSR
	BCC +continue
	INC list3+0																																		; restore 3 instead of 2

+continue:
	ASL
  SEC
  SBC locVar1                                                                   ; # of heatsinks that can be restored
  CMP list3+0
  BCS +notLess
  STA list3+0

+notLess:
  ;LDA list3+0
  ;STA systemMenuLine2+4
  ;LDA #$D1
  ;STA systemMenuLine2+3
  RTS
