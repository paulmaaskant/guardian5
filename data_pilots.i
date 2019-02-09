; -----------------------------------------------
; traits
; 00000000
; |||||||+ brawler    58
; ||||||+- crack shot 59
; |||||+-- survivor   60
; ||||+--- lucky      61
; |||+---- dare devil 62
; ||+----- sprinter   63
;
; -----------------------------------------------
traitName:
  .db 58, 59, 60, 61, 62, 63, 61, 61

pilotTable:
  ; -----------------------------------------------
  ; Name, Skill level, Traits, portrait
  ; -----------------------------------------------

  ; ------- players
  .db 40, 4, %00000001, 3     ; pilot 0 BURKE
  .db 22, 4, %00001000, 4     ; pilot 1 MARU
  .db 23, 4, %00000100, 5     ; pilot 2 NIKOLI
  .db 25, 3, %00000010, 1     ; pilot 3 ORTEGA
  .db 52, 3, %00000000, 2     ; pilot 4 CASE
  .db 27, 4, %00000000, 6     ; pilot 5 UNKNOWN

  ; ------- npc
  .db 49, 4, %00000000, 12    ; pilot 6 CONVOY
  .db 28, 4, %00000000, 0     ; pilot 7 UNKNOWN
  .db 41, 4, %00000000, 8     ; pilot 8 Generic Pilot 1
  .db 41, 4, %00000000, 9     ; pilot 9 Generic Pilot 2
  .db 41, 4, %00000000, 10    ; pilot 10 Drone
  .db 48, 3, %00000000, 11    ; pilot 11 ENEMY Turret
  .db 71, 0, %00000000, 11    ; pilot 12 BUILD
