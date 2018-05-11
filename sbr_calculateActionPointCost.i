; ----------------------------------------
; calculates ap cost and heat cost
; ----------------------------------------
calculateActionPointCost:
  BIT actionMessage
	BPL +continue
	RTS

+continue:
  JSR getSelectedWeaponTypeIndex  ; sets X to selected action
  BCS +notWeapon
  LDA weaponType+6, Y             ; heat cost
  BCC +next

+notWeapon:
  LDA heatCostTable, X            ; heat cost

+next:
  STA list3+12                    ; store heat cost
  LDA actionPointCostTable, X     ; load action point cost
  CPX #aBRACE
  BNE +store
  LDA activeObjectStats+9         ; BRACE ap cost = remaining points

+store:
  STA list3+0
  RTS
