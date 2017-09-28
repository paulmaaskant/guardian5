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
  LDA soundFlags                          ; reset silence event
  AND #%10111111
  STA soundFlags
  RTS
