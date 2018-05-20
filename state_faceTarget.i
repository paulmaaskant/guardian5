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
  JSR directionToCursor
  STA locVar1

  LDY activeObjectIndex
  LDA object+0, Y
  AND #%11111000
  ORA locVar1
  STA object+0, Y

  LDY activeObjectIndex   ; parameter for getStatsAddress
  JSR getStatsAddress
  LDY #4
  LDA (pointer1), Y       ; base tile
  CLC
  ADC locVar1             ; + facing direction
  ORA #%11000000          ; + block move and block LOS
                          ; A parameter for setTile
  LDY activeObjectGridPos ; Y parameter for setTile
  JSR setTile

+done:
  JMP pullState

attackDirectionTable:
	.db 1, 1, 2, 3, 4, 4, 5, 6
