getSelectedWeaponTypeIndex:
  LDY selectedAction
  LDX actionList, Y						; 1 for weapon 1, 2 for weapon 2

  CPX #aATTACK
	BNE +failed

+continue:
  CLC
  TXA
  ADC activeObjectIndex
  TAY
  LDA object+5, Y							; object +6 or +7
  AND #$F0										; mask the weapon type
  LSR
  TAY
  CLC
  RTS

+failed:
  SEC
  RTS
