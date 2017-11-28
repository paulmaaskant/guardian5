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
