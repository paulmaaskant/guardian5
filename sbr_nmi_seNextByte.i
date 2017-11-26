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
  CMP $F0
  BCS +opCode
  RTS

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

+opCode:
   STX nmiVar2
   INY                                                                           ; ready to read opcode argument
   EOR #$FF
   ASL
   TAX
   LDA soundJumpOpCode+1, X
   PHA
   LDA soundJumpOpCode+0, X
   PHA
   LDX nmiVar2
   RTS

   endSound = $FF
   loopSound = $FE
   noteOffset = $FD
   setCountLoop1 = $FC
   repeatLoop1 = $FB
   transposeLoop1 = $FA
   setDutyCycle = $F9
   setSweep = $F8
   decreaseVolume = $F7
   increaseVolume = $F6
   setCountLoop2 = $F5
   repeatLoop2 = $F4

soundJumpOpCode:
  .dw seEndSound-1
  .dw seLoopSound-1
  .dw seNoteOffset-1
  .dw seSetCountLoop1-1
  .dw seRepeatLoop1-1
  .dw seTransposeLoop1-1
  .dw seSetDutyCycle-1
  .dw seSetSweep-1
  .dw seDecreaseVolume-1
  .dw seIncreaseVolume-1
  .dw seSetCountLoop2-1
  .dw seRepeatLoop2-1


; opCode FC
seSetCountLoop1:
  LDA (nmiVar0), Y
  STA soundStreamLoop1Counter, X
  LDA #2
  BNE +updatePointerGetNextByte

; opCode F5
seSetCountLoop2:
  LDA (nmiVar0), Y
  STA soundStreamLoop2Counter, X
  LDA #2
  BNE +updatePointerGetNextByte

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
  LDA #3
  BNE +updatePointerGetNextByte

;opCode FB
seRepeatLoop1:
  DEC soundStreamLoop1Counter, X
  BNE seLoopSound
  LDA #3
  BNE +updatePointerGetNextByte

seRepeatLoop2:
DEC soundStreamLoop2Counter, X
  BNE seLoopSound
  LDA #3
  BNE +updatePointerGetNextByte

; opCode FD
seNoteOffset:
  LDA (nmiVar0), Y
  CLC
  ADC soundStreamNoteOffset, X
  STA soundStreamNoteOffset, X
  LDA #2
  BNE +updatePointerGetNextByte

; opCode F9
seSetDutyCycle:
  LDA (nmiVar0), Y
  AND #%11000000
  STA nmiVar0
  LDA soundStreamDutyVolume, X
  AND #%00110000
  ORA nmiVar0
  STA soundStreamDutyVolume, X
  LDA #2
  BNE +updatePointerGetNextByte

; opCode F8
seSetSweep:
  LDA (nmiVar0), Y
  STA soundStreamSweepControl, X
;  LDA #$02
;  LDA soundStreamDutyVolume, X
;  AND #%11011111                    ; enable loop
;  STA soundStreamDutyVolume, X
  LDA #2
  BNE +updatePointerGetNextByte


; F7
seDecreaseVolume:
  LDA soundStreamDutyVolume, X
  AND rightNyble
  CMP #$0F
  BEQ +continue
  INC soundStreamDutyVolume, X

+continue:
  LDA #1
  BNE +updatePointerGetNextByte                 ; (recursion) get next byte

; F6
seIncreaseVolume:
  LDA soundStreamDutyVolume, X
  AND rightNyble
  BEQ +continue
  DEC soundStreamDutyVolume, X

+continue:
  LDA #1
  BNE +updatePointerGetNextByte                 ; (recursion) get next byte

;---------------
+updatePointerGetNextByte:
  CLC
  ADC soundStreamPointerLo, X
  STA soundStreamPointerLo, X
  LDA soundStreamPointerHi, X
  ADC #0
  STA soundStreamPointerHi, X
  JMP seNextByte


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

L32th           = $80
L16th           = $81
L8th            = $82
L4th            = $83
L2              = $84
L1              = $85

noteLenght:
.db $01, $02, $04, $08, $10, $20

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
  .db #$06
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
  .db #$0C, #$09, #$06, #$06, #$00
  .db #$FF

eSoftStaccato = $06
volumeEnvelope06:
  .db #$08, #$07, #$06, #$05, #$04, #$02, #$00
  .db #$FF

eConstantLoud = $07
volumeEnvelope07:
  .db #$0F
  .db #$FF
