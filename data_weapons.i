weaponType:
  .db 42			    ; 0 name: GIANT BLADE
  .db %01000000   ; 1 damage profile (+1 close combat)
  .db %00000000		; 2 target inflicted heat profile
  .db 0           ; 3 heat cost
  .db 0           ; 4 not used
  .db 0           ; 5 not used
  .db 0           ; 6 not used
  .db 0           ; 7 not used


  .db 29				  ; 0 name: MACHINE GUN
  .db %00010000   ; 1 damage profile (+1 short range)
  .db %00000000		; 2 target inflicted heat profile
  .db 0           ; 3 heat cost
  .db 0           ; 4 not used
  .db 0           ; 5 not used
  .db 0           ; 6 not used
  .db 0           ; 7 not used

  .db 45			    ; 0 name: MEDIUM LASER
  .db %00000100   ; 1 damage profile (+1 mid range)
  .db %00000000		; 2 target inflicted heat profile
  .db 0           ; 3 heat cost
  .db 0           ; 4 not used
  .db 0           ; 5 not used
  .db 0           ; 6 not used
  .db 0           ; 7 not used

  .db 30			    ; 0 name: LR MISSILE
  .db %00000001   ; 1 damage profile (+1 long range)
  .db %00000000		; 2 target inflicted heat profile
  .db 0           ; 3 heat cost
  .db 0           ; 4 not used
  .db 0           ; 5 not used
  .db 0           ; 6 not used
  .db 0           ; 7 not used
