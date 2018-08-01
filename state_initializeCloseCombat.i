; --------------------------------------------------
; game state 17: initialize close combat
; --------------------------------------------------
state_initializeCloseCombat:
  JSR calculateAttack

  LDA #0
  STA effects

  JSR pullAndBuildStateStack
  .db 7							  ; 7 items
  .db $1C              ; face target
  .db $3A, 1					; switch CHR bank 1 to 1
  .db $1D 						; close combat animation
  .db $3A, 0					; switch CHR bank 1 back to 0
  .db $16							; show results
  ; built in RTS
