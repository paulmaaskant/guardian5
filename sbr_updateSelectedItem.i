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

+updateWeapon:                    ; update weapon
  STX locVar2                      ; store x
  STA locVar3                      ; store A

  LDY #5

-loop:
  LDA list1+6, Y
  CMP locVar3                     ; same item
  BNE +endOfLoop                  ; no -> next iteration

  LDA #3
  CMP locVar3
  BCS +endOfLoop                  ; is item unique?

  TYA
  CLC
  ADC #6
  CMP identity, X                 ; same slot?
  BEQ +endOfLoop                  ; yes -> next iteration

  LDY list1, X                    ; current value of selected slot
  TAX                             ; slot # with duplicate
  TYA                             ; write current value of selected slot to duping slot (swap)
  JSR updateWeaponTiles
  LDY #0                          ; break out of loop

+endOfLoop
  DEY
  BPL -loop

  LDX locVar2
  LDA locVar3

  JSR updateWeaponTiles

  LDX locVar2         ; restore X

  RTS

+updateMech:
  STA list1, X                    ; set mech
  STA locVar1

  TAY							  	            ; retrieve mech sprites
  LDA objectTypeL, Y
  STA pointer1+0
  LDA objectTypeH, Y
  STA pointer1+1

  LDY #3
  LDA (pointer1), Y
  STA currentEffects-3, X         ; set mech sprites for direction 4

  LDA locVar1                     ; set object type
  ASL                             ;
  SEC                             ; set object direction 4
  ROL
  ASL
  ASL
  LDY deploymentObjectMap, X
  STA object, Y

  RTS

deploymentObjectMap:
  .db  0, 8, 16, 0, 8, 16
  .db  6, 14, 22, 7, 15, 23



; A weapon index
; X slot index
; destroys X and Y
updateWeaponTiles:
  PHA
  LDY deploymentObjectMap, X
  ASL
  ASL
  ASL
  ASL
  STA object, Y                   ; update object

  PLA

  STA list1, X

  LDY weaponListOffset-6, X       ; determine position in list8
  ASL
  ASL
  ASL
  ADC #7
  TAX                             ; last tile position of selected weapon

  LDA #7                          ; init loop
  STA locVar1

-loop:
  LDA locVar1
  CMP #3                          ; upon the 4th iteration
  BNE +continue
  DEY                             ; adjust Y (list8 pos) by 4
  DEY
  DEY
  DEY

+continue:
  LDA weaponTiles, X              ; tile
  STA list8+128, Y                ; to buffer
  DEX
  DEY
  DEC locVar1                      ; counter
  BPL -loop
  RTS


weaponListOffset:
  .db 11, 27, 43, 15, 31, 47

weaponTiles:
  .hex 90 96 97 93
  .hex 90 A6 A7 93

  .hex 90 86 87 93
  .hex 90 94 95 93

  .hex 90 84 85 93
  .hex 90 94 95 93

  .hex 90 B1 B2 93    ; lr missiles
  .hex 90 B1 B2 93

  .hex A8 A4 A5 93    ; armor
  .hex 90 B4 B5 93

  .hex A8 84 86 93    ; flamer
  .hex 90 A6 B3 93

  .hex A8 87 87 93    ; actuator
  .hex 90 B6 94 93

  .hex A8 A4 A5 93    ;
  .hex 90 89 99 93
