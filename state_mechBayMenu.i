state_mechBayMenu:
  LDA buttons
  BPL +end
  JMP +continue
+end
  ; ------------                  ; all pilots are unique and can be assigned only once

  LDX list1+1                     ; unit 0, 1, or 2
  LDY #2

-loop:
  ; LDA objectList+3
  LDA object+28
  ;AND #%00000111                  ; if new pilot for unit X
  AND #%01111100
  CMP list3+10, Y                 ; is same pilot as new pilot for Y
  BNE +endOfLoop
  TYA
  CMP identity, X                 ; in another unit (X<>Y)
  BEQ +endOfLoop


  LDA itemIndex, Y                ;
  TAY
  LDA list3+10, X                 ; then take current pilot in X
  STA object, Y                   ; and assign pilot to unit Y

  LDY #0                          ; break from loop

+endOfLoop
  DEY
  BPL -loop

  ; --------------                ; item 4-15 are unique and can be assigned only once

  LDY list1+3
  CPY #2
  BCC +endState

  LDA object+28, Y
  LSR
  LSR
  LSR
  LSR
  CMP #4
  BCC +endState
  STA locVar3                      ; locVar3 = new item #

  LDA list1+1
  ASL                               ; 0 for object 0, 2 for object 1 and 4 for object 2
  ADC list1+3                       ; 2 for slot 1 and 3 for slot 2
  TAX
  DEX
  DEX                               ; X = selected item slot (0-5)

  LDA #0
  STA debug
  STA debug+1

  LDY #5

-loop:
  LDA list3+13, Y                  ; is item in slot Y
  CMP locVar3                      ; same as new item?
  BNE +endOfLoop                   ; no -> next iteration

  LDA #3
  CMP locVar3
  BCS +endOfLoop                   ; is item unique?

  TYA
  CMP identity, X                 ; same slot?
  BEQ +endOfLoop                  ; yes -> next iteration

  LDA itemToObject, Y
  CMP itemToObject, X
  BNE +differentObject
  TYA
  LSR                             ; even sets Y to 30, uneven to 31
  ADC #30
  TAY                             ; slot in object 3
  BNE +skip

+differentObject:
  LDA itemIndex+3, Y
  TAY                             ; slot in object 0, 1 or 2

+skip:                            ; Y is set to the right slot
  LDA itemIndex+3, X
  TAX
  LDA object, X                   ; old value of selected slot moves to
  STA object, Y                   ; slot with duplicate
  LDY #0                          ; break out of loop

+endOfLoop
  DEY
  BPL -loop
  ; --------------

+endState:
  LDY #24                         ; copy current unit 3 to active unit
  LDX activeObjectIndex
  JSR copyObject

  JSR assignEquipment:

  JSR pullAndBuildStateStack
  db 7
  db $46, 17             ; clear right area
  db $46, 18             ; clear right area
  db $46, 21             ; clear left area
  db $1F                 ; reload mech

+continue:
  LDA #3
  STA effects

  LDA #1
  STA currentEffects+26

  LDA frameCounter          ; cursor effect (pallete toggle)
  LSR
  LSR
  AND #%00000111
  TAX
  LDA cursorColor, X
  STA pal_color3+7
  STA pal_color3+2

  LDX list1+3
  LDA menuSize, X
  STA locVar1

  LDY list1+2
  LDA buttons
  LSR                 ; Ri
  BCC +nextButton

  INY
  CPY locVar1
  BCC +nextButton
  LDY #0

+nextButton:
  LSR                 ; Le
  BCC +nextButton

  DEY
  BPL +nextButton
  LDY locVar1
  DEY

+nextButton:
  LSR                 ; Do
  BCC +nextButton

  INY
  INY
  CPY locVar1
  BCC +nextButton
  LDY #0

+nextButton:
  LSR                 ; Up
  BCC +nextButton

  DEY
  DEY
  BPL +nextButton
  LDY locVar1
  DEY

+nextButton:
  ;LSR                 ; st
  ;LSR                 ; se
  ;LSR                 ; b
  ;LSR                 ; a

  STY list1+2

  LDA list1+0
  CMP #1
  BEQ +mechMenu
  BCS +itemMenu

+pilotMenu:
  ;LDA #%00011000
  ;SEC
  ;ADC identity, Y
  ;STA objectList+3
  TYA
  ASL
  ASL
  STA object+28
  BPL +setCursor

+mechMenu:
  INC effects
  TYA
  ASL
  ASL
  ASL
  ASL
  ORA #4              ; starting direction
  STA object+24

+setCursor:
  LDA subMenu1CursorPositions, Y
  AND #%01100000
  CLC
  ADC #35
  STA currentEffects+14

  LDA subMenu1CursorPositions, Y
  AND #%00011000
  CLC
  ADC #16
  STA currentEffects+8
  BNE +done

+itemMenu:
  SEC
  SBC #2
  TAX

  TYA
  ASL
  ASL
  ASL
  ASL
  STA object+30, X

  TYA
  LSR
  TAX
  LDA #24
  JSR multiply
  LDA #27
  CLC
  ADC par2
  STA currentEffects+14

  LDY #24
  LDA list1+2
  LSR
  BCS +skip
  LDY #0

+skip:
  TYA
  CLC
  ADC #200
  STA currentEffects+8

+done:
  LDA buttons
  ASL
  LSR                     ; mask A button
  BNE +wait               ; block input for a few frames if any button (except A) was pressed
  RTS

+wait:
  LDA #0                        ; switch of secondary cursor blinking
  STA currentEffects+26

  JSR buildStateStack
  db 2
  db $4C          ; update text area
  db $1F          ; update mech & stats
  db $1A          ; wait a frame

subMenu1CursorPositions:
  db %00000000
  db %00011000
  db %00100000
  db %00111000
  db %01000000
  db %01011000


assignEquipment:
  LDX #8

-loop:
  LDA itemIndex, X
  TAY

  CPX #3
  BCC +pilot
  LDA object, Y
  LSR
  LSR
  LSR
  LSR
  STA list3+10, X
  BPL +nextLoop

+pilot:
  LDA object, Y
  STA list3+10, X

+nextLoop:
  DEX
  BPL -loop
  RTS

itemIndex:
  db 4
  db 12
  db 20
  db 6,7,14,15,22,23

itemToObject:
  .db 0, 0, 1, 1, 2, 2

menuSize:
  db 6, 4, 8, 8, 8
