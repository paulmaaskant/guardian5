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
  BPL +setVolume                      ; is this the end $FF byte in the envelope?
  DEC soundStreamEnvelopeCounter, X   ; yes ->
  JMP -getVolume                      ; then retrieve the volume of the prev byte

+setVolume:
  INC soundStreamEnvelopeCounter, X
  STA nmiVar3                         ; current volume from envelope
  LDY nmiVar2                         ; restore Y (soft port index)
  CPY #$12                            ; channel = triangle? (volume control for triangle is different)
  BNE +continue                       ; no > continue
  LDA nmiVar3                         ; yes > volume greater than 0?
  BNE +continue                       ; no > continue
  LDA #$80                            ; if volume is 0, silence the triangle
  BNE +storeVolume

+continue:
  LDA soundStreamDutyVolume, X
  AND rightNyble
  STA nmiVar4
  LDA nmiVar3
  SEC
  SBC nmiVar4
  BCS +positive
  LDA #$00

+positive:
  STA nmiVar3
  LDA soundStreamDutyVolume, X
  AND leftNyble
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

restFlag:
  .db %01000000
