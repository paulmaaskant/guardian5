sound01:
  .db #$03                              ; number of streams

  .db #$00                              ; stream #
  .db #$83                              ; channel (noise)
  .db #$B0                              ; initial duty
  .db #$30                              ; initial tempo
  .db eSoftStaccato                     ; initial volume envelope
  .dw sound01_stream00                  ; stream address

  .db #$01                              ; stream #
  .db #$81                              ; channel (pulse)
  .db #$B0                              ; initial duty
  .db #$30                              ; initial tempo
  .db eConstant                         ; initial volume envelope
  .dw sound01_stream01                  ; stream addres

  .db #$02                              ; stream #
  .db #$82                              ; channel (pulse)
  .db #$80                              ; initial duty
  .db #$30                              ; initial tempo
  .db eConstant                         ; initial volume envelope
  .dw sound01_stream02                  ; stream addres

sound01_stream00:
  .db L8th
  .db setCountLoop1, 3
-loop:
  .db $0D, $0D, $04, REST
  .db repeatLoop1
  .dw -loop
  .db L16th
  .db $04, REST, $04, REST, $04, $04,$04,$04
  .db loopSound
  .dw sound01_stream00

sound01_stream01:
  .db L8th
  .db setCountLoop1, $08
-loop:
  .db E3, A2, A2, A2, E3, A2, A2, A3
  .db transposeLoop1
  .dw +transposeTable
  .db repeatLoop1
  .dw -loop
  .db loopSound
  .dw sound01_stream01

+transposeTable:
  .db $02, $00, $02, $00, $FE, $00, $FE, $00

sound01_stream02:
  .db L16th
  .db A5, A5, B5, B5, C6, C6
  .db loopSound
  .dw sound01_stream02
