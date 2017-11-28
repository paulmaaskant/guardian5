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
