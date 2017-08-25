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
  .db $01                               ; number of streams in sound

  .db $00                               ; assign to stream # (0 to 5)
  .db %10000000                         ; b7 channel active flag, b6 rest flag, b5-2 not used, b1-0 channel
  .db $00                               ; b7-6 duty, b5-0 not used
  .db $40                               ; initial tempo
  .db eConstant                         ; initial volume envelope
  .dw sound02_stream00                  ; stream pointer

  .db $01                               ; assign to stream #
  .db %10000000                         ; b7 channel active flag, b6 rest flag, b5-2 not used, b1-0 channel
  .db $B0                               ; b7-6 duty, b5-0 not used
  .db $40                               ; initial tempo
  .db eSnareDrum                        ; initial volume envelope
  .dw sound02_stream01                  ; stream pointer

sound02_stream00:
  .db L16th
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
  .db loopSound
  .dw sound02_stream00

sound02_stream01:
  .db L16th
  .db $04, REST, $0D, REST
  .db loopSound
  .dw sound02_stream01
