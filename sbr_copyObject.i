; copies object Y to object X

copyObject:
  LDA object+0, Y
  STA object+0, X

  LDA object+4, Y
  STA object+4, X

  LDA object+6, Y
  STA object+6, X

  LDA object+7, Y
  STA object+7, X

  TYA
  LSR
  LSR
  LSR
  TAY

  TXA
  LSR
  LSR
  LSR
  TAX

  LDA objectList, Y
  AND #%10000111
  STA locVar1

  LDA objectList, X
  AND #%01111000
  ORA locVar1
  STA objectList, X


  RTS
