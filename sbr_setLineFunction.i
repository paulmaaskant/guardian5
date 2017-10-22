; LOC list1+0 	Y orig coordinate
; LOC list1+1 	X orig coordinate (list1+1)
; LOC list1+2 	Y center of check node
; LOC list1+3	  X center of check node
; LOC list1+4 	delta Y (list+4)
; LOC list1+5 	delta X (list+5)
; LOC list1+6 	b0 stores sign of delta y / delta x
; LOC list1+7 	temp var used in line function
; LOC list1+8 	result var used in line function
;
;       (X1 - Xorig) * deltaY
;    _________________________  + Yorig - Y1 = RESULT (SIGN)
;			    deltaX
;

;
;
; IN A =  grid position

setLineFunction:
  LDX #$00                                                                      ; point 1
  STX list1+6		                                                                ; initialize b0 to 0
  STX list1+8		                                                                ;
  JSR gridPosToTilePos

  TYA		                                                                         ; point 2, 
  LDX #$02
  JSR gridPosToTilePos

  ; --- determine Y delta ---
  LDA list1+0           ; y point 1
  SEC
  SBC list1+2           ; - y point 2
  BCS +continue         ; if delta is negative
  INC list1+6           ; then store the sign
  EOR #$FF              ; and negate
  ADC #$01              ; clc guaranteed

+continue:
  STA list1+4           ; delta y

  ; --- determine X delta --
  LDA list1+1           ; x point 1
  SEC
  SBC list1+3           ; - x point 2
  BCS +continue         ; if delta is negative
  INC list1+6           ; then store the sign
  EOR #$FF              ; and negate
  ADC #$01              ; clc guaranteed

+continue:
  STA list1+5

  RTS
