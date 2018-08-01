; list1+0..11 item container value
; list+12 selected item container value
; list+13 selected item container #
; list+14 pilot loop (currently always 2, code to control this is removed)
; list+15 selected unit's object index
; list+16 first loop flag (used to render stat area)
; list+18 item container number
;

state_unitMenu:
  BIT list1+16
  BPL +continue
  ASL list1+16
  LDA list1+13
  JMP +updateCursorPosition

+continue:
  LDX list1+14
  LDY #252

-outterLoop:                    ; loop for pilot portrait sprites
  CPX #3
  BNE +continue
  LDA list1+12
  BPL +next

+continue:
  LDA list1, X
+next
  ASL
  ASL
  CMP #16
  BCC +continue
  EOR #%11010000

+continue:
  STA locVar1                   ;
  LDA portraitYPosOffset, X
  STA locVar3
  STX locVar2
  LDX #8

-innerLoop:
  CLC

  LDA locVar1
  ADC portraitMap, X
  STA $0201, Y

  LDA portraitBaseXPos, X
  ADC #36
  STA $0203, Y

  LDA portraitBaseYPos, X
  ADC #67
  ADC locVar3
  STA $0200, Y

  LDA #%00100010
  STA $0202, Y

  DEY
  DEY
  DEY
  DEY
  DEX
  BPL -innerLoop

  LDX locVar2
  DEX
  BPL -outterLoop

  LDA frameCounter          ; cursor effect (pallete toggle)
  LSR
  LSR
  AND #%00000111
  TAX
  LDA cursorColor, X
  STA pal_color3+7

  ;STA pal_color1+2
  ;STA pal_color2+2
  STA pal_color3+2

  LDA blockInputCounter     ; buttons still blocked
  BEQ +continue             ; no block -> check buttons
  DEC blockInputCounter     ; dec block counter

-done:
  RTS

+continue:
  LDA buttons
  BEQ -done

+continue:
  LSR										; RIGHT
  BCC +next
  LDA list1+18
  ADC #3-1
  CMP #12
  BCC +updateCursorPosition
  SBC #12
  BCS +updateCursorPosition

+next:
  LSR										; LEFT
  BCC +next
  LDA list1+18
  SBC #3
  BPL +updateCursorPosition
  ADC #12
  BPL +updateCursorPosition

+next:
  LSR										; DOWN
  BCC +next
  LDA list1+18
  ADC #0
  CMP #12
  BCC +updateCursorPosition
  SBC #12
  BCS +updateCursorPosition

+next:
  LSR										;UP
  BCC +next
  LDA list1+18
  SBC #1
  BPL +updateCursorPosition
  RTS

+next:
  LSR									; start button
  BCC +next
  JMP pullState

+next:
  LSR									; select button
  LSR									; B
  BCC +next
  INC list1+12
  BPL +detailArea

+next:
  LSR									; A button
  BCC +next

  LDA #15
  STA runningEffectCounter

  JSR buildStateStack
  .db 5
  .db $52
  .db $46, 11
  .db $46, 14

+next:
  RTS

+updateCursorPosition:
  STA list1+18          ; cursor position item
  STA list1+13          ; current item's type
  TAX
  LDA list1, X          ; overwrite only if type changed
  STA list1+12          ; current item value

  LDA cursorScreenPosY, X
  STA currentEffects+15
  LDA cursorScreenPosX, X
  STA currentEffects+9

  LDA containerToObjectIndex, X
  STA list1+15

  TAX                             ; object 0, 1 or 2
  JSR lcl_copyObjectXtoObject3    ; takes X
  JSR updateUnitStats             ; write object 3 stats to list8+196-2015
  JSR lcl_moveColumn              ; move list8+196-2015 to list8+176+185

+detailArea:                      ; toggle entry point
  JSR updateDetailArea            ; update detail area
  JSR updateUnitStats             ; write object 3 stats to list8+196-2015
  JSR lcl_compareColumns          ; compare list8+196-2015 to list8+176+185

+wait:
  LDA #8
  STA blockInputCounter
  JSR buildStateStack
  .db 8
  .db $46, 12         ; refresh selected item
  .db $46, 11         ; refresh weapons
  .db $46, 10         ; refresh name area
  .db $46, 14         ; refresh stats
  ; RTS

portraitYPosOffset:
  .db 0, 32, 64, 104
cursorColor:
  .hex 0F 0B 1B 2B 3B 2B 1B 0B
cursorScreenPosX:
  db 36,36,36,68,68,68,100,100,100,132,132,132
cursorScreenPosY:
  .db 63, 63+32, 63+64, 63, 63+32, 63+64, 63, 63+32, 63+64, 63, 63+32, 63+64
containerToObjectIndex:
  .db 0, 1, 2, 0, 1, 2, 0, 1, 2, 0, 1, 2

lcl_copyObjectXtoObject3:
  LDA objectList, X     ;
  AND #%00000111        ;
  ORA #%00011000        ;
  STA objectList+3      ;

  TXA
  ASL
  ASL
  ASL
  TAX

  LDA object+0, X
  STA object+0+24

  LDA object+6, X
  STA object+6+24

  LDA object+7, X
  STA object+7+24

  RTS

lcl_moveColumn:
  LDX #9

-loop:
  LDA list8+196, X
  STA list8+176, X
  DEX
  BPL -loop
  RTS

lcl_compareColumns:
  LDX #9

-loop:
  LDA list8+176, X
  CMP list8+196, X
  BNE +diff
  LDA #space
  STA list8+196, X
  STA list8+186, X
  BPL +loopEnd

+diff:
  LDA #$41
  BCS +greater
  LDA #$40

+greater:
  STA list8+186, X

+loopEnd:
  DEX
  BPL -loop
  RTS
