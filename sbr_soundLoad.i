; --------------------------------------
; soundLoad, play a sound
; IN Y, sound index
; --------------------------------------
soundLoad:
  LDA soundsLo, Y                       ; set pointer 1 to sound header
  STA pointer1+0
  LDA soundsHi, Y
  STA pointer1+1
  LDY #$00                              ; start pulling bytes from the header
  LDA (pointer1), Y
  STA locVar3                           ; byte 0: number of stream headers

-loop:                                  ; for every stream header
  INY
  LDA (pointer1), Y                     ; byte 0: stream #
  TAX
  INY
  LDA (pointer1), Y                     ; byte 1: channel #
  STA soundStreamChannel, X
  INY
  LDA (pointer1), Y                     ; byte 2: duty
  AND #%11000000                        ; b7,b6
  ORA #%00110000                        ; disable loop & envelope
  STA soundStreamDutyVolume, X
  LDA #$00
  STA soundStreamNoteOffset, X          ; note adjustment
  INY
  LDA (pointer1), Y                     ; tempo (adjusted for PAL / NTSC)
  PHA
  LDA sysFlags
  AND sysFlag_NTSC
  BEQ +continue
  PLA
  STX locVar4
  STY locVar5
	LDX #$D5                              ; * (5/6) = * ($D5/$100)
	JSR multiply
  LDA par1                              ; use the HI byte as the LO, effectively dividing by $100
  LDX locVar4
  LDY locVar5
  BNE +store

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
  LDA (pointer1), Y
  STA soundStreamEnvelope, X            ; initial volume envelope
  LDA #$02
  STA soundStreamEnvelopeCounter, X     ; start at the beginning of the volume envelope
  INY
  LDA (pointer1), Y                     ; pointer lo
  STA soundStreamPointerLo, X
  INY
  LDA (pointer1), Y                     ; pointer hi
  STA soundStreamPointerHi, X
  LDA #$01
  STA soundStreamNoteLengthCounter, X
  LDA #$02
  STA soundStreamNoteLength, X
  LDA #$08                              ; disabled, but also set the negate flag to prevent static on pulse channels
  STA soundStreamSweepControl, X
  DEC locVar3
  BNE -loop
  RTS
