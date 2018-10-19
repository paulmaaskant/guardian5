; -----------------------------------------------
; IN X,       object index
; IN locVar1, pilot
; IN locVar2, grid position
; IN locVar3, type & facing direction
; IN A        items
; -----------------------------------------------
insertObject:
  PHA									      ; store
  AND #$F0
  STA object+6, X			      ; item 1
  PLA									      ; restore
  ASL
  ASL
  ASL
  ASL
  STA object+7, X		        ; item 2

  LDA #0                    ; then clear the
  STA object+2, X           ; animation counter
  STA object+4, X           ; and status flags

  LDA locVar2
  STA object+3, X           ; grid position

  LDA locVar3
  STA object+0, X           ; type and facing

  LDY objectListSize        ; first step is to
  TXA
  ORA locVar1               ; paste the pilot bits onto the index
  STA objectList, Y         ; to create object list entry
  INC objectListSize        ; add object to the list

insertObjectGridPosOnly:
  TXA                       ; X to Y
  PHA
  TAY
  JSR getStatsAddress       ; sets pointer1
  PLA
  TAX
  LDY #7							      ; # for BG tile offset
  LDA (pointer1), Y
  STA locVar1

  LDY object+3, X           ; Y = grid position
  LDA object+0, X           ; type and facing direction
  AND #$0F									; mask facing direction
  CLC                       ; and add to base BG tile
  ADC locVar1
  ORA #%11000000						; raise obscuring and blocking flags
  STA nodeMap, Y

  LDY #1                    ; add
  LDA (pointer1), Y					; #1 armor points
;  INY                       ; to
;  ADC (pointer1), Y					; #2 structure points
  ASL
  ASL
  ASL
  STA object+1, X						; to set the hitpoints

  RTS
