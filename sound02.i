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
  .db $02                               ; number of streams in sound

  .db $00                               ; assign to stream # (0 to 5)
  .db %10000000                         ; b7 channel active flag, b6 rest flag, b5-2 not used, b1-0 channel
  .db $C0                               ; b7-6 duty, b5-0 not used
  .db $80                               ; initial tempo
  .db eConstantLoud                     ; initial volume envelope
  .dw sound02_stream00                  ; stream pointer

  .db $01                               ; assign to stream #
  .db %10000001                         ; b7 channel active flag, b6 rest flag, b5-2 not used, b1-0 channel
  .db $C0                               ; b7-6 duty, b5-0 not used
  .db $80                               ; initial tempo
  .db eConstantLoud                     ; initial volume envelope
  .dw sound02_stream01                  ; stream pointer

sound02_stream00:
  .db L16th
-restart:
  .db setDutyCycle, $C0
  .db setCountLoop1, 15
  .db A3, REST
-loop:
  .db A3, REST
  .db decreaseVolume
  .db repeatLoop1
  .dw -loop

  .db setDutyCycle, $C0
  .db setCountLoop1, 15
  .db F3, REST
-loop:
  .db F3, REST
  .db decreaseVolume
  .db repeatLoop1
  .dw -loop

  .db setDutyCycle, $C0
  .db setCountLoop1, 15
  .db C3, REST
-loop:
  .db C3, REST
  .db decreaseVolume
  .db repeatLoop1
  .dw -loop

  .db setDutyCycle, $C0
  .db setCountLoop1, 15
  .db D3, REST
-loop:
  .db D3, REST
  .db decreaseVolume
  .db repeatLoop1
  .dw -loop
  .db loopSound
  .dw -restart

sound02_stream01:
  .db noteOffset, 7
  .db loopSound
  .dw sound02_stream00
