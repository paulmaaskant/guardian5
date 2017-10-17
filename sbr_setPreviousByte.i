setPreviousByte:

  LDA bytePointer+0
  BNE +noDec
  DEC bytePointer+1

+noDec:
  DEC bytePointer+0

  RTS
