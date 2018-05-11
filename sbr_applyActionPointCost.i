
; result messages

; 1 hit or miss msg
; 2 destroyed animation / target heat animation / evade animation
; 3 destroyed msg

; 4 unit heat damage animation
; 5 unit heat damage msg
; 6 temp effects animation

; 7 unit destroyed animation
; 8 unit destroyed msg

applyActionPointCost:
  LDA activeObjectStats+9
  SEC
  SBC list3+0
  STA activeObjectStats+9         ; calculate remaining AP

  LDA #0
  STA list3+16                    ; no heat damage

  LDX #$81                        ; show gauge message
  LDA #6												  ; prio
  JSR addToSortedList

  JSR getSelectedWeaponTypeIndex  ; sets X to selected action

  LDY activeObjectIndex           ; move this to calculate sbr?
  LDA object+1, Y
  AND #$07
  STA list3+3                     ; current heat points

  LDA list3+12                    ; calculated heat point cost
  CLC
  ADC list3+3                     ; + current heat points
  BPL +continue
  LDA #0                          ; no less than 0

+continue
  CMP #6
  BCC +less                       ; less than 6

  LDX #$83                        ; show result: heat damage animation
  LDA #4
  JSR addToSortedList

  LDX #8                          ; show result: heat damage msg
  LDA #5
  JSR addToSortedList

  LDA #2
  STA list3+16

  LDA #6                          ; cap heat points at 6
  STA list3+3
  BNE +continue                   ; JMP

+less:
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
