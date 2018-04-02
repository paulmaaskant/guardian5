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
    .db #< header             ; 0
    .db #< layout0            ; 1
    .db #< layout1            ;
    .db #< selector0          ; 3
    .db #< labels0            ;
    .db #< labels1            ; 5
    .db #< layout2            ; 6
    .db #< clearLayout        ; 7
    .db #< titleMenuOptions   ; 8
    .db #< titleMenuSelect    ; 9
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

  header:
    .db 10,  9, $2B, $27, 20        ; pilot name
    .db  5, 14, $4B, $27, 10        ; skill
    ;.db  5, 54, $41, $27, 10
    .db 0

  layout0:
    .db 10, 29, $A7, $27, 20        ; mech name
    .db 3, 32, $2B, $24, 7          ; health / mov / mel 10s
    .db 3, 42, $2C, $24, 7          ; health / mov / mel 01s
    .db 3, 35, $34, $24, 7          ; def front / side / rear 10s
    .db 3, 45, $35, $24, 7          ; def front / side / rear 01s
    .db 0

  layout1:                           ; weapon 1
    .db 2, 71, $2B, $24, 5
    .db 2, 73, $2C, $24, 5
    .db 1, 77, $55, $24, 2
    .db 2, 79, $34, $24, 4
    .db 2, 81, $3D, $24, 5          ; heat x2
    .db 19, 101, $A7, $27, 38         ; weapon name
    .db 0

  layout2:                           ; weapon 2
    .db 2, 121, $2B, $24, 5          ; damg
    .db 2, 123, $2C, $24, 5          ;
    .db 1, 127, $55, $24, 2          ; min range
    .db 2, 129, $34, $24, 4          ; max range
    .db 2, 131, $3D, $24, 5          ; heat x2
    .db 19, 151, $A7, $27, 38         ; weapon name
    .db 0

labels0:
    ;.db 128+3, H, C, M, $07, $24, 6
    .db 128+16,$8F,space,space,$0A,R,F,D,space,space,$3F,space,space,$0A,P,T,H, $27, $24, 32
    .db 128+16,$8F,space,space,$0A,I,S,D,space,space,$3E,space,space,$0A,V,O,M, $47, $24, 32
    .db 128+16,$8F,space,space,$0A,R,R,D,space,space,$3D,space,space,$0A,L,E,M, $67, $24, 32
    .db 0

labels1:
    ;.db 128+3, N, P, W, $07, $24, 6
    .db 128+24,$3B,space,$0A,I,T,H,space,space,$3E,space, space,$0A,X,A,M,space,space,$3D,space,space,$0A,G,M,D, $27, $24, 48
    .db 128+24,$3B,space,$0A,C,T,H,space,space,$3E,space,$0A,$0A,N,I,M,space,space,X,space,space,$0A,M,M,A, $47, $24, 48
    .db 128+7,T,space,$0A,$0A,D,L,R, $67, $24, 14
    .db 0

selector0:
  .db 4, 58, $01, $24, 9
  .db 4, 62, $05, $24, 9
  .db 0

clearLayout:
  .db 128+23, repeatChar, 23, $0F, $A7, $27, 46         ;
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
