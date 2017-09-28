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
