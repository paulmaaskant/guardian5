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
  LDA #%00000010       ; firstEnemy
  BNE +findPilot

+firstPlayer:
  LDA #%00000001

+findPilot:
  STA locVar1
  LDX objectListSize

-loop:
  LDA objectList-1, X
  AND locVar1
  BEQ +found
  DEX
  BNE -loop

+found:
  LDA objectList-1, X
  AND #%01111000
  TAX
  LDA object+4, X
  AND #%01111100  
  RTS

+active:
  LDX activeObjectIndex
  LDA object+4, X
  AND #%01111100
  RTS

+target:
  LDA targetObjectIndex
  LDA object+4, X
  AND #%01111100
  RTS
