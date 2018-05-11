; -----------------------------------------------
; game state 12: start ranged attack
; -----------------------------------------------
state_initializeRanged:
	JSR calculateAttack					; calculate hit / miss
	JSR clearCurrentEffects			; clear remaining effects
	JSR clearActionMenu					; clear the menu

	LDX #15										; position 0
	LDY #6										; "attacking"
	JSR writeToActionMenu

	JSR getSelectedWeaponTypeIndex
	LDA weaponType+7, Y					; figure out which animation
	BEQ +machineGun							; 0 machinegun
	CMP #1											; 1 missiles
	BEQ +missile

+laser:
	JSR pullAndBuildStateStack
	.db #10											; 8 items
	.db $45, %00111000					; blink action menu ON
	.db $31, eRefreshStatusBar	; raise event
	.db $1C											; face target
	.db $2B											; center camera on attack area
	.db $49											; start laser animation
	.db $4B, 0									; clear runningEffect
	.db $16											; show results

+machineGun:
	JSR pullAndBuildStateStack
	.db #10											; 8 items
	.db $45, %00111000					; blink action menu ON
	.db $31, eRefreshStatusBar	; raise event
	.db $1C											; face target
	.db $2B											; center camera on attack area
	.db $38											; start machine gun animation
	.db $4B, 0									; clear runningEffect
	.db $16											; show results

+missile:
	JSR pullAndBuildStateStack
	.db #10											; 8 items
	.db $45, %00111000					; blink action menu ON
	.db $31, eRefreshStatusBar	; raise event
	.db $1C											; turn active unit to face target
	.db $2B											; center camera on attack area
	.db $39											; start missile animation
	.db $4B, 0									; clear runningEffect
	.db $16											; show results
