
; result messages

; 1 hit or miss msg
; 2 destroyed animation / target heat animation / evade animation
; 3 destroyed msg

; 4 temp effects animation
; 5 unit heat damage animation
; 6 unit heat damage msg

; 7 unit destroyed animation
; 8 unit destroyed msg

applyActionPointCost:
  LDA activeObjectStats+9
  SEC
  SBC list3+0
  STA activeObjectStats+9         ; calculate remaining AP

  LDA #0                          ; init value
  STA list3+16                    ;

  LDX #$81                        ; show gauge message
  LDA #4												  ; prio
  JSR addToSortedList

  LDY selectedAction
  LDX actionList, Y						    ; set x to selected action

  LDY activeObjectIndex           ; move this to calculate sbr?
  LDA object+1, Y
  AND #$07
  STA list3+3                     ; current heat points

  LDA list3+12                    ; calculated heat point cost
  CLC
  ADC list3+3                     ; + current heat points
  BPL +continue

  LDA list3+3                     ; if modifier would reduce heat below 0
  EOR #$FF                        ; then update modifier
  STA list3+12                    ; to equal - (current heat points)
  INC list3+12                    ;
  LDA #0                          ; no less than 0

+continue:
  CMP #3                          ;
  BCC +noHeatDamage               ; less than 4
  CMP #5
  BCC +heatDamage
  LDA #4                          ; ceiling at heat 4

+heatDamage:
  STA list3+3                     ; store new heat level

  LDA activeObjectStats+9         ; chec if this ist the last action
  BNE +continue                   ; -> not the last action, no heat damage

  LDX #$83                        ; show result: heat damage animation
  LDA #5                          ;
  JSR addToSortedList             ;

  LDX #8                          ; show result: heat damage msg
  LDA #6                          ;
  JSR addToSortedList             ;

  LDA list3+3                     ; damage = heat - 2
  SEC
  SBC #2

  STA list3+16                    ; heat damage
  BNE +continue                   ; JMP

+noHeatDamage:
  STA list3+3                     ; new heat point total

+continue:
  LDA list3+16                    ; heat damage
  ASL
  ASL
  ASL
  STA locVar2                     ; heat damage 3x shifted left

  LDY activeObjectIndex
  LDA object+1, Y
  AND #%11111000
  SEC
  SBC locVar2
  BCS +continue                   ; if heat damage would destroy unit, set to 0 instead
  LDA #0

+continue:
  ORA list3+3
  STA object+1, Y
  LSR
  LSR
  LSR
  STA activeObjectStats+6         ; update current HP
  RTS
