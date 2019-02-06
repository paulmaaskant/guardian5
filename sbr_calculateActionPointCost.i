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

  LDA activeObjectStats+2
  AND #typeNoHeat
  BEQ +continue
  LDA #0                          ; no heat cost applied
  BEQ +store

+continue:
  LDA heatCostTable, X            ; heat cost

+store:
  STA list3+12                    ; store heat cost
  LDA actionPointCostTable, X     ; load action point cost
  BPL +store
  LDA activeObjectStats+9         ; B7 set? -> use all remaining AP

+store:
  STA list3+0

  CPX #aBRACE                     ; this code ensures that when target = SELF
  BNE +continue                   ; that the target HUD also shows a cool down
  LDA list3+12                    ; so active unit heat reduction ...
  STA list3+13                    ; is target unit heat reduction
  BCS +done                       ; always true

+continue:                        ; if action is not BRACE
  LDA activeObjectStats+0
  AND #%00001000                  ; and if engine is damaged
  BEQ +done
  INC list3+12                    ; then increase heat cost by 1

+done:
  RTS
