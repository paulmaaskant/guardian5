; opcodes         argument
;
; endSound                              ; end of sound
; loopSound       address:word          ; stream continues at specified address
; noteOffset      offset:byte           ; raise / lower tone by 'offset'  -128 to + 127
; setCountLoop1   count:byte            ; set loop1 count
; repeatLoop1     address:word          ; decrement loop 1 count, if not zero then stream continues at specified address
; transposeLoop1  address:word          ; apply note offset as found in table at specified addres, using the current loop 1 count as the index
; setDutyCycle    dutyCycle:byte        ; set duty cycle ($00, $40, $80 or $C0)

sound02:
  .db $03                               ; number of streams in sound

  .db $00                               ; assign to stream # (0 to 5)
  .db %10000000                         ; b7 channel active flag, b6 rest flag, b5-2 not used, b1-0 channel
  .db $C0                               ; b7-6 duty, b5-0 not used
  .db $40                               ; initial tempo
  .db eConstant                         ; initial volume envelope
  .dw sound02_stream00                  ; stream pointer

  .db $01                               ; assign to stream #
  .db %10000011                         ; b7 channel active flag, b6 rest flag, b5-2 not used, b1-0 channel
  .db $00                               ; b7-6 duty, b5-0 not used
  .db $40                               ; initial tempo
  .db eSnareDrum                        ; initial volume envelope
  .dw sound02_stream01                  ; stream pointer

  .db $02                               ; assign to stream # (0 to 5)
  .db %10000001                         ; b7 channel active flag, b6 rest flag, b5-2 not used, b1-0 channel
  .db $C0                               ; b7-6 duty, b5-0 not used
  .db $40                               ; initial tempo
  .db eConstant                         ; initial volume envelope
  .dw sound02_stream02                  ; stream pointer

sound02_stream00:
  .db L16th
  .db setCountLoop1, 4
-loop:
  .db A3, B3, C4, D4, E4, F4
  .db repeatLoop1
  .dw -loop
  .db setCountLoop1, 4
-loop:
  .db F3, G3, A3, B3, C4, D4
  .db repeatLoop1
  .dw -loop
  .db setCountLoop1, 4
-loop:
  .db C4, D4, E4, F4, G4, A4
  .db repeatLoop1
  .dw -loop
  .db setCountLoop1, 4
-loop:
  .db B3, C4, D4, E4, F4, G4
  .db repeatLoop1
  .dw -loop

  .db loopSound
  .dw sound02_stream00

sound02_stream01:
  .db L16th
  .db $04, REST, REST, REST, $06, REST
  .db loopSound
  .dw sound02_stream01


sound02_stream02:


  .db L16th
  .db setCountLoop1, 90
-loop:
  .db REST
  .db repeatLoop1
  .dw -loop
  .db E3, REST, E3, REST, E3, REST
-restart:

  .db A3, A3, A3, A3, A3, A3
  .db A3, A3, A3, A3, A3, A3
  .db A3, A3, A3, A3, A3, A3
  .db A3, REST, B3, REST, C4, REST

  .db F3, F3, F3, F3, F3, F3
  .db F3, F3, F3, F3, F3, F3
  .db F3, F3, F3, F3, F3, F3
  .db F3, REST, F3, REST, F3, REST

  .db C3, C3, C3, C3, C3, C3
  .db C3, C3, C3, C3, C3, C3
  .db C3, C3, C3, C3, C3, C3
  .db C3, REST, C3, REST, C3, REST

  .db B2, B2, B2, B2, B2, B2
  .db B2, B2, B2, B2, B2, B2
  .db B2, B2, B2, B2, B2, B2
  .db E3, REST, E3, REST, E3, REST

  .db loopSound
  .dw -restart
