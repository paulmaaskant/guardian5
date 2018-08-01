updateSpritePriority:
  LDX list6         ; store current contents of sorted list

-loop:
  LDA list6, X
  PHA
  LDA list7, X
  PHA
  DEX
  BPL -loop

  LDA #0
  STA list6
  LDX objectListSize
  DEX

-loop:
  LDA objectList, X
  STX locVar5
  TAX
  AND #%01111000
  TAY

  LDA object+3, Y
  AND #$0F				; X
  EOR #$FF				; - (X+1)
  SEC
  ADC #$0F
  STA locVar1				; 15-X

  LDA object+3, Y
  LSR
  LSR
  LSR
  LSR
  CLC
  ADC locVar1
  EOR #%00011111         ; inverse score

  ; A = priority (score)
  ; X = id (object list entry)
  JSR addToSortedList   ; breaks X, Y and locVar1-4

  LDX locVar5       ; restore X
  DEX
  BPL -loop

  LDX objectListSize

-loop:                      ; copy sorted list back to object list
  LDA list6, X
  STA objectList-1, X
  DEX
  BNE -loop





            ; restore original sorted list
  PLA       ; list7+0 is irrelevant
  PLA       ; list6+0 = item count
  STA list6
  BEQ +done

-loop:
  PLA
  STA list7+1, X
  PLA
  STA list6+1, X
  INX
  CPX list6
  BNE -loop

+done:
  RTS
