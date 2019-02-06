; 35
; list1

; 0 primary cursor position
; 1 unit
; 2 secondary cursor position
; 3 maxitems in menu
; 4


state_mechBay:
  LDA #2
  STA effects

  LDA #1
  STA currentEffects+25     ; set cursor 1 to blinking pallete

  LDA frameCounter          ; cursor effect (pallete toggle)
  LSR
  LSR
  AND #%00000111
  TAX
  LDA cursorColor, X
  STA pal_color3+7
  STA pal_color3+2

  LDY list1+0
  LDA buttons
  LSR                 ; Ri
  BCC +nextButton

  CPY #2
  BCS +nextButton
  INY
  INY

+nextButton:
  LSR                 ; Le
  BCC +nextButton

  CPY #2
  BCC +nextButton
  DEY
  DEY
  CPY #2
  BCC +nextButton
  DEY

+nextButton:
  LSR                 ; Do
  BCC +nextButton

  INY
  CPY #4
  BCC +nextButton
  LDY #0

+nextButton:
  LSR                 ; Up
  BCC +nextButton

  DEY
  BPL +nextButton
  LDY #3

+nextButton:
  LSR                 ; st
  BCC +nextButton
  JMP pullState       ; done

+nextButton:
  LSR                 ; se
  LSR                 ; b
  BCC +nextButton

  LDA list1+1
  CLC
  ADC #1
  CMP #3
  BCC +next
  LDA #0

+next:
  STA list1+1
  ASL
  ASL
  ASL
  STA activeObjectIndex   ; assign next mech as active mech
  TAY

  LDX #24                 ; object 3 index
  JSR copyObject

  LDA #8
  STA blockInputCounter

  JSR buildStateStack
  db 2
  db $1F                              ; reload active mech
  db $1A                              ; wait

+nextButton:
  LSR                                 ; a
  BCC +continue
  JMP +openMenu                       ; open sub menu

+continue:                            ; update cursor sprite position
  STY list1                           ; and cursor shape
  LDA mechBayCursorPosition, Y
  AND #$0F
  ASL
  ASL
  ASL
  ADC #35
  STA currentEffects+13               ; updated Y position

  LDA mechBayCursorPosition, Y
  AND #%00110000
  ASL
  ADC #72
  STA currentEffects+7                ; updated x position

  LDA mechBayCursorPosition, Y        ; updated shape
  ASL
  LDY #$34
  BCC +med
  INY
  INY
  INY
  INY

+med:
  STY currentEffects+2
  STY currentEffects+1

  LDA buttons
  BNE +wait                           ; block input for 8 frames if a button was pressed
  RTS

+wait:
  LDA #6
  STA blockInputCounter

  LDY list1+0
  LDA list1+4, Y
  STA list1+2

+done:
  JSR buildStateStack
  db 2
  db $4C
  db $1A

+openMenu:
  LDA #0                        ; switch of primary cursor blinking
  STA currentEffects+25         ;

  STY list1+3                   ; store which menu

  CPY #0
  BEQ +openMechBayPilotMenu
  DEY
  BNE +openItemMenu

+openMechBayMechMenu:
  ;LDA #1
  ;STA list1+3                   ; mech menu

  LDX #28

-loop:
  LDA mechMenuTiles-1, X
  STA list8-1, X
  DEX
  BNE -loop

  JSR buildStateStack
  db 5
  db $46, 22           ; item menu
  db $46, 23
  db $21

+openMechBayPilotMenu:
  LDX #44

-loop:
  LDA pilotMenuTiles-1, X
  STA list8-1, X
  DEX
  BNE -loop

  LDX #2

-loop:
  LDA list3+10, X
  LSR
  LSR
  TAY
  LDA pilotMenuAssignedTile, Y
  TAY
  LDA assignmentPilotTile, X
  STA list8, Y
  DEX
  BPL -loop

  JSR buildStateStack
  db 5
  db $46, 19            ; item menu frame
  db $46, 20            ; item menu
  db $21

+openItemMenu:
  LDX #92

-loop:
  LDA itemMenuTiles-1, X
  STA list8-1, X
  DEX
  BNE -loop

  ;INY                 ; item menu 1 or 2 or 3
  ;STY list1+3

  LDX #5

-loop:
  LDA list3+13, X
  TAY
  LDA itemMenuAssignedTile, Y
  BMI +itemNotUnique
  TAY
  LDA assignmentItemTile, X
  STA list8, Y

+itemNotUnique:
  DEX
  BPL -loop

  JSR buildStateStack
  db 5
  db $46, 1            ; item menu frame
  db $46, 2            ; item menu
  db $21

mechBayCursorPosition:
  db %10000000
  db %10001000
  db %00110011
  db %00110110
  db %00111001

itemMenuTiles:
  .hex  F0 F0 AB C4 D4 AB E4 F4 AB C7 F6 AB F8 0F AB F8 0F AB F8 0F AB F8 0F
  .hex  F0 F0 BB C5 D5 BB E5 F5 BB C7 D4 BB F9 0F BB F9 0F BB F9 0F BB F9 0F
  .hex  C6 D4 AB F1 F1 AB C4 E6 AB D6 E6 AB F8 0F AB F8 0F AB F8 0F AB F8 0F
  .hex  C7 D5 BB F2 F2 BB C6 F3 BB D7 E7 BB F9 0F BB F9 0F BB F9 0F BB F9 0F

;  .hex  D6 E6 AB C4 D4 AB E4 F4 AB C7 F6 AB F8 0F AB F8 0F AB F8 0F AB F8 0F
;  .hex  D7 E7 BB C5 D5 BB E5 F5 BB C7 D4 BB F9 0F BB F9 0F BB F9 0F BB F9 0F
;  .hex  C6 D4 AB F1 F1 AB C4 E6 AB D6 E6 AB F8 0F AB F8 0F AB F8 0F AB F8 0F
;  .hex  C7 D5 BB F2 F2 BB C6 F3 BB D7 E7 BB F9 0F BB F9 0F BB F9 0F BB F9 0F

itemMenuAssignedTile
  .db 128+24, 128+70, 128+27, 128+73, 30, 76, 33, 79, 36, 82, 39, 85, 42, 88, 45, 91

pilotMenuTiles:
  .hex  5E 5F 60 AB 70 71 72 AB 55 56 57
  .hex  61 62 63 BB 73 74 75 BB 58 59 5A
  .hex  67 68 69 AB 4C 4D 4E AB 79 7A 7B
  .hex  6A 6B 6C BB 4F 50 51 BB 7C 7D 7E

pilotMenuAssignedTile:
  .db 13, 35, 17, 39, 21, 43

assignmentPilotTile:
  .hex CF DF EF

assignmentItemTile:
  .hex CF CF DF DF EF EF

cursorColor:
  .hex 0F 0B 1B 2B 3B 2B 1B 0B

mechMenuTiles:
  .hex  F0 D1 E1 AB F0 D1 E1
  .hex  F0 D2 E2 BB F0 D2 E2
  .hex  F0 D1 E1 AB F0 D1 E1
  .hex  F0 D2 E2 BB F0 D2 E2
