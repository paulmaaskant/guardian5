; ------
; game state 1C: active unit face target
; -----
;      \_1__/
;      /\  /\
;   6 /  \/  \ 2
;  ---------------
;     \  /\  /
;   5  \/__\/  3
;      / 4  \
;
; first the line function transposes p1 and p2 to the tile grid
; then we do 3 comparisons and store the sign of each
;
; (p1_x - p1_y) compared to (p2_x - p2_y)
; (p1_x + p1_y) compared to (p2_x + p2_y)
; p1_y compared to p2_y
;
; which gives us a number between 0 and 7 and we used that that
; to retrieve the direction from a look up table

state_faceTarget:
  LDY targetObjectIndex
  LDA object+3, Y
  TAY


  LDA activeObjectGridPos                                                       ; point 1
  JSR setLineFunction                                                           ; used to set to transpose
                                                                                ; point 1 and point 2 to tile grid coors
                                                                                ; and store them in list1+0, 1, 2, 3
  LDA #$00
  STA list1+9

  CLC
  LDA list1+1         ; ox
  ADC list1+2         ; py
  SEC
  SBC list1+0         ; oy
  SBC list1+3         ; px
  ASL
  ROL list1+9         ; push sign bit into list1+9

  CLC
  LDA list1+1         ; ox
  ADC list1+0         ; oy
  SEC
  SBC list1+2         ; py
  SBC list1+3         ; px
  ASL
  ROL list1+9         ; push sign bit into list1+9

  SEC
  LDA list1+2         ; py
  SBC list1+0         ; oy
  ASL
  ROL list1+9         ; push sign bit into list1+9

  LDY list1+9
  LDX state29_direction, Y
  STX locVar1

  LDY activeObjectIndex
  LDA object+0, Y
  AND #%11111000
  ORA locVar1
  STA object+0, Y

  LDY activeObjectIndex
  JSR getStatsAddress
  LDY #4
  LDA (pointer1), Y
  BNE	+done

  LDY activeObjectGridPos
  LDX locVar1
  TXA
  ORA #%11000000
  STA nodeMap, Y
  JSR setTile

+done:

  JMP pullState

state29_direction:
  db 5, 6, 4, 3, 5, 1, 3, 2
