; A node center
; X
; Y radius


; Y = sqrt(R^2 - X^2)
;
; 64^2
; $0800


sbr_circle:

  PHA       ; save A

  TXA
  JSR absolute
  TAX

  JSR multiply

  SEC
  LDA #$00
  SBC par2
  STA par2
  LDA #$08
  SBC par1
  STA par1

  JSR squareRoot


  RTS
