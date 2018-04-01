;
; calculates ap cost and heat cost
;

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
  CPX #aCOOLDOWN
  BEQ +restore
  STA list3+12                    ; store heat cost
  LDA actionPointCostTable, X     ; load action point cost
  STA list3+0
  RTS

+restore:
  LDA activeObjectStats+9
	STA list3+0									    ; AP cost = all remaining action points
  STA list3+12
  RTS
