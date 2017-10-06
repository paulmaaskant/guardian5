; ------
; 29 face target (only works after charge, needs rewrite)
; -----
state_faceTarget:
  JSR setLineFunction           ; draw a line from the active unit pos
                                ; to the target pos
  LDX #$03
-loop:                          ; then loop to find wich of the line segments of the active
  LDA list1+0                   ; units hexagon intersect that line
  CLC                           ;
  ADC state29_point_dY, X
  STA list2+0                   ; point 1 Y

  LDA list1+1
  CLC
  ADC state29_point_dX, X
  STA list2+1                 ; point 1 X

  LDA list1+0
  CLC
  ADC state29_point_dY-1, X
  STA list2+2                 ; point 2 Y

  LDA list1+1
  CLC
  ADC state29_point_dX-1, X
  STA list2+3                 ; point 2 X

  TXA
  PHA
  JSR checkIntersect
  PLA
  TAX

  BCS +foundIntersection

  DEX
  CPX #$01
  BNE -loop

+foundIntersection:
  ; unfortunately, the line always intersect 2 hexagon line segments
  ; so we can't yet see choose between direction
  ; 1 and 4
  ; 2 and 5
  ; 3 and 6
  ; ( draw any lin through the center of the hex below and you'll understand)
  ; the following code solves that problem
  ; by "drawing" a symetry line in the active hexagon (dividing direction 1, 2 and 3 from 4, 5, and 6)
  ;      \_1__
  ;      /\   \
  ;   6 /  \   \ 2
  ;     \   \  /
  ;   5  \___\/  3
  ;        4  \

  ; and seeing on which side the targeted node lies
  ; this can be done through simple addition ad substractoin
  ; by comparing (active unit X - active unit Y)
  ; to (target X - target Y)


  CLC
  LDA list1+1         ; ox
  ADC list1+2         ; py
  SEC
  SBC list1+0         ; oy
  SBC list1+3         ; px
  BMI +continue:
  INX
  INX
  INX

+continue
  LDY activeObjectIndex
  LDA object, Y
  AND #%11111000
  ORA identity, X
  STA object, Y
  JMP pullState

;     _1_
;    /   \2
;    \_ _/3
;

state29_point_dY:
  .db  -1, -1, 0, 1
state29_point_dX:
  .db  -1, 1, 2, 1
