sSimpleBlip = $10
sound10:
  .db #$01                              ; number of streams

  .db #$04                              ; stream #
  .db #$80                              ; channel (suare 1)
  .db #$40                              ; initial duty
  .db #$80                              ; initial tempo
  .db #eConstant                        ; initial volume envelope
  .dw sound10_stream00                  ; stream address
sound10_stream00:
  .db L32th
  .db A4
  .db endSound

;sToggle = $11 ; not used
sound11:
  .db #$01                              ; number of streams

  .db #$04                              ; stream #
  .db #$80                              ; channel (p 1)
  .db #$B0                              ; initial duty
  .db #$80                              ; initial tempo
  .db eShortBlip                        ; initial volume envelope
  .dw sound11_stream00                  ; stream address
sound11_stream00:
  .db L32th
  .db setCountLoop1, $10
-loop:
  .db A2, Gs2
  .db repeatLoop1
  .dw -loop
  .db endSound

sSelect = $12
sound12:
  .db #$01                              ; number of streams

  .db #$04                              ; stream #
  .db #$83                              ; channel (suare 1)
  .db #$70                              ; initial duty
  .db #$40                              ; initial tempo
  .db eShortStaccato                    ; initial volume envelope
  .dw sound12_stream00                  ; stream address
sound12_stream00:
  .db L32th
  .db $14, $14, $12
  .db endSound

sRelease = $13
sound13:
  .db #$01                              ; number of streams

  .db #$04                              ; stream #
  .db #$80                              ; channel (suare 1)
  .db #$70                              ; initial duty
  .db #$40                              ; initial tempo
  .db eShortStaccato                    ; initial volume envelope
  .dw sound13_stream00                  ; stream address
sound13_stream00:
  .db L16th
  .db C4
  .db endSound

sConfirm = $14
sound14:
  .db #$01                              ; number of streams

  .db #$05                              ; stream #
  .db #$80                              ; channel (suare 1)
  .db #$70                              ; initial duty
  .db #$40                              ; initial tempo
  .db eShortStaccato                    ; initial volume envelope
  .dw sound14_stream00                  ; stream address
sound14_stream00:
  .db L32th
  .db F4, F5, F4
  .db endSound

sDeny = $15
sound15:
  .db #$01                              ; number of streams

  .db #$04                              ; stream #
  .db #$83                              ; channel (noise 1)
  .db #$B0                              ; initial duty
  .db #$40                              ; initial tempo
  .db eConstant                        ; initial volume envelope
  .dw sound15_stream00                  ; stream address
sound15_stream00:
  .db L32th
  .db #$18, REST, #$18,#$18,#$18,#$18
  .db endSound

sExplosion = $16
sound16:
  .db #$01                              ; number of streams

  .db #$04                              ; stream #
  .db #$83                              ; channel (noise 1)
  .db #$B0                              ; initial duty
  .db #$80                              ; initial tempo
  .db eSoftStaccato                      ; initial volume envelope
  .dw sound16_stream00                  ; stream address
sound16_stream00:
  .db L32th
  .db setCountLoop1, $0F
-loop:
  .db #$0F
  .db noteOffset, -1
  .db repeatLoop1
  .dw -loop
  .db endSound

sMechStep = $17
sound17:
  .db #$01                              ; number of streams

  .db #$04                              ; stream #
  .db #$83                              ; channel (noise 1)
  .db #$B0                              ; initial duty
  .db #$40                              ; initial tempo
  .db eSoftStaccato                     ; initial volume envelope
  .dw sound17_stream00                  ; stream address
sound17_stream00:
  .db L16th
  .db $0E
  .db endSound

sGunFire = $18
sound18:
  .db #$01                              ; number of streams

  .db #$04                              ; stream #
  .db #$83                              ; channel (noise 1)
  .db #$B0                              ; initial duty
  .db #$80                              ; initial tempo
  .db eConstant                         ; initial volume envelope
  .dw sound18_stream00                  ; stream address
sound18_stream00:
  .db L32th
  .db setCountLoop1, $12
-loop:
  .db $1B, REST
  .db repeatLoop1
  .dw -loop
  .db setCountLoop1, $04
-loop:
  .db $1B, $1B
  .db noteOffset, 1
  .db repeatLoop1
  .dw -loop
  .db endSound

sound19:
  .db #$01                              ; number of streams

  .db #$04                              ; stream #
  .db #$80                              ; channel (pulse 1)
  .db #$80                              ; initial duty
  .db #$10                              ; initial tempo
  .db eConstant                         ; initial volume envelope
  .dw sound19_stream00                  ; stream address
sound19_stream00:
  .db L8th
  .db setSweep, %11000011
  .db A4
  .db endSound

sound1A:
  .db #$01                              ; number of streams

  .db #$04                              ; stream #
  .db #$80                              ; channel (pulse 1)
  .db #$80                              ; initial duty
  .db #$40                              ; initial tempo
  .db eConstant                         ; initial volume envelope
  .dw sound1A_stream00                  ; stream address
sound1A_stream00:
  .db L8th
  .db setSweep, %11010011
  .db A4
  .db endSound

sound1B:
  .db #$01                              ; number of streams

  .db #$00                              ; stream #
  .db #$80                              ; channel (pulse 1)
  .db #$C0                              ; initial duty
  .db #$10                              ; initial tempo
  .db eConstant                         ; initial volume envelope
  .dw sound1B_stream00                  ; stream address
sound1B_stream00:
  .db L8th
  .db A4,A4,A4,A4,A4,A4,A4,A4,A4,A4,A4,A4,A4,A4,A4,A4,A4
  .db endSound
