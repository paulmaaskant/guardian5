; A binary radian
; X radius

; X = radius * sin(a)
; Y = radius * cos(a)
;


getCircleCoordinates:

  STA locVar5
  AND #%00111111
  TAY
  LDA sinTable, Y
  JSR multiply
  LDA par2
  ASL
  LDA par1
  ADC #0
  STA locVar3         ; Y

  LDA locVar5
  AND #%00111111
  EOR #$FF
  SEC
  ADC #%00111111
  TAY
  LDA sinTable, Y
  JSR multiply
  LDA par2
  ASL
  LDA par1
  ADC #0
  STA locVar4         ; X


  LDX locVar4         ; X
  LDY locVar3         ; Y

  BIT locVar5
  BMI +leftSide
  BVS +done
  LDA locVar4
  EOR #$FF
  CLC
  ADC #1
  TAY
  LDX locVar3
  JMP +done

+leftSide:
  BVS +Q4
  LDY locVar4
  LDA locVar3
  EOR #$FF
  CLC
  ADC #1
  TAX
  JMP +done

+Q4:
  LDA locVar4
  EOR #$FF
  CLC
  ADC #1
  TAX
  LDA locVar3
  EOR #$FF
  CLC
  ADC #1
  TAY
+done:




  STX debug
  STY debug+1

  RTS

sinTable:
  .db $00
  .db $06
  .db $0C
  .db $12
  .db $19
  .db $1F
  .db $25
  .db $2B
  .db $31
  .db $38
  .db $3E
  .db $44
  .db $4A
  .db $50
  .db $56
  .db $5C
  .db $61
  .db $67
  .db $6D
  .db $73
  .db $78
  .db $7E
  .db $83
  .db $88
  .db $8E
  .db $93
  .db $98
  .db $9D
  .db $A2
  .db $A7
  .db $AB
  .db $B0
  .db $B5
  .db $B9
  .db $BD
  .db $C1
  .db $C5
  .db $C9
  .db $CD
  .db $D1
  .db $D4
  .db $D8
  .db $DB
  .db $DE
  .db $E1
  .db $E4
  .db $E7
  .db $EA
  .db $EC
  .db $EE
  .db $F1
  .db $F3
  .db $F4
  .db $F6
  .db $F8
  .db $F9
  .db $FB
  .db $FC
  .db $FD
  .db $FE
  .db $FE
  .db $FF
  .db $FF
  .db $FF
  .db $FF
