; grid pos
;
; b7+b2-0 pilot
;	b7-4 object type, b3-0 facing RD
;	b7-4 weapon 1, b3-0 weapon 2
;
; 0


state_loadWave:
  ; read grid pos
  ; put cursor there
  ;
  ; loop
  ; select grid pos as close to cursor as possible
  ;     that is not occupied
  ; create new object
  ; next object? -> loop
