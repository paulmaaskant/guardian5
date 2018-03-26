; state 44
state_initializeTargetLockAction:


  JSR pullAndBuildStateStack
  .db 6			; 4 items
  .db $1C   ; face target
  .db $2B   ; center on attack area
  .db $3E   ; init targetLock
  .db $15   ; focus animation
  .db $40   ; LOCK marker animation
  .db $16		; show results
  ; built in RTS
