sTitleSong = $00

sound00:
  .db #$04                              ; number of streams

  .db #$01                              ; stream #
  .db #$80                              ; channel (sq1)
  .db #$B0                              ; initial duty
  .db #$40                              ; initial tempo
  .db eShortStaccato                        ; initial volume envelope
  .dw sound00_stream00                  ; stream address

  .db #$00                              ; stream #
  .db #$81                              ; channel (sq2)
  .db #$C0                              ; initial duty / volume
  .db #$40                              ; initial tempo
  .db eConstant                         ; initial volume envelope
  .dw sound00_stream01                  ; stream address

  .db #$02                              ; stream #
  .db #$82                              ; channel (tr)
  .db #$80                              ; initial duty / volume
  .db #$40                              ; initial tempo
  .db eConstant                          ; initial volume envelope
  .dw sound00_stream02                  ; stream address

  .db #$03                              ; stream #
  .db #$83                              ; channel (noise)
  .db #$B0                              ; initial duty
  .db #$40                              ; initial tempo
  .db eSnareDrum                        ; initial volume envelope
  .dw sound00_stream03                  ; stream address

sound00_stream00:
  .db L16th
  .db A3, A3, C4, E4, A4, C5, E5, A5
  .db loopSound
  .dw sound00_stream00

sound00_stream01:
  .db L8th
  .db setCountLoop1, $08

-loop:
  .db E4, A3, A3, A3, E4, A3, A3, A3
  .db transposeLoop1
  .dw +transposeTable
  .db repeatLoop1
  .dw -loop
  .db loopSound
  .dw sound00_stream01

+transposeTable:
  .db $02, $00, $02, $00, $FE, $00, $FE, $00

sound00_stream02:
  .db L8th
  .db A5, REST, A5, REST
  .db loopSound
  .dw sound00_stream02

sound00_stream03:
  .db L16th
  .db #$0D, #$0D, #$04, #$0D, #$0D, #$04, REST, #$04
  .db loopSound
  .dw sound00_stream03
