state_mechBayUpdateDetails:
  LDX #41
  LDA #space

-loop:                      ; clear text area
  STA list8+130, X
  DEX
  BPL -loop

  LDY list1+0               ; check cursor position
  BNE +continue             ; -> cursor on mech or on item

  LDA list1+2
  ASL
  ASL
  TAY
  LDA pilotTable+2, Y
  PHA
  LDA pilotTable, Y
  TAY
  LDX #130
  JSR writeToList8

  PLA
  LDX #7

-loop:                          ; every bit represents an ability
  ASL                           ; show the first ability
  BCS +break
  DEX
  BPL -loop
  BMI +noTrait

+break:
  LDY traitName, X              ; first trait
  LDX #130+14
  JSR writeToList8

+noTrait:
  LDY #$C2
  STY list8+204
  INY
  STY list8+205
  BNE +done

+continue:
  DEY
  BNE +continue             ; -> cursor on item

  LDA list1+2
  ASL
  ASL
  ASL
  ASL
  TAY
  LDA objectType0+14, Y
  PHA
  LDA objectType0+8, Y
  TAY
  LDX #130
  JSR writeToList8

  PLA
  BEQ +skip
  ASL
  TAX
  LDY actionTable+1, X
  LDX #130+14
  JSR writeToList8

+skip:
  LDY #$E8
  STY list8+204
  INY
  STY list8+205
  BNE +done

+continue:
  LDA list1+2
  ASL
  ASL
  TAY
  LDA weaponType, Y
  TAY
  LDX #130
  JSR writeToList8

  LDY #$C0
  STY list8+204
  INY
  STY list8+205

+done:
  JSR pullAndBuildStateStack
  db 2
  db $46, 24
