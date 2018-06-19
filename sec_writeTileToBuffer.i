; this code sections writes the tile in 'tileIndex' / 'tileGridPos'
; to the buffer

  LDA tileGridPos
  AND #$0F
  STA locVar1				        ; grid-X

  LDA tileGridPos
  LSR
  LSR
  LSR
  LSR
  STA locVar2				        ; grid-Y

  TSX						            ; switch stack pointers
  STX	stackPointer1
  LDX stackPointer2
  TXS

  LDX #3

-loop:
  CLC
  LDA locVar2         ; calculate tile-X
  ADC locVar1         ; add grid-X to grid-Y
  STA locVar3   		  ; and multiply by 3
  ASL
  ADC locVar3
  ADC setTileXOffset, X
  AND #%00011111
  STA locVar3			    ; (X+Y) * 3

  LDA locVar1         ; caculate tile-Y
  SEC                 ; sbc grid-Y from grid-X
  SBC locVar2				  ;
  CLC
  ADC setTileYOffset, X           ; offset (value 1 .. 31)
  CMP #30
  BCC +continue
  SEC
  SBC #30

+continue:
  ASL                 ; multiply tile-Y by 32
  ASL
  ASL
  ASL
  LDY #0
  STY locVar4
  ROL locVar4         ; address HI byte
  ASL
  ROL locVar4         ; address HI byte
  ADC locVar3         ; add tile-X
  STA locVar3         ; address LO byte
  LDA locVar4
  ADC #$20
  STA locVar4          ; address HI byte

  LDA tileIndex
  ASL
  ASL
  CLC
  ADC identity, X
  TAY
  LDA objectTiles, Y
  PHA
  LDA locVar3
  PHA
  LDA locVar4
  PHA
  LDA #2
  PHA

  DEX
  BPL -loop

  TSX						; switch stack pointers back
  STX	stackPointer2
  LDX stackPointer1
  TXS
