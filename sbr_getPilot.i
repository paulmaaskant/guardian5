;
; X
; 0 active object
; 1 target object
; 2 first player unit
; 3 first enemy unit

getPilot:
  DEX
  BMI +active
  DEX
  BMI +target
  DEX
  BMI +firstPlayer
  LDA #%10100000       ; firstEnemy
  BNE +findPilot

+firstPlayer:
  LDA #0

+findPilot:
  STA locVar1
  LDX objectListSize

-loop:
  LDA objectList-1, X
  AND #%11111000
  CMP locVar1
  BEQ +found
  DEX
  BNE -loop

  LDX objectListSize
  LDA #%00001000
  CLC
  ADC locVar1
  STA locVar1
  BNE -loop

+found:
  LDA objectList-1, X
  RTS

+active:
  LDA activeObjectIndexAndPilot
  RTS

+target:
  LDA targetObjectTypeAndNumber
  RTS
