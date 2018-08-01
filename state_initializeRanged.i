; -----------------------------------------------
; game state 12: start ranged attack
; -----------------------------------------------
state_initializeRanged:
	JSR calculateAttack					; calculate hit / miss
	JSR clearCurrentEffects			; clear remaining effects
	JSR clearActionMenu					; clear the menu

	LDX #15										  ; position 0
	LDY #6									  	; "attacking"
	JSR writeToActionMenu

	LDY distanceToTarget
	LDA rangeCategoryMap-1, Y
	CMP #3
	BCS +missile
	CMP #2
	BCS +laser

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

+missile:
	JSR pullAndBuildStateStack
	.db #11											; 8 items
	.db $45, %00111000					; blink action menu ON
	.db $31, eRefreshStatusBar	; raise event
	.db $1C											; turn active unit to face target
	.db $2B											; center camera on attack area
	.db $0C											; wait for camera
	.db $39											; start missile animation
	.db $4B, 0									; clear runningEffect
	.db $16											; show results
