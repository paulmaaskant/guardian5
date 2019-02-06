weaponType:
  .db 74			    ; 0 name: EMPTY SLOT
  .db %00000000   ; 1 damage profile (+1 close combat)
  .db %00000000		; 2 target inflicted heat profile
  .db 0           ; 3 heat cost

  .db 29				  ; 0 name: MACHINE GUN
  .db %00010000   ; 1 damage profile (+1 short range)
  .db %00000000		; 2 target inflicted heat profile
  .db 0           ; 3 heat cost

  .db 45			    ; 0 name: MEDIUM LASER
  .db %00000100   ; 1 damage profile (+1 mid range)
  .db %00000000		; 2 target inflicted heat profile
  .db 0           ; 3 heat cost

  .db 30			    ; 0 name: LR MISSILE
  .db %00000001   ; 1 damage profile (+1 long range)
  .db %00000000		; 2 target inflicted heat profile
  .db 0           ; 3 heat cost

  .db 51			    ; 0 name: ARMOR
  .db %00000000   ; 1 damage profile (+1 long range)
  .db %00000000		; 2 target inflicted heat profile
  .db 0           ; 3 heat cost

  .db 68			    ; 0 name: FLAMER
  .db %00000000   ; 1 damage profile (n/a)
  .db %00000000		; 2 target inflicted heat profile
  .db 0           ; 3 heat cost

  .db 47			    ; 0 name: ACTUATOR
  .db %00000000   ; 1 damage profile (+1 move point)
  .db %00000000		; 2 target inflicted heat profile
  .db 0           ; 3 heat cost

  .db 42			    ; 0 name: GIANT BLADE
  .db %01000000   ; 1 damage profile (+1 close combat)
  .db %00000000		; 2 target inflicted heat profile
  .db 0           ; 3 heat cost
