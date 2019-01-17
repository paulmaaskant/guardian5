; ---------------------------------------
; Reads the sound header and initializes the sound stream variables
; requires the sound headers to be in an active bank
; ---------------------------------------
seLoadSound:
  LDY soundHeader
  LDA soundsLo, Y                       ; set pointer 1 to sound header
  STA nmiVar0+0
  LDA soundsHi, Y
  STA nmiVar0+1
  LDY #$00                              ; start pulling bytes from the header
  LDA (nmiVar0), Y
  STA nmiVar2                           ; byte 0: number of stream headers

-loop:                                  ; for every stream header
  INY
  LDA (nmiVar0), Y                     ; byte 0: stream #
  TAX
  INY
  LDA (nmiVar0), Y                     ; byte 1: channel #
  STA soundStreamChannel, X
  INY
  LDA (nmiVar0), Y                     ; byte 2: duty
  AND #%11000000                        ; b7,b6
  ORA #%00110000                        ; disable loop & envelope
  STA soundStreamDutyVolume, X
  LDA #$00
  STA soundStreamNoteOffset, X          ; note adjustment
  INY
  LDA (nmiVar0), Y                     ; tempo (adjusted for PAL / NTSC)
  PHA
  LDA sysFlags
  AND sysFlag_NTSC
  BEQ +continue
  ;BNE +continue


  PLA
  LSR
  STA nmiVar3
  LSR
  STA nmiVar4
  LSR
  LSR
  CLC
  ADC nmiVar4
  ADC nmiVar3       ;= 50% + 25% + 6.25% = close to 5/6
  BNE +store

  ;PLA
  ;STX nmiVar3
  ;STY nmiVar4
  ;LDX #$D5                              ; * (5/6) = * ($D5/$100)
  ;JSR multiply
  ;LDA par1                              ; use the HI byte as the LO, effectively dividing by $100
  ;LDX nmiVar3
  ;LDY nmiVar4
  ;BNE +store

+continue:
  LDA soundStreamChannel, X
  AND #$03
  CMP #$03
  BEQ +continue
  INC soundStreamNoteOffset, X

+continue:
  PLA

+store:
  STA soundStreamTempo, X
  EOR #$FF
  SEC
  ADC #$00
  STA soundStreamTickerTotal, X         ; initialize so that first tick hits
  INY
  LDA (nmiVar0), Y
  STA soundStreamEnvelope, X            ; initial volume envelope
  LDA #$02
  STA soundStreamEnvelopeCounter, X     ; start at the beginning of the volume envelope
  INY
  LDA (nmiVar0), Y                     ; pointer lo
  STA soundStreamPointerLo, X
  INY
  LDA (nmiVar0), Y                     ; pointer hi
  STA soundStreamPointerHi, X
  LDA #$01
  STA soundStreamNoteLengthCounter, X
  LDA #$02
  STA soundStreamNoteLength, X
  LDA #$08                              ; disabled, but also set the negate flag to prevent static on pulse channels
  STA soundStreamSweepControl, X
  DEC nmiVar2
  BNE -loop
  RTS
