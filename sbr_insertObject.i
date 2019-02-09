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

  LDA locVar1               ; set pilot
  AND #%01111100
  STA object+4, X           ;

  LDA locVar1
  AND #%10000011
  STA locVar1               ; only AI + faction bits

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

  LDY object+3, X           ; Y = grid position
  LDA nodeMap, Y
  BIT bit5                  ; can BG tile be overwritten?
  BEQ +continue             ; yes -> continue
  ORA #%11000000            ; no, then skip tile logic and just block the node
  BNE +writeToMap           ; JMP

+continue:
  STA object+5, X           ; store map BG tile

  LDY #7
  LDA (pointer1), Y
  STA locVar1               ; # for BG tile offset

  LDY #3
  LDA (pointer1), Y         ; movement properties
  AND #$0F
  BEQ +continue             ; no movement points -> skip direction offset

  LDA object+0, X           ; type and facing direction
  AND #$0F									; mask facing direction

+continue:
  CLC                       ; and add to base BG tile
  ADC locVar1
  ORA #%11000000						; raise obscuring and blocking flags
  LDY object+3, X

+writeToMap:
  STA nodeMap, Y            ; overwrite map BG tile with object BG tile

  LDY #1                    ; add
  LDA (pointer1), Y					; #1 armor points
  ASL
  ASL
  ASL
  STA object+1, X						; to set the hitpoints

  RTS
