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
  ; Name, Skill level, Traits, not used
  ; -----------------------------------------------
  .db 40, 4, %00000001, 0     ; pilot 1 BURKE
  .db 22, 4, %00001000, 0     ; pilot 2 MARU
  .db 23, 4, %00000100, 0     ; pilot 3 NIKOLI
  .db 25, 3, %00000010, 0     ; pilot 4 ORTEGA
  .db 52, 3, %00000000, 0     ; pilot 5 CASE
  .db 27, 4, %00000000, 0     ; pilot 6 UNKNOWN
  .db 27, 4, %00000000, 0     ; pilot 7 UNKNOWN

  ; AI pilots
  .db 27, 4, %00000000, 0     ; pilot 8 UNKNOWN
  .db 27, 4, %00000000, 0     ; pilot 9 UNKNOWN
  .db 27, 4, %00000000, 0     ; pilot 10 UNKNOWN
  .db 27, 4, %00000000, 0     ; pilot 11 UNKNOWN
