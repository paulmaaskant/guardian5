directionToCursor:
  LDA activeObjectGridPos
  JSR gridPosToScreenPos
  JSR angleToCursor
  CLC																			; to derive the appropriate defense value
  ADC #32																	; rotate by 45 degrees (32 radial)
  LSR
  LSR
  LSR
  LSR
  LSR
  TAY
  LDA attackDirectionTable, Y                  ; 8 to 6
  RTS
