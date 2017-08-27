; opcodes         argument
;
; endSound                              ; end of sound
; loopSound       address:word          ; stream continues at specified address
; noteOffset      offset:byte           ; raise / lower tone by 'offset'  -128 to + 127
; setCountLoop1   count:byte            ; set loop1 count
; repeatLoop1     address:word          ; decrement loop 1 count, if not zero then stream continues at specified address
; transposeLoop1  address:word          ; apply note offset as found in table at specified addres, using the current loop 1 count as the index
; setDutyCycle    dutyCycle:byte        ; set duty cycle ($00, $40, $80 or $C0)

sound03:
  .db $02                               ; number of streams in sound

  .db $00                               ; assign to stream # (0 to 5)
  .db %10000000                         ; b7 channel active flag, b6 rest flag, b5-2 not used, b1-0 channel
  .db $00                               ; b7-6 duty, b5-0 not used
  .db $40                               ; initial tempo
  .db eConstant                         ; initial volume envelope
  .dw sound03_stream00                  ; stream pointer

  .db $01                               ; assign to stream # (0 to 5)
  .db %10000011                         ; b7 channel active flag, b6 rest flag, b5-2 not used, b1-0 channel
  .db $00                               ; b7-6 duty, b5-0 not used
  .db $40                               ; initial tempo
  .db eSnareDrum                        ; initial volume envelope
  .dw sound03_stream01                  ; stream pointer

sound03_stream00:
  .db L16th
  .db setCountLoop1, 4
-loop:
  .db A3
  .db setDutyCycle
  .db $40
  .db A3
  .db setDutyCycle
  .db $80
  .db A3
  .db setDutyCycle
  .db $C0
  .db A3
  .db setDutyCycle
  .db $00
  .db repeatLoop1
  .dw -loop
-restart:
  .db L8th, E4, L16th, E4, A3, REST, REST
  .db L8th, A4, L16th, A4, A3, REST, REST
  .db B3, REST, C4, REST
  .db D4, REST, C4, B3, REST, REST
  .db L4th, G3, G3, L8th, REST
  .db loopSound
  .dw -restart

sound03_stream01:
  .db L1, REST
-restart:
  .db L16th
  .db $0D, $0D, $04, REST
  .db loopSound
  .dw -restart
