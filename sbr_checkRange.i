; -----------------------------------------
;
; -----------------------------------------
checkRange:
	JSR getSelectedWeaponTypeIndex
	BCS +failed
	LDA weaponType+2, Y									;
	BCC +next

+failed:
  LDA #%00010000									; default range for close combat (max 1, min 0)

+next:
	STA locVar2
	LSR
	LSR
	LSR
	LSR										; max range
	CMP distanceToTarget
	BCS +checkMinRange

+outOfRange:
	LDA #$88							; deny (b7) + out of range (b6-b0)
	STA actionMessage
	RTS

+checkMinRange:
	LDA locVar2							; minimum range
	AND #$0F								; distance
	CMP distanceToTarget
	BEQ +done
	BCC +done
	LDA #$8C								; deny (b7) + target too close (b6-b0)
	STA actionMessage

+done:
	RTS
