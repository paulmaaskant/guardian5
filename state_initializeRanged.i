; -----------------------------------------------
; game state 12: start ranged attack (laser)
; -----------------------------------------------

; list1+0 = delta X
; list1+1 (b7) = X delta sign
; list1+2 = delta Y
; list1+3 (b7) = Y delta sign
; list1+4 delta X^2 hi
; list1+5 delta X^2 lo
; list1+6 (b7) delta Y > delta X
;
; list1+7 = angle
; list1+8 = radius


state_initializeRanged:
	JSR calculateAttack					; calculate hit / miss
	JSR clearCurrentEffects			; clear remaining effects
	JSR clearActionMenu					; clear the menu

	LDX #$00										; position 0
	LDY #$06										; "opening fire"
	JSR writeToActionMenu

	JSR getSelectedWeaponTypeIndex
	LDA weaponType+7, Y					; figure out which animation
	BNE +missile								; 0 machinegun, 1 missiles

+machineGun:
	JSR pullAndBuildStateStack
	.db #9											; 8 items
	.db $45, %00111000					; blink action menu ON
	.db $31, eRefreshStatusBar	; raise event
	.db $1C											; face target
	.db $2B											; center camera on attack area
	.db $38											; start machine gun animation
	.db $16											; show results
	.db $42											; show temp gauge change

+missile:
	JSR pullAndBuildStateStack
	.db #9											; 8 items
	.db $45, %00111000					; blink action menu ON
	.db $31, eRefreshStatusBar	; raise event
	.db $1C											; turn active unit to face target
	.db $2B											; center camera on attack area
	.db $39											; start missile animation
	.db $16											; show results
	.db $42											; show temp gauge change
