; -----------------------
; check if the active object has item A equipped
; in A item
; in Y object index
; -----------------------

isEquippedOnActiveObject:
  LDY activeObjectIndex

isEquipped:
  ASL
  ASL
  ASL
  ASL
  STA locVar1
  LDA object+6, Y
  AND #$F0
  CMP locVar1
  BEQ +match            ; carry flag is set
  LDA object+7, Y
  AND #$F0
  CMP locVar1
  BEQ +match            ; carry flag is set
  CLC                   ; no match

+match
  RTS
