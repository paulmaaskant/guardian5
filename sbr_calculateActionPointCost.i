; ----------------------------------------
; calculates ap cost and heat cost
; ----------------------------------------
calculateActionPointCost:
  BIT actionMessage
	BPL +continue
	RTS

+continue:
  LDY selectedAction
  LDX actionList, Y						    ;
  LDA heatCostTable, X            ; heat cost
  STA list3+12                    ; store heat cost
  LDA actionPointCostTable, X     ; load action point cost
  BPL +store
  LDA activeObjectStats+9         ; BRACE ap cost = remaining points

+store:
  STA list3+0

  CPX #aBRACE                     ; reduce
  BNE +done
  LDA list3+12                    ; heat cost (-1)
  STA list3+13                    ; set to make sure that HUD shows heat reduc in target area

+done:
  RTS
