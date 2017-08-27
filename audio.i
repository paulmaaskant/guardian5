; --------------------------------------------
; Notes
; --------------------------------------------
periodTableLo:
  .db #$f1,#$7f,#$13,#$ad,#$4d,#$f3,#$9d,#$4c,#$00,#$b8,#$74,#$34
  .db #$f8,#$bf,#$89,#$56,#$26,#$f9,#$ce,#$a6,#$80,#$5c,#$3a,#$1a
  .db #$fb,#$df,#$c4,#$ab,#$93,#$7c,#$67,#$52,#$3f,#$2d,#$1c,#$0c
  .db #$fd,#$ef,#$e1,#$d5,#$c9,#$bd,#$b3,#$a9,#$9f,#$96,#$8e,#$86
  .db #$7e,#$77,#$70,#$6a,#$64,#$5e,#$59,#$54,#$4f,#$4b,#$46,#$42
  .db #$3f,#$3b,#$38,#$34,#$31,#$2f,#$2c,#$29,#$27,#$25,#$23,#$21
  .db #$1f,#$1d,#$1b,#$1a,#$18,#$17,#$15,#$14
  .db #$00  ; silent note
periodTableHi:
  .db #$07,#$07,#$07,#$06,#$06,#$05,#$05,#$05,#$05,#$04,#$04,#$04
  .db #$03,#$03,#$03,#$03,#$03,#$02,#$02,#$02,#$02,#$02,#$02,#$02
  .db #$01,#$01,#$01,#$01,#$01,#$01,#$01,#$01,#$01,#$01,#$01,#$01
  .db #$00,#$00,#$00,#$00,#$00,#$00,#$00,#$00,#$00,#$00,#$00,#$00
  .db #$00,#$00,#$00,#$00,#$00,#$00,#$00,#$00,#$00,#$00,#$00,#$00
  .db #$00,#$00,#$00,#$00,#$00,#$00,#$00,#$00,#$00,#$00,#$00,#$00
  .db #$00,#$00,#$00,#$00,#$00,#$00,#$00,#$00
  .db #$00  ; silent note

L32th           = #$80
L16th           = #$81
L8th            = #$82
L4th            = #$83
L2              = #$84
L1              = #$85
noteLenght:
.db #$01, #$02, #$04, #$08, #$10, #$20

; --------------------------------------------
; Volume Envelopes
; --------------------------------------------
volumeEnvelopeTableLo:
  .db #< volumeEnvelope00
  .db #< volumeEnvelope01
  .db #< volumeEnvelope02
  .db #< volumeEnvelope03
  .db #< volumeEnvelope04
  .db #< volumeEnvelope05
  .db #< volumeEnvelope06
  .db #< volumeEnvelope07
volumeEnvelopeTableHi:
  .db #> volumeEnvelope00
  .db #> volumeEnvelope01
  .db #> volumeEnvelope02
  .db #> volumeEnvelope03
  .db #> volumeEnvelope04
  .db #> volumeEnvelope05
  .db #> volumeEnvelope06
  .db #> volumeEnvelope07

eConstant = $00
volumeEnvelope00:
  .db #$08
  .db #$FF

eFadeIn = $01
volumeEnvelope01:
  .db #$00, #$00, #$02, #$02, #$03, #$03, #$04, #$04, #$07, #$07
  .db #$08, #$08, #$0A, #$0A, #$0C, #$0C, #$0D, #$0D, #$0E, #$0E
  .db #$0F, #$0F
  .db #$FF

eBlipEcho = $02
volumeEnvelope02:
  .db #$0D, #$0D, #$0C, #$0B, #$00, #$00, #$00, #$00
  .db #$00, #$00, #$00, #$06, #$06, #$05, #$04, #$00
  .db #$FF

eShortStaccato = $03
volumeEnvelope03:
  .db #$0F, #$0E, #$0D, #$0C, #$09, #$05, #$00
  .db #$FF

eSnareDrum = $04
volumeEnvelope04:
  .db #$0E, #$09, #$08, #$06, #$04, #$02, #$00
  .db #$FF

eShortBlip = $05
volumeEnvelope05:
  .db #$0C, #$09, #$06, #$06
  .db #$FF

eSoftStaccato = $06
volumeEnvelope06:
  .db #$08, #$07, #$06, #$05, #$04, #$02, #$00
  .db #$FF

eConstantLoud = $07
volumeEnvelope07:
  .db #$0F
  .db #$FF

; --------------------------------------------
; Sounds
; --------------------------------------------
soundsLo:
  .db #< sound00
  .db #< sound01
  .db #< sound02
  .db #< sound03
  .dsb 12, #< sound15
  .db #< sound10
  .db #< sound11
  .db #< sound12
  .db #< sound13
  .db #< sound14
  .db #< sound15
  .db #< sound16
  .db #< sound17
  .db #< sound18
  .db #< sound19
  .db #< sound1A
  .dsb 5, #< sound15

soundsHi:
  .db #> sound00
  .db #> sound01
  .db #> sound02
  .db #> sound03
  .dsb 12, #> sound15
  .db #> sound10
  .db #> sound11
  .db #> sound12
  .db #> sound13
  .db #> sound14
  .db #> sound15
  .db #> sound16
  .db #> sound17
  .db #> sound18
  .db #> sound19
  .db #> sound1A
  .dsb 5, #> sound15

; sound streams
  .include sound00.i
  .include sound01.i
  .include sound02.i
  .include sound03.i
  .include soundEffects.i


; --------------------------------------
; soundDisable, switch off sound
; --------------------------------------
soundDisable:
    LDA #$00
    STA $4015                             ; silence all channels
    LDA soundFlags
    AND #$7F
    STA soundFlags                        ; set b7 to 0
    RTS

; --------------------------------------
; soundInitialize, ready all APU ports, set to silent
; --------------------------------------
soundInitialize:
  LDA #$0F                               ; switch on all 4 channels
  STA $4015
  LDA #$30                              ; switch off volume (b4-0) and disables timer (b5)
  STA softApuPorts+0                    ; $4000 channel 1 (square 1)
  STA softApuPorts+4                    ; $4004 channel 2 (square 2)
  STA softApuPorts+12                   ; $400C channel 4 (noise)
  LDA #$80                              ; switch off volume (b7)
  STA softApuPorts+8                    ; channel 3 (triangle)
  STA soundFlags                        ; set sound flags: sound on (b7)
  LDA #$FF                              ; initialize compare values
  STA currentPortValue+0                ; current value of $4003
  STA currentPortValue+1                ; current value of $4007
  RTS

soundSilence:
  LDA soundFlags
  ORA #$40
  STA soundFlags
  RTS

; --------------------------------------
; soundLoad, play a sound
; IN Y, sound index
; --------------------------------------
soundLoad:
  LDA soundsLo, Y
  STA pointer1+0
  LDA soundsHi, Y
  STA pointer1+1
  LDY #$00
  LDA (pointer1), Y
  STA locVar3                           ; number of streams in sound

-loop:
  INY
  LDA (pointer1), Y                     ; stream #
  TAX
  INY
  LDA (pointer1), Y                     ; channel #
  STA soundStreamChannel, X
  INY
  LDA (pointer1), Y                     ; duty
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

; --------------------------------------
; soundNextFrame, sound stream X by 1 frame
; IN X, sound stream index
; --------------------------------------
soundNextFrame:
  BIT soundFlags                          ; is sound enabled?
  BPL +done                               ; if not > done
  LDX #$00

-loop:                                    ; loop over all 6 streams
  BIT soundFlags
  BVC +continue
  JSR seEndSound
  JMP +streamDone

+continue:
  LDA soundStreamChannel, X
  BPL +nextStream                         ; b7 tells us if channel is on (1) or off (0)
  CLC                                     ; channel is on, so update ticker
  LDA soundStreamTickerTotal, X           ;
  ADC soundStreamTempo, X                 ;
  STA soundStreamTickerTotal, X           ;
  BCC +streamDone                         ; if carry set, then 'tick'
  DEC soundStreamNoteLengthCounter, X     ; dec the number of ticks the current note is holding
  BNE +streamDone                         ; if not 0, then note is still playing
  LDA soundStreamNoteLength, X            ; otherwise,
  STA soundStreamNoteLengthCounter, X     ; restore note length
  JSR seNextByte                          ; set next note / execute opcode

+streamDone:
  JSR seWriteToSoftApu                    ; write udated stream to soft APU

+nextStream:
  INX
  CPX #$06
  BNE -loop

+done:
  JSR seWriteToApu                        ; write soft APU to real APU

  LDA soundFlags
  AND #%10111111
  STA soundFlags

  RTS

; --------------------------------------
; seNextByte, read next byte of sound stream X
; IN X, sound stream index
; --------------------------------------
seNextByte:
  LDA soundStreamPointerLo, X
  STA nmiVar0+0
  LDA soundStreamPointerHi, X
  STA nmiVar0+1

  LDY #$00
  LDA (nmiVar0), Y
  BPL +note
  CMP #$A0
  BCC +noteLength

  INY
  ; --- Opcode ----
  CMP #repeatLoop1                                                              ; 2 cycles
  BNE +                                                                         ; 3 cycles (2 if no branche)
  JMP seRepeatLoop1                                                             ; 7 cycles to get here
+ CMP #transposeLoop1
  BNE +
  JMP seTransposeLoop1                                                          ; 12 cycles to get here
+ CMP #setCountLoop1
  BNE +
  JMP seSetCountLoop1
+ CMP #endSound
  BNE +
  JMP seEndSound
+ CMP #loopSound
  BNE +
  JMP seLoopSound
+ CMP #noteOffset
  BNE +
  JMP seNoteOffset
+ CMP #setDutyCycle
  BNE +
  JMP seSetDutyCycle
+ CMP #setSweep
  BNE +
  JMP seSetSweep                                                                ; 47 cycles to get here
+ RTS

+noteLength:
  AND #%01111111
  TAY
  LDA noteLenght, Y
  STA soundStreamNoteLength, X
  STA soundStreamNoteLengthCounter, X
  INC soundStreamPointerLo, X             ; move pointer to next byte
  BNE +noCarry                            ;
  INC soundStreamPointerHi, X             ;

+noCarry:
  JMP seNextByte                          ; (recursion) get next byte

+note:
  TAY
  LDA soundStreamChannel, X
  AND #%10111111                          ; reset 'rest' flag
  CPY #REST                               ; check 'silent note'
  BNE +continue                           ; if silent then
  ORA #%01000000                          ; raise 'rest' flag

+continue:
  STA soundStreamChannel, X               ; store rest flag
  TYA
  CLC
  ADC soundStreamNoteOffset, X            ; add offset
  TAY
  LDA soundStreamChannel, X
  AND #$03
  CMP #$03
  BNE +getPeriod                          ; if channel is not noise, get period
  TYA                                     ; if channel is noise
  CMP #$10                                ; make sure b7 is set if A > 0F
  BCC +continue
  ORA #$80

+continue:
  STA soundStreamPeriodLo, X              ; deals with noise
  JMP +resetEnvelope

+getPeriod:
  LDA periodTableLo, Y
  STA soundStreamPeriodLo, X
  LDA periodTableHi, Y
  STA soundStreamPeriodHi, X

+resetEnvelope:
  LDA #$FF
  STA currentPortValue+0
  STA currentPortValue+1
  LDA #$00
  STA soundStreamEnvelopeCounter, X
  INC soundStreamPointerLo, X             ; move pointer to next byte
  BNE +noCarry                            ;
  INC soundStreamPointerHi, X             ;

+noCarry:
  RTS

-updatePointerGetNextByte:
  CLC
  ADC soundStreamPointerLo, X
  STA soundStreamPointerLo, X
  LDA soundStreamPointerHi, X
  ADC #$00
  STA soundStreamPointerHi, X
  JMP seNextByte

; opCode FC
seSetCountLoop1:
  LDA (nmiVar0), Y
  STA soundStreamLoop1Counter, X
  LDA #$02
  BNE -updatePointerGetNextByte

; opCode FA
seTransposeLoop1:
  LDA (nmiVar0), Y
  STA nmiVar2+0
  INY
  LDA (nmiVar0), Y
  STA nmiVar2+1
  LDY soundStreamLoop1Counter, X
  DEY
  LDA (nmiVar2), Y
  CLC
  ADC soundStreamNoteOffset, X
  STA soundStreamNoteOffset, X
  LDA #$03
  BNE -updatePointerGetNextByte

;opCode FB
seRepeatLoop1:
  DEC soundStreamLoop1Counter, X
  BNE seLoopSound
  LDA #$03
  BNE -updatePointerGetNextByte

; opCode FD
seNoteOffset:
  LDA (nmiVar0), Y
  CLC
  ADC soundStreamNoteOffset, X
  STA soundStreamNoteOffset, X
  LDA #$02
  BNE -updatePointerGetNextByte

; opCode F9
seSetDutyCycle:
  LDA (nmiVar0), Y
  AND #%11000000
  STA nmiVar0
  LDA soundStreamDutyVolume, X
  AND #%00111111
  ORA nmiVar0
  STA soundStreamDutyVolume, X
  LDA #$02
  BNE -updatePointerGetNextByte
  RTS

; opCode F8
seSetSweep:
  LDA (nmiVar0), Y
  STA soundStreamSweepControl, X
  LDA #$02
;  LDA soundStreamDutyVolume, X
;  AND #%11011111                    ; enable loop
;  STA soundStreamDutyVolume, X
  LDA #$02
  BNE -updatePointerGetNextByte
  RTS

; opCode FF
seEndSound:
  LDA soundStreamChannel, X
  AND #$03                       ; mask the channel (b1-0)
  ORA #$40                       ; switch of stream (b7) and set rest (b6)
  STA soundStreamChannel, X

  RTS
; opCode FE
seLoopSound:
  LDA (nmiVar0), Y
  STA soundStreamPointerLo, X
  INY
  LDA (nmiVar0), Y
  STA soundStreamPointerHi, X
  JMP seNextByte                  ; (recursion) get next byte

; --------------------------------------
; seWriteToSoftApu, write sound stream X to soft APU ports
; IN X, sound stream index
; --------------------------------------
seWriteToSoftApu:
  LDA soundStreamChannel, X
  AND #$03
  ASL
  ASL
  TAY
  STY nmiVar2                          ; save Y

-getVolume:
  LDY soundStreamEnvelope, X
  LDA volumeEnvelopeTableLo, Y
  STA nmiVar0+0
  LDA volumeEnvelopeTableHi, Y
  STA nmiVar0+1
  LDY soundStreamEnvelopeCounter, X
  LDA (nmiVar0), Y
  BPL +setVolume
  DEC soundStreamEnvelopeCounter, X
  JMP -getVolume

+setVolume:
  INC soundStreamEnvelopeCounter, X
  STA nmiVar3                         ; current volume
  LDY nmiVar2                         ; restore Y
  CPY #$12                            ; triangle ?
  BNE +continue                       ; no > contuine
  LDA nmiVar3                         ; yes > volume greater than 0?
  BNE +continue                       ; no > continue
  LDA #$80                            ; if volume is 0, silence the triangle
  BNE +storeVolume

+continue:
  LDA soundStreamDutyVolume, X
  AND #$F0
  ORA nmiVar3

+storeVolume:
  STA softApuPorts+0, Y
  LDA soundStreamPeriodLo, X
  STA softApuPorts+2, Y
  LDA soundStreamPeriodHi, X
  STA softApuPorts+3, Y
  LDA soundStreamChannel, X
  BIT restFlag
  BEQ +continue
  CPY #$08                        ; triangle is silenced differently
  BNE +notTriangle
  LDA #$80
  BNE +store

+notTriangle:
  LDA #$30

+store:
  STA softApuPorts+0, Y

+continue:
  LDA soundStreamSweepControl, X
  STA softApuPorts+1, Y

+done:
  RTS

; --------------------------------------
; seWriteToApu, write soft APU ports to real APU ports
; --------------------------------------
seWriteToApu:
  LDY #$0F                    ; port $400F is not used

-loop:
  CPY #$09                    ; port $4009 is not used (no sweep on TRI)
  BEQ +nextPort
  CPY #$0D                    ; port $400D is not used (no sweep on NOI)
  BEQ +nextPort
  LDA softApuPorts, Y

  CPY #$03                    ; don't write to $4003
  BNE +continue               ; unless its a new value
  CMP currentPortValue+0
  BEQ +nextPort
  STA currentPortValue+0

+continue:
  CPY #$07                    ; don't write to $4007
  BNE +continue               ; unless its a new value
  CMP currentPortValue+1
  BEQ +nextPort
  STA currentPortValue+1

+continue:
  STA $4000, Y

+nextPort:
  DEY
  BPL -loop
  RTS

; --------------------------------------
; constants
; --------------------------------------
restFlag:
  .db %01000000

  ;Octave 1
  A1  = $00   ;"1" means octave 1.
  As1 = $01   ;"s" means "sharp"
  Bb1 = $01   ;"b" means "flat".  A == Bb
  B1  = $02

  ;Octave 2
  C2  = $03
  Cs2 = $04
  Db2 = $04
  D2  = $05
  Ds2 = $06
  Eb2 = $06
  E2  = $07
  F2  = $08
  Fs2 = $09
  Gb2 = $09
  G2  = $0A
  Gs2 = $0B
  Ab2 = $0B
  A2  = $0C
  As2 = $0D
  Bb2 = $0D
  B2  = $0E

  ;Octave 3
  C3  = $0F
  Cs3 = $10
  Db3 = $10
  D3  = $11
  Ds3 = $12
  Eb3 = $12
  E3  = $13
  F3  = $14
  Fs3 = $15
  Gb3 = $15
  G3  = $16
  Gs3 = $17
  Ab3 = $17
  A3  = $18
  As3 = $19
  Bb3 = $19
  B3  = $1A

  ;Octave 4
  C4  = $1B
  Cs4 = $1C
  Db4 = $1C
  D4  = $1D
  Ds4 = $1E
  Eb4 = $1E
  E4  = $1F
  F4  = $20
  Fs4 = $21
  Gb4 = $21
  G4  = $22
  Gs4 = $23
  Ab4 = $23
  A4  = $24
  As4 = $25
  Bb4 = $25
  B4  = $26

  C5  = $27
  Cs5 = $28
  Db5 = $28
  D5  = $29
  Ds5 = $2A
  Eb5 = $2A
  E5  = $2B
  F5  = $2C
  Fs5 = $2D
  Gb5 = $2D
  G5  = $2E
  Gs5 = $2F
  Ab5 = $2F
  A5  = $30
  As5 = $31
  Bb5 = $31
  B5  = $32

  C6  = $33
  Cs6 = $34
  Db6 = $34
  D6  = $35
  Ds6 = $36
  Eb6 = $36
  E6  = $37
  F6  = $38
  Fs6 = $39
  Gb6 = $39
  G6  = $3A
  Gs6 = $3B
  Ab6 = $3B
  A6  = $3C
  As6 = $3D
  Bb6 = $3D
  B6  = $3E

  REST = $50

  endSound = $FF
  loopSound = $FE
  noteOffset = $FD
  setCountLoop1 = $FC
  repeatLoop1 = $FB
  transposeLoop1 = $FA
  setDutyCycle = $F9
  setSweep = $F8
