; nmiVar0, 1 meta tile pointer
; A, pointer tile
;
getObjectTile:
  AND #$03
  TAX
;  CLC
;  LDA nmiVar0				; low
;  ADC #$90
;  STA nmiVar5
;  LDA nmiVar1
;  ADC #$03
;  STA nmiVar6

;  LDA (nmiVar5), Y   ; A is grid position

;  CPX #4
;  BCC +continue
;  ADC #15

+continue:



  LDA objectTiles, X


  RTS
