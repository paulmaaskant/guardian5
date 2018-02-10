; -----------------------------------------
;
; -----------------------------------------
checkRange:
	LDA #%00010000									; default range for close combat (max 1, min 0)
	LDY selectedAction
	LDX actionList, Y								; 1 for weapon 1, 2 for weapon 2
	CPX #aCLOSECOMBAT
	BEQ +continue										; if true, stick with current value of A

	LDA activeObjectStats-1, X			; max range (b7-4) min range (b3-2)

+continue:
	STA locVar2
	LSR
	LSR
	LSR
	LSR										; max range
	CMP distanceToTarget
	BCS +checkMinRange
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
