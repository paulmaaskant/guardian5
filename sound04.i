; opcodes         argument
;
; endSound                              ; end of sound
; loopSound       address:word          ; stream continues at specified address
; noteOffset      offset:byte           ; raise / lower tone by 'offset'  -128 to + 127
; setCountLoop1   count:byte            ; set loop1 count
; repeatLoop1     address:word          ; decrement loop 1 count, if not zero then stream continues at specified address
; transposeLoop1  address:word          ; apply note offset as found in table at specified addres, using the current loop 1 count as the index
; setDutyCycle    dutyCycle:byte        ; set duty cycle ($00, $40, $80 or $C0)

sound04:
  .db $03                               ; number of streams in sound

  .db $00                               ; assign to stream # (0 to 5)
  .db %10000010                         ; b7 channel active flag, b6 rest flag, b5-2 not used, b1-0 channel
  .db $00                               ; b7-6 duty, b5-0 not used
  .db $50                               ; initial tempo
  .db eSnareDrum                        ; initial volume envelope
  .dw sound04_stream00                  ; stream pointer

  .db $01                               ; assign to stream # (0 to 5)
  .db %10000000                         ; b7 channel active flag, b6 rest flag, b5-2 not used, b1-0 channel
  .db $C0                               ; b7-6 duty, b5-0 not used
  .db $50                               ; initial tempo
  .db eConstant                        ; initial volume envelope
  .dw sound04_stream01                  ; stream pointer

  .db $02                               ; assign to stream # (0 to 5)
  .db %10000001                         ; b7 channel active flag, b6 rest flag, b5-2 not used, b1-0 channel
  .db $C0                               ; b7-6 duty, b5-0 not used
  .db $50                               ; initial tempo
  .db eConstant                        ; initial volume envelope
  .dw sound04_stream02                  ; stream pointer

sound04_stream00:

  .db setCountLoop1, 4
-loop:
  .db L16th
  .db A4, REST, REST, REST
  .db repeatLoop1
  .dw -loop

-restart:
  .db setCountLoop1, 32
-loop:
  .db L16th
  .db A3, REST, A3, G3

  .db repeatLoop1
  .dw -loop

  .db L4th
  .db A3, A3, A3
  .db L16th
  .db A3, A3
  .db C4, B3

  .db L4th
  .db G3, G3, G3
  .db L16th
  .db G3, G3
  .db C4, B3

  .db L4th
  .db D3, D3, D3
  .db L16th
  .db G3, G3
  .db C4, B3

  .db L4th
  .db F3, F3, F3
  .db L16th
  .db G3, G3
  .db C4, B3


  .db setCountLoop1, 16
-loop:
  .db L16th
  .db A3, REST, A3, G3

  .db repeatLoop1
  .dw -loop


  .db setCountLoop1, 2
-loop:
  .db L8th
  .db E3, F3, G3, A3
  .db B3, C4, B3, A3

  .db F3, G3, A3, B3
  .db C4, D4, C4, B3

  .db C3, D3, E3, F3
  .db G3, A3, G3, F3

  .db G3, A3, B3, C4
  .db D4, E4, D4, C4

  .db repeatLoop1
  .dw -loop
  .db loopSound
  .dw -restart

+transposeTable:
  .db -3, 7, -5, 1, -3, 7, -5, 1



sound04_stream01:
  .db L1, REST
-restart:
  .db setCountLoop1, 4
-loop:
  .db A3, G3, D4, F3
  .db repeatLoop1
  .dw -loop

  .db E3, F3, C4, G3
  .db E3, F3, C4, G3

  .db loopSound
  .dw -restart

sound04_stream02:
  .db L1, REST
-restart:
  .db L1
  .db E4, D4, A4, C4
  .db E4, D4, A4, C4
  .db L4th
  .db C4, D4, E4, D4
  .db B3, C4, D4, C4
  .db F4, G4, A4, G4
  .db A3, B3, C4, B3
  .db L1
  .db E4, D4, A4, C4


  .db setCountLoop1, $02
-loop:
  .db L8th
  .db B3, A3, B3, A3, B3, A3, B3, A3
  .db C4, B3, C4, B3, C4, B3, C4, B3
  .db L4th
  .db G4, F4, E4, F4
  .db D4, C4, B3, C4
  .db repeatLoop1
  .dw -loop

  .db loopSound
  .dw -restart
