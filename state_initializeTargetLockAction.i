; state 44
state_initializeTargetLockAction:


  JSR pullAndBuildStateStack
  .db 7			; 4 items
  .db $1C   ; face target
  .db $2B   ; center on attack area
  .db $0C   ; wait for camera to center
  .db $3E   ; init targetLock
  .db $3F   ; focus animation
  .db $40   ; running effect: LOCK marker animation
  .db $16		; show results
  ; built in RTS
