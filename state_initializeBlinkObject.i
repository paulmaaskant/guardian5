; --------------------------------------------
; 59 Blink target object
;
; --------------------------------------------
state_initializeBlinkObject:
  LDY targetObjectIndex             ;
  LDA object+5, Y                   ;
  STA list1+3                       ; empty tile

  LDA object+0, Y
  STA list1+6                       ;

  LDX object+3, Y                   ;
  STX list1+5                       ; gridPos

  LDA nodeMap, X                    ;
  STA list1+4                       ; filled tile

  LDA #128                          ;
  STA list1+0                       ; counter

  LDA #$5A
  JMP replaceState
