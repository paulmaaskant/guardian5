showScreenDialog:
  LDA frameCounter				; make sure buffer is empty
-	CMP frameCounter
  BEQ -


  LDX #$3F
  LDA #$0F
- STA list3, X
  DEX
  BPL -

  LDA #$2A
  STA list3+0
  LDA #$2B
  STA list3+15
  LDA #$2C
  STA list3+48
  LDA #$2D
  STA list3+63


  LDA #$00
  STA locVar1
  LDA cameraX+1
  LSR
  LSR
  LSR
  CLC
  ADC #$08
  AND #%00011111           ; make sure we do not carry over to the next row!
  STA locVar2

  LDA cameraY+1			; first determine the VRAM address = $2000 + MOD(($0020 * (y camera row + offset 24)), $03C0)
  AND #%11111000		;
  LSR								;
  LSR								; y row number
  ADC #$08					; 4 rows down from the status bar
  CMP #$3C
  BCC +skip
  SEC								; MOD (fast & simple) for map of max 2 screens wide (use JSR divide for propper)
  SBC #$3C

+skip:
  ASL								; $2[XX]0 -> $[2X][X0]
  ROL locVar1
  ASL
  ROL locVar1
  ASL
  ROL locVar1
  ASL
  ROL locVar1
  ADC locVar2
  STA locVar2
  LDA #$20
  ADC locVar1         ; CLC guaranteed
  STA locVar1
  LDA cameraX+1       ; indicatates if where in col 0-31
  LSR                 ; because we want to MOD 32 anyway
  LSR                 ; we dont care about camerX+0, i.e. the hi byte
  LSR
  EOR #$FF
  SEC
  ADC #$18
  BEQ +zero
  CMP #$10
  BCC +lessThan16

+zero:
  LDA #$10

+lessThan16:
  STA locVar3

  LDA #$00
  STA locVar5

  TSX						                                                                ; switch stack pointers
  STX	stackPointer1
  LDX stackPointer2
  TXS

  ; loop!!

-nextLine:
  INC debug

  LDX locVar3
-
  TXA
  CLC
  ADC locVar5
  TAY
  LDA list3-1, Y
  PHA
  DEX
  BNE -

  LDA locVar2        ; address (L)
  PHA
  LDA locVar1
  PHA						     ; address (H)
  LDA locVar3			   ; length 16x2
  ASL
  PHA

  LDA #$10
  SEC
  SBC locVar3
  STA locVar4
  BEQ +done

  LDX #$10
  LDA #$00
-
  TXA
  CLC
  ADC locVar5
  TAY
  LDA list3-1, Y
  PHA
  DEX
  CPX locVar3
  BNE -

  LDA locVar2        ; address (L)
  AND #%11100000
  PHA
  LDA locVar1
  PHA						     ; address (H)
  LDA locVar4			   ; length 16x2
  ASL
  PHA

+done:

  LDA #$20
  CLC
  ADC locVar2
  STA locVar2
  LDA locVar1
  ADC #$00
  STA locVar1

  LDA locVar5
  CMP #$30
  BEQ +continue
  ADC #$10
  STA locVar5

  BNE -nextLine


+continue:
  TSX						     ; switch stack pointers
  STX	stackPointer2
  LDX stackPointer1
  TXS

  RTS
