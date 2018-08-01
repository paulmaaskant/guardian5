;
; In X = item ID
; In A = item score
;
; high score goes down the list
;
addToSortedList:

  LDY #0

-loop:
  CPY list6                     ; at end of the list?
  BNE +continue
  STA list7+1, Y                ; store score
  TXA
  STA list6+1, Y                ; store ID
  LDA list6
  CMP #62
  BCS +done
  INC list6

+done:
  RTS

+continue:
  CMP list7+1, Y
  BCS +found
  INY
  BNE -loop                     ; always

+found:                         ; bump rest of the list

  STX locVar1                   ; item (1) to insert
  STA locVar2                   ; item (1) to insert

;  BNE +noDuplicate              ; check if this is a duplicate entry
;  LDA list6+1, Y
;  CMP locVar1                   ; deduplicate
;  BNE +noDuplicate
;  RTS                           ; duplicate entry - done

;+noDuplicate:
  LDA list6+1, Y
  STA locVar3                   ; item (2) to push down
  LDA list7+1, Y
  STA locVar4                   ; item (2) to push down
  LDA locVar1
  STA list6+1, Y                ; insert item (1)
  LDA locVar2
  STA list7+1, Y                ; insert item (1)

  LDX locVar3                   ;
  LDA locVar4

  INY
  CPY list6                     ; loop until Y > number of items in list
  BCC -loop
  BEQ -loop
  RTS
