weaponType:

  .db 29				  ; 0 name: reaper
  .db 1           ; 1 damage
  .db $82					; 2 range (max|min)
  .db 128+0       ; 3 once per turn bit and ammo (0=infinite)
  .db 1           ; 4 turns to reload
  .db 0           ; 5 heat inflicted
  .db 1           ; 6 heat cost
  .db 0           ; 7 type: machine gun

  .db 30			    ; 0 name: hailfire
  .db 3           ; 1 damage
  .db $83					; 2 range (max|min)
  .db 128+03      ; 3 ammo (0=infinite)
  .db 1           ; 4 not used
  .db 0           ; 5 heat inflicted
  .db 2           ; 6 heat cost
  .db 1           ; 7 type: missiles

  .db 42			    ; 0 name: spark
  .db 2           ; 1 damage
  .db $72					; 2 range (max|min)
  .db 128+02      ; 3 ammo (0=infinite)
  .db 1           ; 4 not used
  .db 0           ; 5 heat inflicted
  .db 2           ; 6 heat cost
  .db 1           ; 7 type: missiles
