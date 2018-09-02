;
; IN A, (new) value
; IN X, item index
;
updateSelectedItem:
  CPX #6
  BCS +updateWeapon   ;
  CPX #3
  BCS +updateMech     ;

  ; Pilots can only be assigned once
  ; If the pilot is already assigned to another mech
  ; then swap

  STA locVar1
  LDY #2

-loop:
  LDA list1, Y
  CMP locVar1                     ; same pilot...
  BNE +endOfLoop
  TYA
  CMP identity, X                 ; in another unit?
  BEQ +endOfLoop
  LDA list1, X
  STA list1, Y
  ORA deploymentObjectMap, Y      ; + the object index (b6-3)
  STA objectList, Y               ; is the object list entry
  LDY #0                          ; break from loop

+endOfLoop
  DEY
  BPL -loop

  LDA locVar1
  STA list1, X                    ; pilot pilot (b2-1)
  ORA deploymentObjectMap, X      ; + the object index (b6-3)
  STA objectList, X               ; is the object list entry

  RTS

+updateWeapon:        ; update weapon
  STX locVar1
  LDY #7
  STY locVar2

  STA list1, X        ; store selected weapon
  ASL
  ASL
  ASL
  ADC #7
  TAX                 ; tile position of selected weapon

  LDY locVar1
  LDA weaponListOffset-6, Y
  TAY                 ; tile buffer position for selected weapon slot

-loop:
  LDA locVar2
  CMP #3
  BNE +continue
  DEY
  DEY
  DEY
  DEY

+continue:
  LDA weaponTiles, X
  STA list8+128, Y
  DEX
  DEY
  DEC locVar2         ; counter
  BPL -loop

  LDX locVar1         ; restore X
  LDY deploymentObjectMap, X
  LDA list1, X
  ASL
  ASL
  ASL
  ASL
  STA object, Y

  RTS

+updateMech:
  STA list1, X        ; set mech
  STA locVar1


  TAY							  	; retrieve mech sprites
  LDA objectTypeL, Y
  STA pointer1+0
  LDA objectTypeH, Y
  STA pointer1+1
  LDY #3
  LDA (pointer1), Y
  STA currentEffects-3, X         ; set mech sprites

  LDY #9
  LDA (pointer1), Y
  STA locVar2                     ; armor

  LDA locVar1                     ; object type
  ASL
  SEC
  ROL
  ASL
  ASL
  LDY deploymentObjectMap, X
  STA object, Y

  LDA locVar2
  ASL
  ASL
  ASL
  STA object+1, Y

+done:
  RTS

deploymentObjectMap:
  .db  0, 8, 16, 0, 8, 16
  .db  6, 14, 22, 7, 15, 23

weaponListOffset:
  .db 11, 27, 43, 15, 31, 47

weaponTiles:
  .hex 90 96 97 93
  .hex 90 A6 A7 93

  .hex 90 86 87 93
  .hex 90 94 95 93

  .hex 90 84 85 93
  .hex 90 94 95 93

  .hex 90 B1 B2 93
  .hex 90 B1 B2 93
