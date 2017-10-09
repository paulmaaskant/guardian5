; opcodes         argument
;
; endSound                              ; end of sound
; loopSound       address:word          ; stream continues at specified address
; noteOffset      offset:byte           ; raise / lower tone by 'offset'  -128 to + 127
; setCountLoop1   count:byte            ; set loop1 count
; repeatLoop1     address:word          ; decrement loop 1 count, if not zero then stream continues at specified address
; transposeLoop1  address:word          ; apply note offset as found in table at specified addres, using the current loop 1 count as the index
; setDutyCycle    dutyCycle:byte        ; set duty cycle ($00, $40, $80 or $C0)

sound06:
  .db $02                               ; number of streams in sound

  .db $00                               ; assign to stream # (0 to 5)
  .db %10000000                         ; b7 channel active flag, b6 rest flag, b5-2 not used, b1-0 channel
  .db $C0                               ; b7-6 duty, b5-0 not used
  .db $60                               ; initial tempo
  .db eShortBlip                        ; initial volume envelope
  .dw sound06_stream00                  ; stream pointer

  .db $01                               ; assign to stream # (0 to 5)
  .db %10000001                         ; b7 channel active flag, b6 rest flag, b5-2 not used, b1-0 channel
  .db $C0                               ; b7-6 duty, b5-0 not used
  .db $60                               ; initial tempo
  .db eConstant                         ; initial volume envelope
  .dw sound06_stream01                  ; stream pointer

sound06_stream00:
  .db L16th
-restart:
  .db setCountLoop1, 4
-loop:

  .db A2, A2, A2, A2, A2, REST, A2, A2, A2, REST, A2, REST, A2, A2, A2, A2
  .db transposeLoop1
  .dw +transposeTable
  .db repeatLoop1
  .dw -loop

  .db loopSound
  .dw -restart

+transposeTable:
  ;.db 3, -5, -2, 4
  .db 4, -2, -5, 3

  sound06_stream01:
    .db L16th
  -restart:
    .db setCountLoop1, 4
  -loop:

    .db E3, E3, E3, E3, E3, REST, E3, E3, E3, REST, E3, REST, E3, E3, E3, E3
    .db transposeLoop1
    .dw +transposeTable
    .db repeatLoop1
    .dw -loop

    .db loopSound
    .dw -restart

  +transposeTable:
    ;.db 0, -5, 1, 4
    .db 4, 1, -5, 0
