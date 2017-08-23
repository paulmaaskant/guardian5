
sound02:
  .db #$02                              ; number of streams

  .db #$00                              ; stream #
  .db #$80                              ; channel (sq1)
  .db #$B0                              ; initial duty
  .db #$40                              ; initial tempo
  .db eConstant                   ; initial volume envelope
  .dw sound02_stream00                  ; stream address

  .db #$01                              ; stream #
  .db #$83                              ; channel (noise)
  .db #$B0                              ; initial duty
  .db #$40                              ; initial tempo
  .db eSnareDrum                        ; initial volume envelope
  .dw sound02_stream01                  ; stream address

sound02_stream00:
  .db L16th
  .db A3, A3, G3, F3
  .db loopSound
  .dw sound02_stream00

sound02_stream01:
  .db L16th
  .db $04, REST, $0D, REST
  .db loopSound
  .dw sound02_stream01
