state_refreshMenu:
  TSX										 ; switch stack pointers
  STX	stackPointer1
  LDX stackPointer2
  TXS

  JSR pullParameter
  TAY

  LDA state46_layout_hi, Y
  STA bytePointer+0
  LDA state46_layout_lo, Y
  STA bytePointer+1

-nextString:
  JSR getNextByte
  TAX           ;length
  BEQ +done
  BPL +listEntry

  AND #%00011111
  TAX

-loop:
  JSR getNextByte
  PHA
  DEX
  BNE -loop
  BEQ +complete

+listEntry:
  JSR getNextByte
  TAY           ;list index

-loop:
  LDA list8, Y
  PHA
  DEY
  DEX
  BNE -loop

+complete:
  JSR getNextByte
  PHA
  JSR getNextByte
  PHA
  JSR getNextByte
  PHA
  BNE -nextString

+done:
  TSX										; switch stack pointers
  STX	stackPointer2
  LDX stackPointer1
  TXS

  RTS

  state46_layout_hi:
    .db #< header                   ; 0
    .db #< layout0                  ; 1
    .db #< layout1                  ;
    .db #< selector0                ; 3
    .db #< labels0                  ;
    .db #< labels1                  ; 5
    .db #< layout2                  ; 6
    .db #< clearLayout              ; 7
    .db #< titleMenuOptions         ; 8
    .db #< titleMenuSelect          ; 9
    .db #< unitMenuInfo             ; 10
    .db #< unitMenuSelectedWeapons  ; 11
    .db #< unitCurrentItem          ; 12
    .db #< unitMenuLabels           ; 13
    .db #< unitMenuStatValues       ; 14

  state46_layout_lo:
    .db #> header
    .db #> layout0
    .db #> layout1
    .db #> selector0
    .db #> labels0
    .db #> labels1
    .db #> layout2
    .db #> clearLayout
    .db #> titleMenuOptions
    .db #> titleMenuSelect
    .db #> unitMenuInfo       ; 10
    .db #> unitMenuSelectedWeapons
    .db #> unitCurrentItem
    .db #> unitMenuLabels           ; 13
    .db #> unitMenuStatValues

  header:
    .db 10,  9, $27, $27, 20        ; pilot name
    .db 10, 29, $47, $27, 20        ; mech name
    .db 0

  layout0:
    ;.db 10, 29, $AD, $27, 20        ; mech name
    ;.db 3, 32, $2D, $24, 7          ; health / mov / mel 10s
    ;.db 3, 42, $2E, $24, 7          ; health / mov / mel 01s
    ;.db 3, 35, $34, $24, 7          ; def front / side / rear 10s
    ;.db 3, 45, $35, $24, 7          ; def front / side / rear 01s
    .db 0

  layout1:                           ; weapon 1
    ;.db 2, 71, $2B, $24, 5
    ;.db 2, 73, $2C, $24, 5
    ;.db 1, 77, $55, $24, 2
    ;.db 2, 79, $34, $24, 4
    ;.db 2, 81, $3D, $24, 5          ; heat x2
    ;.db 19, 101, $A7, $27, 38         ; weapon name
    .db 0

  layout2:                           ; weapon 2
    ;.db 2, 121, $2B, $24, 5          ; damg
    ;.db 2, 123, $2C, $24, 5          ;
    ;.db 1, 127, $55, $24, 2          ; min range
    ;.db 2, 129, $34, $24, 4          ; max range
    ;.db 2, 131, $3D, $24, 5          ; heat x2
    ;.db 19, 151, $A7, $27, 38        ; weapon name
    .db 0

labels0:
    ;.db 128+6, $0A,A,H,C,E,M, $A7, $27, 12
    ;.db 128+6, $0A,R,O,M,R,A, $27, $24, 12
    ;.db 128+6, $0A,D,E,E,P,S, $47, $24, 12
    ;.db 128+6, $0A,E,E,L,E,M, $67, $24, 12
    .db 0

labels1:
    ;.db 128+3, N, P, W, $07, $24, 6
    ;.db 128+24,space,space,$0A,I,T,H,space,space,space,space, space,$0A,X,A,M,space,space,space,space,space,$0A,G,M,D, $27, $24, 48
    ;.db 128+24,space,space,$0A,C,T,H,space,space,space,space,$0A,$0A,N,I,M,space,space,space,space,space,$0A,M,M,A, $47, $24, 48
    ;.db 128+7,space,space,$0A,$0A,D,L,R, $67, $24, 14
    .db 0

selector0:
  .db 4, 58, $01, $24, 9
  .db 4, 62, $05, $24, 9
  .db 0

clearLayout:
  .db 128+24, repeatChar, 24, $0F, $A7, $27, 48         ;
  .db 128+24, repeatChar, 24, $0F, $27, $24, 48         ;
  .db 128+24, repeatChar, 24, $0F, $47, $24, 48         ;
  .db 128+24, repeatChar, 24, $0F, $67, $24, 48         ;
  .db 0

titleMenuOptions:
  .db 128+4, O, M, E, D, $0D, $26, 8
  .db 128+5, D, N, U, O, S, $2D, $26, 10

titleMenuSelect:
  .db 2, 1, $0C, $26, 5
  .db 2, 6, $33, $26, 4
  .db 0

unitMenuInfo:
  .db 12, 11, $A8, $26, 24
  .db 12, 23, $C8, $26, 24
  .db 18, 41, $44, $27, 36
  .db 12, 53, $E8, $26, 24

  ;.db 12, 59, $48, $27, 24
  .db 0

unitMenuSelectedWeapons:
  .db 8, 135, $2C, $25, 16
  .db 8, 143, $4C, $25, 16
  .db 8, 151, $AC, $25, 16
  .db 8, 159, $CC, $25, 16
  .db 8, 167, $2C, $26, 16
  .db 8, 175, $4C, $26, 16
  .db 0

unitCurrentItem:
  .db 4, 67, $A4, $26, 8
  .db 4, 71, $C4, $26, 8
  .db 4, 75, $E4, $26, 8
  .db 4, 79, $04, $27, 8
  .db 0

unitMenuLabels:
  .db 128+10, L,M,S,C,space,I,M,S,A,P, $36, $25, 21   ;
  .db 128+10, R,R,R,C,space,N,V,T,R,L, $37, $25, 21   ;
  .db 0

unitMenuStatValues:
  db 10, 185, $39, $25, 21   ;
  db 10, 195, $3A, $25, 21   ;
  db 10, 205, $3B, $25, 21   ;
  db 10, 215, $34, $25, 21   ;
  db 0
