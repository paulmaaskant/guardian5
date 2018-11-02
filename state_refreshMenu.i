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
  TAX                  ; b7 use list, b6 vertical, b5-0 length
  BEQ +done

  ASL                  ; get b7 and store on stack
  PHP
  ASL                  ; get b6 into carry
  TXA
  AND #%00111111
  ROL
  STA locVar5
  LSR
  TAX                  ; length
  PLP                  ; restore b7
  BCC +listEntry

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
  LDA locVar5
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
    .db #< mechBayItemMenuFrame     ; 1
    .db #< mechBayItemMenu          ; 2
    .db #< selector0                ; 3
    .db #< mechBayLeftCol           ; 4
    .db #< mechBayRightCol          ; 5
    .db #< mechBayEquipped          ; 6
    .db #< clearLayout              ; 7
    .db #< titleMenuOptions         ; 8
    .db #< titleMenuSelect          ; 9
    .db #< mechDemon                ; 10
    .db #< unitMenuSelectedWeapons  ; 11
    .db #< unitCurrentItem          ; 12
    .db #< unitMenuLabels           ; 13
    .db #< unitMenuStatValues       ; 14
    .db #< mechBayLegs              ; 15
    .db #< mechSlingShot            ; 16
    .db #< clearItemMenu            ; 17
    .db #< clearItemMenu2           ; 18
    .db #< mechBayPilotMenuFrame    ; 19
    .db #< mechBayPilotMenu         ; 20
    .db #< clearPilotMenu           ; 21
    .db #< mechBayMechMenuFrame     ; 22
    .db #< mechBayMechMenu          ; 23
    .db #< mechBayTextArea          ; 24
    .db #< mechGeist                ; 25
    .db #< mechBattleAngel          ; 26
    .db #< mechBayStats             ; 27


  state46_layout_lo:
    .db #> header
    .db #> mechBayItemMenuFrame
    .db #> mechBayItemMenu
    .db #> selector0
    .db #> mechBayLeftCol
    .db #> mechBayRightCol
    .db #> mechBayEquipped
    .db #> clearLayout
    .db #> titleMenuOptions
    .db #> titleMenuSelect
    .db #> mechDemon
    .db #> unitMenuSelectedWeapons
    .db #> unitCurrentItem
    .db #> unitMenuLabels
    .db #> unitMenuStatValues
    .db #> mechBayLegs
    .db #> mechSlingShot
    .db #> clearItemMenu
    .db #> clearItemMenu2
    .db #> mechBayPilotMenuFrame
    .db #> mechBayPilotMenu
    .db #> clearPilotMenu
    .db #> mechBayMechMenuFrame
    .db #> mechBayMechMenu
    .db #> mechBayTextArea
    .db #> mechGeist
    .db #> mechBattleAngel
    .db #> mechBayStats             ; 27

  header:
    .db 10,  9, $27, $27      ; pilot name
    .db 10, 29, $47, $27      ; mech name
    .db 0

  mechBayItemMenuFrame:
    .db 128+7, $8F,$8E,$8D,$AE,$8E,$8D,$8C, $78,$24
    .db 128+64+23,$9C,$9C,$9D,$9C,$9C,$9D,$9C,$9C,$9D,$9C,$9C,$9D,$9C,$9C,$9D,$9C,$9C,$9D,$9C,$9C,$9D,$9C,$9C ,$98,$24
    .db 128+64+23,$9B,$8B,$B8,$9B,$8B,$B8,$9B,$8B,$B8,$9B,$8B,$B8,$9B,$8B,$B8,$9B,$8B,$B8,$9B,$8B,$B8,$9B,$8B ,$9B,$24
    .db 128+64+23,$AF,$9F,$9E,$AF,$9F,$9E,$AF,$9F,$9E,$AF,$9F,$9E,$AF,$9F,$9E,$AF,$9F,$9E,$AF,$9F,$9E,$AF,$9F ,$9E,$24
    .db 128+7, $BF,$BE,$BD,$AD,$BE,$BD,$BC, $78,$27
    .db 0

  mechBayItemMenu:
    .db 64+23, 22,$99,$24
    .db 64+23, 45,$9A,$24
    .db 64+23, 68,$9C,$24
    .db 64+23, 91,$9D,$24
    .db 0

  mechBayEquipped:
    .db 64+8,99,$15,$25
    .db 64+8,107,$16,$25
    .db 64+11,118,$A9,$24
    .db 64+11,129,$AA,$24
    .db 2,173,$B5,$24
    .db 2,175,$D5,$24
    .db 0

mechBayLeftCol:
    db 128+64+19,  repeatChar,6,$9C,$BC,$9C,$9C,$9C,$8C,space, $BC,$9C,$9D,$9C,$9C,$9C,$8C,                           $88,$24  ;
    db 128+64+19,  L,M,S,C,space,H,$BD,repeatBlank,3,$8D,space,$BD,space,$AB,repeatBlank,3,$8D,      $89,$24   ;
    db 128+64+19,  R,R,R,C,space,P,$BE,repeatBlank,3,$8E,space,$BE,space,$BB,repeatBlank,3,$8E,      $8A,$24 ;
    db 128+64+13,  $BF,$AF,$AF,$9F,$8F,space,$BF,$9F,$9E,$AF,$AF,$9F,$8F,                            $8B,$24   ;
    db 0

mechBayRightCol:
    db 128+64+13,  $9C,$9C,$9C,$BC,$9C,$9C,$9D,$9C,$9C,$9D,$9C,$9C,$8C,                  $F4,$24   ;
    db 128+64+10,  $BD,space,space,$AB,space,space,$AB,space,space,$8D,      $F5,$24   ;
    db 128+64+10,  $BE,space,space,$BB,space,space,$BB,space,space,$8E,      $F6,$24   ;
    db 128+64+16,  repeatChar,6,$9F,$BF,$AF,$9F,$9E,$AF,$9F,$9E,$AF,$9F,$8F,                  $F7,$24   ;
    db 128+2,      $C0,$CD,                                                  $95,$24
    db 128+64+3,   S,I,M,                                                    $35,$26
    db 128+7,      Y,A,B,H,C,E,M,                                            $70,$24
    db 0

selector0:
  .db 64+4, 58, $01, $24
  .db 64+4, 62, $05, $24
  .db 0

clearLayout:
;  .db 128+24, repeatChar, 24, $0F, $A7, $27         ;
;  .db 128+24, repeatChar, 24, $0F, $27, $24         ;
;  .db 128+24, repeatChar, 24, $0F, $47, $24         ;
;  .db 128+24, repeatChar, 24, $0F, $67, $24         ;
  .db 0

titleMenuOptions:
  .db 128+4, O, M, E, D, $0D, $26
  .db 128+5, D, N, U, O, S, $2D, $26

titleMenuSelect:
  .db 64+2, 1, $0C, $26
  .db 2, 6, $33, $26
  .db 0

unitMenuSelectedWeapons:
;  .db 8, 135, $2C, $25
;  .db 8, 143, $4C, $25
;  .db 8, 151, $AC, $25
;  .db 8, 159, $CC, $25
;  .db 8, 167, $2C, $26
;  .db 8, 175, $4C, $26
  .db 0

unitCurrentItem:
;  .db 4, 67, $A4, $26
;  .db 4, 71, $C4, $26
;  .db 4, 75, $E4, $26
;  .db 4, 79, $04, $27
  .db 0

unitMenuLabels:
;  .db 128+64+10, L,M,S,C,space,I,M,S,A,P, $36, $25  ;
;  .db 128+64+10, R,R,R,C,space,N,V,T,R,L, $37, $25   ;
  .db 0

unitMenuStatValues:
;  db 64+10, 215, $23, $25   ;
;  db 64+10, 185, $39, $25   ;
;  db 64+10, 195, $3A, $25   ;
;  db 64+10, 205, $3B, $25   ;
;  db 64+10, 215, $34, $25   ;
  db 0

mechBayLegs:
  db 128+64+4, $B0,$A0,$90,$80, $8D, $25  ;
  db 128+64+4, $B1,$A1,$91,$81, $8E, $25   ;
  db 128+64+4, $B0,$A0,$90,$80, $91, $25   ;
  db 128+64+4, $B1,$A1,$91,$81, $92, $25   ;
  db 128+6, $A3,$A2,$83,$83,$A2,$82,             $4D,$25  ;
  db 128+6, $B3,$B2,$86,$87,$93,$92,             $6D,$25  ;
  db 128+8, $85,X,X,$84,$85,X,X,$84,$EC,$25  ;
  db 0

mechSlingShot:
  db 128+8, $85,$98,$84,space,space,$85,$98,$84,      $AC,$24   ;
  db 128+8, $88,$A2,$88,$A2,$84,$88,$A8,$88,          $CC,$24   ;
  db 128+8, $88,$A2,$97,$96,$95,$94,$A8,$88,          $EC,$24   ;
  db 128+8, $87,$98,$A7,$A6,$A5,$A4,$98,$86,          $0C,$25   ;
  db 128+8, space,space,$B7,$B6,$B5,$B4,space,space,  $2C,$25   ;
  db 0

clearItemMenu:
  db 128+64+25, repeatBlank, 25 ,$78,$24
  db 128+64+25, repeatBlank, 25 ,$79,$24
  db 128+64+25, repeatBlank, 25 ,$7A,$24
  db 128+64+25, repeatBlank, 25 ,$7B,$24
  db 0

clearItemMenu2:
  db 128+64+25, repeatBlank, 25 ,$7C,$24
  db 128+64+25, repeatBlank, 25 ,$7D,$24
  db 128+64+25, repeatBlank, 25 ,$7E,$24
  db 0

mechBayPilotMenuFrame:
  db 128+7, $8F,$8E,$8D,$AE,$8E,$8D,$8C,$81,$24
  db 128+64+11,$9C,$9C,$9C,$9D,$9C,$9C,$9C,$9D,$9C,$9C,$9C,$A1,$24
  db 128+64+11,$9B,$9B,$8B,$B8,$9B,$9B,$8B,$B8,$9B,$9B,$8B,$A4,$24
  db 128+64+11,$AF,$AF,$9F,$9E,$AF,$AF,$9F,$9E,$AF,$AF,$9F,$A7,$24
  db 128+7, $BF,$BE,$BD,$AD,$BE,$BD,$BC,$01,$26
  db 0

mechBayPilotMenu
  db 64+11, 10, $A2,$24
  db 64+11, 21, $A3,$24
  db 64+11, 32, $A5,$24
  db 64+11, 43, $A6,$24
  db 0

clearPilotMenu:
  db 128+64+13,repeatBlank,13,$81,$24
  db 128+64+13,repeatBlank,13,$82,$24
  db 128+64+13,repeatBlank,13,$83,$24
  db 128+64+13,repeatBlank,13,$84,$24
  db 128+64+13,repeatBlank,13,$85,$24
  db 128+64+13,repeatBlank,13,$86,$24
  db 128+64+13,repeatBlank,13,$87,$24
  db 0

mechBayMechMenuFrame:
  db 128+7, $8F,$8E,$8D,$AE,$8E,$8D,$8C,$81,$24
  db 128+64+7, $9C,$9C,$9C,$9D,$9C,$9C,$9C,$A1,$24
  db 128+64+7, $9B,$9B,$8B,$B8,$9B,$9B,$8B,$A4,$24
  db 128+64+7, $AF,$AF,$9F,$9E,$AF,$AF,$9F,$A7,$24
  db 128+7, $BF,$BE,$BD,$AD,$BE,$BD,$BC,$81,$25
  db 0

mechBayMechMenu:
  db 64+7, 6, $A2,$24
  db 64+7, 13, $A3,$24
  db 64+7, 20, $A5,$24
  db 64+7, 27, $A6,$24
  db 0

mechBayTextArea:
  db 14,143,$0C,$27
  db 14,157,$2C,$27
  db 14,171,$4C,$27
  db 2,205,$09,$27
  db 0

mechGeist:
  db 128+8, repeatBlank,8,                          $AC,$24  ;
  db 128+8, repeatBlank,3,$85,$82,repeatBlank,3,    $CC,$24   ;
  db 128+8, space,$85,$A2,$96,$95,$A2,$84,space,    $EC,$24   ;
  db 128+8, space,$8A,$A8,$AA,$A9,$A8,$89,space,    $0C,$25   ;
  db 128+8, space,space,$9A,$A6,$A5,$99,space,space,$2C,$25   ;
  db 0

mechBattleAngel:
  db 128+8, repeatBlank,8,                          $AC,$24  ;
  db 128+8, $85,$98,$84,$85,$84,$85,$98,$84,        $CC,$24   ;
  db 128+8, $88,$A8,$97,$BA,$B9,$94,$A8,$88,        $EC,$24   ;
  db 128+8, $97,$83,$B9,$8A,$89,$BA,$83,$94,        $0C,$25   ;
  db 128+8, $87,$86,$B7,$9A,$99,$B4,$87,$86,        $2C,$25   ;
  db 0

mechDemon:
  db 128+8, repeatBlank,8,                          $AC,$24  ;
  db 128+8, $85,$98,$85,$98,$98,$84,$98,$84,        $CC,$24   ;
  db 128+8, $88,$A8,$86,$AC,$A2,$87,$A3,$82,        $EC,$24   ;
  db 128+8, $88,$A8,$B2,$A6,$A2,$93,$A3,$82,        $0C,$25   ;
  db 128+8, $87,$98,$B7,$81,$80,$B4,$98,$86,        $2C,$25   ;
  db 0

mechBayStats:
  db 8,183,$2C,$26
  db 5,188,$6C,$26
  db 5,193,$8C,$26
  db 5,198,$AC,$26
  db 5,203,$CC,$26
  db 64+3,211,$36,$26
  db 0
